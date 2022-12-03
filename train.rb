class Train
  include Company
  include InstanceCounter
  include Validation

  ID_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i.freeze # формат ххх-хх

  attr_reader :wagons, :previous_station, :next_station, :type, :route, :current_station, :id, :speed, :company

  @@trains = []

  def initialize(id, type, company)
    @id = id
    @type = type
    @speed = 0
    @wagons = []
    @route = nil
    @company = company
    validate!
    register_instance
    @@trains << self
  end

  def self.find(id)
    @@trains.find { |train| train.id == id }
  end

  # возвращает количество вагонов в поезде
  def amount_of_wagons
    wagons.size
  end

  def speed_up(speed)
    @speed = speed
  end

  def speed_down
    @speed = 0
  end

  def add_wagon(wagon)
    wagons << wagon if wagon.type == type && speed.zero?
    raise RuntimeError, "Несовпадение типов поезда и вагона!" if wagon.type != type
  end

  def delete_wagon(wagon)
    wagons.delete(wagon) if wagon.type == type && speed.zero?
  end

  def take_route(route)
    @route = route
    @current_station = route.first_station
    @previous_station = 'Вы на первой станции маршрута'
    @next_station = route.stations[1]
    @current_station_index = 0
  end

  def forward
    if route.nil?
      puts 'Выберите маршрут'
    elsif current_station == route.last_station
      puts 'Вы прибыли на конечную станцию'
    else
      @current_station_index += 1
      @previous_station = route.stations[@current_station_index - 1]
      @current_station = route.stations[@current_station_index] # обновить текущую станцию
      @next_station = route.stations[@current_station_index + 1] # обновить следующую станцию
    end
  end

  def back
    if route.nil?
      puts 'Выберите маршрут'
    elsif current_station == route.first_station
      puts 'Вы на начальной станции маршрута'
    else
      @current_station_index -= 1
      @previous_station = route.stations[@current_station_index + 1]
      @current_station = route.stations[@current_station_index]
      @next_station = route.stations[@current_station_index - 1]
    end
  end

  def location
    puts "Current station - #{current_station.name}"
    puts "Previousvious station - #{previous_station.name}"
    puts "Next station - #{next_station.name}"
  end

  protected

  def validate!
    errors = []

    errors << "Не указан номер поезда" if id == ""
    errors << "Не указано название компании изготовителя поезда" if company == ""
    errors << "Неверный формат номера поезда" if id !~ ID_FORMAT
    errors << "Вы не указали тип поезда. Введите: passenger или cargo" if type.nil?
    errors << "Неверный тип поезда, введите: passenger или cargo" unless [:passenger, :cargo].include?(@type)
  
    raise errors.join('. ') unless errors.empty?
  end
end
