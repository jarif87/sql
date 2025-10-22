-- find the total number of orders

select
count(*) as total_orders
from orders

-- find total sales of all orders

select count(*) as total_orders,
sum(sales) as total_sales from orders

-- find the average sales of all orders

select count(*) as total_orders,
sum(sales) as total_sales,
avg(sales) as avg_sales

from orders

-- find the highest sales of all orders

select 
count(*) as total_orders,
sum(sales) as total_sales,
avg(sales) as avg_sales,
max(sales) as highest_sales

from orders

-- find the lowest sales of all orders


select customer_id,
count(*) as total_orders,
sum(sales) as total_sales,
avg(sales) as avg_sales,
max(sales) as highest_sales,
min(sales) as Lowest_sales

from orders

group by customer_id