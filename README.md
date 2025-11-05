# [TLC] - NYC Taxi Trip Analysis
By Alifia Ganjaraharja

This repository contains a data analysis project that utilizes SQL to examine taxi trip patterns to understand demand, pricing, and efficiency. This project utilizes a real public dataset that was recorded by the NYC Taxi & Limousine Commission (TLC), which is available on Google BigQuery.

## Project Overview:
This project utilizes a real public dataset from the NYC Taxi & Limousine Commission (TLC). It's perfect for practicing advanced SQL, including window functions and performance optimization on big data.
1. **Goals**: analyze taxi trip patterns to understand demand, pricing, and efficiency.

   **Sample Questions to Answer**:
   - Busiest Hours: What are the busiest hours of the day for taxi pickup? How does this change between weekdays and weekends?
   - Popular Routes: What are the top 10 most common pick-up and drop-off location combinations?
   - Trip Duration Analysis: How do trip duration and distance vary by time of day?
   - Tipping Behavior: Is there a correlation between the payment type (Cash vs. Credit Card) and tip amount?
   - Delivery Efficiency: Calculate the average time between a driver dropping off a passenger and picking up the next one. This one can be a great use for $LEAD()$ window function.
  
2. **Dataset**: The NYC Taxi & Limousine Commission (TLC) Trip record data is available as a public dataset on [Google BigQuery](https://console.cloud.google.com/marketplace/product/city-of-new-york/nyc-tlc-trips?hl=de&project=nyc-taxi-trip-475207). You can query it directly in the BigQuery console with a free account.

3. **Tools Used**: BigQuery

## Result and Findings

Question 1: Busiest Hours - What are the busiest 
