/*
===============================================================================
Script: 01 - Database Exploration
===============================================================================
Purpose:
- To explore the structure of the database
- To identify all available tables and their schemas
- To inspect columns, data types, and nullability of key tables

Business Question: 
- What data is aavilable to us, and how is it structured?

Tables Used:
- INFORMATION_SCHEMA.Tables
- INFORMATION_SCHEMA.COLUMNS

Author: Tunay Arman Gürbüz
Date(D/M/Y): 25-03-2026

===============================================================================
*/

-- -------------------------------------------------------
-- All tables in the AdventureWorksDW2022 database
USE AdventureWorksDW2022

SELECT
    TABLE_SCHEMA    AS SchemaName,
    TABLE_NAME      AS TableName,
    TABLE_TYPE     AS TableType
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_NAME;

-- -------------------------------------------------------
-- Row counts across all tables
-- Helps identify which are fact tables (high row count)
-- vs dimension tables (low row count)
-- -------------------------------------------------------

SELECT 
    t.TABLE_SCHEMA  AS SchemaName,
    t.TABLE_NAME    AS TableName,
    p.[ROWS]        AS TotalRows 

FROM INFORMATION_SCHEMA.TABLES t 
JOIN sys.partitions p 
    ON p.object_id = OBJECT_ID(t.TABLE_SCHEMA + '.' + t.TABLE_NAME)
WHERE t.TABLE_TYPE = 'BASE TABLE'
    AND p.index_id IN (0,1)
ORDER BY p.rows DESC; 

-- -------------------------------------------------------
-- Column details for the main fact table
-- -------------------------------------------------------

SELECT
    COLUMN_NAME                AS ColumnName,
    DATA_TYPE                  AS DataType,
    IS_NULLABLE                AS IsNullable,
    CHARACTER_MAXIMUM_LENGTH   AS MaxLength
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FactInternetSales'
ORDER BY ORDINAL_POSITION;