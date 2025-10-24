/* find the products that have a price higher
than the average price of all products*/
select
*
from(
	select
	productid,
	price,
	avg(price) over() as avg_price
	from sales.products)t
where price>avg_price

-- rank customers based on their total amount of sales
select
*,
rank() over(order by total_sales desc) as customer_rank
from(
	select
	customerid,
	sum(sales) as total_sales
	from sales.orders
group by customerid)t

/* show the products id,product names,prices and total number
of orders */
select
	productid,
	product,
	price,
	(select count(*)  from sales.orders) as total_orders
from sales.products

-- subquery join

-- show all the customer details and find the total orders of each customer

select

customers.*,
orders.total_orders
from sales.customers
left join
   (select
	customerid,
	count(*) as total_orders
	from sales.orders group by customerid) orders
on customers.customerid = orders.customerid

-- subquery where

/* find the products that have a price higher than the average
price of all products */

select
	productid,
	price,
	(select avg(price) from sales.products) as avg_price
	from sales.products
where price>(select avg(price) from sales.products)

-- subquery using in operator

-- show the details of orders made by customers in germany
select
*
from sales.orders
where customerid in (
	select
	customerid
	from sales.customers
	where country='germany'
	)

-- show the details of orders made by customers who are not from germany

select
*
from sales.orders
where customerid not in (
	select
	customerid
	from sales.customers
	where country ='germany'
	)
-- all & any operators
-- find female employees whose salaries are greater than the salaries of any male employees

select
	employeeid,
	firstname,
	gender,
	salary
	from sales.employees
	where gender='f' and 
 salary> any(select salary from sales.employees where gender ='m')

 -- all operators

 select
	employeeid,
	firstname,
	gender,
	salary
	from sales.employees
	where gender='f' and 
salary> all(select salary from sales.employees where gender ='m')

-- correlated subquery
-- show all customer details and find the total orders of each customer

select
	*,
	(select  count(*) from sales.orders where orders.customerid=customers.customerid) as total_sales
from sales.customers

-- subquery using exists
-- show the details of orders made by customers in germany
select
* 
	from sales.orders
	where  exists 
	(select
	*
	from sales.customers where country='germany' and 
orders.customerid=customers.customerid)


select
* 
	from sales.orders
	where not exists 
	(select
	*
	from sales.customers where country='germany' and 
orders.customerid=customers.customerid)