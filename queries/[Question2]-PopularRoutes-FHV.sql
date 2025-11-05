SELECT 
location_id, -- Pickup Location ID
dropoff_location_id, -- Drop Off Location ID
COUNT(*) AS total_trips
FROM 
-- Uses only the FHV trip 2017 table 
`bigquery-public-data.new_york_taxi_trips.tlc_fhv_trips_2017`
WHERE location_id IS NOT NULL 
  AND dropoff_location_id IS NOT NULL
GROUP BY 
location_id,
dropoff_location_id
ORDER BY total_trips DESC
LIMIT 10;