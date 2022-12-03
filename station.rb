class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  # принимает поезда
  def take_train(train)
    trains << train
  end

  # возвращает список id поездов по типу
  def train_list(type)
    trains.each { |train| puts train.id if train.type == type }
  end

  # отправляет поезда
  def send_train(train)
    trains.delete(train) if trains.include?(train)
  end

  private

  def validate!
    raise "Не указано название станции" if name == ""
  end
end
