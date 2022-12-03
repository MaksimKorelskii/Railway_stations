class TrainPassenger < Train  
  def initialize(id, type, company)
    super(id, type, company)
    @type = :passenger
  end
end
