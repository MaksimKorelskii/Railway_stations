class TrainCargo < Train
  def initialize(id, type, company)
    super(id, type, company)
    @type = :cargo
  end
end
