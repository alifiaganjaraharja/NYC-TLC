SELECT 
pickup_location_id, -- Pickup Location ID
dropoff_location_id, -- Drop Off Location ID
COUNT(*) AS total_trips
FROM 
-- Uses the wildcard to query all Green Taxi tables (2014 - 2023) 
`bigquery-public-data.new_york_taxi_trips.tlc_green_trips_*`
GROUP BY 
pickup_location_id,
dropoff_location_id
ORDER BY total_trips DESC
LIMIT 10;