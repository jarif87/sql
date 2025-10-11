-- retrive all customers from germany

select * from Customers where country='Germany'

-- retrive all customers who are not from Germany

select * from Customers where country!='Germany'

select * from Customers where country<>'Germany'

-- retrive all customers with a score greater than 500
select * from customers where score > 500

-- retrive all customers with a score of 500 or more
select * from customers where score >= 500

-- retrive all customers with a score less than 500

select * from customers where score < 500

-- retrive all customers with a score of 500 or less

select * from customers where score <= 500
