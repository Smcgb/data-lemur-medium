--https://datalemur.com/questions/odd-even-measurements

--Assume you're given a table with measurement values obtained from a Google sensor over multiple days with measurements taken multiple times within each day.

--Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns. Refer to the Example Output below for the desired format.

--Definition:

--Within a day, measurements taken at 1st, 3rd, and 5th times are considered odd-numbered measurements, and measurements taken at 2nd, 4th, and 6th times are considered even-numbered measurements.

--subquery with row_number() function and case statement

with t1 as (SELECT DATE(measurement_time) mday, measurement_value mval, 
ROW_NUMBER() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time) morder
  FROM measurements
  ORDER BY 1 ASC),
  
t2 as (SELECT mday, sum(mval) mval, morder
FROM t1
GROUP BY mday, morder
order by mday ASC, morder ASC)

SELECT mday, 
  SUM(CASE 
    WHEN morder %2=1 THEN mval 
    ELSE 0 
    END) AS odd,
  SUM(CASE 
    WHEN morder %2=0 THEN mval 
    ELSE 0 
    END) AS Even
  FROM t2
  GROUP BY mday

