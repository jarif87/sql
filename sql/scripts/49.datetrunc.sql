select orderid,creationtime,


datetrunc(year,creationtime) as Year_dt,
datetrunc(minute,creationtime) as Minute_dt,
datetrunc(day,creationtime) as Day_dt,


datename(month,creationtime) as month_dn,
datename(weekday,creationtime) as Weekday_dn,
datename(day,creationtime) as Day_dn,
datename(year,creationtime) as Year_dn,

datepart(year,creationtime) as year_dp,
datepart(month,creationtime) as month_dp,
datepart(day,creationtime) as day_dp,
datepart(hour,creationtime) as HOUR_dp,
datepart(quarter,creationtime) as Quarter_dp,
datepart(weekday,creationtime) as Weekday_dp,

datepart(week,creationtime) as Week_dp,



year(creationtime) as year,Month(creationtime) as month, day(creationtime) as day from sales.orders

/*============================================================================================================*/

select datetrunc(month,creationtime) as Creation,count(*) from sales.orders group by datetrunc(month,creationtime)







