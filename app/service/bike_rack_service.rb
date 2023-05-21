class BikeRackService
  def get_all_bike_racks
    bike_racks = get_bike_rack_list
    if bike_racks
      return Result.new(true, bike_racks, nil)
    end

    Result.new(false, nil, "Something went wrong")
  end

  def get_bike_rack_list
    station_information = get_station_information
    station_status = get_station_status
    if station_information && station_status
      merge_information_and_status(station_information, station_status)
    end
  end

  def merge_information_and_status(information, status)
    bike_rack_list = information.map { |i| [i["station_id"], BikeRack.new(i["station_id"], i["name"])] }.to_h
    status.each do |stat|
      bike_rack_list[stat["station_id"]].available_bikes = stat["num_bikes_available"].to_i
      bike_rack_list[stat["station_id"]].available_locks = stat["num_docks_available"].to_i
    end
    bike_rack_list
  end

  def get_station_information
    response = Faraday.get("https://gbfs.urbansharing.com/oslobysykkel.no/station_information.json")
    if response.success?
      return JSON.parse(response.body)["data"]["stations"]
    end
    nil
  end

  def get_station_status
    response = Faraday.get("https://gbfs.urbansharing.com/oslobysykkel.no/station_status.json")
    if response.success?
      return JSON.parse(response.body)["data"]["stations"]
    end
    nil
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
