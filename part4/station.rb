class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    trains << train
  end

  def trains_list      
    trains.each { |train| puts train.id}
  end

  def train_list_type
    cargo = @trains.count { |train| train.type == "cargo" }
    passenger = @trains.count { |train| train.type == "passenger" }
    puts "Грузовые поезда - #{cargo}"
    puts "Пассажирские поезда - #{passenger}"
  end

  def send_train(train)
    trains.delete(train) if trains.include?(train)
  end
end
