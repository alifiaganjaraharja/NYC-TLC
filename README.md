# [TLC] - NYC Taxi Trip Analysis
By Alifia Ganjaraharja

This repository contains a data analysis project that utilizes SQL to examine taxi trip patterns to understand demand, pricing, and efficiency. This project utilizes a real public dataset recorded by the NYC Taxi & Limousine Commission (TLC), which is available on Google BigQuery.

## Project Overview:
This project utilizes a real public dataset from the NYC Taxi & Limousine Commission (TLC). It's ideal for practicing advanced SQL, including window functions and performance optimization on large datasets.
1. **Goals**: analyze taxi trip patterns to understand demand, pricing, and efficiency.

   **Sample Questions to Answer**:
   - Busiest Hours - What are the busiest hours of the day for taxi pickup? How does this change between weekdays and weekends?
   - Popular Routes - What are the top 10 most common pick-up and drop-off location combinations?
   - Trip Duration Analysis - How do trip duration and distance vary by time of day?
   - Tipping Behavior - Is there a correlation between the payment type (Cash vs. Credit Card) and tip amount?
   - Delivery Efficiency - Calculate the average time between a driver dropping off a passenger and picking up the next one. This one can be a great use for $LEAD()$ window function.
  
2. **Dataset**: The NYC Taxi & Limousine Commission (TLC) Trip record data is available as a public dataset on [Google BigQuery](https://console.cloud.google.com/marketplace/product/city-of-new-york/nyc-tlc-trips?hl=de&project=nyc-taxi-trip-475207). You can query it directly in the BigQuery console with a free account.

3. **Tools Used**: BigQuery and Looker

## Result and Findings

Question 1: Busiest Hours - What are the busiest hours of the day for taxi pickup? How does this change between weekdays and weekends?

See the full visualization of the line chart of Yellow Taxi [Here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-BusiestHours-YellowTaxi.pdf)

The pattern of demand shifts significantly:
- **Weekdays** are dominated by the Evening Commute/Dinner time (6 PM - 8 PM) with 72,575,146 total pickups, reflecting the typical rush of people leaving work and heading out.
- **Weekends** show a peak at Midnight (hour 0) with 25,554,686 total pickups, suggesting a stronger demand from Late Night/Nightlife activity. The weekday evening rush hours (6 PM - 7 PM) remain busy, but the overall highest volume shifts later into the night/early morning on weekends.

See the full visualization of the line chart of Green Taxi [here](https://github.com/alifiaganjaraharja/NYC-TLC/blob/main/visualizations/%5BNYC%5D-BusiestHours-GreenTaxi.pdf)

The overall change in pattern for green taxis is consistent** with the yellow taxi data, showing a clear shift from the commuting rush to nightlife demand:
- **Weekday Peak** concentrated entirely in the Evening Commute period (5 PM TO 7 PM, with 6 PM being the busiest with 3,990,528 total pickups).
- **Weekend Peak** Shifts to Midnight (hour 0) with 1,611,417 total pickups, with the late evening hours (6 PM and 7 PM) still maintaining high volume. The peak time itself moves later to capture people leaving social venues.

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

The most popular yellow taxi routes are overwhelmingly dominated by trips within and between the Midtown and Downtown Manhattan business districts, with a key link to the Upper East/West Sides. In summary, the Yellow Taxi data confirms its role as a high-volume carrier primarily serving the most dense and wealthy commuter routes in the Manhattan core, a very different pattern than the FHV and Green Taxi fleets.

Question 3: Trip Duration Analysis - How do trip duration and distance vary by time of day?

**NOTE**: For this question, the analysis is only done for the Green and Yellow Taxi because the FHV dataset doesn't include Trip Duration fields. 









