-- ===========================================
-- 📦 Hospital Supply Chain SQL Data Model Views
-- Author: Anusha Komati
-- Purpose: Create key business views for Tableau Dashboard
-- ===========================================

-- View 1: Inventory + Vendor Details
CREATE OR REPLACE VIEW vw_inventory_vendor AS
SELECT 
  i.Item_ID,
  i.Item_Name,
  i.Item_Type,
  i.Current_Stock,
  i.Min_Required,
  i.Max_Capacity,
  i.Unit_Cost,
  i.Avg_Usage_Per_Day,
  i.Restock_Lead_Time,
  i.Date AS Inventory_Date,
  v.Vendor_ID,
  v.Vendor_Name,
  v.`Avg_Lead_Time (days)`,
  v.Cost_Per_Item,
  v.Last_Order_Date,
  v.Next_Delivery_Date
FROM 
  inventory_data i
LEFT JOIN 
  vendor_data v ON i.Vendor_ID = v.Vendor_ID;

-- View 2: Inventory Restock Risk Classification
CREATE OR REPLACE VIEW vw_inventory_risk AS
SELECT 
  i.Item_ID,
  i.Item_Name,
  i.Item_Type,
  i.Current_Stock,
  i.Min_Required,
  i.Unit_Cost,
  i.Restock_Lead_Time,
  v.Vendor_Name,
  v.`Avg_Lead_Time (days)`,
  v.Next_Delivery_Date,
  CASE 
    WHEN i.Current_Stock < i.Min_Required AND v.`Avg_Lead_Time (days)` > 5 THEN 'High Risk'
    WHEN i.Current_Stock < i.Min_Required THEN 'Medium Risk'
    ELSE 'Safe'
  END AS Restock_Risk_Level
FROM 
  inventory_data i
LEFT JOIN 
  vendor_data v ON i.Vendor_ID = v.Vendor_ID;

-- View 3: Patient with Assigned Staff
CREATE OR REPLACE VIEW vw_patient_staff AS
SELECT 
  p.Patient_ID,
  p.Admission_Date,
  p.Discharge_Date,
  p.Primary_Diagnosis,
  p.Procedure_Performed,
  p.Room_Type,
  p.Bed_Days,
  p.Supplies_Used,
  p.Equipment_Used,
  s.Staff_ID,
  s.Staff_Type,
  s.Shift_Date,
  s.Hours_Worked,
  s.Patients_Assigned,
  s.Overtime_Hours
FROM 
  patient_data p
LEFT JOIN 
  staff_data s ON p.Staff_Needed = s.Staff_ID;

-- View 4: Financial Summary by Vendor
CREATE OR REPLACE VIEW vw_financial_summary AS
SELECT 
  f.Date,
  f.Expense_Category,
  f.Amount,
  f.Description,
  v.Vendor_Name,
  f.Staff_ID
FROM 
  financial_data f
LEFT JOIN 
  vendor_data v ON f.Vendor_ID = v.Vendor_ID;

-- View 5: Staff Summary and Workload Classification
CREATE OR REPLACE VIEW vw_staff_summary AS
SELECT 
  Staff_ID,
  Staff_Type,
  Shift_Date,
  Hours_Worked,
  Patients_Assigned,
  Overtime_Hours,
  CASE 
    WHEN Overtime_Hours > 2 THEN 'Overloaded'
    WHEN Patients_Assigned >= 5 THEN 'High Load'
    ELSE 'Normal'
  END AS Workload_Status
FROM 
  staff_data;
