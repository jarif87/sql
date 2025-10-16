SELECT 
    orderid,
    creationtime,
    format(creationtime,'MM-dd-yyy') as USA_Format,
    format(creationtime,'dd-MM-yyy') as USA_Format,

    FORMAT(creationtime,'dd') AS DD,       -- Day number
    FORMAT(creationtime,'ddd') AS DDD,     -- Abbreviated weekday
    FORMAT(creationtime,'dddd') AS DDDD,   -- Full weekday name

    FORMAT(creationtime,'MM') AS MM,       -- Month number
    FORMAT(creationtime,'MMM') AS MMM,     -- Abbreviated month name
    FORMAT(creationtime,'MMMM') AS MMMM    -- Full month name

FROM sales.orders;

/* show creationtime using the following format:
day wed jan Q1 2025 12:34:56 PM */

select orderid,creationtime,'Day ' + format(creationtime,'ddd MMM') +

' Q' + datename(quarter,creationtime) + ' ' + format(creationtime,'yyyy hh:ss tt') as 
customformat  from sales.orders


select format(orderdate,'MMM yy') as OrderDATE, 
count(*) from sales.orders group by orderdate

-- =====================================================================================================

