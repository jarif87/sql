select orderid,creationtime,datepart(year,creationtime) as year_dp,
datepart(month,creationtime) as month_dp,
datepart(day,creationtime) as day_dp,
datepart(hour,creationtime) as HOUR_dp,
datepart(quarter,creationtime) as Quarter_dp,
datepart(weekday,creationtime) as Weekday_dp,

datepart(week,creationtime) as Week_dp,
year(creationtime) as year,Month(creationtime) as month, day(creationtime) as day from sales.orders