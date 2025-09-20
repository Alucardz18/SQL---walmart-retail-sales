-- Overall sales trend across 2010–2012 (monthly aggregation):
SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month,
    SUM(Weekly_Sales) AS monthly_sales
FROM walmart_store_sales
GROUP BY 1
ORDER BY 1;
