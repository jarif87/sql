-- retrive employee details with gender displayed as full text

select employeeid,firstname,lastname,gender,
case
	when gender='F' then 'Female'
	when gender='M' then 'Male'
	else 'Not Available'

end  as genderfulltext
from sales.employees

-- retrive customers details with abbreviated country code

select customerid,firstname,lastname,country,
case
	when country='Germany' then 'De'
	when country='USA' then 'US'
	else 'n/a'
end as CountryABBR

from sales.customers;
