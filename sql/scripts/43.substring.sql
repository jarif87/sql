/* retrive a list of customers first names removing the first character */

select first_name, substring(trim(first_name), 2,len(first_name)) as sub_name from customers