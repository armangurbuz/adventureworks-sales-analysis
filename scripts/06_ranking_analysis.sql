/*
===============================================================================
Script: 06 - Ranking Analysis
===============================================================================
Purpose:
    - To identify the top and bottom performing products
    - To rank subcategories by revenue contribution

Business Question:
    - Which are the top 10 products by revenue?
    - Which bike subcategories rank highest?

Tables Used:
    - FactInternetSales      (f)
    - DimProduct             (p)
    - DimProductSubcategory  (ps)
    - DimProductCategory     (pc)

Author: Tunay Arman Gürbüz

Date(D/M/Y): 26-03-2026
===============================================================================
*/
USE AdventureWorksDW2022;

-- Top 10 products by revenue
SELECT TOP 10
    p.EnglishProductName                            AS Product,
    ps.EnglishProductSubcategoryName                AS Subcategory,
    pc.EnglishProductCategoryName                   AS Category,
    ROUND(SUM(f.SalesAmount), 2)                    AS TotalRevenue,
    ROUND(SUM(f.SalesAmount - f.TotalProductCost), 2) AS TotalGrossProfit
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
JOIN DimProductSubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY p.EnglishProductName, ps.EnglishProductSubcategoryName, pc.EnglishProductCategoryName
ORDER BY TotalRevenue DESC;

-- Bottom 10 products by revenue
SELECT TOP 10
    p.EnglishProductName                            AS Product,
    ps.EnglishProductSubcategoryName                AS Subcategory,
    pc.EnglishProductCategoryName                   AS Category,
    ROUND(SUM(f.SalesAmount), 2)                    AS TotalRevenue,
    ROUND(SUM(f.SalesAmount - f.TotalProductCost), 2) AS TotalGrossProfit
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
JOIN DimProductSubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY p.EnglishProductName, ps.EnglishProductSubcategoryName, pc.EnglishProductCategoryName
ORDER BY TotalRevenue ASC;