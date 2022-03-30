-- Q1-1
SELECT W_JOB_F.Location_ID,Location_Name,W_SALES_CLASS_D.Sales_class_id,Sales_Class_Desc,Time_Year,Time_Month,Base_price,
	SUM(Quantity_Ordered) AS SUMQTY,SUM(Quantity_Ordered*Unit_Price) AS Job_Amount
FROM W_JOB_F
INNER JOIN W_LOCATION_D ON W_JOB_F.Location_ID = W_LOCATION_D.Location_ID
INNER JOIN W_SALES_CLASS_D ON W_JOB_F.Sales_class_id = W_SALES_CLASS_D.Sales_class_id
INNER JOIN W_TIME_D ON W_TIME_D.Time_id = W_JOB_F.Contract_date
GROUP BY W_JOB_F.Location_ID,Location_Name,W_SALES_CLASS_D.Sales_class_id,Sales_Class_Desc,Time_Year,Time_Month,Base_price
ORDER BY Location_id, sales_class_id, time_month;

-- Q1-2
SELECT W_JOB_F.JOB_ID,W_JOB_F.Location_ID,W_Location_D.Location_Name,Unit_Price,Quantity_Ordered,Time_Year,Time_Month,
	SUM(Invoice_Amount) AS SUMINVAMT,SUM(Invoice_Quantity) AS SUMINVQTY
FROM W_JOB_F
INNER JOIN W_LOCATION_D ON W_JOB_F.Location_ID = W_LOCATION_D.Location_ID
INNER JOIN W_TIME_D ON W_TIME_D.Time_id = W_JOB_F.Contract_date 
INNER JOIN W_SUB_JOB_F ON W_JOB_F.Job_Id = W_SUB_JOB_F.Job_Id
INNER JOIN W_JOB_SHIPMENT_F ON W_JOB_SHIPMENT_F.Sub_Job_Id = W_Sub_Job_F.Sub_Job_Id
INNER JOIN W_INVOICELINE_F ON W_Job_Shipment_F.Invoice_Id = W_InvoiceLine_F.Invoice_Id
GROUP BY W_JOB_F.JOB_ID,W_JOB_F.Location_ID,W_Location_D.Location_Name,Unit_Price,Quantity_Ordered,Time_Year,Time_Month;

CREATE VIEW BQ2 AS
SELECT W_JOB_F.JOB_ID,W_JOB_F.Location_ID,W_Location_D.Location_Name,Unit_Price,Quantity_Ordered,Time_Year,Time_Month,
	SUM(Invoice_Amount) AS SUMINVAMT,SUM(Invoice_Quantity) AS SUMINVQTY
FROM W_JOB_F
INNER JOIN W_LOCATION_D ON W_JOB_F.Location_ID = W_LOCATION_D.Location_ID
INNER JOIN W_TIME_D ON W_TIME_D.Time_id = W_JOB_F.Contract_date 
INNER JOIN W_SUB_JOB_F ON W_JOB_F.Job_Id = W_SUB_JOB_F.Job_Id
INNER JOIN W_JOB_SHIPMENT_F ON W_JOB_SHIPMENT_F.Sub_Job_Id = W_Sub_Job_F.Sub_Job_Id
INNER JOIN W_INVOICELINE_F ON W_Job_Shipment_F.Invoice_Id = W_InvoiceLine_F.Invoice_Id
GROUP BY W_JOB_F.JOB_ID,W_JOB_F.Location_ID,W_Location_D.Location_Name,Unit_Price,Quantity_Ordered,Time_Year,Time_Month;

-- Q1-3
SELECT JOB_ID,Location_ID,Location_Name,Time_Year,Time_Month,SUMLABOUR, SUMMATERIAL, SUMOVERHEAD,SUMMACHINE,SUMQTY,TOTALCOST,TOTALCOST/SUMQTY AS UNIT_PRICE
FROM (
	SELECT W_SUB_JOB_F.JOB_ID,W_SUB_JOB_F.Location_ID,Location_Name,Time_Year,Time_Month,
		SUM(Cost_Labor) AS SUMLABOUR,SUM(Cost_Material) AS SUMMATERIAL,SUM(Cost_Overhead) AS SUMOVERHEAD,
		SUM(Machine_Hours*Rate_per_hour) AS SUMMACHINE,SUM(Quantity_produced) AS SUMQTY,
		SUM(Cost_Labor+Cost_Material+Cost_Overhead+Machine_Hours*Rate_per_hour) AS TOTALCOST
	FROM W_SUB_JOB_F
	INNER JOIN W_JOB_F ON W_SUB_JOB_F.Job_id = W_JOB_F.Job_id
	INNER JOIN W_TIME_D ON W_Time_D.Time_id = W_Job_F.Contract_Date
	INNER JOIN W_LOCATION_D ON W_location_d.location_id = W_SUB_JOB_F.Location_id
	INNER JOIN W_MACHINE_TYPE_D ON W_SUB_JOB_F.Machine_Type_id = W_Machine_Type_D.Machine_Type_ID
	GROUP BY W_SUB_JOB_F.JOB_ID,W_SUB_JOB_F.Location_ID,Location_Name,Time_Year,Time_Month
) main;

CREATE VIEW BQ3 AS
SELECT JOB_ID,Location_ID,Location_Name,Time_Year,Time_Month,SUMLABOUR, SUMMATERIAL, SUMOVERHEAD,SUMMACHINE,SUMQTY,TOTALCOST,TOTALCOST/SUMQTY AS UNIT_PRICE
FROM (
	SELECT W_SUB_JOB_F.JOB_ID,W_SUB_JOB_F.Location_ID,Location_Name,Time_Year,Time_Month,
		SUM(Cost_Labor) AS SUMLABOUR,SUM(Cost_Material) AS SUMMATERIAL,SUM(Cost_Overhead) AS SUMOVERHEAD,
		SUM(Machine_Hours*Rate_per_hour) AS SUMMACHINE,SUM(Quantity_produced) AS SUMQTY,
		SUM(Cost_Labor+Cost_Material+Cost_Overhead+Machine_Hours*Rate_per_hour) AS TOTALCOST
	FROM W_SUB_JOB_F
	INNER JOIN W_JOB_F ON W_SUB_JOB_F.Job_id = W_JOB_F.Job_id
	INNER JOIN W_TIME_D ON W_Time_D.Time_id = W_Job_F.Contract_Date
	INNER JOIN W_LOCATION_D ON W_location_d.location_id = W_SUB_JOB_F.Location_id
	INNER JOIN W_MACHINE_TYPE_D ON W_SUB_JOB_F.Machine_Type_id = W_Machine_Type_D.Machine_Type_ID
	GROUP BY W_SUB_JOB_F.JOB_ID,W_SUB_JOB_F.Location_ID,Location_Name,Time_Year,Time_Month
) main;

-- Q1-4
SELECT W_InvoiceLine_F.Location_Id, Location_Name,W_InvoiceLine_F.Sales_Class_Id, Sales_Class_Desc,Time_Year, Time_Month,
	SUM (Quantity_shipped - Invoice_Quantity ) as QTYRETURNED,
	SUM ((Quantity_shipped - Invoice_quantity) * (Invoice_amount/Invoice_quantity)) AS SUMAMTRETURNED
FROM W_INVOICELINE_F
INNER JOIN W_Location_D ON W_INVOICELINE_F.Location_Id = W_Location_D.Location_Id
INNER JOIN W_Sales_Class_D ON W_INVOICELINE_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
INNER JOIN W_TIME_D ON W_INVOICELINE_F.INVOICE_SENT_DATE = W_TIME_D.TIME_ID
WHERE quantity_shipped - invoice_quantity > 0 
GROUP BY W_InvoiceLine_F.Location_Id, Location_Name,W_InvoiceLine_F.Sales_Class_Id, Sales_Class_Desc,Time_Year, Time_Month;

-- Q1-5
SELECT Job_id,Location_ID,Location_Name,Sales_class_id,sales_class_desc,Date_Promised,Quantity_Ordered,LastShipDate,SUMSHIPQTY,
	getBusDaysDiff(LastShipDate,Date_Promised) AS DaysDiff
FROM (
	SELECT W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Promised,Quantity_Ordered,
		MAX(Actual_Ship_Date) AS LastShipDate,SUM(Actual_Quantity) AS SUMSHIPQTY
	FROM W_JOB_F
	INNER JOIN W_LOCATION_D ON W_JOB_F.Location_id =  W_LOCATION_D.Location_id
	INNER JOIN W_SALES_CLASS_D ON W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
	INNER JOIN W_SUB_JOB_F ON W_Job_F.Job_Id = W_SUB_JOB_F.JOB_ID
	INNER JOIN W_JOB_SHIPMENT_F ON W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID
	WHERE Actual_Ship_Date > Date_Promised
	GROUP BY W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Promised,Quantity_Ordered
) main
WHERE LastShipDate > Date_Promised;

CREATE VIEW BQ5 AS
SELECT Job_id,Location_ID,Location_Name,Sales_class_id,sales_class_desc,Date_Promised,Quantity_Ordered,LastShipDate,SUMSHIPQTY,
	getBusDaysDiff(LastShipDate,Date_Promised) AS DaysDiff
FROM (
	SELECT W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Promised,Quantity_Ordered,
		MAX(Actual_Ship_Date) AS LastShipDate,SUM(Actual_Quantity) AS SUMSHIPQTY
	FROM W_JOB_F
	INNER JOIN W_LOCATION_D ON W_JOB_F.Location_id =  W_LOCATION_D.Location_id
	INNER JOIN W_SALES_CLASS_D ON W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
	INNER JOIN W_SUB_JOB_F ON W_Job_F.Job_Id = W_SUB_JOB_F.JOB_ID
	INNER JOIN W_JOB_SHIPMENT_F ON W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID
	WHERE Actual_Ship_Date > Date_Promised
	GROUP BY W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Promised,Quantity_Ordered
) main
WHERE LastShipDate > Date_Promised;

-- Q1-6
SELECT Job_id,Location_ID,Location_Name,Sales_class_id,sales_class_desc,Date_Ship_By,FirstShipDate,getBusDaysDiff(FirstShipDate,Date_Ship_By) AS DaysDiff
FROM (
	SELECT W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Ship_By,MIN(Actual_Ship_Date) AS FirstShipDate
	FROM W_JOB_F
	INNER JOIN W_LOCATION_D ON W_JOB_F.Location_id =  W_LOCATION_D.Location_id
	INNER JOIN W_SALES_CLASS_D ON W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
	INNER JOIN W_SUB_JOB_F ON W_Job_F.Job_Id = W_SUB_JOB_F.JOB_ID
	INNER JOIN W_JOB_SHIPMENT_F ON W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID 
	GROUP BY W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Ship_By
) main
WHERE FirstShipDate > Date_Ship_By;


CREATE VIEW BQ6 AS
SELECT Job_id,Location_ID,Location_Name,Sales_class_id,sales_class_desc,Date_Ship_By,FirstShipDate,getBusDaysDiff(FirstShipDate,Date_Ship_By) AS DaysDiff
FROM (
	SELECT W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Ship_By,MIN(Actual_Ship_Date) AS FirstShipDate
	FROM W_JOB_F
	INNER JOIN W_LOCATION_D ON W_JOB_F.Location_id =  W_LOCATION_D.Location_id
	INNER JOIN W_SALES_CLASS_D ON W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
	INNER JOIN W_SUB_JOB_F ON W_Job_F.Job_Id = W_SUB_JOB_F.JOB_ID
	INNER JOIN W_JOB_SHIPMENT_F ON W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID 
	GROUP BY W_JOB_F.Job_id,W_JOB_F.Location_ID,Location_Name,W_JOB_F.Sales_class_id,sales_class_desc,Date_Ship_By
) main
WHERE FirstShipDate > Date_Ship_By;









