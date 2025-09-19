-- Do stores with higher temperature ranges see sales differences?
WITH temp_stats AS (
    SELECT 
        Store,
        MAX(Temperature) - MIN(Temperature) AS temp_range,
        AVG(Weekly_Sales) AS avg_sales
    FROM walmart_store_sales
    GROUP BY Store
)

SELECT * FROM temp_stats
ORDER BY temp_range DESC;

