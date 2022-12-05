class Wagon
  include Company
  include Validation

  NUMBER_FORMAT = /^[1-9][0-9]?$/.freeze # от 1 до 99

  attr_reader :number, :company, :total_space, :occupied_space

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :company, :presence
  validate :total_space, :presence

  def initialize(number, company, total_space)
    @number = number
    @company = company
    validate!
    @total_space = total_space
    @occupied_space = 0
  end

  def free_space
    total_space - occupied_space
  end

  protected

  attr_writer :occupied_space
end
