-- Which store generates the highest total sales over the period?
SELECT Store, SUM(Weekly_Sales) AS total_sales
FROM walmart_store_sales
GROUP BY Store
ORDER BY total_sales DESC
LIMIT 10;
