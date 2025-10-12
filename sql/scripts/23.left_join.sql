/* get all customers along with their orders ,
including those without orders */


select customers.id, customers.first_name,orders.order_id, orders.sales from customers left join orders
	on customers.id = orders.customer_id
