class Wagon
  include Company

  attr_reader :number, :company

  def initialize(number, company)
    @number = number
    @company = company
  end
end
