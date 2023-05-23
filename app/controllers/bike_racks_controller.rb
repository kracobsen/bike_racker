class BikeRacksController < ApplicationController
  def index
    result = BikeRackService.new.get_all_bike_racks
    if result.success
      render json: result.bike_racks
    else
      render json: {error_message: result.error_message}, status: :internal_server_error
    end
  end

  def search
    result = BikeRackService.new.search_bike_racks(params[:query])
    if result.success
      render json: result.bike_racks
    else
      render json: {error_message: result.error_message}, status: :internal_server_error
    end
  end

  def bikes_available
    result = BikeRackService.new.get_bikes_available_bike_racks
    if result.success
      render json: result.bike_racks
    else
      render json: {error_message: result.error_message}, status: :internal_server_error
    end
  end

  def locks_available
    result = BikeRackService.new.get_locks_available_bike_racks
    if result.success
      render json: result.bike_racks
    else
      render json: {error_message: result.error_message}, status: :internal_server_error
    end
  end
end
