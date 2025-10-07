-- add a new column called email to the persons table

alter table persons add email varchar(100) not null

alter table persons drop column phone

select * from persons

