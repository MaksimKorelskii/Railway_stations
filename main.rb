require_relative 'instance_counter'
require_relative 'company'
require_relative 'wagon'
require_relative 'train'
require_relative 'route'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'station'

class Main
  MENU = [
    { id: 0, title: 'выйти из приложения', action: :exit },
    { id: 1, title: 'создать станцию', action: :new_station },
    { id: 2, title: 'создать поезд', action: :new_train },
    { id: 3, title: 'создать маршрут', action: :new_route },
    { id: 4, title: 'добавить станцию  в маршрут', action: :add_station },
    { id: 5, title: 'удалить станцию из маршрута', action: :delete_station },
    { id: 6, title: 'назначить маршрут поезду', action: :set_route },
    { id: 7, title: 'прицепить вагон к поезду', action: :add_wagon },
    { id: 8, title: 'отцепить вагон от поезда', action: :delete_wagon },
    { id: 9, title: 'переместить поезд вперед', action: :move_forward },
    { id: 10, title: 'переместить поезд назад', action: :move_back },
    { id: 11, title: 'показать станции на маршруте', action: :list_stations },
    { id: 12, title: 'показать список поездов на станции', action: :list_trains_on_station },
  ].freeze

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start_menu
    puts
    puts 'МЕНЮ:'
    MENU.each do |item|
      puts "#{item[:id]} - #{item[:title]}"
    end
  end

  def program
    loop do
      start_menu
      puts
      print 'Выберите действие и введите соответствующую цифру: '
      choice = gets.chomp.to_i
      break if choice.zero?

      puts
      send(MENU[choice][:action])
    end
  end

  # создавать станции
  def new_station
    name = ask('Введите название станции')
    @stations << Station.new(name)
    puts "Станция #{name} успешно создана."
  end

  # создавать поезда
  def new_train
    id = ask('Введите номер поезда')
    type = ask('Введите тип поезда: пассажирский или грузовой')
    company = ask('Введите название производителя поезда')
    @trains << if type == 'пассажирский'
                 TrainPassenger.new(id, type, company)
               elsif type == 'грузовой'
                 TrainCargo.new(id, type, company) # любой некорретный тип уходит сюда
               else
                 puts 'Поезд не создан'
               end
    if %w[пассажирский грузовой].include?(type)
      puts "#{type.capitalize} поезд #{id} успешно создан. Производитель: #{company}."
    else
      puts 'Введён неверный тип поезда'
    end
  end

  # создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def new_route
    start_station = ask('Введите начало маршрута')
    finish_station = ask('Введите конец маршрута')
    @routes << Route.new(find_station(start_station), find_station(finish_station))
    puts "Маршрут с начальной станцией #{start_station} и конечной станцией #{finish_station} успешно создан."
  end

  def add_station
    station = ask('Введите название станции')
    start_station = ask('Введите начало маршрута')
    finish_station = ask('Введите конец маршрута')
    route(start_station, finish_station).add_new_station(find_station(station))
  end

  def delete_station
    station = ask('Введите название станции')
    start_station = ask('Введите начало маршрута')
    finish_station = ask('Введите конец маршрута')
    route(start_station, finish_station).delete_station(find_station(station))
  end

  # назначать маршрут поезду
  def set_route
    start_station = ask('Введите начало маршрута')
    finish_station = ask('Введите конец маршрута')
    id = ask('Введите номер поезда')
    train(id).take_route(route(start_station, finish_station))
    find_station(start_station).take_train(train(id))
  end

  # добавлять вагоны к поезду
  def add_wagon
    number = ask('Введите номер вагона')
    wagon_type = ask('Введите тип вагона: пассажирский или грузовой')
    company = ask('Введите название производителя вагона')
    case wagon_type
    when 'пассажирский'
      wagon = WagonPassenger.new(number, company)
    when 'грузовой'
      wagon = WagonCargo.new(number, company)
    end
    id = ask('Введите номер поезда, к которому нужно прицепить вагон')
    train(id).add_wagon(wagon)
    puts "#{wagon_type.capitalize} вагон #{number}, производителя #{company} успешно создан. " \
         "Вагон прицеплён к поезду #{id}."
  end

  # отцеплять вагоны от поезда
  def delete_wagon
    number = ask('Введите номер вагона')
    id = ask('Введите номер поезда, от которого нужно отцепить вагон')
    train(id).delete_wagon(wagon_of_train(id, number))
  end

  # перемещать поезд по маршруту вперед и назад
  def move_forward
    id = ask('Введите номер поезда')
    train(id).forward
    train(id).current_station.take_train(train(id))
    train(id).previous_station.send_train(train(id))
  end

  def move_back
    id = ask('Введите номер поезда')
    train(id).back
    train(id).current_station.take_train(train(id))
    train(id).previous_station.send_train(train(id))
  end

  # просматривать список станций
  def list_stations
    start_station = ask('Введите начало маршрута')
    finish_station = ask('Введите конец маршрута')
    route(start_station, finish_station).show_route
  end

  def list_trains_on_station
    station_name = ask("Введите название станции")
    type = ask("Введите тип поезда (пассажирский или грузовой)")
    find_station(station_name).train_list(type)
  end

  private

  def ask(question)
    puts question
    gets.chomp
  end

  def ask_integer(question)
    puts question
    gets.chomp.to_i
  end

  def find_station(station)
    @stations.find { |item| item.name == station }
  end

  def route(start_station, finish_station)
    @routes.find { |route| route.first_station.name == start_station && route.last_station.name == finish_station }
  end

  # поиск поезда по его номеру
  def train(id)
    @trains.find { |train| train.id == id }
  end

  def wagon_of_train(id, number)
    train(id).wagons.find { |wagon| wagon.number == number }
  end
end

Main.new.program
