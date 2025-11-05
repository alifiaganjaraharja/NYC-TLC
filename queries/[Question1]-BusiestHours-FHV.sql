SELECT
  -- 1. Create a new category for Weekday and Weekend
  CASE WHEN EXTRACT(DAYOFWEEK FROM pickup_datetime) IN (1,7) THEN 'Weekend'
  ELSE 'Weekday'
  END AS day_type,

  -- 2. Extract the pickup hour from the FHV pickup time
  EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour,

  -- 3. Count all trips
  COUNT(*) AS total_pickups
FROM 
  -- This line queries all tables that start with 'tlc_fhv_trips'
`bigquery-public-data.new_york_taxi_trips.tlc_fhv_trips_*`
GROUP BY 
  -- 4. Group by BOTH the new category and the pickup_hour
  day_type, 
  pickup_hour
ORDER BY
  -- 5. Sort by day type, then by the busiest hours
  day_type,
  total_pickups DESC;