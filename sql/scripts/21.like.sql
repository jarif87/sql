-- find all customers whose first name starts with 'M'

select * from customers where first_name like 'M%'

-- find all customers whose first name ends with 'n'

select * from customers where first_name like '%n'


-- find all customers whose first name contains 'r'

select * from customers where first_name like '%r%'

/* find all customers whose first name
 HAS 'r' in the third position */

 select * from customers where first_name like '__r%'

