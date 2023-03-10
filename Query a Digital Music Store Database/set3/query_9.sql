--Write a query that determines the customer that has spent the most on music for each country. 
--Write a query that returns the country along with the top customer and how much they spent. 
--For countries where the top amount spent is shared, provide all customers who spent this amount.
WITH t1 AS 
(SELECT c.Country, 
        SUM(i.Total) TotalSpent, 
		c.FirstName, 
		c.LastName, 
		c.CustomerId
	FROM Customer c
	JOIN Invoice i 
	ON c.CustomerId = i.CustomerId
	GROUP BY c.CustomerId)

SELECT t1.*
FROM t1
JOIN(SELECT Country, 
	        MAX(TotalSpent) MaxTotalSpent, 
	        FirstName, 
	        LastName, 
	        CustomerId
	FROM t1
	GROUP BY Country)t2
ON t1.Country = t2.Country
WHERE t1.TotalSpent = t2.MaxTotalSpent
ORDER BY Country 