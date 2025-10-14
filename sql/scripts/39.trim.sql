/* find customers whose first name contains leading or trailing spaces */

select first_name from customers where first_name != trim(first_name)