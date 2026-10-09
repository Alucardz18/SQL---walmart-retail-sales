# 🛒 Walmart Retail Sales Analysis
 # 📌 Project Overview

This project analyzes Walmart’s historical retail sales data (2010–2012) using SQL. The goal is to uncover insights on store performance, sales volatility, holiday impacts, and long-term sales trends.

# 📂 Dataset

The dataset comes from [Kaggle – Walmart Dataset (Retail)](https://www.kaggle.com/datasets/rutuspatel/walmart-dataset-retail).
It includes:  
Store – Store number  
Date – Week of sales  
Weekly_Sales – Sales for the given store  
Holiday_Flag – 1 if holiday week, 0 otherwise  
Temperature – Average temperature  
Fuel_Price – Fuel cost in the region  
CPI – Consumer Price Index  
Unemployment – Regional unemployment rate  

# 🔎 Key Analysis & SQL Queries

- Top Performing Stores → Which store generated the highest total sales
- Sales Volatility → Stores with the highest standard deviation of weekly sales
- Sales Trends → Monthly & semester breakdown of sales from 2010–2012
- Holiday Impact → Which holidays boosted sales compared to average weeks
- Quarterly Growth → Stores with the best Q3 2012 growth
- Performance Benchmarking → Outperforming vs. underperforming stores
- External Factors → Relationship between temperature ranges and sales

# 🛠️ Tools & Skills

- SQL (MySQL Workbench) → Data cleaning, querying, and analysis
- SQL techniques → CTEs, aggregate functions, `CASE WHEN` logic, `CROSS JOIN` benchmarking, date functions
- Data Analytics → Sales trend analysis, seasonality, volatility checks, store benchmarking

# 📈 Key Insights

The dataset covers **45 stores** and **6,435 weekly sales records** (February 2010 to October 2012), totaling **$6.74B** in sales.

- **Store 20** had the highest total sales across the period (**$301.4M**), followed closely by Store 4 ($299.5M) and Store 14 ($289.0M).
- **Holiday weeks averaged 7.8% higher sales** than non-holiday weeks, but the lift came almost entirely from one holiday:
  - **Thanksgiving week: +41%** above a normal week
  - **Super Bowl week: +4%**
  - **Labor Day week: about even**
  - **The flagged Christmas week: 8% lower**, because the flagged week falls at the very end of December, after the pre-Christmas shopping rush
- **Store 14** had the most volatile weekly sales (highest standard deviation), followed by Stores 10 and 20, so the top-selling stores also tend to be the least predictable.

# 🚀 Next Steps

- Build a Power BI or Excel dashboard on top of these queries
- Extend the analysis with predictive modeling (linear regression) using temperature, fuel price, CPI, and unemployment
