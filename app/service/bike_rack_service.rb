class BikeRackService
  def get_all_bike_racks
    bike_racks = [BikeRack.new(1, "Bike Rack 1", 5, 5), BikeRack.new(2, "Bike Rack 2", 3, 7)] 
    return Result.new(true, bike_racks, nil)
  end


  class Result 
    attr_accessor :success, :bike_racks, :error_message

    def initialize(success, bike_racks, error_message)
      @success = success
      @bike_racks = bike_racks
      @error_message = error_message
    end
  end
end