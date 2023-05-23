class BikeRack
  attr_accessor :id,:name, :available_bikes, :available_locks

  def initialize(id, name)
    @id = id
    @name = name
    @available_bikes = 0
    @available_locks = 0
  end
end