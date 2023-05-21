require "test_helper"

class BikeRacksControllerTest < ActionDispatch::IntegrationTest
  test "index returns success" do
    get bike_racks_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.count == 2
  end
end
