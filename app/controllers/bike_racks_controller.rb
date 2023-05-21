class BikeRacksController < ApplicationController
  def index
    result = BikeRackService.new.get_all_bike_racks
    if result.success
      render json: result.bike_racks
    else
      render json: {error_message: result.error_message}, status: :internal_server_error
    end
  end
end
