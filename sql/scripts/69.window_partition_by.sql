/* find the total sales across all orders additionally 
provide details such order id and order date */

/* find the total sales for each product  additionally 
provide details such order id and order date

find the total sales for each combination of product and order status
additionally provide details such order id,order datge

*/

select 
orderid,
orderdate, 
productid,
sales,
orderstatus,
sum(sales) over() as total_sales,
sum(sales) over(partition by productid) as total_salesbyproductid,
sum(sales) over(partition by productid,orderstatus) as salesproductstatus
from sales.orders