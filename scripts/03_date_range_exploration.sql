/*
===========================================================================
Script: 03 - Date Range Exploration
===========================================================================
Purpose:
- To identify the time boundaries of the sales data
- To understand the full period covered by the analysis 

Business Question: 
- What is the earliest and latest order and ship date in the dataset?
- What time period does this analysis cover? 

Tables Used:
- FactInternetSales

Author: Tunay Arman Gürbüz

Date(D/M/Y): 26-03-2026 
============================================================================
*/
USE AdventureWorksDW2022;

SELECT
MIN(OrderDate) AS FirstOrderDate, 
MAX(OrderDate) AS LatestOrderDate,
MIN(ShipDate) AS FirstShipDate, 
MAX(ShipDate) AS LatestShipDate 
FROM FactInternetSales;
