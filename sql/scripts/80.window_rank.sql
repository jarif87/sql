-- rank the orders based on their sales from highest to lowest

select
	orderid,
	productid,
	sales,
	row_number() over(order by sales desc) as salesrank_row,
	rank() over(order by sales desc) as salesRANK_RANK
from sales.orders

-- Dense Rank

select
	orderid,
	productid,
	sales,
	row_number() over(order by sales desc) as salesrank_row,
	rank() over(order by sales desc) as salesRANK_RANK,
	dense_rank() over(order by sales desc) as sales_Dense_RANK
from sales.orders
