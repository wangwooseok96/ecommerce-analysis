SELECT
    SUBSTR(InvoiceDate, 1, 7) AS Month,
    ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM transactions
GROUP BY Month
ORDER BY Month;