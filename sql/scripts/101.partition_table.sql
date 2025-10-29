CREATE PARTITION FUNCTION partitionbyyear (date)
AS RANGE LEFT FOR VALUES ('2022-12-31', '2023-12-31', '2024-12-31', '2025-12-31');
GO

SELECT pf.name AS PartitionFunction,
       COUNT(prv.value) AS BoundaryCount
FROM sys.partition_functions pf
LEFT JOIN sys.partition_range_values prv
    ON pf.function_id = prv.function_id
WHERE pf.name = 'partitionbyyear'
GROUP BY pf.name;

ALTER DATABASE SalesDB ADD FILEGROUP fg_2022;
GO



CREATE PARTITION SCHEME schemepartitionbyyear
AS PARTITION partitionbyyear
TO (fg_2022, fg_2023, fg_2024, fg_2025, fg_2026);





DROP PARTITION FUNCTION partitionbyyear;
GO


USE SalesDB;
GO

ALTER DATABASE SalesDB ADD FILE
(
    NAME = p_2022,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2022.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP fg_2022;
GO


--create table sales
CREATE TABLE dbo.orders_partitioned
(
    orderid INT,
    orderdate DATE,
    sales INT
)
ON schemepartitionbyyear(orderdate);

--insert data
INSERT INTO dbo.orders_partitioned (orderid, orderdate, sales)
VALUES
(1, '2022-10-10', 150),
(2, '2023-05-15', 200),
(3, '2024-07-22', 250),
(4, '2025-03-19', 300),
(5, '2026-01-05', 350);
GO

select * from dbo.orders_partitioned

SELECT
    p.partition_number AS PartitionNumber,
    fg.name AS PartitionFileGroup,
    p.rows AS NumberOfRows
FROM sys.partitions p
JOIN sys.indexes i
    ON p.object_id = i.object_id AND p.index_id = i.index_id
JOIN sys.partition_schemes ps
    ON i.data_space_id = ps.data_space_id
JOIN sys.destination_data_spaces dds
    ON ps.data_space_id = dds.partition_scheme_id
JOIN sys.filegroups fg
    ON dds.data_space_id = fg.data_space_id
WHERE object_name(p.object_id) = 'orders_partitioned'
  AND i.index_id IN (0,1)  -- 0=heap, 1=clustered index
ORDER BY p.partition_number;


select * 
into dbo.orders_nopartition
from dbo.orders_partitioned

select
*
from dbo.orders_nopartition
where orderdate='2025-03-19'