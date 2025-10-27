--step 1: write query
/* for us customers find the total number of customers and the average score */

select
	count(*) as total_customers,
	avg(score) as AVG_SCORE
	from sales.customers
where country='USA'

-- step 2: turning the query into a stored procedure

create procedure get_customer_summary as 
begin
select
	count(*) as total_customers,
	avg(score) as AVG_SCORE
	from sales.customers
where country='USA'
end

-- step 3: execute the stored procedure
exec get_customer_summary

-- Parameters Inside stored Procedure

/* for german customers find the total number of customers
and the average score */

alter  procedure get_customer_summary @country nvarchar(50)='usa' as 
begin
select
	count(*) as total_customers,
	avg(score) as AVG_SCORE
	from sales.customers
where country=@country
end

exec get_customer_summary @country='germany'

exec get_customer_summary @country='usa'

-- find the total number of orders and total SALES

alter  procedure get_customer_summary @country nvarchar(50)='usa' as 
begin
select
	count(*) as total_customers,
	avg(score) as AVG_SCORE
	from sales.customers
where country=@country



select
	count(orderid) as total_orders,
	sum(sales) as total_sales
	from sales.orders
	join sales.customers
	on customers.customerid=orders.customerid
where customers.country=@country

end


exec get_customer_summary @country='germany'


-- variables

alter  procedure get_customer_summary @country nvarchar(50)='usa' as 
begin
declare @total_customers int, @avg_score float;
select
	@total_customers=count(*) ,
	@avg_score=avg(score) 
	from sales.customers
where country=@country

print 'total customers from' +@country+ ':'+ cast(@total_customers as Nvarchar);
print 'average score from' +@country+ ':' + cast(@avg_score as nvarchar);




select
	count(orderid) as total_orders,
	sum(sales) as total_sales
	from sales.orders
	join sales.customers
	on customers.customerid=orders.customerid
where customers.country=@country

end
go


exec get_customer_summary @country='germany'

-- control flow if else

alter  procedure get_customer_summary @country nvarchar(50)='usa' as 
begin
declare @total_customers int, @avg_score float;


if exists(select 1 from sales.customers where score is null and country=@country)
begin
	print('updating null scores to 0')
	update sales.customers
	set score=0
	where score is null and country=@country;
end


else
begin
	print('no null scores found');
end

select
	@total_customers=count(*) ,
	@avg_score=avg(score) 
	from sales.customers
where country=@country

print 'total customers from' +@country+ ':'+ cast(@total_customers as Nvarchar);
print 'average score from' +@country+ ':' + cast(@avg_score as nvarchar);




select
	count(orderid) as total_orders,
	sum(sales) as total_sales
	from sales.orders
	join sales.customers
	on customers.customerid=orders.customerid
where customers.country=@country

end
go

exec get_customer_summary 

exec get_customer_summary @country='germany'

-- error handling try and catch

alter  procedure get_customer_summary @country nvarchar(50)='usa' as 
begin
begin try
declare @total_customers int, @avg_score float;


if exists(select 1 from sales.customers where score is null and country=@country)
begin
	print('updating null scores to 0')
	update sales.customers
	set score=0
	where score is null and country=@country;
end


else
begin
	print('no null scores found');
end

select
	@total_customers=count(*) ,
	@avg_score=avg(score) 
	from sales.customers
where country=@country

print 'total customers from' +@country+ ':'+ cast(@total_customers as Nvarchar);
print 'average score from' +@country+ ':' + cast(@avg_score as nvarchar);




select
	count(orderid) as total_orders,
	sum(sales) as total_sales,
	
	1/0
	from sales.orders
	join sales.customers
	on customers.customerid=orders.customerid
where customers.country=@country
end try
begin catch
	print('an error occurred');
	print('error message: ' + error_message());
	print('error number: ' + cast(error_number() as nvarchar));
	print('error line: ' + cast(error_line() as nvarchar));
	print('error procedure: ' + error_procedure());
end catch
end
go

exec get_customer_summary 

-- styling stored procedures

ALTER PROCEDURE get_customer_summary 
    @country NVARCHAR(50) = 'usa'
AS
BEGIN
    BEGIN TRY
        DECLARE 
            @total_customers INT, 
            @avg_score FLOAT;

        -- Check and update null scores
        IF EXISTS (
            SELECT 1 
            FROM sales.customers 
            WHERE score IS NULL 
              AND country = @country
        )
        BEGIN
            PRINT('Updating null scores to 0...');
            UPDATE sales.customers
            SET score = 0
            WHERE score IS NULL 
              AND country = @country;
        END
        ELSE
        BEGIN
            PRINT('No null scores found.');
        END

        -- Calculate customer statistics
        SELECT
            @total_customers = COUNT(*),
            @avg_score = AVG(score)
        FROM sales.customers
        WHERE country = @country;

        PRINT 'Total customers from ' + @country + ': ' + CAST(@total_customers AS NVARCHAR(20));
        PRINT 'Average score from ' + @country + ': ' + CAST(@avg_score AS NVARCHAR(20));

        -- Order summary
        SELECT
            COUNT(o.orderid) AS total_orders,
            SUM(o.sales) AS total_sales
        FROM sales.orders AS o
        JOIN sales.customers AS c
            ON c.customerid = o.customerid
        WHERE c.country = @country;

        -- Force an error (for testing TRY...CATCH)
        SELECT 1 / 0;  
    END TRY

    BEGIN CATCH
        PRINT('An error occurred.');
        PRINT('Error message: ' + ERROR_MESSAGE());
        PRINT('Error number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)));
        PRINT('Error line: ' + CAST(ERROR_LINE() AS NVARCHAR(10)));
        PRINT('Error procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A'));
    END CATCH
END;
GO

-- Execute the procedure
EXEC get_customer_summary;
