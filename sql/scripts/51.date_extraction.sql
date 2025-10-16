select year(orderdate), count(*) as  Nrorders from sales.orders group by year(orderdate)
-- how many order were placed each month

select month(orderdate), count(*) as  Nrorders from sales.orders group by month(orderdate)

select datename(month,orderdate) as orderdate, count(*) as  Nrorders from sales.orders 
group by datename(month,orderdate)

-- show all orders that were placed during the month of february
select * from sales.orders where month(orderdate)=2
