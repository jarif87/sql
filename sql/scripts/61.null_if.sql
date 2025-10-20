/* find the sales price for each order by dividing sales by quantity */

select orderid,sales,quantity,sales/nullif(quantity,0) as price from sales.orders