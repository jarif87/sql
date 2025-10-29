-- create partition
create partition function partitionbyyear(date)
as range left for values('2023-12-31','2024-12-31','2025-12-31','2026-12-31')

-- query lists all existing partition function
select
	name,
	function_id,
	type,
	type_desc,
	boundary_value_on_right
from sys.partition_functions

-- create filegroups
alter database salesdb add filegroup fg_2023;
alter database salesdb add filegroup fg_2024;
alter database salesdb add filegroup fg_2025;
alter database salesdb add filegroup fg_2026;

--query lists all existing filegroups

select 
	*
	from sys.filegroups
where type='FG'

-- add .ndf files to each filegroup
alter database salesdb add file
(
name=p_2023,
filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2023.ndf'

)
to filegroup fg_2023

-- add .ndf files to each filegroup
alter database salesdb add file
(
name=p_2024,
filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2024.ndf'

)
to filegroup fg_2024

-- add .ndf files to each filegroup
alter database salesdb add file
(
name=p_2025,
filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2025.ndf'

)
to filegroup fg_2025

-- add .ndf files to each filegroup
alter database salesdb add file
(
name=p_2026,
filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2026.ndf'

)
to filegroup fg_2026

select
	fg.name as filegroupname,
	mf.name as logicalfilename,
	mf.physical_name as physicalfilepath,
	mf.size/128 as sizeinmb

from sys.filegroups fg
join
	sys.master_files mf on fg.data_space_id=mf.data_space_id
where
	mf.database_id=db_id('SalesDB')


-- create partition scheme
create partition scheme schemepartitionbyyear
as partition partitionbyyear
to(fg_2023,fg_2024,fg_2025,fg_2026)

-- query list all partition scheme
select
	ps.name as partitionschemename,
	pf.name as partitionfunctionname,
	ds.destination_id as partitionNumber,
	fg.name as filegroupname

from sys.partition_schemes ps
join sys.partition_functions pf on ps.function_id=pf.function_id
join sys.destination_data_spaces ds on ps.data_space_id=ds.partition_scheme_id
join sys.filegroups fg on ds.data_space_id=fg.data_space_id

