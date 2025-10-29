select * from sales.customers-- bad practice

select customerid,firstname,lastname from sales.customers--good practice

--avoid unnessary distinct and order by
select
	distinct
	firstname
	from sales.customers
order by firstname

select firstname from sales.customers --good practice

-- tips for filtering

select * from sales.orders where orderstatus='delivered'

create nonclustered index idx_orders_orderstatus on sales.orders(orderstatus)


-- avoid functions to columns in where clauses
select * from sales.orders --bad practice
where lower(orderstatus)='delivered'

select * from sales.orders
where orderstatus='delivered'

-- tips for joining
--bad practice

select o.orderid,c.firstname
from sales.customers c,sales.orders o
where c.customerid=o.customerid

--good practice
select o.orderid,c.firstname
from sales.customers c
inner join sales.orders o
on c.customerid=o.customerid

create nonclustered index idx_order_customerid on sales.orders(customerid)

--filter after join
select c.firstname,o.orderid
from sales.customers c
inner join sales.orders o
on c.customerid=o.customerid
where o.orderstatus='delivered'

--filter during join
select c.firstname,o.orderid
from sales.customers c
inner join sales.orders o
on c.customerid=o.customerid
and o.orderstatus='delivered'

--filter before join (subquery)
select c.firstname,o.orderid
from sales.customers c
inner join (select orderid,customerid from sales.orders where orderstatus='delivered') o
on c.customerid=o.customerid

--aggregate before joining (big tables)
--grouping and joining
select c.customerid,c.firstname,count(o.orderid) as ordercount
from sales.customers c
inner join sales.orders o
on c.customerid=o.customerid
group by c.customerid,c.firstname

--pre-aggregated subquery
select c.customerid,c.firstname,o.ordercount
from sales.customers c
inner join(
	select customerid,count(orderid) as ordercount
	from sales.orders
	group by customerid) o
on c.customerid=o.customerid

--correlated subquery
--worst

select
	c.customerid,
	c.firstname,
		(select count(o.orderid) 
		from sales.orders o
		where o.customerid=c.customerid) as ordercount
from sales.customers c

--use union instead of OR in joins
--bad practice
select o.orderid,c.firstname
from sales.customers c
inner join sales.orders o
on c.customerid=o.customerid
or c.customerid=o.salespersonid

--best practice
select o.orderid,c.firstname
from sales.customers c
inner join sales.orders o
on c.customerid=o.customerid
union
select o.orderid,c.firstname
from sales.customers c
inner join sales.orders o
on c.customerid=o.salespersonid

--use columnstore index for aggregations on large table
select customerid,count(orderid) as ordercount
from sales.orders group by customerid

create clustered columnstore index idx_orders_columnstore on sales.orders

-- pre aggregate data and store it in new table for reporting

select month(orderdate) orderyear,sum(sales) as total_sales
into sales.salessummary
from sales.orders
group by month(orderdate)

select orderyear,total_sales from sales.salessummary

--join--best practice
select o.orderid,o.sales
from sales.orders o
inner join sales.customers c
on o.customerid=c.customerid
where c.country='usa'


--exists --best practice
select o.orderid,o.sales
from sales.orders o
where exists(
	select 1
	from sales.customers c
	where c.customerid=o.customerid
	and c.country='usa'
	)


--IN--bad practice

select o.orderid,o.sales
from sales.orders o
where o.customerid in(

select customerid
FROM SALES.CUSTOMERS
where country='usa'
)
