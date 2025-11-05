SELECT 
pickup_location_id, -- Pickup Location ID
dropoff_location_id, -- Drop Off Location ID
COUNT(*) AS total_trips
FROM 
-- Uses the wildcard to query all Yellow Taxi tables 
`bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_*`
GROUP BY 
pickup_location_id,
dropoff_location_id
ORDER BY total_trips DESC
LIMIT 10;