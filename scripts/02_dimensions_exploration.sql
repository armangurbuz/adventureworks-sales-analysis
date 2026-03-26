/*
==========================================================================================
Script: 02 - Dimensions Exploration
==========================================================================================
Purpose:
- To explore the unique values within key dimension tables
- To understand the geographic spread of customers
- To map the full product hierarcy
- To identify avaiable customer segments for analysis 

Business Question: 
- What markets does the company operate in?
- What is the complete product catalogue structure?
- What customer profiles exist in the data? 

Tables Used:
- DimGeography          (g)
- DimProduct            (p)
- DimProductSubcategory (ps)
- DimProductCategory    (pc)
- DimCustomer           (c)

Author: Tunay Arman Gürbüz

Date(D/M/Y): 25-03-2026
==========================================================================================
*/ 
-- ---------------------------------------------------------------------------------------
-- Countries where customers are located
-- ---------------------------------------------------------------------------------------
USE AdventureWorksDW2022;

SELECT DISTINCT 
    EnglishCountryRegionName    AS Country 
FROM DimGeography 
ORDER BY Country; 

-- ----------------------------------------------------------------------------------------
-- Full product hierarchy: Category > Subcategory > Product
-- Note: Requires 2 JOINs because AdventureWorksDW stores this as a 3 level star schema, not a flat table
-- ----------------------------------------------------------------------------------------
SELECT DISTINCT 
    pc.EnglishProductCategoryName AS Category,
    ps.EnglishProductSubcategoryName AS Subcategory,
    p.EnglishProductName    AS Product 
FROM DimProduct p  
JOIN DimProductSubcategory ps 
ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey 
JOIN DimProductCategory pc 
ON ps.ProductCategoryKey = pc.ProductCategoryKey 
ORDER BY Category, Subcategory, Product; 

-- -------------------------------------------------------
-- Customer education levels
-- -------------------------------------------------------
SELECT DISTINCT
    EnglishEducation        AS EducationLevel
FROM DimCustomer
ORDER BY EducationLevel;

-- -------------------------------------------------------
-- Customer occupations
-- -------------------------------------------------------
SELECT DISTINCT
    EnglishOccupation       AS Occupation
FROM DimCustomer
ORDER BY Occupation;

-- -------------------------------------------------------
-- Sales territories and regions
-- -------------------------------------------------------
SELECT DISTINCT
    SalesTerritoryGroup     AS TerritoryGroup,
    SalesTerritoryCountry   AS Country,
    SalesTerritoryRegion    AS Region
FROM DimSalesTerritory
ORDER BY TerritoryGroup, Country, Region;