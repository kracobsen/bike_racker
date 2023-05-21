class BikeRacksController < ApplicationController
    def index
        result = BikeRackService.new.get_all_bike_racks
        render json: result
    end
end
