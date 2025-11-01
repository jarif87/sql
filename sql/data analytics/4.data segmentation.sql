/*segment products into cost ranges and count how
many products fall into each segment*/
with product_segments as (
select
product_key,
product_name,
cost,
case when cost<100 then 'below 100'
	 when cost between 100 and 500 then '100-500'
	 when cost between 500 and 1000 then '500-1000'
	 else 'above 1000'
end cost_range

from gold.dim_products)

select
cost_range,
count(product_key) as total_products
from product_segments
group by cost_range
order by total_products desc

/* group customers into three segments based on their spending behavior:
--vip:at least 12 months of history and spending more than $5000
--regular:at least 12 months of history but spending $5000 or less
--new:lifespan less than 12 months
*/
with customer_spending as (

select
	c.customer_key,
	sum(f.sales_amount) as total_spending,

	min(order_date) as first_order,
	max(order_date) as last_order,
	datediff(month,min(order_date),max(order_date)) as lifespan
	from gold.fact_sales f
	left join gold.dim_customers c
	on f.customer_key=c.customer_key
group by c.customer_key
)
select
customer_segment,
count(customer_key) as total_customers
from(
     select
	 customer_key,

	 case when lifespan>=12 and total_spending >5000 then 'vip'
	 when lifespan>=12 and total_spending<=5000 then 'regular'
	 else 'new'
	 end customer_segment

from customer_spending)t
group by customer_segment
order by total_customers desc
 