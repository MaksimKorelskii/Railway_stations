class WagonCargo < Wagon
  attr_reader :type

  def initialize(number)
    super(number)
    @type = 'грузовой'
  end
end
