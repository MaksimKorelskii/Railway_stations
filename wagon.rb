class Wagon
  include Company

  NUMBER_FORMAT = /^[1-9][0-9]?$/.freeze # от 1 до 99

  attr_reader :number, :company

  def initialize(number, company)
    @number = number
    @company = company
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Не указан номер вагона" if number == ""
    raise "Не указано название компании изготовителя вагона" if company == ""
    raise "Неверный формат номера вагона" if number !~ NUMBER_FORMAT
  end
end
