-- rank the orders based on their sales from highest to lowest

select 
	orderid,
	productid,
	sales,
	row_number() over(order by sales desc) as sales_ranK_row
from sales.orders