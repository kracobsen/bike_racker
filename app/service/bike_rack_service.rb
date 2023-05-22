class BikeRackService
  def initialize
    @conn = get_connection
  end

  def get_all_bike_racks
    bike_racks = get_bike_rack_list
    if bike_racks
      return Result.new(true, bike_racks, nil)
    end

    Result.new(false, nil, "Something went wrong")
  end

  def get_bike_rack_list
    begin
      station_information = get_station_information
      station_status = get_station_status
    rescue Faraday::ConnectionFailed
      nil
    end
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
    response = @conn.get("station_information.json")
    if response.success?
      return JSON.parse(response.body)["data"]["stations"]
    end
    nil
  end

  def get_station_status
    response = @conn.get("station_status.json")
    if response.success?
      return JSON.parse(response.body)["data"]["stations"]
    end
    nil
  end

  def get_connection
    puts "Getting connection"
    Faraday.new(
      url: "https://gbfs.urbansharing.com/oslobysykkel.no",
      headers: {"Accept" => "application/json"}
    )
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
