class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
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
