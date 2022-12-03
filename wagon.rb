class Wagon
  include Company
  include Validation

  NUMBER_FORMAT = /^[1-9][0-9]?$/.freeze # от 1 до 99

  attr_reader :number, :company

  def initialize(number, company)
    @number = number
    @company = company
    validate!
  end

  protected

  def validate!
    errors = []

    errors << "Не указан номер вагона" if number == ""
    errors << "Не указано название компании изготовителя вагона" if company == ""
    errors << "Неверный формат номера вагона" if number !~ NUMBER_FORMAT

    raise errors.join('. ') unless errors.empty?
  end
end
