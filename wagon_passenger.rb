class WagonPassenger < Wagon
  attr_reader :type

  def initialize(number, company)
    super(number, company)
    @type = 'пассажирский'
  end
end
