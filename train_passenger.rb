class TrainPassenger < Train  
  def initialize(id, type, company)
    super(id, type, company)
    @type = 'пассажирский'
  end
end
