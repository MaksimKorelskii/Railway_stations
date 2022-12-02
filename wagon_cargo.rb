class WagonCargo < Wagon
  attr_reader :type

  def initialize(number, company)
    super(number, company)
    @type = 'грузовой'
  end
end
