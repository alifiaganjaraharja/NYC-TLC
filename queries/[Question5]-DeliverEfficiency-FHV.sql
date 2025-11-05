SELECT 
  dispatching_base_num,
  pickup_datetime, 
  LEAD(pickup_datetime,1) OVER (PARTITION BY dispatching_base_num ORDER BY pickup_datetime) AS next_pickup_datetime, -- To retrieve the next pick up date and time
  TIMESTAMP_DIFF(LEAD(pickup_datetime,1) OVER (PARTITION BY dispatching_base_num ORDER BY pickup_datetime), pickup_datetime, MINUTE) AS gap_in_minutes -- To calculate the difference/gap between the next pick up date and time
FROM `bigquery-public-data.new_york_taxi_trips.tlc_fhv_trips_2017`
WHERE dropoff_datetime IS NOT NULL
AND pickup_datetime IS NOT NULL
ORDER BY dispatching_base_num, pickup_datetime ASC;