/* sort the customers from lowest to highest scores, with
nulls appearing last */

select customerid,score

from sales.customers order by case when score is null then 1 else 0 end,score