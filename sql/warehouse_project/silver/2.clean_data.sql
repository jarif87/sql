-- check nulls or duplicates in primary key

select 
	cst_id,
	count(*)
	from bronze.crm_cust_info
	group by cst_id
having count(*)>1 or cst_id is null

-- rank function

select
	*,
	row_number() over(partition by cst_id order by cst_create_date desc) as flag_last
	from bronze.crm_cust_info
where cst_id=29466

select
*
from (
select*,
row_number() over(partition by cst_id order by cst_create_date desc) as flag_last
from bronze.crm_cust_info)t
where flag_last=1 and cst_id=29466

-- check unwanted spaces
select cst_firstname from bronze.crm_cust_info
where cst_firstname!=trim(cst_firstname)

--clean data
SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname)  AS cst_lastname,

    case    when upper(trim(cst_material_status))='S' then 'Single'
            when upper(trim(cst_material_status))='M' then 'Married'
            else 'n/a'
    end cst_material_status,


    case    when upper(trim(cst_gndr))='F' then 'Female'
            when upper(trim(cst_gndr))='M' then 'Male'
            else 'n/a'
    end cst_gndr,

    cst_create_date
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY cst_id
            ORDER BY cst_create_date DESC
        ) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) t
WHERE flag_last = 1;

-- data standardization & consistency
select distinct cst_gndr
from bronze.crm_cust_info