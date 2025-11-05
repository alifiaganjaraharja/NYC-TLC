SELECT 
  EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour, 
  ROUND(AVG(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)),1) AS avg_duration_minutes,
  ROUND(AVG(trip_distance),1) AS avg_distance_miles
FROM -- This line queries all tables that start with 'tlc_green_trips'
`bigquery-public-data.new_york_taxi_trips.tlc_green_trips_*`
WHERE pickup_location_id IS NOT NULL
AND dropoff_location_id IS NOT NULL
AND dropoff_datetime IS NOT NULL
AND pickup_datetime IS NOT NULL
AND trip_distance IS NOT NULL
GROUP BY pickup_hour
ORDER BY pickup_hour;