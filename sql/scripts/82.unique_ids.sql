select
	row_number() over(order by orderid,orderdate) as uniqueid,
	*
from sales.ordersarchive