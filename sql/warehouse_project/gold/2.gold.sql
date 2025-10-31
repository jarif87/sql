select

	ci.cst_gndr,
	ca.gen,
	case when ci.cst_gndr!='n/a' then ci.cst_gndr
	else coalesce(ca.gen,'n/a')
	end as new_gen

from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key=ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key=la.cid
order by 1,2


