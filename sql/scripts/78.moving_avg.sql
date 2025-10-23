-- calculate moving average of sales for each product over time

select 
	orderid,
	productid,
	orderdate,
	sales,
	avg(sales) over(partition by productid) as avgbyproduct,
	avg(sales) over(partition by productid order by orderdate ) as Movingavg
from sales.orders

/* calculate moving aveaage of sales for each product over time,
including only the next order */


select 
	orderid,
	productid,
	orderdate,
	sales,
	avg(sales) over(partition by productid) as avgbyproduct,
	avg(sales) over(partition by productid order by orderdate ) as Movingavg,
	avg(sales) over(partition by productid order by orderdate rows between current row and 1 following ) as rollingavg

from sales.orders
