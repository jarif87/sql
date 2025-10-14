-- remove dashes (-) froma phone number

select '123-456-7890' as phone,  replace('123-456-7890','-','') as clean_phone

-- replace file extense from txt to csv

select 'report.txt' as old_name,replace('report.txt','.txt','.csv') as new_name