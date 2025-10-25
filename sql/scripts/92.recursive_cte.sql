-- generate a sequence of numbers from 1 to 20
with series as (
	select
	1 as my_number
	union all
	select 
	my_number+1
	from series
where my_number <1000
)

select
	*
from series
option(maxrecursion 5000)

/*show the employee hierarchy by displaying each employee
level within the organization */
with cte_employee_hierarchy as 
(
select
	employeeid,
	firstname,
	managerid,
	1 as LEVEL
	from sales.employees
where managerid is null
union all
select
	employees.employeeid,
	employees.firstname,
	employees.managerid,
	level+1
from sales.employees
inner join cte_employee_hierarchy
on employees.managerid=cte_employee_hierarchy.employeeid
)

select
	* 
from cte_employee_hierarchy









