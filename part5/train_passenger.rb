class TrainPassenger < Train  
  def initialize(id, type)
    super(id, type)
    @type = 'пассажирский'
  end
end
