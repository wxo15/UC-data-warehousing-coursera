-- Q2-1
SELECT Location_Name,Time_Year,Time_Month,
	SUM(Quantity_Ordered*Unit_Price) AS AMT,
	SUM(SUM(Quantity_Ordered*Unit_Price)) OVER (Partition by Location_Name,Time_Year Order By Time_Month ROWS UNBOUNDED PRECEDING) AS CUMSUMAMT
FROM W_JOB_F
INNER JOIN W_LOCATION_D ON W_JOB_F.Location_ID = W_LOCATION_D.Location_ID
INNER JOIN W_TIME_D ON W_TIME_D.Time_id = W_JOB_F.Contract_date
GROUP BY Location_Name,Time_Year,Time_Month;

-- Q2-2
SELECT Location_Name,Time_Year,Time_Month,
	AVG(Quantity_Ordered*Unit_Price) AS AVGAMT,
	AVG(AVG(Quantity_Ordered*Unit_Price)) OVER (Partition by Location_Name Order By Time_Year,Time_Month ROWS 11 PRECEDING) AS AVGSUMAMT
FROM W_JOB_F
INNER JOIN W_LOCATION_D ON W_JOB_F.Location_ID = W_LOCATION_D.Location_ID
INNER JOIN W_TIME_D ON W_TIME_D.Time_id = W_JOB_F.Contract_date
GROUP BY Location_Name,Time_Year,Time_Month;

-- Q2-3
Select BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month,
	SUM(SUMINVAMT - TOTALCOST) AS Profit,
	RANK() OVER(Partition By BQ2.Time_Year Order by SUM(SUMINVAMT - TOTALCOST) DESC) AS Rank
FROM BQ2
INNER JOIN BQ3 ON BQ2.Job_id = BQ3.Job_id
GROUP BY BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month;

-- Q2-4
SELECT BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month,
	SUM(SUMINVAMT - TOTALCOST)/SUM(SUMINVAMT) AS ProfitMargin,
	RANK() OVER(Partition By BQ2.Time_Year Order by SUM(SUMINVAMT - TOTALCOST)/SUM(SUMINVAMT) DESC) AS Rank
FROM BQ2
INNER JOIN BQ3 ON BQ2.Job_id = BQ3.Job_id
GROUP BY BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month;


-- Q2-5
SELECT BQ2.Job_Id,BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month,
	SUM(SUMINVAMT - TOTALCOST)/SUM(SUMINVAMT) AS ProfitMargin,
	PERCENT_RANK() OVER(Order by SUM(SUMINVAMT - TOTALCOST)/SUM(SUMINVAMT) DESC) AS PercentRank
FROM BQ2
INNER JOIN BQ3 ON BQ2.Job_id = BQ3.Job_id
GROUP BY BQ2.Job_Id,BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month;

-- Q2-6
SELECT *
FROM(
	SELECT BQ2.Job_Id,BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month,
		SUM(SUMINVAMT - TOTALCOST)/SUM(SUMINVAMT) AS ProfitMargin,
		PERCENT_RANK() OVER(Order by SUM(SUMINVAMT - TOTALCOST)/SUM(SUMINVAMT) DESC) AS PercentRank
	FROM BQ2
	INNER JOIN BQ3 ON BQ2.Job_id = BQ3.Job_id
	GROUP BY BQ2.Job_Id,BQ2.Location_Name,BQ2.Time_Year,BQ2.Time_Month
) main
WHERE PercentRank < 0.05;

-- Q2-7
SELECT  Sales_Class_Desc,Time_Year,
	SUM(Quantity_shipped - Invoice_Quantity) as QTYRETURNED,
	RANK() OVER(Partition By Time_Year Order By SUM ( Quantity_shipped - Invoice_Quantity ) DESC) AS Rank
FROM W_INVOICELINE_F
INNER JOIN W_Sales_Class_D ON W_INVOICELINE_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
INNER JOIN W_TIME_D ON W_INVOICELINE_F.INVOICE_SENT_DATE = W_TIME_D.TIME_ID 
WHERE quantity_shipped - invoice_quantity > 0
GROUP BY Sales_Class_Desc,Time_Year;

-- Q2-8
SELECT  Sales_Class_Desc,Time_Year,
	SUM ( Quantity_shipped - Invoice_Quantity ) as QTYRETURNED,
	SUM ( Quantity_shipped - Invoice_Quantity )/SUM(SUM ( Quantity_shipped - Invoice_Quantity ))OVER(Partition By Time_Year)  AS Ratio
FROM W_INVOICELINE_F
INNER JOIN W_Sales_Class_D ON W_INVOICELINE_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
INNER JOIN W_TIME_D ON W_INVOICELINE_F.INVOICE_SENT_DATE = W_TIME_D.TIME_ID 
WHERE quantity_shipped - invoice_quantity > 0
GROUP BY Sales_Class_Desc,Time_Year
ORDER BY Time_Year,QTYRETURNED;

-- Q2-9
SELECT Location_Name,W_Time_D.Time_Year,
	SUM(DAYSDIFF) AS SUMDAYSDIFF,
	RANK() OVER(Partition By W_Time_D.Time_Year Order By SUM(DAYSDIFF) DESC) AS Rank,
	DENSE_RANK() OVER(Partition By W_Time_D.Time_Year Order By SUM(DAYSDIFF) DESC) AS DenseRank
FROM BQ6
INNER JOIN W_Time_D ON W_Time_D.Time_Id = BQ6.Date_Ship_By
GROUP BY Location_Name,W_Time_D.Time_Year;

-- Q2-10
SELECT Location_Name,W_Time_D.Time_Year,
	SUM(DAYSDIFF) AS SUMDAYSDIFF,Count(*) AS NoofJobs,
	SUM(Quantity_Ordered - SumShipQty) / SUM(Quantity_Ordered) AS Delay_Rate,
	RANK() OVER(Partition By W_Time_D.Time_Year Order By SUM(Quantity_Ordered - SumShipQty) / SUM(Quantity_Ordered) DESC) AS Rank
FROM BQ5
INNER JOIN W_Time_D ON W_Time_D.Time_Id = BQ5.Date_Promised
GROUP BY Location_Name,W_Time_D.Time_Year;







