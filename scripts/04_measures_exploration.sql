/*
===============================================================================
Script: 04 - Measures Exploration
===============================================================================
Purpose: 
- To calculate the core business metrics of the company
- To establish the headline KPIs that frame all further analysis 

Business Question: 
- What is the overall scale of the business? 
- What are the total revenue, profit, orders and units sold?
- What is the average order value and profit margin? 

Tables Used: 
- FactInternetSales (f)

Author: Tunay Arman Gürbüz

Date(D/M/Y): 26-03-2026
===============================================================================
*/
USE AdventureWorksDW2022;
-- -------------------------------------------------------
-- Core business KPIs — the headline numbers
-- -------------------------------------------------------
SELECT
    COUNT(DISTINCT SalesOrderNumber)                AS TotalOrders,
    SUM(OrderQuantity)                              AS TotalUnitsSold,
    ROUND(SUM(SalesAmount), 2)                      AS TotalRevenue,
    ROUND(SUM(SalesAmount - TotalProductCost), 2)   AS TotalGrossProfit,
    ROUND(AVG(SalesAmount), 2)                      AS AvgOrderValue,
    ROUND(
        SUM(SalesAmount - TotalProductCost)
        / SUM(SalesAMount) * 100, 2)                AS GrossMarginPct
   FROM FactInternetSales;