class Train
  attr_reader :wagons, :previous_station, :next_station, :type, :route, :current_station, :id, :speed

  def initialize(id, type)
    @id = id
    @type = type
    @speed = 0
    @wagons = []
    @route = nil
  end

  # возвращает количество вагонов в поезде
  def amount_of_wagons
    wagons.size
  end

  def speed_up(speed)
    @speed = speed
  end

  def current_speed
    speed
  end

  def speed_down
    @speed = 0
  end

  def add_wagon(wagon)
    wagons << wagon if wagon.type == type && speed.zero?
  end

  def delete_wagon(wagon)
    wagons.delete(wagon) if wagon.type == type && speed.zero?
  end

  def take_route(route)
    @route = route
    @current_station = route.first_station
    @previous_station = 'Вы на первой станции маршрута'
    @next_station = route.stations[1]
  end

  def forward
    if route.nil?
      puts 'Выберите маршрут'
    elsif current_station == route.last_station
      puts 'Вы прибыли на конечную станцию'
    else
      @previous_station = current_station
      @current_station = new_station_forward_from(previous_station) # обновить текущую станцию
      @next_station = new_station_forward_from(current_station) # обновить следующую станцию
    end
  end

  def back
    if route.nil?
      puts 'Выберите маршрут'
    elsif current_station == route.first_station
      puts 'Вы на начальной станции маршрута'
    else
      @previous_station = current_station
      @current_station = new_station_back_from(previous_station)
      @next_station = new_station_back_from(current_station)
    end
  end

  def location
    puts "Current station - #{current_station.name}"
    puts "Previousvious station - #{previous_station.name}"
    puts "Next station - #{next_station.name}"
  end

  protected

  # возвращает индекс станции на маршруте поезда
  def find_index_of_station(station)
    route.stations.index(station)
  end

  def new_station_forward_from(station)
    route.stations[find_index_of_station(station) + 1]
  end

  def new_station_back_from(station)
    route.stations[find_index_of_station(station) - 1]
  end
end
