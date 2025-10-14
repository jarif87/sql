/* orders data are stored in seperate tables (orders and orderarchive)
combine all orders data into one report without duplicates*/

select * from sales.orders union
select * from sales.ordersarchive