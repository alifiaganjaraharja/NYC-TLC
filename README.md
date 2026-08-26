# NYC Taxi & Limousine Commission (TLC) Trip Analysis
**Author:** Alifia Ganjaraharja  
**Tools Used:** Google BigQuery (SQL) and Looker  
**Dataset:** NYC TLC Public Dataset [Google BigQuery](https://console.cloud.google.com/marketplace/product/city-of-new-york/nyc-tlc-trips?hl=de&project=nyc-taxi-trip-475207)

---

## 📌 Project Overview
This repository contains a data analysis project examining taxi trip patterns in New York City to understand demand, pricing, and efficiency. The project utilizes a multi-year public dataset recorded by the NYC Taxi & Limousine Commission (TLC) available on Google BigQuery. 

It serves as an exploration of advanced SQL techniques—including window functions (`LEAD()`) and performance optimization across high-volume datasets—paired with data visualization to uncover urban mobility patterns.

### 📅 Dataset Coverage
* **Yellow Taxi:** 2011 – 2023  
* **Green Taxi:** 2014 – 2023  
* **For-Hire Vehicles (FHV):** 2017 *(Selected multi-year records depending on field availability)*

### Key Questions
1. **Busiest Hours:** What are the busiest hours of the day for taxi pickup, and how does this shift between weekdays and weekends?
2. **Popular Routes:** What are the top 10 most common pickup and drop-off location combinations across vehicle fleets?
3. **Trip Duration Analysis:** How do trip duration and distance vary by time of day, and what does this reveal about traffic congestion?
4. **Tipping Behavior:** Is there a correlation between payment type (Cash vs. Credit Card) and tip amount?
5. **Driver Turnaround Efficiency:** What is the average time between a driver dropping off a passenger and picking up the next one?

---

## Results & Findings

### Question 1: Busiest Hours
> 🔗 **Visualizations:** [Yellow Taxi Pickup Demand Chart](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-BusiestHours-YellowTaxi.pdf) | [Green Taxi Pickup Demand Chart](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-BusiestHours-GreenTaxi.pdf)

The pattern of demand shifts significantly between weekdays and weekends across both fleets (evaluated across **Yellow Taxi: 2011–2023** and **Green Taxi: 2014–2023**):

* **Yellow Taxi (2011–2023):**
  * **Weekday Peak:** Dominated by the evening commute/dinner period (**6 PM – 8 PM**) with **72,575,146 total pickups**, reflecting standard work-commute patterns.
  * **Weekend Peak:** Shifts to **Midnight (Hour 0)** with **25,554,686 total pickups**, driven by nightlife activity. Late evening hours (6 PM – 7 PM) remain busy, but peak volume moves later.
* **Green Taxi (2014–2023):**
  * **Weekday Peak:** Concentrated entirely in the evening commute (**5 PM – 7 PM**, peaking at 6 PM with **3,990,528 pickups**).
  * **Weekend Peak:** Shifts to **Midnight (Hour 0)** with **1,611,417 pickups**, with high sustained volume throughout late evening hours (6 PM – 7 PM).

---

### Question 2: Popular Routes
> 🔗 **Data Tables:** [FHV Route Summary](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-PopularRoute-FHV.pdf) | [Green Taxi Route Summary](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-PopularRoutes-GreenTaxi.pdf) | [Yellow Taxi Route Summary](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-PopularRoutes-YellowTaxi.pdf)

> **Dataset Limitation Note:** For For-Hire Vehicles (FHV), analysis is restricted to **2017 data** because subsequent years lack drop-off location IDs. Results are based on 107.9M trips (56% of total 2017 FHV records) containing complete location data. Green Taxi covers **2014–2023** and Yellow Taxi covers **2011–2023**.

* **For-Hire Vehicles (FHV - 2017):** Routes are characterized by strong airport connections (JFK/LGA) and frequent intra-neighborhood trips (starting and ending in the same zone). Demand is split between high-volume, long-distance airport transit and high-frequency, short-distance trips within outer boroughs.
* **Green Taxi (2014–2023):** Dominated by two major patterns: intra-zone local trips within non-Manhattan neighborhoods and connecting routes to LaGuardia Airport (LGA).
* **Yellow Taxi (2011–2023):** Overwhelmingly dominated by trips within and between Midtown and Downtown Manhattan business districts, alongside key connections to the Upper East and Upper West Sides. Serves high-density commuter corridors in core Manhattan.

---

### Question 3: Trip Duration & Traffic Congestion
> 🔗 **Visualizations:** [Green Taxi Duration vs Distance](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TripDuration-GreenTaxi.pdf) | [Yellow Taxi Duration vs Distance](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TripDuration-YellowTaxi.pdf)

> **Dataset Limitation Note:** Evaluated for Green Taxi (2014–2023) and Yellow Taxi (2011–2023). Excludes the FHV fleet as the dataset lacks duration fields.

**The Congestion Effect:**
* **High-Efficiency Window (4 AM – 8 AM):** Average distances reach daily highs (up to **13.8 miles** for Green, **11.9 miles** at 5 AM for Yellow), while trip duration remains short (**13.3 to 20 mins**). Low traffic allows high-speed travel.
* **Low-Efficiency Window (3 PM – 5 PM):** Distances drop significantly (**5.9 – 7.4 miles**), yet durations peak (**19 – 26.2 mins**). Yellow Taxis hit their slowest average speeds at 3 PM (averaging **6.4 miles in 26.2 minutes**), illustrating severe afternoon gridlock.

---

### Question 4: Tipping Behavior & Payment Type
> 🔗 **Visualizations:** [Green Taxi Tipping Patterns](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TippingBehavior-GreenType.pdf) | [Yellow Taxi Tipping Patterns](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TippingBehavior-YellowTaxi.pdf)

> **Dataset Limitation Note:** Evaluated for Green Taxi (2014–2023) and Yellow Taxi (2011–2023). Excludes FHV fleet as the dataset lacks tip amount fields. Note that cash tips are unrecorded in official TLC log systems.

* **Green Taxi (2014–2023):** Unlike Yellow Taxis (where digital payments dominate), Green Taxis record slightly higher cash trip volume (**35.2M cash** vs. **32.1M digital**). However, the Digital Average Fare (**$13.92**) is notably higher than Yellow Taxi digital fares (**$13.01**).
* **Yellow Taxi (2011–2023):** Digital payments (Credit Card) drive higher recorded revenues and capture an average **23% tipping premium** compared to cash transactions (which record $0 tips in official system logs).

---

### Question 5: Driver Turnaround Efficiency
> 🔗 **Visualizations:** [FHV Top Dispatching Bases Chart](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-DeliverEfficiency-FHV.pdf)

> **Dataset Limitation Note:** Evaluated using **2017 FHV data**, as Green and Yellow Taxi logs do not record `dispatching_base_num` or driver-specific identifiers.

Using `LEAD()` window functions to measure the idle time between a driver dropping off a passenger and picking up the next across ~765 drivers:

* **Hyper-Efficiency:** The top 20 most efficient FHV dispatching bases exhibit wait times tightly clustered between **0.02 minutes (1.2 seconds)** and **0.17 minutes (10.2 seconds)**.
* **Operational Insight:** These low values point to systematic dispatching advantages, likely driven by pre-scheduled app bookings or automated matching algorithms that minimize driver idle time between trips.

---

## 🛠️ SQL Implementation Example

```sql
-- Example: Calculating average idle time between trips using LEAD() of each driver (dispatching_base_num) (2017 FHV Dataset)
/*
 * Step 1: Calculate the downtime (gap) for each ride sequence.
 * We use a CTE for clarity and to store the next pickup time.
 */
WITH DriverDowntime AS (
  SELECT 
  dispatching_base_num,
  pickup_datetime, 
  LEAD(pickup_datetime,1) OVER (PARTITION BY dispatching_base_num ORDER BY pickup_datetime) AS next_pickup_datetime, -- To retrieve the next pick up date and time
  TIMESTAMP_DIFF(LEAD(pickup_datetime,1) OVER (PARTITION BY dispatching_base_num ORDER BY pickup_datetime), pickup_datetime, MINUTE) AS gap_in_minutes -- To calculate the difference/gap between the next pickup date and time
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
