/* in order to analyze customer loyality,rank customers based on the
average days between their orders*/

select
customerid,
avg(daysuntil_NEXTorder) as avg_days,
rank() over(order by coalesce(avg(daysuntil_NEXTorder),999999)) as rank_AVG
from(
	select
	orderid,
	customerid,
	orderdate as currentorder,
	lead(orderdate) over(partition by customerid order by orderdate) as nextORDER,
	datediff(day,orderdate,lead(orderdate) over(partition by customerid order by orderdate)) as daysuntil_NEXTorder
	from sales.orders)t
group by customerid