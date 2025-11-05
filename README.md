# [TLC] - NYC Taxi Trip Analysis
By Alifia Ganjaraharja

This repository contains a data analysis project that utilizes SQL to examine taxi trip patterns to understand demand, pricing, and efficiency. This project utilizes a real public dataset that was recorded by the NYC Taxi & Limousine Commission (TLC), which is available on Google BigQuery.

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
