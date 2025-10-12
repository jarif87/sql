-- get all customers who haven't placed any order

select * from customers left join orders on customers.id = orders.customer_id
	where orders.customer_id is null