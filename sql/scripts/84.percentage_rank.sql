-- find the products that fall within the highest 40% of the prices
select *,
	concat(dist_rank*100, '%') as Distrank_percentage
from(
	select
	product,
	price,
	percent_rank() over(order by price desc) as dist_rank
	from sales.products)t
where dist_rank<=0.4