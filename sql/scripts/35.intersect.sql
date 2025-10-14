-- find the employees who are also customers


select firstname,lastname from sales.employees

intersect select firstname,lastname from sales.customers