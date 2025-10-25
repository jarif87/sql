-- find the total sales per customer
with cte_total_sales as 
(
select
	customerid,
	sum(sales) as total_sales
	from sales.orders
group by customerid

)

select
	customers.customerid,
	customers.firstname,
	customers.lastname,
	cte_total_sales.total_sales
	from sales.customers
	left join cte_total_sales
on cte_total_sales.customerid = customers.customerid

-- Multiple standalone CTE
-- find the total sales per customer
-- find the last order date per customer

with cte_total_sales as 
(
select
	customerid,
	sum(sales) as total_sales
	from sales.orders
group by customerid

),cte_last_order as 
(
select 
	customerid,
	max(orderdate) as last_order
	from sales.orders
group by customerid
)

select
	customers.customerid,
	customers.firstname,
	customers.lastname,
	cte_total_sales.total_sales,
	cte_last_order.last_order
	from sales.customers
	left join cte_total_sales
on cte_total_sales.customerid = customers.customerid
left join cte_last_order on 
cte_last_order.customerid=customers.customerid

-- nested cte
-- find the total sales per customer
-- find the last order date per customer
-- rank customers based on total sales for customer

with cte_total_sales as 
(
select
	customerid,
	sum(sales) as total_sales
	from sales.orders
group by customerid

),cte_last_order as 
(
select 
	customerid,
	max(orderdate) as last_order
	from sales.orders
group by customerid
),
cte_customer_rank as
(
select
	customerid,
	total_sales,
	rank() over(order by total_sales desc) as customer_rank
from cte_total_sales
)

select
	customers.customerid,
	customers.firstname,
	customers.lastname,
	cte_total_sales.total_sales,
	cte_last_order.last_order,
	cte_customer_rank.customer_rank
	from sales.customers
	left join cte_total_sales
on cte_total_sales.customerid = customers.customerid
left join cte_last_order on 
cte_last_order.customerid=customers.customerid
left join cte_customer_rank on
cte_customer_rank.customerid=customers.customerid

-- nested cte
-- find the total sales per customer
-- find the last order date per customer
-- rank customers based on total sales for customer
-- segment customers based on their total sales

with cte_total_sales as 
(
select
	customerid,
	sum(sales) as total_sales
	from sales.orders
group by customerid

),cte_last_order as 
(
select 
	customerid,
	max(orderdate) as last_order
	from sales.orders
group by customerid
),
cte_customer_rank as
(
select
	customerid,
	total_sales,
	rank() over(order by total_sales desc) as customer_rank
from cte_total_sales
)
,
cte_customer_segment as 
(
select
	customerid,
	case when total_sales> 100 then 'High'
	when total_sales>50 then 'Medium'
	else 'Low'
	end customer_segments
from cte_total_sales
)

select
	customers.customerid,
	customers.firstname,
	customers.lastname,
	cte_total_sales.total_sales,
	cte_last_order.last_order,
	cte_customer_rank.customer_rank,
	cte_customer_segment.customer_segments
	from sales.customers
	left join cte_total_sales
on cte_total_sales.customerid = customers.customerid
left join cte_last_order on 
cte_last_order.customerid=customers.customerid
left join cte_customer_rank on
cte_customer_rank.customerid=customers.customerid
left join cte_customer_segment on
cte_customer_segment.customerid=customers.customerid