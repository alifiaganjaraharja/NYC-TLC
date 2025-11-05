SELECT 
  payment_type,
  COUNT(*) AS trip_count,
  ROUND(AVG(tip_amount), 2) AS avg_tip,
  ROUND(AVG(fare_amount), 2) AS avg_fare,
  ROUND(AVG(tip_amount / NULLIF(fare_amount, 0) * 100), 2) AS avg_tip_percentage,
FROM -- This line queries all tables that start with 'tlc_green_trips'
`bigquery-public-data.new_york_taxi_trips.tlc_green_trips_*`
WHERE payment_type IN ('1', '2')  -- Only these two (Cash vs. Credit Card)
  AND pickup_location_id IS NOT NULL 
  AND dropoff_location_id IS NOT NULL
  AND fare_amount > 0
GROUP BY payment_type;