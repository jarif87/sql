/* find the average score for each country considering only customers with a score not equal to 0 
and return only those countries with an average score greater than 430 */

select country,avg(score) as avg_score from customers where score !=0 
	group by country having avg(score)>430

