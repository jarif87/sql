select * 
into sales.dbcustomers
from sales.customers

select * 

from sales.customers
where customerid=1

-- create cluster index

create clustered index idx_dbcustomers_customerid
on sales.dbcustomers (customerid)


drop index idx_dbcustomers_customerid on sales.dbcustomers

create clustered index idx_dbcustomers_firstname
on sales.dbcustomers (firstname)

create clustered index idx_dbcustomers_customerid
on sales.dbcustomers (customerid)

select
*
from sales.dbcustomers
where lastname='brown'

create nonclustered index idx_dbcustomers_lastName
on sales.dbcustomers (lastName)


create index idx_dbcustomers_firstName
on sales.dbcustomers (firstName)

-- create composite inDEX

select
*
from sales.dbcustomers
where country='usa' and score > 500

create index idx_dbcustomers_countryscore
on sales.dbcustomers(country,score)

-- coluimnstore INDEX
drop index [idx_dbcustomers_customerid] on sales.dbcustomers

create clustered columnstore index idx_dbcustomers_cs
on sales.dbcustomers

drop index [idx_dbcustomers_cs] on sales.dbcustomers

create nonclustered columnstore index idx_dbcustomers_cs_firstname
on sales.dbcustomers(firstname)

-- heap
select *
into factinternetsales_hp
from factinternetsales

--rowstore
select *
into factinternetsales_rs
from factinternetsales

create clustered index idx_factinternetsales_rs_pk
on factinternetsales_rs(salesordernumber,salesorderlinenumber)

--columnstore

select *
into factinternetsales_cs
from factinternetsales

create clustered columnstore index idx_factinternetsales_cs_pk
on factinternetsales_cs

-- unique index

select * from sales.products

create unique nonclustered index idx_products_product
on sales.products(product)

-- filter index
select * from sales.customers 

where country='usa'

drop index [idx_customers_country] on sales.customers

create Nonclustered index idx_customers_country
on sales.customers(country)
where country='usa'

--Monitor Usage


-- list all indexes on a specific table

--sp_helpindex 'sales.dbcustomers'
select 
	tables.name as TABLeName,
	
	idx.name as indexName,
	idx.type_desc as indextype,
	idx.is_primary_key as isprimarykey,
	idx.is_unique as inunique,
	idx.is_disabled as iddisabled,
	sys.dm_db_index_usage_stats.user_seeks as userseeks,
	sys.dm_db_index_usage_stats.user_scans as userscans,
	sys.dm_db_index_usage_stats.user_lookups as userlookups,
	sys.dm_db_index_usage_stats.user_updates as userupdates,
	coalesce(sys.dm_db_index_usage_stats.last_user_seek,sys.dm_db_index_usage_stats.last_user_scan) as LastUPDATE
	

from sys.indexes idx
join sys.tables 
on idx.object_id=tables.object_id
left join sys.dm_db_index_usage_stats
on sys.dm_db_index_usage_stats.object_id=idx.object_id
and sys.dm_db_index_usage_stats.index_id=idx.index_id
order by tables.name,idx.name

select * from sys.dm_db_index_usage_stats

-- Monitor Missing Indexes
SELECT
    fs.SalesOrderNumber,
    dp.EnglishProductName,
    dp.Color
FROM FactInternetSales AS fs
INNER JOIN DimProduct AS dp
    ON fs.ProductKey = dp.ProductKey
WHERE dp.Color = 'Black'
  AND fs.SalesOrderKey BETWEEN 20101229 AND 20101231;


select * from sys.dm_db_missing_index_details

--Monitor Duplicate indexes
select
		tbl.name as tablename,
		col.name as indexcolumn,
		idx.name as indexname,
		idx.type_desc as indextype
		count(*) over(partition by tbl.name,col.name) as column_count
		from sys.indexes idx
	join sys.tables tbl on idx.object_id=tbl.object_id
	join sys.index_columns ic on idx.object_id=ic.object_id and idx.index_id=ic.index_id
	join sys.columns col on ic.object_id=col.object_id and ic.column_id=col.column_idorder by tbl.name,col.name
	order by column_count desc


select
*
from sys.dm_db_index_physical_stats (DB_ID(),null,null,null,'limited)