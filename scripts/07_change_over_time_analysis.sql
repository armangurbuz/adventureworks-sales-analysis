/*
===============================================================================
Script: 07 - Change Over Time Analysis
===============================================================================
Purpose:
- To analyse how revenue, profit and orders have trended year on year
- To identify growth years, decline years and inflection points

Business Question: 
- How has internet sales performance evolved between 2010 and 2014?
- Which years saw the strongest growth or decline?

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
-- Year on year revenue, profit and orders
SELECT
    YEAR(f.OrderDate)                               AS Year,
    COUNT(DISTINCT f.SalesOrderNumber)              AS TotalOrders,
    SUM(f.OrderQuantity)                            AS TotalUnitsSold,
    ROUND(SUM(f.SalesAmount), 2)                    AS TotalRevenue,
    ROUND(SUM(f.SalesAmount - f.TotalProductCost), 2) AS TotalGrossProfit,
    ROUND(SUM(f.SalesAmount - f.TotalProductCost)
        / SUM(f.SalesAmount) * 100, 2)              AS GrossMarginPct
FROM FactInternetSales f
GROUP BY YEAR(f.OrderDate)
ORDER BY Year;

-- Revenue by year and product category 
SELECT
    YEAR(f.OrderDate)                               AS Year,
    pc.EnglishProductCategoryName                   AS Category,
    ROUND(SUM(f.SalesAmount), 2)                    AS TotalRevenue,
    ROUND(SUM(f.SalesAmount - f.TotalProductCost), 2) AS TotalGrossProfit
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
JOIN DimProductSubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY YEAR(f.OrderDate), pc.EnglishProductCategoryName
ORDER BY Year, TotalRevenue DESC;

