-- Which store generates the highest total sales over the period?
SELECT Store, SUM(Weekly_Sales) AS total_sales
FROM walmart_store_sales
WHERE Date BETWEEN '2010-01-01' AND '2012-12-31'
GROUP BY Store
ORDER BY total_sales DESC
LIMIT 1;