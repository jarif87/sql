/* display the full name of customers in single field by mergin their
first and last names and add 10 bonus points to each customers score */

select customerid,firstname + ' '+ lastname as FuLLName,firstname,lastname,
coalesce(lastname,'') as LASTNAME2,
score from sales.customers

select customerid,firstname + ' '+ coalesce(lastname,'') as FuLLName,firstname,lastname,
coalesce(lastname,'') as LASTNAME2,
score,coalesce(score,0) + 10 as scoreWithbonUS from sales.customers