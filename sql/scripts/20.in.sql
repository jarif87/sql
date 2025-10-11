-- retrive all customers from either germany or USA

select * from customers where country='Germany' or country ='usa'

select * from customers where country in ('germany','usa')