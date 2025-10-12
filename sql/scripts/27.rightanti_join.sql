-- get all orders without matching cusstomers 

select * from customers right join orders on customers.id = orders.customer_id
where customers.id is null


select * from orders left join customers on customers.id = orders.customer_id
where customers.id is null