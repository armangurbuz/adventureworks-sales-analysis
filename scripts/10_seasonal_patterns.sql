/*
===============================================================================
Script: 10 - Seasonal Patterns
===============================================================================
Purpose:
    - To identify monthly revenue patterns across all years
    - To determine whether this business has seasonal peaks or is consistent

Business Question:
    - Does a cycling company show seasonal spikes in spring/summer?
    - Which months consistently perform strongest?

Tables Used:
    - FactInternetSales (f)

Author: Tunay Arman Gürbüz
Date(D/M/Y): 26-03-2026
===============================================================================
*/

USE AdventureWorksDW2022;

-- Monthly revenue across all years
SELECT
    YEAR(f.OrderDate)                           AS Year,
    MONTH(f.OrderDate)                          AS MonthNumber,
    DATENAME(MONTH, f.OrderDate)                AS MonthName,
    COUNT(DISTINCT f.SalesOrderNumber)          AS TotalOrders,
    ROUND(SUM(f.SalesAmount), 2)                AS TotalRevenue
FROM FactInternetSales f
GROUP BY YEAR(f.OrderDate), MONTH(f.OrderDate), DATENAME(MONTH, f.OrderDate)
ORDER BY Year, MonthNumber;

-- Average revenue by month across all years combined
SELECT
    MONTH(f.OrderDate)                          AS MonthNumber,
    DATENAME(MONTH, f.OrderDate)                AS MonthName,
    COUNT(DISTINCT f.SalesOrderNumber)          AS TotalOrders,
    ROUND(SUM(f.SalesAmount), 2)                AS TotalRevenue,
    ROUND(AVG(f.SalesAmount), 2)                AS AvgOrderValue
FROM FactInternetSales f
GROUP BY MONTH(f.OrderDate), DATENAME(MONTH, f.OrderDate)
ORDER BY MonthNumber;