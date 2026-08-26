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
> 🔗 **Data Tables:** [FHV Route Summary](LINK_HERE) | [Green Taxi Route Summary](LINK_HERE) | [Yellow Taxi Route Summary](LINK_HERE)

> **Dataset Limitation Note:** For For-Hire Vehicles (FHV), analysis is restricted to **2017 data** because subsequent years lack drop-off location IDs. Results are based on 107.9M trips (56% of total 2017 FHV records) containing complete location data. Green Taxi covers **2014–2023** and Yellow Taxi covers **2011–2023**.

* **For-Hire Vehicles (FHV - 2017):** Routes are characterized by strong airport connections (JFK/LGA) and frequent intra-neighborhood trips (starting and ending in the same zone). Demand is split between high-volume, long-distance airport transit and high-frequency, short-distance trips within outer boroughs.
* **Green Taxi (2014–2023):** Dominated by two major patterns: intra-zone local trips within non-Manhattan neighborhoods and connecting routes to LaGuardia Airport (LGA).
* **Yellow Taxi (2011–2023):** Overwhelmingly dominated by trips within and between Midtown and Downtown Manhattan business districts, alongside key connections to the Upper East and Upper West Sides. Serves primarily high-density commuter corridors in core Manhattan.

---

### Question 3: Trip Duration & Traffic Congestion
> 🔗 **Visualizations:** [Green Taxi Duration vs Distance](LINK_HERE) | [Yellow Taxi Duration vs Distance](LINK_HERE)

> **Dataset Limitation Note:** Evaluated for Green Taxi (2014–2023) and Yellow Taxi (2011–2023). Excludes FHV fleet as the dataset lacks duration fields.

**The Congestion Effect:**
* **High-Efficiency Window (4 AM – 8 AM):** Average distances reach daily highs (up to **13.8 miles** for Green, **11.9 miles** at 5 AM for Yellow), while trip duration remains short (**13.3 to 20 mins**). Low traffic allows high-speed travel.
* **Low-Efficiency Window (3 PM – 5 PM):** Distances drop significantly (**5.9 – 7.4 miles**), yet durations peak (**19 – 26.2 mins**). Yellow Taxis hit their slowest average speeds at 3 PM (averaging **6.4 miles in 26.2 minutes**), illustrating severe afternoon gridlock.

---

### Question 4: Tipping Behavior & Payment Type
> 🔗 **Visualizations:** [Green Taxi Tipping Patterns](LINK_HERE) | [Yellow Taxi Tipping Patterns](LINK_HERE)

> **Dataset Limitation Note:** Evaluated for Green Taxi (2014–2023) and Yellow Taxi (2011–2023). Excludes FHV fleet as the dataset lacks tip amount fields. Note that cash tips are unrecorded in official TLC log systems.

* **Green Taxi (2014–2023):** Unlike Yellow Taxis (where digital payments dominate), Green Taxis record slightly higher cash trip volume (**35.2M cash** vs. **32.1M digital**). However, the Digital Average Fare (**$13.92**) is notably higher than Yellow Taxi digital fares (**$13.01**).
* **Yellow Taxi (2011–2023):** Digital payments (Credit Card) drive higher recorded revenues and capture an average **23% tipping premium** compared to cash transactions (which record $0 tips in official system logs).

---

### Question 5: Driver Turnaround Efficiency
> 🔗 **Visualizations:** [FHV Top Dispatching Bases Chart](LINK_HERE)

> **Dataset Limitation Note:** Evaluated using **2017 FHV data**, as Green and Yellow Taxi logs do not record `dispatching_base_num` or driver-specific identifiers.

Using `LEAD()` window functions to measure the idle time between a driver dropping off a passenger and picking up the next across ~765 drivers:

* **Hyper-Efficiency:** The top 20 most efficient FHV dispatching bases exhibit wait times tightly clustered between **0.02 minutes (1.2 seconds)** and **0.17 minutes (10.2 seconds)**.
* **Operational Insight:** These low values point to systematic dispatching advantages, likely driven by pre-scheduled app bookings or automated matching algorithms that minimize driver idle time between trips.

---

## 🛠️ SQL Implementation Example

```sql
-- Example: Calculating idle time between trips using LEAD() (2017 FHV Dataset)
SELECT 
  dispatching_base_num,
  driver_id,
  pickup_datetime,
  dropoff_datetime,
  TIMESTAMP_DIFF(
    LEAD(pickup_datetime) OVER (PARTITION BY driver_id ORDER BY pickup_datetime),
    dropoff_datetime,
    SECOND
  ) / 60.0 AS idle_time_minutes
FROM 
  `bigquery-public-data.new_york_taxi_trips.tlc_fhv_trips_2017`
WHERE 
  driver_id IS NOT NULL;




## Result and Findings

Question 2: Popular Routes - What are the top 10 most common pick-up and drop-off location combinations?

- **FHV**
  
**NOTE**: For FHV, the analysis is only done for 2017 because the rest of the dataset doesn't contain any drop-off location ID. And the result of the analysis is based on 107,9M trips (56%) with complete location data. 

See the result table [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-PopularRoute-FHV.pdf)

The most popular routes for For-Hire Vehicles are characterized by a strong connection to airports and frequent intra-neighborhood trips (trips starting and ending in the same zone). This analysis clearly demonstrates that FHV demand is split between high-volume, long-distance trips (especially to and from airports/regions) and high-frequency, short-distance trips within dense Manhattan and core neighborhood areas.

- **Green Taxi**

See the result table [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-PopularRoutes-GreenTaxi.pdf)

The most popular green taxi routes are dominated by two major trip types: intra-zone trips (trips starting and ending in the same neighborhood) and trips involving LaGuardia Airport (LGA).

- **Yellow Taxi**

See the result table [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-PopularRoutes-YellowTaxi.pdf)

The most popular yellow taxi routes are overwhelmingly dominated by trips within and between the Midtown and Downtown Manhattan business districts, with a key link to the Upper East/West Sides. In summary, the Yellow Taxi data confirms its role as a high-volume carrier, primarily serving the most densely populated and affluent commuter routes in the Manhattan core, a distinct pattern from the FHV and Green Taxi fleets.

Question 3: Trip Duration Analysis - How do trip duration and distance vary by time of day?

**NOTE**: For this question, the analysis is only done for the Green and Yellow Taxi because the FHV dataset doesn't include Trip Duration fields. 

- **Green Taxi**

See the full visualization of the line chart of Green Taxi [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TripDuration-GreenTaxi.pdf)

The data show a distinct pattern, where trip distance peaks in the early morning commute, while duration remains relatively stable, suggesting faster travel times for longer trips. 

**Trip Efficiency Analysis (The Congestion Effect)**

Comparing the two columns reveals a crucial insight about traffic and efficiency:
1. **High Efficiency (4 AM - 8 AM)**: The trips are very long (up to 13,8 miles), but the average duration only slightly increases (~19 - 20 minutes). This indicates that the longest trips of the day occur when there is very little congestion, resulting in high-speed travel.
2. **Low Efficiency (3 PM - 5 PM)**: Distances are relatively short (~5.9 - 7.4 miles), but the duration remains relatively high (~19 - 22 minutes). This suggests that trips are moving slowly due to heavy afternoon/evening traffic congestion.

- **Yellow Taxi**

See the full visualization of the line chart of Yellow Taxi [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TripDuration-YellowTaxi.pdf)

The  data reveals a classic pattern of Manhattan-centric congestion and usage, where trip time is maximized during the afternoon/evening rush hour, even though distances aren't the longest. 

**Trip Efficiency Analysis (The Congestion Effect)**

The most important insight comes from comparing the duration and distance at different times:
1. **Highest Efficiency (5 AM - 6 AM)**: At 5 AM (hour 5), the average duration is 13.3 minutes for a distance of 11.9 miles. And the longest trips of the day are taken in the shortest amount of time, clearly showing that trips are completed at high speed with virtually zero congestion.
2. **Lowest Efficiency (3 PM - 4 PM)**: At 3 PM (hour 15), the average duration is 26.2 minutes for a distance of 6.4 miles. And this result is an incredibly slow average speed, indicating maximum gridlock. The trips are long in time but only moderately long in distance.

Question 4: Tipping Behavior - Is there a correlation between the payment type (Cash vs. Credit Card) and tip amount?

**NOTE**: For this question, the analysis is only done for the Green and Yellow Taxi because the FHV dataset doesn't include the Tip Amount field. 

- **Green Taxi**

See the full visualization of the line chart of Green Taxi [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TippingBehavior-GreenType.pdf)

Key Comparative Insights for the Green Taxi Fleet
1. **Payment Preference**: Unlike Yellow Taxis, where digital payments had a higher trip count, Green Taxis see a slightly higher volume of cash trips (35.2M) than digital trips (32.1M).
2. **Highest Fare**: The Digital Average Fare ($13.92) for Green Taxis is notably higher than the Digital Average Fare for Yellow Taxis ($13.01), suggesting that the high-value Green Taxi trips are among the most expensive in the combined system. 

- **Yellow Taxi**

See the full visualization of the line chart of Green Taxi [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-TippingBehavior-YellowTaxi.pdf)

The data proves that digital payment (Type 1) is the driver of recorded revenue and higher-value trips for Yellow Taxis. Any financial analysis or policy decision relying solely on recorded transaction values must account for the 23% tipping premium on digital payments and the missing tip revenue from cash transactions.

Question 5: Delivery Efficiency - Calculate the average time between a driver dropping off a passenger and picking up the next one. This one can be a great use for $LEAD()$ window function.

**NOTE**: For this question, the analysis is only done for the FHV (specifically the 2017) because either the Green and/or Yellow Taxi dataset doesn't include the 'dispatching_base_num' field or any driver info field. 

See the full visualization of the horizontal bar chart of FHV [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-DeliverEfficiency-FHV.pdf)

**Interpretation: Hyper-Efficiency**
This data represents the Top 20 Most Efficient For-Hire Vehicle (FHV) Dispatching Bases based on the average time a driver spends waiting between dropping off one passenger and picking up the next from a total of around 765 drivers.

The striking feature of this result is the extremely low values for the average time between rides, which indicate **hyper-efficiency** for these dispatching bases.

The values are tightly clustered, ranging from 0.02 minutes to 0.17 minutes. This small range demonstrates that the top 20 bases are not just lucky; they have a systematic operational advantage that keeps their drivers on the road and earning with minimal idle time. 

This result confirms that these dispatching bases are the absolute leaders in fleet efficiency within the FHV market.

