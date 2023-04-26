--https://datalemur.com/questions/rolling-average-tweets

--Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

--Notes:

    --A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time.
    --In this case, we want to determine how the tweet count for each user changes over a 3-day period.
	
--using avg window function rows BETWEEN

SELECT user_id, tweet_date,
  Round(AVG(count(*)) 
    OVER (PARTITION BY 
            user_id 
          ORDER BY 
            tweet_date 
          ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) 
    as rolling_avg_3d
FROM tweets
GROUP BY user_id, tweet_date;
