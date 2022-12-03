class WagonCargo < Wagon
  attr_reader :type

  def initialize(number, company, total_space)
    super(number, company, total_space)
    @type = :cargo
  end

  def take_space(volume)
    raise 'Загружаемый объём больше свободного места в вагоне. Уменьшите ваш объём' if volume > free_space
    raise 'В вагоне нет свободного места' if free_space.zero?

    self.occupied_space += volume
    self.free_space -= volume
  end
end
