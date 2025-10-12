/* using salesdb, retrive a list of all orders,along with
the related customer,product and employee details */

select * from Sales.customers
select * from sales.orders

select orders.OrderID,orders.Sales from sales.orders

select * from sales.customers;

select * from sales.orders;

select * from sales.employees

select orders.OrderID,orders.Sales,customers.FirstName,
	customers.lastname from sales.orders left join sales.customers on 
	orders.customerid = customers.customerid


select orders.OrderID,orders.Sales,customers.FirstName,
	customers.lastname,products.Product as Productname from sales.orders left join sales.customers on 
	orders.customerid = customers.customerid left join sales.products on orders.productid = products.productid



select orders.OrderID,orders.Sales,customers.FirstName as customerfirstname,
	customers.lastname as customerlastname,products.Product as Productname,
	products.price,employees.firstname as employeefirstname,employees.lastname as employeelastname
	
	from sales.orders left join sales.customers on 
	orders.customerid = customers.customerid left join sales.products on orders.productid = products.productid
	left join sales.employees on orders.salespersonid = employees.employeeid
