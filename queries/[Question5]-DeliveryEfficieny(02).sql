/*
 * Step 1: Calculate the downtime (gap) for each ride sequence.
 * We use a CTE for clarity and to store the next pickup time.
 */
WITH DriverDowntime AS (
  SELECT 
  dispatching_base_num,
  pickup_datetime, 
  LEAD(pickup_datetime,1) OVER (PARTITION BY dispatching_base_num ORDER BY pickup_datetime) AS next_pickup_datetime, -- To retrieve the next pick up date and time
  TIMESTAMP_DIFF(LEAD(pickup_datetime,1) OVER (PARTITION BY dispatching_base_num ORDER BY pickup_datetime), pickup_datetime, MINUTE) AS gap_in_minutes -- To calculate the difference/gap between the next pick up date and time
FROM `bigquery-public-data.new_york_taxi_trips.tlc_fhv_trips_2017`
WHERE dropoff_datetime IS NOT NULL
AND pickup_datetime IS NOT NULL
)

/*
 * Step 2: Calculate the average of the time gaps.
 */
SELECT
  dispatching_base_num,
  
  -- Calculate the average time difference in minutes
  ROUND(
    AVG(gap_in_minutes),2 ) AS avg_minutes_between_rides --To calculate the average of the time gaps
FROM DriverDowntime
WHERE gap_in_minutes IS NOT NULL -- Exclude the last ride of each driver (where gap_in_minutes is NULL)
GROUP BY dispatching_base_num
ORDER BY dispatching_base_num;