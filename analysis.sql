-- 1. Top 10 countries by revenue, orders, and average order value

SELECT
    Country,
    ROUND(SUM(Revenue), 2) AS TotalRevenue,
    COUNT(DISTINCT InvoiceNo) AS Orders,
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT InvoiceNo),
        2
    ) AS AOV
FROM transactions
GROUP BY Country
ORDER BY TotalRevenue DESC
LIMIT 10;


-- 2. Monthly revenue trend

SELECT
    SUBSTR(InvoiceDate, 1, 7) AS Month,
    ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM transactions
GROUP BY Month
ORDER BY Month;