select orderid,orderdate,
dateadd(day,-10,orderdate) as tendaysbefore,
dateadd(year,2,orderdate) as twoyearslater,
dateadd(month,3,orderdate) as threemonthslater
from sales.orders
