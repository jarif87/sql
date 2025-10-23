-- find the total sales across all orders
-- and the total sales for each product
-- additionally provide details such order id, order date

select
	orderid,
	orderdate,
	sales,
	productid,
	sum(sales) over() as total_sales,
	sum(sales) over (partition by productid) as salesbyproducts
from sales.orders

/* find the percentage contribution of each products sales
to the total sales */

select 
	orderid,
	productid,
	sales,
	sum(sales) over() as total_sales,
	round(cast(sales as float)/sum(sales) over() * 100,2) as percentage_TOTAL
from sales.orders
