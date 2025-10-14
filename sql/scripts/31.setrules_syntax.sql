select firstname,lastname from sales.customers

union

select firstname,lastname from sales.employees



select customerid,lastname from sales.customers

union

select employeeid,lastname from sales.employees
