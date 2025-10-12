/* get all customers and all orders even
	if thers no match */

select customers.id, customers.first_name,orders.order_id, orders.sales from customers full join orders
	on customers.id = orders.customer_id