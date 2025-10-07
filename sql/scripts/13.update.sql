-- change the score of customer with id 6 to 0

select * from customers

-- update
 update customers set score=0 where id=6


insert into customers(id,first_name,country,score)
values(10,'Max','Russia',0)


UPDATE customers
SET first_name = 'John',
    country = 'UK',
    score = 0
WHERE id = 10;


select * from customers

/* change the score of customer with id 10 to 0 and update the country to UK */

update customers set score=20,country='Russia' where id=10

/* update all customers with a null score by setting their score to 0 */

update customers set score =0 where score is null
