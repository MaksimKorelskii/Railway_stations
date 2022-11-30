class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  # может принимать поезда
  def take_train(train)
    trains << train
  end

  # может поазывать список id поездов по типу
  def train_list(type)
    trains.each { |train| puts train.id if train.type == type }
  end

  # может отправлять поезда
  def send_train(train)
    trains.delete(train) if trains.include?(train)
  end
end
