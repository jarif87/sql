/* get all customers along with their orders ,
but only for customers who have placed an order */

select * from customers inner join orders
	on id = customer_id


select customers.id, customers.first_name,orders.order_id, orders.sales from customers inner join orders
	on customers.id = orders.customer_id

