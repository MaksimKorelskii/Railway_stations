class Route
  include InstanceCounter

  attr_reader :stations, :start_station, :finish_station

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  # возвращает список всех станций
  def show_route
    stations.each { |station| puts station.name }
  end

  def add_new_station(station)
    stations.insert(-2, station) # добавить в массив после элемента с индексом -2
  end

  def delete_station(station)
    if (station == start_station) || (station == finish_station)
      puts 'Нельзя удалить начальную и конечную станции'
    elsif stations.include?(station)
      stations.delete(station)
    end
  end

  private

  def validate!
    errors = []

    errors << 'Не указана начальная станция маршрута' if first_station.nil?
    errors << 'Не указана конечная станция маршрута' if last_station.nil?

    raise errors.join('. ') unless errors.empty?
  end
end
