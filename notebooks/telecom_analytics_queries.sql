CREATE DATABASE Telecom_Analytics;
GO
USE Telecom_Analytics;
GO

SELECT COUNT(*) AS Total_rows
FROM Telecom_Final_Segmented;

SELECT TOP 10 *
FROM Telecom_Final_Segmented;

SELECT *
FROM Telecom_Final_Segmented;

--CHURN RATE BY SEGMENT--
SELECT 
	Segment_Label,
	COUNT(*) AS Total_Customers,
	SUM(CASE
			WHEN Customer_Status = 'Churned' THEN 1 
			ELSE 0 
		END) AS Churned_Customers,
ROUND(SUM(CASE 
				WHEN Customer_Status = 'Churned' THEN 1.0
				ELSE 0
		END) / COUNT(*) * 100, 2) AS Churn_Rate_Pct
FROM Telecom_Final_Segmented
GROUP BY Segment_Label
ORDER BY Churn_Rate_Pct DESC; 

--REVENUE AT RISK--
SELECT 
    Segment_Label,
    SUM(CASE 
			WHEN Customer_Status = 'Churned' THEN Total_Revenue 
			ELSE 0 
			END) AS Revenue_At_Risk,
    SUM(Total_Revenue) AS Total_Segment_Revenue,
    ROUND(SUM(CASE 
				WHEN Customer_Status = 'Churned' THEN Total_Revenue 
				ELSE 0 
				END) / SUM(Total_Revenue) * 100, 2) AS Pct_Revenue_At_Risk
FROM Telecom_Final_Segmented
GROUP BY Segment_Label
ORDER BY Revenue_At_Risk DESC;

--RETENTION KPIs--
SELECT 
    Segment_Label,
    AVG(CAST(Tenure_in_Months AS FLOAT)) AS Avg_Tenure,
    SUM(CASE 
			WHEN Contract = 'Month-to-Month' THEN 1			
			ELSE 0 
			END) AS Month_to_Month_Count,
    SUM(CASE 
			WHEN Contract != 'Month-to-Month' THEN 1 
			ELSE 0 
			END) AS Longer_Contract_Count
FROM Telecom_Final_Segmented
GROUP BY Segment_Label;