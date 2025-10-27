select *

into factresellersales_hp
from factresellersales


select *
from factresellersales_hp


select *
from factresellersales


select *
from factresellersales_hp
order by salesordernumber

select *
from factresellersales_hp
where  carriertrackingnumber='4911-403C-98'

create nonclustered index idx_factreseller_cta
on factresellersales(carrierTrackingnumber)

select
	p.englishproductname as productname,
	sum(s.salesamount) as total_sales
	from factresellersales s
	join dimproduct p
	on p.productkey=s.productkey
group by p.englishproductname

-- sql hints
select
	orders.sales,
	customers.country
	from sales.orders
	left join sales.customers with (forceseek)
on orders.customerid=customers.customerid
--option (hash join)