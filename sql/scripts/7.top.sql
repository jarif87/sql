-- retrive only 3 customers

select top 3 * from customers

-- retrive the top 3 customers with the highest scores

select top 3 * from customers order by score desc

-- retrive the lowest 2 customers ased on the score

select top 3 * from customers order by score asc

-- get the two most recent orders

select top 2 * from orders order by order_date desc