select
*
into #orders
from sales.orders

select
*
from #orders

delete from #orders
where orderstatus='delivered'

select
*
into sales.ordersTEST
from #orders
