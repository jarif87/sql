
/* find customers without orders and orders without customers */


select * from orders full join customers on customers.id = orders.customer_id
where customers.id is null or orders.customer_id is null

/* get all customers along with their orders,
but only for customers who have placed an order */

select * from customers left join orders on customers.id = orders.customer_id
	where orders.customer_id is not null