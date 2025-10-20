-- find the average scores of the customers

select customerid,score,coalesce(score,0) as score2,
avg(score) over() as AVGSCores,
avg(coalesce(score,0)) over() as avgscore2 from sales.customers