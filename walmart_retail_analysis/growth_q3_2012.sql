-- Stores with highest quarterly growth in Q3 2012:
WITH quarterly_sales AS (
    SELECT 
        Store,
        DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS quarter,
        SUM(Weekly_Sales) AS total_sales
    FROM walmart_store_sales
    WHERE Date BETWEEN '2012-04-01' AND '2012-09-30'
    GROUP BY Store, 2
),
growth AS (
    SELECT 
        q3.Store,
        q3.total_sales AS q3_sales,
        q2.total_sales AS q2_sales,
        (q3.total_sales - q2.total_sales) / NULLIF(q2.total_sales, 0) AS growth_rate
    FROM quarterly_sales q3
    JOIN quarterly_sales q2 ON q3.Store = q2.Store
    WHERE q3.quarter = DATE '2012-07-01' AND q2.quarter = DATE '2012-04-01'
)

SELECT * FROM growth
ORDER BY growth_rate DESC
LIMIT 5;