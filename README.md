# Bike Racker
Gets information about stations and corresponding number of locks and bikes at those stations as JSON

## Running the application
Using docker compose:

`docker compose up`

Using Ruby(requires Ruby 3.2.1 installed)

`
bundle install

bin/dev
`

## Endpoints

### GET http://localhost:3000
### GET http://localhost:3000/bike_racks
Gets all bike racks and realtime information about locks and bikes as an JSON array

### GET http://localhost:3000/bike_racks/search?query={query}
Searches for all bike racks that have {query} in its name and returns an JSON array of these

### GET http://localhost:3000/bike_racks/bikes_available
Gets an JSON array of all bike racks with bikes available

### GET http://localhost:3000/bike_racks/locks_available
Gets an JSON array of all bike racks with locks available