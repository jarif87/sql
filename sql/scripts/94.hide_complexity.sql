/* provide view that combines details from orders,
products,customers and employees */
create view sales.v_order_details as
(
	select
	orders.orderid,
	orders.orderdate,
	orders.sales,
	orders.quantity,
	products.product,

	products.category,
	coalesce(customers.firstname,'')+' '+coalesce(customers.lastname,'') as customer_NAME,
	customers.country as customer_COUNTRY,
	coalesce(employees.firstname,'')+' '+coalesce(employees.lastname,'') as EMPLOYEE_NAME,
	employees.department

from sales.orders
left join sales.products
on products.productid=orders.productid
left join sales.customers
on customers.customerid=orders.customerid
left join sales.employees
on employees.employeeid=orders.salespersonid

)
--==========================================================================================================--
select
	*
from sales.v_order_details

-- data security
/* provide a view for the eu sales team that combines details from all
tables and excludes data related to the usa*/
create view sales.v_order_details_eu as (
	select
	orders.orderid,
	orders.orderdate,
	orders.sales,
	orders.quantity,
	products.product,

	products.category,
	coalesce(customers.firstname,'')+' '+coalesce(customers.lastname,'') as customer_NAME,
	customers.country as customer_COUNTRY,
	coalesce(employees.firstname,'')+' '+coalesce(employees.lastname,'') as EMPLOYEE_NAME,
	employees.department

from sales.orders
left join sales.products
on products.productid=orders.productid
left join sales.customers
on customers.customerid=orders.customerid
left join sales.employees
on employees.employeeid=orders.salespersonid
where customers.country !='USA')

select
	*
from sales.v_order_details_eu
