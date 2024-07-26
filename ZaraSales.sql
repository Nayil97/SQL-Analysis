CREATE DATABASE ZaraSalesDB;
USE ZaraSalesDB;

CREATE TABLE ZaraSales (
    ProductID INT,
    ProductPosition VARCHAR(255),
    Promotion VARCHAR(255),
    ProductCategory VARCHAR(255),
    Seasonal VARCHAR(255),
    SalesVolume INT,
    Brand VARCHAR(255),
    URL VARCHAR(255),
    SKU VARCHAR(255),
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    Currency VARCHAR(10),
    ScrapedAt DATETIME,
    Terms TEXT,
    Section VARCHAR(255)
);

-- Check the structure of the table
DESCRIBE ZaraSales;

-- View the first few rows
SELECT * FROM ZaraSales LIMIT 5;

SELECT 
    ProductID, 
    ProductPosition, 
    Promotion, 
    ProductCategory, 
    Seasonal, 
    SalesVolume, 
    Brand, 
    URL, 
    SKU, 
    Name, 
    Description, 
    Price, 
    Currency, 
    ScrapedAt, 
    Terms, 
    Section, 
    COUNT(*) as duplicate_count 
FROM 
    ZaraSales 
GROUP BY 
    ProductID, 
    ProductPosition, 
    Promotion, 
    ProductCategory, 
    Seasonal, 
    SalesVolume, 
    Brand, 
    URL, 
    SKU, 
    Name, 
    Description, 
    Price, 
    Currency, 
    ScrapedAt, 
    Terms, 
    Section 
HAVING 
    COUNT(*) > 1;
    
    
    -- Standardize the promotion field
UPDATE ZaraSales SET Promotion = 'Yes' WHERE Promotion LIKE 'Y%';
UPDATE ZaraSales SET Promotion = 'No' WHERE Promotion LIKE 'N%';

-- Standardize the seasonal field
UPDATE ZaraSales SET Seasonal = 'Yes' WHERE Seasonal LIKE 'Y%';
UPDATE ZaraSales SET Seasonal = 'No' WHERE Seasonal LIKE 'N%';

-- Calculate summary statistics for numerical columns
SELECT 
    AVG(SalesVolume) AS AvgSalesVolume, 
    MIN(SalesVolume) AS MinSalesVolume, 
    MAX(SalesVolume) AS MaxSalesVolume,
    AVG(Price) AS AvgPrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM ZaraSales;

-- View sales distribution
SELECT SalesVolume, COUNT(*) AS Frequency
FROM ZaraSales
GROUP BY SalesVolume
ORDER BY SalesVolume;

-- Analyze sales by product category
SELECT ProductCategory, SUM(SalesVolume) AS TotalSales
FROM ZaraSales
GROUP BY ProductCategory
ORDER BY TotalSales DESC;

-- Assess the impact of promotions on sales
SELECT Promotion, SUM(SalesVolume) AS TotalSales
FROM ZaraSales
GROUP BY Promotion
ORDER BY TotalSales DESC;

-- Identify sales trends across different seasons
SELECT Seasonal, SUM(SalesVolume) AS TotalSales
FROM ZaraSales
GROUP BY Seasonal
ORDER BY TotalSales DESC;

-- Examine the relationship between price and sales volume
SELECT Price, AVG(SalesVolume) AS AvgSalesVolume
FROM ZaraSales
GROUP BY Price
ORDER BY Price;

-- Correlation between sales volume and price
SELECT 
    (SUM(SalesVolume * Price) - SUM(SalesVolume) * SUM(Price) / COUNT(*)) / 
    (SQRT(SUM(SalesVolume * SalesVolume) - SUM(SalesVolume) * SUM(SalesVolume) / COUNT(*)) * 
    SQRT(SUM(Price * Price) - SUM(Price) * SUM(Price) / COUNT(*))) AS Correlation
FROM ZaraSales;

-- Measure the effectiveness of different promotions
SELECT Promotion, AVG(SalesVolume) AS AvgSalesVolume
FROM ZaraSales
GROUP BY Promotion
ORDER BY AvgSalesVolume DESC;

-- Segment products based on sales patterns
SELECT ProductCategory, AVG(SalesVolume) AS AvgSalesVolume
FROM ZaraSales
GROUP BY ProductCategory
ORDER BY AvgSalesVolume DESC;

























    


