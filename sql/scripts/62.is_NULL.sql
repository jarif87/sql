-- identify the customers who have no scores

select * from sales.customers where score is null

-- list all customers who have scores

select * from sales.customers where score is not null

-- list all details for customers who have not placed any orders

select customers.* from sales.customers  left join sales.orders
on customers.CustomerID= orders.customerid where  orders.customerid is null