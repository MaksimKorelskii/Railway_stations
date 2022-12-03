class WagonCargo < Wagon
  attr_reader :type

  def initialize(number, company)
    super(number, company)
    @type = :cargo
  end
end
