-- find the top highest sales for each product
select
*
from(
select
	orderid,
	productid,
	sales,
	row_number() over(partition by productid order by sales desc) as rankby_Product
	from sales.orders)t
where rankby_product=1

-- find the lowest 2 customers based on their total sales
select
*
from(
select
	customerid,
	sum(sales) as total_sales,
	row_number() over(order by sum(sales)) as rankcustomer
	from sales.orders
group by customerid)t where rankcustomer<=2

