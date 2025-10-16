select convert (int,'123') as [str to int convert],
convert(date,'2025-08-20') as [string to date convert],
creationtime,
convert(date,creationtime) as [datetime to date convert]
from sales.orders

--========================================================================================


select creationtime,

convert(date,creationtime) as [datetime to date convert],
convert(varchar,creationtime,32) as [usa std. style:32],

convert(varchar,creationtime,34) as [usa std. style:34]
from sales.orders