class BikeRacksController < ApplicationController
    def index
       result = [BikeRack.new(1, "Bike Rack 1", 5, 5), BikeRack.new(2, "Bike Rack 2", 3, 7)] 
       render json: result
    end
end
