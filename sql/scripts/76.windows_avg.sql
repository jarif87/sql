-- find the average sales across all orders
-- and find the average sales for each product
-- additionally provide details such order id, order date

select
	orderid,
	orderdate,
	sales,
	productid,
	avg(sales) over() as avgsales,
	avg(sales) over (partition by productid) as avgsalesproductid
from sales.orders

-- find the average scores of customers
-- additionally provide details such customerid and lastname

select 
	customerid,
	lastname,
	score,
	coalesce(score,0) as customerscore,
	avg(score) over() as avgscore,
	avg(coalesce(score,0)) over() as avgscorewithoutNULL
from sales.customers

/* find all orders where sales are higher than the
average sales across all orders*/

select
*
from(
	select
		orderid,
		productid,
		sales,
		avg(sales) over() as avgsales
		from sales.orders)t 
where sales> avgsales