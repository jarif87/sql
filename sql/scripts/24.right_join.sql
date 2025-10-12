/* get all customers along with their orders ,
including orders without matching customers */

select * from customers

select * from orders

select customers.id, customers.first_name,orders.order_id, orders.sales from customers right join orders
	on customers.id = orders.customer_id


/* get all customers along with their orders ,
including orders without matching customers  using LEFT join*/

select customers.id, customers.first_name,orders.order_id, orders.sales from orders left join customers
	on customers.id = orders.customer_id