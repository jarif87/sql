-- find the total number of orders
-- find the total number of orders for each customers
-- additionally provide details such orderid,order date
select orderid,orderdate,customerid,

count(*) over() as total_orders, 
count(*) over (partition by customerid) as ordersbycustomers

from sales.orders

/* find the total number of customers additionally provide all customers details */
-- find the total number of scores for the customers

select *, 
count(*) over() as total_customers,
count(1) over() as total_customer_one,
count(score) over () as total_scores,
count(country) over() as total_countries
from sales.customers
-- check whether the table 'orders' contains any duplicate rows

select orderid,count(*) over (partition by orderid) as checkPK


from sales.orders



select 
*

from(select orderid,

count(*) over (partition by orderid) as checkPK


from sales.ordersarchive)t where checkPK >1



