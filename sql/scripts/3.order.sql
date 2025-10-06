/* retrive all customers and sort the results by the highest score first */

select * from customers order by score desc

/* retrive all customers and sort the results by the lowest score first */


select * from customers order by score asc

/* retrive all customers and sort the results by the country and then by the highest score */
select * from customers order by country asc,score desc