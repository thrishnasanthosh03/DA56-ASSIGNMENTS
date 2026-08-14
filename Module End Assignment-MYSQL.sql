USE ecomm;

-- Data Cleaning

 set sql_safe_updates=0;

UPDATE customer_churn c
CROSS JOIN (
    SELECT 
        ROUND(AVG(WarehouseToHome)) AS avg_warehousetohome,
        ROUND(AVG(HourSpendOnApp)) AS avg_HourSpendOnApp,
        ROUND(AVG(OrderAmountHikeFromlastYear)) AS avg_OrderAmountHikeFromlastYear,
        ROUND(AVG(DaySinceLastOrder)) AS avg_DaySinceLastOrder
    FROM customer_churn
) avg_vals
SET 
    c.WarehouseToHome = IFNULL(c.WarehouseToHome, avg_vals.avg_warehousetohome),
    c.HourSpendOnApp = IFNULL(c.HourSpendOnApp, avg_vals.avg_HourSpendOnApp),
    c.OrderAmountHikeFromlastYear = IFNULL(c.OrderAmountHikeFromlastYear, avg_vals.avg_OrderAmountHikeFromlastYear),
    c.DaySinceLastOrder = IFNULL(c.DaySinceLastOrder, avg_vals.avg_DaySinceLastOrder);
    
   
    -- 1.
WITH ModeValues AS (
    SELECT 
        (SELECT Tenure FROM customer_churn WHERE Tenure IS NOT NULL GROUP BY Tenure ORDER BY COUNT(*) DESC LIMIT 1) AS mode_tenure,
        (SELECT CouponUsed FROM customer_churn WHERE CouponUsed IS NOT NULL GROUP BY CouponUsed ORDER BY COUNT(*) DESC LIMIT 1) AS mode_coupon,
        (SELECT OrderCount FROM customer_churn WHERE OrderCount IS NOT NULL GROUP BY OrderCount ORDER BY COUNT(*) DESC LIMIT 1) AS mode_order
)
-- 2. 
UPDATE customer_churn c
CROSS JOIN ModeValues m
SET 
    c.Tenure = IFNULL(c.Tenure, m.mode_tenure),
    c.CouponUsed = IFNULL(c.CouponUsed, m.mode_coupon),
    c.OrderCount = IFNULL(c.OrderCount, m.mode_order);
    
   DELETE FROM customer_churn 
WHERE WarehouseToHome > 100;
    
   -- Dealing with Inconsistencies
   
UPDATE customer_churn
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';

UPDATE customer_churn
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';

UPDATE customer_churn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';

UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';

-- Data Transformation

ALTER TABLE customer_churn
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;
ALTER TABLE customer_churn
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;

-- Creating New Columns

ALTER TABLE customer_churn
ADD COLUMN ComplaintReceived VARCHAR(5);
UPDATE customer_churn
SET ComplaintReceived = IF(Complain = 1, 'Yes', 'No');

ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(10);
UPDATE customer_churn
SET ChurnStatus = IF(Churn = 1, 'Churned', 'Active');

-- Column Dropping

ALTER TABLE customer_churn
DROP COLUMN Churn,
DROP COLUMN Complain;

-- Data Exploration and Analysis

SELECT 
    ChurnStatus, 
    COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY ChurnStatus;

 SELECT 
    AVG(Tenure) AS Average_Tenure,
    SUM(CashbackAmount) AS Total_Cashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';
    
    SELECT 
(COUNT(CASE WHEN ComplaintReceived = 'Yes' THEN 1 END) * 100.0 / COUNT(*)) AS Complained_Percentage
FROM customer_churn
WHERE ChurnStatus = 'Churned';

SELECT 
    CityTier, 
    COUNT(*) AS Churned_Customer_Count
FROM customer_churn
WHERE ChurnStatus = 'Churned' 
  AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churned_Customer_Count DESC
LIMIT 1;
    
  SELECT 
    PreferredPaymentMode, 
    COUNT(*) AS Customer_Count
FROM customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY Customer_Count DESC;  
    
    SELECT 
    SUM(OrderAmountHikeFromlastYear) AS Total_Order_Amount_Hike
FROM customer_churn
WHERE MaritalStatus = 'Single' 
  AND PreferredOrderCat = 'Mobile Phone';
    
SELECT AVG(NumberOfDeviceRegistered) AS Avg_Devices_Registered
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';

    SELECT 
    CityTier, 
    COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY CityTier
ORDER BY Total_Customers DESC;

SELECT 
    Gender, 
    SUM(CouponUsed) AS Total_Coupons_Used
FROM customer_churn
GROUP BY Gender
ORDER BY Total_Coupons_Used DESC;

SELECT 
    PreferredOrderCat, 
    COUNT(*) AS Total_Customers,
    MAX(HoursSpentOnApp) AS Max_Hours_Spent
FROM customer_churn
GROUP BY PreferredOrderCat;

SELECT 
    SUM(OrderCount) AS Total_Order_Count
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card' 
  AND SatisfactionScore = (SELECT MAX(SatisfactionScore) FROM customer_churn);


SELECT 
    AVG(SatisfactionScore) AS Avg_Satisfaction_Score
FROM customer_churn
WHERE ComplaintReceived = 'Yes';

SELECT PreferredOrderCat, COUNT(*) AS Total_Customers FROM customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY Total_Customers DESC;

SELECT PreferredOrderCat, AVG(CashbackAmount) AS Avg_Cashback_Amount
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Avg_Cashback_Amount DESC
LIMIT 3;

SELECT 
    PreferredPaymentMode,
    AVG(Tenure) AS Avg_Tenure,
    SUM(OrderCount) AS Total_Orders
FROM customer_churn
GROUP BY PreferredPaymentMode
HAVING AVG(Tenure) >= 10 
   AND SUM(OrderCount) > 500;
   
  SELECT 
    CASE 
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END AS Distance_Category,
    ChurnStatus,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY Distance_Category, ChurnStatus
ORDER BY Distance_Category, ChurnStatus;

SELECT *
FROM customer_churn
WHERE MaritalStatus = 'Married'
  AND CityTier = 1
  AND OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);

CREATE TABLE customer_returns (
    ReturnID INT PRIMARY KEY,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount INT
);

INSERT INTO customer_returns (ReturnID, CustomerID, ReturnDate, RefundAmount) 
VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);

SELECT *
FROM customer_returns
JOIN customer_churn USING (CustomerID)
WHERE ChurnStatus = 'Churned' 
  AND ComplaintReceived = 'Yes';




  