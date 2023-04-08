--https://datalemur.com/questions/sql-highest-grossing
--Highest-Grossing Items

--Assume you are given the table containing information on Amazon customers and their spending on products in various categories.

--Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend.

--Using CTE and Rank with an AND date filter. 
with t1 as (SELECT 
  category, Product, sum(spend) total_spend,
  RANK() OVER(PARTITION BY Category ORDER BY sum(spend) DESC) rnk
FROM product_spend
WHERE transaction_date >= '2022-01-01' 
  AND transaction_date <='2022-12-01'
GROUP BY product, category)

SELECT category, product, total_spend
FROM t1
WHERE rnk < 3