class Route
  attr_reader :stations, :start_station, :finish_station

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def show_route
    stations.each { |station| puts station.name }
  end

  def add_new_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    if (station == start_station) || (station == finish_station)
      puts 'Нельзя удалить начальную и конечную станции'
    elsif stations.include?(station)
      stations.delete(station)
    end
  end
end
