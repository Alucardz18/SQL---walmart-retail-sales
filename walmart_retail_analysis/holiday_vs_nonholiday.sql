-- Holiday weeks vs Non-holiday weeks sales:
SELECT 
    CASE WHEN Holiday_Flag = 1 THEN 'Holiday Week' ELSE 'Non-Holiday Week' END AS week_type,
    AVG(Weekly_Sales) AS avg_sales
FROM walmart_store_sales
GROUP BY week_type;

-- Which holidays consistently boost sales above average?
WITH avg_weekly_sales AS (
    SELECT AVG(Weekly_Sales) AS avg_sales
    FROM walmart_store_sales
)

SELECT 
    'Holiday Week' AS week_type,
    AVG(CASE WHEN Holiday_Flag = 1 THEN Weekly_Sales ELSE NULL END) AS avg_sales,
    (SELECT avg_sales FROM avg_weekly_sales) AS overall_avg,
    CASE 
        WHEN AVG(CASE WHEN Holiday_Flag = 1 THEN Weekly_Sales ELSE NULL END) > (SELECT avg_sales FROM avg_weekly_sales)
        THEN 'Boost'
        ELSE 'No Boost' 
    END AS sales_impact
FROM walmart_store_sales;