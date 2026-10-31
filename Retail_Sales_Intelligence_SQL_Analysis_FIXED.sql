/*=====================================================================
 RETAIL SALES INTELLIGENCE PLATFORM — BUSINESS ANALYSIS
 Database: projectdata | SQL dialect: MySQL 8+
 Purpose: validate core KPIs and answer the project's main business questions.
 IMPORTANT: Run against the same raw Global Superstore file used by Python.
 The Order Date expressions below assume strings formatted as dd-mm-yyyy,
 matching the existing notebook and earlier SQL screenshots. If the target
 column is a native DATE/DATETIME, replace STR_TO_DATE(`Order Date`, ...) with
 `Order Date` directly.
=====================================================================*/

USE projectdata;

/* 0. TABLE-NAME CHECK
   The user's original SELECT used a leading space inside the table name:
   ` global_superstore`. Confirm this exact name appears in SHOW TABLES.
   If the result instead shows `global_superstore` without the leading space,
   replace every ` global_superstore` reference below with `global_superstore`.
*/
SHOW TABLES FROM projectdata;

SELECT *
FROM projectdata.` global_superstore`
LIMIT 20;

/* 1. BASELINE KPI RECONCILIATION — compare with Python output */
SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders,
    COUNT(DISTINCT `Customer ID`) AS Distinct_Customers,
    COUNT(DISTINCT `Product ID`) AS Distinct_Products,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct,
    ROUND(SUM(Sales) / NULLIF(COUNT(DISTINCT `Order ID`), 0), 2) AS Average_Order_Value,
    MIN(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS First_Order_Date,
    MAX(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS Last_Order_Date
FROM ` global_superstore`;

/* 2. DATA QUALITY: missing-value counts for key fields */
SELECT
    SUM(`Order ID` IS NULL OR TRIM(`Order ID`) = '') AS Missing_Order_ID,
    SUM(`Customer ID` IS NULL OR TRIM(`Customer ID`) = '') AS Missing_Customer_ID,
    SUM(`Product ID` IS NULL OR TRIM(`Product ID`) = '') AS Missing_Product_ID,
    SUM(`Order Date` IS NULL OR TRIM(CAST(`Order Date` AS CHAR)) = '') AS Missing_Order_Date,
    SUM(Sales IS NULL) AS Missing_Sales,
    SUM(Profit IS NULL) AS Missing_Profit,
    SUM(`Postal Code` IS NULL) AS Missing_Postal_Code
FROM ` global_superstore`;

/* 3. SALES AND PROFIT BY CATEGORY */
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders
FROM ` global_superstore`
GROUP BY Category
ORDER BY Total_Sales DESC;

/* 4. SALES AND PROFIT BY SUB-CATEGORY */
SELECT
    `Sub-Category` AS Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders
FROM ` global_superstore`
GROUP BY `Sub-Category`
ORDER BY Total_Profit ASC;

/* 5. REGIONAL PERFORMANCE */
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders
FROM ` global_superstore`
GROUP BY Region
ORDER BY Total_Profit DESC;

/* 6. MARKET PERFORMANCE */
SELECT
    Market,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders
FROM ` global_superstore`
GROUP BY Market
ORDER BY Total_Sales DESC;

/* 7. CUSTOMER SEGMENT PERFORMANCE — distinct orders, not order lines */
SELECT
    Segment,
    COUNT(DISTINCT `Customer ID`) AS Distinct_Customers,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct
FROM ` global_superstore`
GROUP BY Segment
ORDER BY Total_Profit DESC;

/* 8. TOP 10 CUSTOMERS BY SALES */
SELECT
    `Customer ID`,
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM ` global_superstore`
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

/* 9. TOP 10 CUSTOMERS BY PROFIT */
SELECT
    `Customer ID`,
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM ` global_superstore`
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Profit DESC
LIMIT 10;

/* 10. TOP 10 PRODUCTS BY SALES */
SELECT
    `Product ID`,
    `Product Name`,
    SUM(Quantity) AS Units_Sold,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM ` global_superstore`
GROUP BY `Product ID`, `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

/* 11. TOP 10 PRODUCTS BY PROFIT */
SELECT
    `Product ID`,
    `Product Name`,
    SUM(Quantity) AS Units_Sold,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM ` global_superstore`
GROUP BY `Product ID`, `Product Name`
ORDER BY Total_Profit DESC
LIMIT 10;

/* 12. TOP 10 LOSS-MAKING PRODUCTS (aggregated product-name profit) */
SELECT
    `Product ID`,
    `Product Name`,
    SUM(Quantity) AS Units_Sold,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM ` global_superstore`
GROUP BY `Product ID`, `Product Name`
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC
LIMIT 10;

/* 13. YEAR-WISE SALES AND PROFIT */
SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS Order_Year,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders
FROM ` global_superstore`
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y'))
ORDER BY Order_Year;

/* 14. CHRONOLOGICAL MONTHLY SALES AND PROFIT — year and month stay distinct */
SELECT
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%d-%m-%Y'), '%Y-%m') AS Order_Year_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders
FROM ` global_superstore`
GROUP BY DATE_FORMAT(STR_TO_DATE(`Order Date`, '%d-%m-%Y'), '%Y-%m')
ORDER BY Order_Year_Month;

/* 15. CALENDAR-MONTH SEASONALITY — all years combined, deliberately */
SELECT
    MONTH(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS Month_Number,
    MONTHNAME(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS Calendar_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales_All_Years,
    ROUND(SUM(Profit), 2) AS Total_Profit_All_Years,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders_All_Years
FROM ` global_superstore`
GROUP BY MONTH(STR_TO_DATE(`Order Date`, '%d-%m-%Y')),
         MONTHNAME(STR_TO_DATE(`Order Date`, '%d-%m-%Y'))
ORDER BY Month_Number;

/* 16. QUARTERLY PERFORMANCE */
SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS Order_Year,
    QUARTER(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS Order_Quarter,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders
FROM ` global_superstore`
GROUP BY YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y')),
         QUARTER(STR_TO_DATE(`Order Date`, '%d-%m-%Y'))
ORDER BY Order_Year, Order_Quarter;

/* 17. DISCOUNT-LEVEL PERFORMANCE — descriptive association, not causation */
SELECT
    ROUND(Discount, 2) AS Discount_Level,
    COUNT(*) AS Transaction_Lines,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct
FROM ` global_superstore`
GROUP BY ROUND(Discount, 2)
ORDER BY Discount_Level;

/* 18. SHIPPING MODE PERFORMANCE */
SELECT
    `Ship Mode` AS Ship_Mode,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(`Shipping Cost`), 2) AS Total_Shipping_Cost,
    ROUND(AVG(`Shipping Cost`), 2) AS Average_Shipping_Cost,
    ROUND(AVG(DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%d-%m-%Y'),
        STR_TO_DATE(`Order Date`, '%d-%m-%Y')
    )), 2) AS Average_Ship_Days
FROM ` global_superstore`
GROUP BY `Ship Mode`
ORDER BY Total_Profit DESC;

/* 19. LOSS-MAKING TRANSACTION LINES BY DISCOUNT LEVEL */
SELECT
    ROUND(Discount, 2) AS Discount_Level,
    COUNT(*) AS Loss_Making_Lines,
    COUNT(DISTINCT `Order ID`) AS Orders_With_Loss_Lines,
    ROUND(SUM(Sales), 2) AS Sales_On_Loss_Lines,
    ROUND(SUM(Profit), 2) AS Total_Negative_Profit
FROM ` global_superstore`
WHERE Profit < 0
GROUP BY ROUND(Discount, 2)
ORDER BY Total_Negative_Profit ASC;

/* 20. PROFIT DISTRIBUTION BY ORDER PRIORITY */
SELECT
    `Order Priority`,
    COUNT(DISTINCT `Order ID`) AS Distinct_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin_Pct
FROM ` global_superstore`
GROUP BY `Order Priority`
ORDER BY Total_Profit DESC;
