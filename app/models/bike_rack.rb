class BikeRack
  attr_accessor :id,:name, :available_bikes, :available_locks

  def initialize(id, name, available_bikes, available_locks)
    @id = id
    @name = name
    @available_bikes = available_bikes
    @available_locks = available_locks
  end
end