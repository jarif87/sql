select
	year(order_date) as order_year,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
	from gold.fact_sales
	where order_date is not null
	group by year(order_date)
order by year(order_date


select
	month(order_date) as order_month,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
	from gold.fact_sales
	where order_date is not null
	group by month(order_date)
order by month(order_date)

select
	datetrunc(month,order_date) as order_date,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
	from gold.fact_sales
	where order_date is not null
	group by datetrunc(month,order_date)
order by datetrunc(month,order_date)

--communicative analysis
/*calculate the total sales per month and
the running total of sales over time */

select
order_date,
total_sales,
sum(total_sales) over(partition by order_date order by order_date) as running_total_sales
from(
select
datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month,order_date))t


SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    AVG(avg_price) OVER (ORDER BY order_date) AS moving_avg_price
FROM (
    SELECT
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(sls_price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t;

select * from gold.fact_sales

/* analyze the yearly performance of products by comparing their sales
to both the average sales performance of the product and the previous year's sales */
WITH yearly_product_sales AS (
  SELECT
    YEAR(f.order_date) AS order_year,
    p.product_name,
    SUM(f.sales_amount) AS current_sales
  FROM gold.fact_sales f
  LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
  GROUP BY YEAR(f.order_date), p.product_name
)
SELECT *
FROM yearly_product_sales;

--=================================================================================================================

WITH yearly_product_sales AS (
  SELECT
    YEAR(f.order_date) AS order_year,
    p.product_name,
    SUM(f.sales_amount) AS current_sales
  FROM gold.fact_sales f
  LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
  GROUP BY YEAR(f.order_date), p.product_name
)
SELECT
  order_year,
  product_name,
  current_sales,
  avg(current_sales) over (partition by product_name) as avg_sale,
  current_sales-avg(current_sales) over (partition by product_name) as diff_avg,
  case when current_sales-avg(current_sales) over (partition by product_name) >0 then 'above avg'
		when current_sales-avg(current_sales) over (partition by product_name) <0 then 'below avg'
	else 'avg'
end as avg_change,
lag(current_sales) over(partition by product_name order by order_year) as previous_year,
current_sales-lag(current_sales) over(partition by product_name order by order_year) as diff_year,

	case when current_sales-lag(current_sales) over (partition by product_name order by order_year) >0 then 'increase'
		 when current_sales-lag(current_sales) over (partition by product_name order by order_year) <0 then 'decrease'
	else 'no change'
end as previous_change


FROM yearly_product_sales
ORDER BY product_name, order_year;

--part to whole analysis
-- which categories contribute the most to overall sales
with category_sales as (
select
category,
sum(sales_amount) as total_sales

from gold.fact_sales f
left join gold.dim_products p
on p.product_key=f.product_key
group by category)

select
category,
total_sales,
sum(total_sales) over() overall_sales,
(cast(total_sales as float)/sum(total_sales) over())*100 as percentage_of_total
from category_sales
order by total_sales desc