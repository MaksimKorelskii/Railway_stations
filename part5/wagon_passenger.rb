class WagonPassenger < Wagon
  attr_reader :type

  def initialize(number)
    super(number)
    @type = 'пассажирский'
  end
end
