# medsurg-supplychain-dashboard
A healthcare Med/Surgical Supply Chain Dashboard built in Tableau using SQL and CSV data sources
# 🏥 Hospital Supply Chain Dashboard (Med/Surgical)

A real-world business intelligence project that showcases how to design a hospital supply chain analytics solution using SQL and Tableau. The goal is to uncover inefficiencies, track resource usage, and deliver actionable KPIs to medical and operations leadership.

---

## 📊 Project Objective

To build a Med/Surgical supply chain dashboard that helps hospitals track inventory, finances, vendor performance, patient resource usage, and staff workload — enabling data-driven decisions for better healthcare delivery.

---

## 🔧 Tools Used

- **MySQL** – Data modeling, SQL views, joins
- **Tableau Public** – Data visualization and KPI dashboards
- **GitHub** – Project version control and documentation
- **Excel** – Source data (CSV format) preparation

---

## 🗂️ Data Sources

All data is mock data sourced from Kaggle and includes:

- `inventory_data.csv`
- `vendor_data.csv`
- `financial_data.csv`
- `patient_data.csv`
- `staff_data.csv`

---

## 🧱 SQL Data Model & Relationships

Tables are connected based on relevant keys:

- `inventory_data` ↔ `vendor_data` via `Vendor_ID`
- `financial_data` ↔ [optional future joins with vendor/staff]
- `patient_data` ↔ `staff_data` via `Staff_Needed = Staff_Type`  
  (with normalization logic applied)
- Staff workload metrics derived directly from `staff_data`

ERD is created using logical joins and optimized for BI consumption.

---

## 🧠 SQL Views

To simplify dashboarding, 5 SQL views were created:

| View Name             | Purpose |
|-----------------------|---------|
| `vw_inventory_vendor` | Combines inventory and vendor data |
| `vw_inventory_risk`   | Flags inventory below minimum stock levels |
| `vw_patient_staff`    | Maps patient needs to staff type using normalized join |
| `vw_financial_summary`| Tracks all financial expenses by category and date |
| `vw_staff_summary`    | Categorizes staff workload and overtime status |

### 🔍 Example: Staff Role Normalization

```sql
ON LOWER(TRIM(SUBSTRING_INDEX(p.Staff_Needed, ' ', -1))) = LOWER(TRIM(s.Staff_Type))
