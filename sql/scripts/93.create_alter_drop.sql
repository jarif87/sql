-- find the running total of sales for each month

with cte_monthly_summary as (
	select
	datetrunc(month,orderdate) as ordermonth,
	sum(sales) as total_sales
	
	from sales.orders
	group by datetrunc(month,orderdate)
)

select
	ordermonth, 
	total_sales,
	sum(total_sales) over (order by ordermonth) as running_total
from cte_monthly_summary

--==============================================================================================================--
create view v_monthly_summary as (
	select
	datetrunc(month,orderdate) as ordermonth,
	sum(sales) as total_sales,
	count(orderid) as total_orders,
	sum(quantity) as total_quality
	from sales.orders
	group by datetrunc(month,orderdate)

	)
--================================================================================================================--
select
* 
from v_monthly_summary

--=================================================================================================================--
select
	ordermonth, 
	total_sales,
	sum(total_sales) over (order by ordermonth) as running_total
from v_monthly_summary
--==================================================================================================================--

drop view v_monthly_summary

--==================================================================================================================--
if object_id('sales.v_monthly_summary','v') is not null
	drop view sales.v_monthly_summary;
go
create view sales.v_monthly_summary as (
	select
	datetrunc(month,orderdate) as ordermonth,
	sum(sales) as total_sales,
	count(orderid) as total_orders,
	sum(quantity) as total_quality
	from sales.orders
	group by datetrunc(month,orderdate)

	)