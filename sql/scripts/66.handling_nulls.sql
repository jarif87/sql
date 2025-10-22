-- find the average scores of customers and trear nulls as 0
-- additionally provide details such customerid and lastname

select customerid,lastname,score,
case
	when score is null then 0
	else score

end as scoreClean,
avg(case
	when score is null then 0
	else score
	end) over() as avgcustomerclean,

avg(score) over() as AVGcustomer 
from sales.customers

-- count how many times each customer has made an order with sales greater than 30

select customerid,

sum(case
	when sales > 30 then 1
	else 0
end) as HighestSales,
count(*) as TotalOrders

from sales.orders
group by customerid