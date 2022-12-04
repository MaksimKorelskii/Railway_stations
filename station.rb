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

  def trains_on_station(&block)
    trains.each { |train| block.call(train) } unless trains.empty?
    puts 'Поездов нет.' if trains.empty?
  end

  def self.all
    @@stations
  end

  # принимает поезда
  def take_train(train)
    trains << train
  end

  # отправляет поезда
  def send_train(train)
    trains.delete(train) if trains.include?(train)
  end

  private

  def validate!
    raise 'Не указано название станции' if name == ''
  end
end
