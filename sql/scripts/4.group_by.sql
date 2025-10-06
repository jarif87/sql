-- find the total score of each country

select  country,sum(score) as total_score from customers group by country

-- find the total score and total number of customers for each country


select  country,sum(score) as total_score,count(id) as total_customers from customers group by country