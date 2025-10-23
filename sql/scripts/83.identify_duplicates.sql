/* identify duplicate rows in the table orders archive and
return a clean result without any duplicates */
select * 
	from(
	select
	row_number() over(partition by orderid order by creationtime desc) as rn,
	*
	from sales.ordersarchive)t 
where rn=1