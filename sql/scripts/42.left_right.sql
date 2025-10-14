-- retrive the first two charcters of each first name

select first_name, left(first_name,2) as first_2_char from customers

select first_name, left(trim(first_name),2) as first_2_char from customers

-- retrive the last two charcters of each first name

select first_name, left(trim(first_name),2) as first_2_char,
right(first_name,2) as last_2_char from customers

