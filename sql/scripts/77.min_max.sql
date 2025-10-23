-- find the highest and lowest sales of all orders
-- find the highest and lowest sales for each product
-- additionally provide details such order id,order date

select
	orderid,
	orderdate,
	productid,
	sales,
	max(sales) over() as highestsales,
	min(sales) over() as lowestsales,
	max(sales) over(partition by productid) as highestsalesbyproduct,
	min(sales) over(partition by productid) as lowestsalesproduct
from sales.orders

-- show the employees who have the highest salaries

select
*
from(
	select
	*,
	max(salary) over() as highestsalary
	from sales.employees)t 
where salary=highestsalary




-- find the deviation of each sales from the minimum and maximum sales amounts

select
	orderid,
	orderdate,
	productid,
	sales,
	max(sales) over() as highestsales,
	min(sales) over() as lowestsales,
	sales-min(sales) over() as deviationFromMIN,
	max(sales) over()-sales as deviationMAX
from sales.orders