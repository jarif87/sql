-- convert the first name to lowercase

select first_name,country, concat(first_name,' , ',country) as name_country,
lower(first_name) as low_name
from customers


-- convert the first name to uppercase

select first_name,country, concat(first_name,' , ',country) as name_country,
lower(first_name) as low_name,
upper(first_name) as up_name
from customers