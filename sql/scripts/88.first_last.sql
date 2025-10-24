-- find the lowest and highest sales for each product

select
	orderid,
	productid,
	sales,
	first_value(sales) over(partition by productid order by sales) as lowest_sales,
	last_value(sales) over(partition by productid order by sales rows 
	between current row and unbounded following) as highest_sales,

	first_value(sales) over(partition by productid order by sales desc) as highest_sales,
	sales-first_value(sales) over(partition by productid order by sales) as sales_difference
from sales.orders