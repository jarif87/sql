create table sales.employeeLOGS(
	logid int identity(1,1) primary key,
	employeeid int,
	logmessage varchar(255),
	logdate date
)

create trigger  trg_after_insert_employee on sales.employees
after insert
as
begin
	insert into sales.employeelogs (employeeid,logmessage,logdate)
	select
		employeeid,
		'new_employee_added='+ cast(employeeid as varchar),
		getdate()
		from inserted
end

select * from sales.employeeLOGS

insert into sales.employees
values
(7,'Maria','doe','messi','1998-01-12','F',80000,3)