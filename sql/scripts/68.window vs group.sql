-- find total sales across all orders

select sum(sales) as total_sales from sales.orders

-- find total sales for each product

select productid,sum(sales) as totalsales from sales.orders group by productid

/* find the total slaes for each product,additionally provide details such order id & order date */


select
orderid,
orderdate,
productid,
sum(sales) over(partition by productid) as totalsalesbyproduct

from sales.orders