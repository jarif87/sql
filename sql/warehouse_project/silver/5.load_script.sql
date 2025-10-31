insert into silver.erp_cust_az12(cid,bdate,gen)

select

case when cid like 'nas%' then substring(cid,4,Len(cid))
	else cid
end as  cid,

case when bdate>getdate() then null 
	else bdate
end as bdate,

case when upper(trim(gen)) in ('F','Female') then 'Female'
	 when upper(trim(gen)) in ('M','Male') then 'Male'
	 else 'n/a'
end as gen


from bronze.erp_cust_az12

--identify out of range dates
select distinct
	bdate
	from bronze.erp_cust_az12
where bdate <'1924-01-01' or bdate > getdate()

--data standardization & consistency
select distinct gen
from bronze.erp_cust_az12

-- table 2
insert into silver.erp_loc_a101(cid,cntry)
select
replace(cid,'-','') as cid,
case when trim(cntry)='DE' then 'Germany'
	when trim(cntry) in ('Us','USA') then 'United states'
	when trim(cntry)='' or cntry is null then 'n/a'
	else trim(cntry)
end as cntry

from bronze.erp_loc_a101 


-- data standardization & consistency

select distinct cntry
from bronze.erp_loc_a101
order by cntry

--table 3
insert into silver.erp_px_cat_g1v2(
id,cat,subcat,maintenance)
select
	id,
	cat,
	subcat,
	maintenance 
from bronze.erp_px_cat_g1v2


-- check for unwanted spaces
select * from bronze.erp_px_cat_g1v2

where cat!=trim(cat)

--datastandardization and consistency
select distinct
cat
from bronze.erp_px_cat_g1v2
