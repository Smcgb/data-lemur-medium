--https://datalemur.com/questions/signup-confirmation-rate

--New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts. Users may receive multiple text messages for account confirmation until they have confirmed their new account.

--A senior analyst is interested to know the activation rate of specified users in the emails table. Write a query to find the activation rate. Round the percentage to 2 decimal places.

--Definitions:

    --emails table contain the information of user signup details.
    --texts table contains the users' activation information.

--Assumptions:

    --The analyst is interested in the activation rate of specific users in the emails table, which may not include all users that could potentially be found in the texts table.
    --For example, user 123 in the emails table may not be in the texts table and vice versa.
	
--With CTE
with t1 as (
select 
  e.user_id,
  e.signup_date,
  t.text_id, 
  t.email_id, 
  t.signup_action
FROM 
  emails AS e
LEFT OUTER JOIN 
  texts AS t
    ON t.email_id = e.email_id
WHERE t.signup_action = 'Confirmed'
order by e.user_id ASC, e.signup_date DESC),

t2 as (
  SELECT COUNT(DISTINCT(user_id)) activation
  FROM t1),
  
t3 as (
 SELECT COUNT(DISTINCT(user_id)) users_count
  FROM emails)
  
SELECT 
  ROUND((t2.activation / t3.users_count::DEC), 2) confirm_rate
FROM t2, t3

--Basic Solution
SELECT 
  ROUND(COUNT(texts.email_id)::DEC
    /COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';