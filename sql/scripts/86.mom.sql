/*analyze the month-over-month performace by finding the percentage change
in sales between the current and previous months*/
select
*,
currentmonth_sales-previousmonth_sales as MOM_change,
round(cast((currentmonth_sales-previousmonth_sales) as float)/previousmonth_sales*100,1) as MOM_PERCEN
from(
select

	month(orderdate) as ordermonth,
	sum(sales) as currentmonth_sales,
	lag(sum(sales)) over(order by month(orderdate)) as previousmonth_sales
from sales.orders
group by
	month(orderdate))t