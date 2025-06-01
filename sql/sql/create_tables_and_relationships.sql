-- Inventory Table
CREATE TABLE inventory_data (
  Item_ID VARCHAR(20),
  Item_Type VARCHAR(50),
  Item_Name VARCHAR(100),
  Current_Stock INT,
  Min_Required INT,
  Max_Capacity INT,
  Unit_Cost DECIMAL(10,2),
  Avg_Usage_Per_Day DECIMAL(10,2),
  Restock_Lead_Time INT,
  Vendor_ID VARCHAR(20),
  Date DATE
);

-- Vendor Table
CREATE TABLE vendor_data (
  Vendor_ID VARCHAR(20),
  Vendor_Name VARCHAR(100),
  Item_Supplied VARCHAR(100),
  Avg_Lead_Time INT,
  Cost_Per_Item DECIMAL(10,2),
  Last_Order_Date DATE,
  Next_Delivery_Date DATE
);

-- Financial Table
CREATE TABLE financial_data (
  Date DATE,
  Expense_Category VARCHAR(100),
  Amount DECIMAL(10,2),
  Description TEXT,
  Vendor_ID VARCHAR(20),
  Staff_ID VARCHAR(20)
);

-- Patient Table
CREATE TABLE patient_data (
  Patient_ID VARCHAR(20),
  Admission_Date DATE,
  Discharge_Date DATE,
  Primary_Diagnosis VARCHAR(100),
  Procedure_Performed VARCHAR(100),
  Room_Type VARCHAR(50),
  Bed_Days INT,
  Supplies_Used TEXT,
  Equipment_Used TEXT,
  Staff_Needed VARCHAR(20)
);

-- Staff Table
CREATE TABLE staff_data (
  Staff_ID VARCHAR(20),
  Staff_Type VARCHAR(50),
  Shift_Date DATE,
  Shift_Start_Time TIME,
  Shift_End_Time TIME,
  Current_Assignment VARCHAR(100),
  Hours_Worked DECIMAL(5,2),
  Patients_Assigned INT,
  Overtime_Hours DECIMAL(5,2)
);
