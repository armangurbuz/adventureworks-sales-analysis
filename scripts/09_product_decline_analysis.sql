/*
===============================================================================
Script: 09 - Product Decline Analysis
===============================================================================
Purpose:
    - To identify products that were selling in early years but
      disappeared or declined significantly by 2013-2014
    - To understand product lifecycle patterns

Business Question:
    - Which products lost sales momentum over time?
    - Are there products the business should reconsider or retire?

Tables Used:
    - FactInternetSales  (f)
    - DimProduct         (p)

Author: Tunay Arman Gürbüz
Date(D/M/Y): 26-03-2026
===============================================================================
*/

USE AdventureWorksDW2022;

-- Revenue per product per year to spot decline patterns 
SELECT
    p.EnglishProductName                        AS Product,
    YEAR(f.OrderDate)                           AS Year,
    COUNT(DISTINCT f.SalesOrderNumber)          AS TotalOrders,
    ROUND(SUM(f.SalesAmount), 2)                AS TotalRevenue
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName, YEAR(f.OrderDate)
ORDER BY p.EnglishProductName, Year;

-- Products that sold in 2011 but had zero sales in 2013
SELECT DISTINCT
    p.EnglishProductName                        AS Product
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
WHERE YEAR(f.OrderDate) = 2011
    AND p.ProductKey NOT IN (
        SELECT DISTINCT ProductKey
        FROM FactInternetSales
        WHERE YEAR(OrderDate) = 2013
    )
ORDER BY Product;