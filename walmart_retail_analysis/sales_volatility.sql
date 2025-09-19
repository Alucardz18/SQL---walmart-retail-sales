-- Which stores have the most volatile sales patterns (stddev of weekly sales)?
SELECT Store, STDDEV(Weekly_Sales) AS volatility
FROM walmart_store_sales
GROUP BY Store
ORDER BY 2 DESC
LIMIT 5;