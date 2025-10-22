select orderid,orderdate,orderstatus,
sales,sum(sales) over(partition by orderstatus order by orderdate
rows between current row and 2 following) as total_sales from sales.orders


select orderid,orderdate,orderstatus,
sales,sum(sales) over(partition by orderstatus order by orderdate
rows unbounded preceding) as total_sales from sales.orders