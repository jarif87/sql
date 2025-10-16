select orderid,creationtime, eomonth(creationtime) as EndofMonth,

cast(datetrunc(month,creationtime) as date) as startofMOnth
from sales.orders