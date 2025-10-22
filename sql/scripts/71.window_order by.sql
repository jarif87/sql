/* rank each order based on their sales from highest to lowest
additionally provide details such order id, order date */

select orderid,orderdate,sales,
rank() over(order by sales desc) as ranksales


from sales.orders