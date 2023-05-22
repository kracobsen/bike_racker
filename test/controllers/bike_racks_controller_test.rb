require "test_helper"

class BikeRacksControllerTest < ActionDispatch::IntegrationTest
  test "index returns success and 1 station when there is 1 station in the response" do
    BikeRackService.stub_any_instance(:get_connection, test_connection_return_1_station) do
      get bike_racks_url
      assert_response :success

      json_response = JSON.parse(response.body)
      assert_equal json_response.count, 1
      # Check that content is correctly parsed
      assert_equal json_response["1"]["id"], "1"
      assert_equal json_response["1"]["name"], "Skøyen Stasjon"
      assert_equal json_response["1"]["available_bikes"], 7
      assert_equal json_response["1"]["available_locks"], 13
    end
  end

  test "index returns success and 5 station when there are 5 stations in the response" do
    BikeRackService.stub_any_instance(:get_connection, test_connection_return_5_stations) do
      get bike_racks_url
      assert_response :success

      json_response = JSON.parse(response.body)
      assert_equal json_response.count, 5
      # Check that content is correctly parsed
      assert_equal json_response["2"]["id"], "2"
      assert_equal json_response["2"]["name"], "Bryn Stasjon"
      assert_equal json_response["2"]["available_bikes"], 0
      assert_equal json_response["2"]["available_locks"], 10
    end
  end

  test "index returns internal server error when connection fails" do
    BikeRackService.stub_any_instance(:get_connection, test_connection_connection_failed) do
      get bike_racks_url
      assert_response :internal_server_error

      json_response = JSON.parse(response.body)
      assert_equal json_response["error_message"], "Something went wrong"
    end
  end

  test "index returns internal server error when API returns something else than sucess(200)" do
    BikeRackService.stub_any_instance(:get_connection, test_connection_returns_400) do
      get bike_racks_url
      assert_response :internal_server_error

      json_response = JSON.parse(response.body)
      assert_equal json_response["error_message"], "Something went wrong"
    end
  end

  private

  def test_connection_return_1_station
    Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.get("/station_information.json") { |env| [200, {}, File.read("test/fixtures/files/station_information_1_station.json")] }
        stub.get("/station_status.json") { |env| [200, {}, File.read("test/fixtures/files/station_status_1_station.json")] }
      end
    end
  end

  def test_connection_return_5_stations
    Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.get("/station_information.json") { |env| [200, {}, File.read("test/fixtures/files/station_information_5_stations.json")] }
        stub.get("/station_status.json") { |env| [200, {}, File.read("test/fixtures/files/station_status_5_stations.json")] }
      end
    end
  end

  def test_connection_returns_400
    Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.get("/station_information.json") { |env| [400, {}, ""] }
        stub.get("/station_status.json") { |env| [400, {}, ""] }
      end
    end
  end

  def test_connection_connection_failed
    Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.get("/station_information.json") do
          raise Faraday::ConnectionFailed
        end
        stub.get("/station_status.json") do
          raise Faraday::ConnectionFailed
        end
      end
    end
  end
end
