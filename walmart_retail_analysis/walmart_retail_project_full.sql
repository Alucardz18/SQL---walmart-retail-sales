use walmart_retail;

-- Which store generates the highest total sales over the period?
SELECT Store, SUM(Weekly_Sales) AS total_sales
FROM walmart_store_sales
GROUP BY Store
ORDER BY total_sales DESC
LIMIT 1;

-- Which stores have the most volatile sales patterns (stddev of weekly sales)?
SELECT Store, STDDEV(Weekly_Sales) AS volatility
FROM walmart_store_sales
GROUP BY Store
ORDER BY 2 DESC
LIMIT 5;


-- Overall sales trend across 2010–2012 (monthly aggregation):
SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month,
    SUM(Weekly_Sales) AS monthly_sales
FROM walmart_store_sales
GROUP BY 1
ORDER BY 1;


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


-- Monthly and Semester Breakdown
-- Monthly
SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month,
    SUM(Weekly_Sales) AS monthly_sales
FROM walmart_store_sales
GROUP BY month
ORDER BY month;

-- Semester
SELECT
    EXTRACT(year FROM CAST(Date AS DATE)) AS year,
    CASE 
        WHEN EXTRACT(month FROM CAST(Date AS DATE)) BETWEEN 1 AND 6 THEN 'H1'
        ELSE 'H2'
    END AS semester,
    SUM(Weekly_Sales) AS semester_sales
FROM walmart_store_sales
GROUP BY year, semester
ORDER BY year, semester;

-- Stores outperforming or underperforming
WITH store_avg AS (
    SELECT Store, AVG(Weekly_Sales) AS avg_sales
    FROM walmart_store_sales
    GROUP BY Store
),
overall_avg AS (
    SELECT AVG(Weekly_Sales) AS overall_avg_sales FROM walmart_store_sales
)

SELECT
    sa.Store,
    sa.avg_sales,
    oa.overall_avg_sales,
    sa.avg_sales - oa.overall_avg_sales AS diff,
    CASE WHEN sa.avg_sales > oa.overall_avg_sales THEN 'Outperforming' ELSE 'Underperforming' END AS performance
FROM store_avg sa
CROSS JOIN overall_avg oa
ORDER BY diff DESC;


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


-- 
