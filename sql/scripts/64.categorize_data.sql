/* create report showing total sales for each of the following categories:
High (sales over 50),Medium (sales 21-50) and low (sales 20 or less sort the
categories from highest sales to lowest */

select category, sum(sales) as TotalSales

from(select orderid, sales,
case
	when sales>50 then 'High'
	when sales>20 then 'Medium'
	else 'Low'

end category
from sales.orders)t group by Category
order by TotalSales Desc