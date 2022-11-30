class TrainCargo < Train
  def initialize(id, type)
    super(id, type)
    @type = 'грузовой'
  end
end
