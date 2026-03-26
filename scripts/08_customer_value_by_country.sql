/*
===============================================================================
Script: 08 - Customer Lifetime Value by Country
===============================================================================
Purpose:
    - To calculate average revenue per customer by country
    - To identify which markets have the highest value customers
      vs highest volume customers

Business Question:
- Which country has the highest value customers on average? 
- Is Australia's strong total revenue driven by many customers or by high-spending customers?

Tables Used: 
- FactInternetSales (f)
- DimCustomer       (c)
- DimGeography      (g)

Author: Tunay Arman Gürbüz
Date(D/M/Y): 26-03-2026
*/ 
USE AdventureWorksDW2022;

-- Customer Value by country
SELECT 
g.EnglishCountryRegionName  AS Country,
COUNT(DISTINCT f.CustomerKey) AS TotalCustomers,
COUNT(DISTINCT f.SalesOrderNumber) AS TotalOrders,
ROUND(SUM(f.SalesAmount), 2)    AS TotalRevenue,
ROUND(SUM(f.SalesAmount)
/ COUNT(DISTINCT f.CUstomerKey), 2) AS AvgRevenuePerCustomer,
ROUND(SUM(f.SalesAmount)
    / COUNT(DISTINCT f.SalesOrderNumber), 2) AS AvgOrderValue 
FROM FactInternetSales f  
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey 
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey 
GROUP BY g.EnglishCountryRegionName
ORDER BY AvgRevenuePerCustomer DESC;