select
	orderid,
	sales,
	ntile(1) over (order by sales desc) as onebucket,

	ntile(2) over (order by sales desc) as onebucket,
	ntile(3) over (order by sales desc) as onebucket,
	ntile(4) over (order by sales desc) as onebucket
from sales.orders

-- segment all order into 3 categoris: high,medium and low sales

select
*,
case when buckets=1 then 'High'
	when buckets=2 then 'Medium'
	when buckets=3 then 'Low'
end as SalesSegmenTATION
from(
select
	orderid,
	sales,
	ntile(3) over(order by sales desc) as buckets
from sales.orders)t

-- in order to export the data,divide the orders into 2 groups

select
ntile(2) over (order by orderid) as buckets,
*
from sales.orders