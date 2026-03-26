/*
===============================================================================
Script: 05 - Magnitude Analysis
===============================================================================
Purpose:
- To identify which cateogories and countries generate the most business 
- To understand the scale of each segment

Business Question:
- Which product categories generate the most revenue and profit?
- Which countries are the biggest markets? 

Tables Used:
- FactInternetSales (f)
- DimProduct        (p)
- DimProductSubcategory (ps)
- DimProductCategory    (pc)
-DimCustomer        (c)
-DimGeography        (g)

Author: Tunay Arman Gürbüz

Date(D/M/Y): 26-03-2026
===============================================================================
*/
USE AdventureWorksDW2022;
-- -------------------------------------------------------
-- Revenue and profit by product category
-- -------------------------------------------------------
SELECT 
pc.EnglishProductCategoryName                       AS Category, 
COUNT(DISTINCT f.SalesOrderNumber)                  AS TotalOrders,
SUM(f.OrderQuantity)                                AS TotalUnitsSold,
ROUND(SUM(f.SalesAmount), 2)                        AS TotalRevenue,
ROUND(SUM(f.SalesAmount - f.TotalProductCost), 2)   AS TotalGrossProfit
FROM FactInternetSales f  
JOIN DimProduct p  
    ON f.ProductKey = p.ProductKey 
JOIN DimProductSubcategory ps 
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey 
JOIN DimProductCategory pc 
    ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.EnglishProductCategoryName 
ORDER BY TotalRevenue DESC; 
-- -------------------------------------------------------
-- Revenue and profit by country
-- -------------------------------------------------------
SELECT
    g.EnglishCountryRegionName              AS Country,
    COUNT(DISTINCT f.SalesOrderNumber)      AS TotalOrders,
    SUM(f.OrderQuantity)                    AS TotalUnitsSold,
    ROUND(SUM(f.SalesAmount), 2)            AS TotalRevenue,
    ROUND(SUM(f.SalesAmount
        - f.TotalProductCost), 2)           AS TotalGrossProfit
FROM FactInternetSales f
JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
JOIN DimGeography g
    ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName
ORDER BY TotalRevenue DESC;
