insert into customers (id,first_name,country,score)
	values (6,'anna','usa',null),
		(7,'sam',null,100)

insert into customers (id,first_name)
	values (12,'sara'),(13,'robi')


select * from customers

-- copy data from customers table into persons

select id,first_name,null,'unknown' from customers

insert into persons(id,person_name,birth_date,phone) select id,first_name,null,'unknown' from customers

select * from persons