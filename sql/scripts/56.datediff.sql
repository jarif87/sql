-- calculate the age of employees 
select * from sales.employees

select employeeid,birthdate,datediff(year,birthdate,getdate())

as AGE from sales.employees

-- find the average shipping duration in days for each month

select month(orderdate) as orderdate,avg(datediff(day,orderdate,shipdate))

as Day2ship  from sales.orders group by month(orderdate)

/* find the number of days between each order and previous order */

select orderid,orderdate as currentorderdate,

lag(orderdate) over (order by orderdate) as previousorderdate,

datediff(day,lag(orderdate) over (order by orderdate),orderdate) as nrofdays

from sales.orders