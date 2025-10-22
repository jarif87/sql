select orderid,orderdate,orderstatus,
sales,sum(sales) over (partition by orderstatus) as total_sales
from sales.orders

order by sum(sales) over (partition by orderstatus) desc

-- rank customers based on their total sales

select customerid,sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as rankcustomers
from sales.orders group by customerid


select orderid,orderdate,orderstatus,
sales,sum(sales) over (partition by orderstatus) as total_sales
from sales.orders where productid in(101,102)

