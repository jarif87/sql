select orderid,creationtime, year(creationtime) as year,
month(creationtime) as month,day(creationtime) as day from sales.orders