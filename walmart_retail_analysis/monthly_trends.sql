-- Overall sales trend across 2010–2012 (monthly aggregation):
SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month,
    SUM(Weekly_Sales) AS monthly_sales
FROM walmart_store_sales
WHERE Date BETWEEN '2010-01-01' AND '2012-12-31'
GROUP BY 1
ORDER BY 1;