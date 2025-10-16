select isdate('123') as datecheck, isdate('2025-08-20') as datecheck2,
	isdate('20-08-2025') as datecheck3,
	isdate('2025') as datecheck4,
	isdate('05') as datecheck4

--=============================================================================
select Orderdate,isdate(Orderdate),
case when isdate(orderdate) =1 then cast(orderdate as Date)
else '9999-01-01'

end neworderdate
from

(   
select '2025-08-10' as Orderdate union
	select '2025-08-20' union
	select '2025-08-15' union
	select '2025-08'
	) as t 
--where isdate(orderdate)=0
