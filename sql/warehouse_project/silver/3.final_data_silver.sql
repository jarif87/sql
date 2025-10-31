insert into silver.crm_cust_info(

cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_material_status,
cst_gndr,
cst_create_date)


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


select 
	cst_id,
	count(*)
	from silver.crm_cust_info
	group by cst_id
having count(*)>1 or cst_id is null


-- check unwanted spaces
select cst_firstname from silver.crm_cust_info
where cst_firstname!=trim(cst_firstname)


--checkout data
select * from silver.crm_cust_info

--crm_prd_info_table
select 
	prd_id,
	count(*)
	from bronze.crm_prd_info
	group by prd_id
having count(*)>1 or prd_id is null

--check for nulls or negative numbers
select prd_cost
from bronze.crm_prd_info
where prd_cost<0 or prd_cost is null

-- data standardization and consistency
select distinct prd_line
from bronze.crm_prd_info

--check for invalid date orders

select
*
from bronze.crm_prd_info
where prd_end_dt<prd_start_dt


select
    prd_id,
    prd_key,
    prd_nm,
    prd_start_dt,
    prd_end_dt,
    lead(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as prd_end_dt_test

from bronze.crm_prd_info
where prd_key in('AC-HE-HL-U509-R','AC-HE-HL-U509')




--======================================================
--clean DATA
INSERT INTO silver.crm_prd_info
(
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
    SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
    prd_nm,
    ISNULL(prd_cost,0) AS prd_cost,
    CASE 
        WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
        WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
        WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
        WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
        ELSE 'n/a'
    END AS prd_line,
    CAST(prd_start_dt AS DATE) AS prd_start_dt,
    CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info;
