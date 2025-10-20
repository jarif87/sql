with orders as (

select 1 id, 'a' category union
select 2,null union
select 3,'' union
select 4,'  ')

select *,datalength(category) as CategoryLength from orders

-- handling null data policies

with orders as (

select 1 id, 'a' category union
select 2,null union
select 3,'' union
select 4,'  ')

select *,datalength(trim(category)) as POLICY1,
datalength(category) as categoryLEN 

from orders

--=========================================================================
with orders as (

select 1 id, 'a' category union
select 2,null union
select 3,'' union
select 4,'  ')

select *,trim(category) as POLICY1,
nullif(trim(category),'') as POLICHY2

from orders

--=======================================================================================
with orders as (

select 1 id, 'a' category union
select 2,null union
select 3,'' union
select 4,'  ')

select *,trim(category) as POLICY1,
nullif(trim(category),'') as POLICHY2,
coalesce(nullif(trim(category),''),'unknown') as polichy3

from orders

--===============================================================================================

