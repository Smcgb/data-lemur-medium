--https://datalemur.com/questions/supercloud-customer
--Supercloud Customer

--A Microsoft Azure Supercloud customer is a company which buys at least 1 product from each product category.

--Write a query to report the company ID which is a Supercloud customer.

--Using CTE

WITH t1 as (SELECT cc.customer_id, p.product_category
FROM customer_contracts as cc
LEFT JOIN products as p  
  on p.product_id = cc.product_id
GROUP BY cc.customer_id, p.product_category)

SELECT customer_id
FROM t1
GROUP BY 1
HAVING count(customer_id) = 3;