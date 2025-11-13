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




