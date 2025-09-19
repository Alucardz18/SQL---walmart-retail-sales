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
