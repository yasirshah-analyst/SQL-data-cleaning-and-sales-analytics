# 📊 End-to-End SQL Data Pipeline: Data Creation, Cleaning & Sales Analytics
## 📌 Project Overview

This project demonstrates an **end-to-end data cleaning and analysis workflow using SQL (PostgreSQL)**.

A messy (dirty) dataset was generated to simulate real-world data issues. The data was then cleaned, transformed, and analyzed to extract meaningful business insights.

---

## 🎯 Objectives

* Generate a **dirty dataset** with real-world issues
* Perform **data cleaning and transformation using SQL**
* Handle:

  * Missing values
  * Inconsistent formats
  * Invalid data entries
  * Duplicate records
* Perform **exploratory data analysis (EDA)** using SQL

---

## 🛠 Tools & Technologies

* **SQL (PostgreSQL)**

---

## 📂 Project Structure

```id="proj1"
SQL-Data-Cleaning-Project/
│
├── dataset-creation/
│   └── dataset_creation.sql
│
├── Data-Cleaning/
│   └── data_cleaning.sql
│
├── Analysis/
│   └── analysis.sql
│
└── README.md
```

---

## 🔹 Step 1: Dataset Creation

* Created a **dirty sales dataset** using SQL
* Used `generate_series(1,200)` to generate 200 rows
* Introduced common real-world data issues:

  * Missing customer names (`NULL`)
  * Inconsistent city formats (`karachi`, `Karachi`, `LAHORE `)
  * Multiple date formats (`DD/MM/YYYY`, `YYYY-MM-DD`, `YYYY/MM/DD`)
  * Invalid values in quantity (`two`, empty string)
  * Invalid values in price (`abc`, negative values)
  * Duplicate records

- **Dirty dataset creation**

```sql
-- =========================================
-- STEP 1: Create a RAW (dirty) table
-- This table stores messy real-world data (all columns as TEXT)
-- =========================================
CREATE TABLE dirty_sales (
    order_id TEXT,
    customer_name TEXT,
    city TEXT,
    order_date TEXT,
    product TEXT,
    quantity TEXT,
    price TEXT
);

-- =========================================
-- STEP 2: Insert 200 rows of fake dirty data
-- generate_series creates numbers from 1 to 200
-- each number becomes one row
-- =========================================
INSERT INTO dirty_sales
SELECT 
    gs::TEXT AS order_id,  -- convert number to text

    -- every 5th row has missing customer name
    CASE 
        WHEN gs % 5 = 0 THEN NULL
        ELSE 'Customer_' || gs
    END AS customer_name,

    -- cities are messy (different case + spaces)
    CASE 
        WHEN gs % 4 = 0 THEN 'karachi'
        WHEN gs % 4 = 1 THEN 'Karachi'
        WHEN gs % 4 = 2 THEN 'LAHORE '
        ELSE 'Islamabad'
    END AS city,

    -- dates are in different formats + some NULL
    CASE 
        WHEN gs % 6 = 0 THEN '10/02/2024'
        WHEN gs % 6 = 1 THEN '2024-01-15'
        WHEN gs % 6 = 2 THEN '2024/03/10'
        WHEN gs % 6 = 3 THEN NULL
        ELSE '2024-02-20'
    END AS order_date,

    -- products are clean (Laptop, Mobile, Tablet)
    CASE 
        WHEN gs % 3 = 0 THEN 'Laptop'
        WHEN gs % 3 = 1 THEN 'Mobile'
        ELSE 'Tablet'
    END AS product,

    -- quantity is messy (numbers + text + empty)
    CASE 
        WHEN gs % 7 = 0 THEN 'two'
        WHEN gs % 7 = 1 THEN ''
        ELSE (gs % 5 + 1)::TEXT
    END AS quantity,

    -- price is messy (valid + text + negative)
    CASE 
        WHEN gs % 8 = 0 THEN '-5000'
        WHEN gs % 8 = 1 THEN 'abc'
        ELSE (gs * 1000)::TEXT
    END AS price

FROM generate_series(1, 200) AS gs;

-- =========================================
-- STEP 3: Create duplicates (real-world issue)
-- duplicate rows for order_id 10, 20, 30
-- =========================================
INSERT INTO dirty_sales
SELECT * 
FROM dirty_sales 
WHERE order_id IN ('10','20','30');

-- check dirty data
SELECT * FROM dirty_sales;

```
👉 View SQL Code:
📁 [Dataset Creation Script](dataset-creation/dataset_creation.sql)

---

## 🔹 Step 2: Data Cleaning

Performed data cleaning using SQL techniques:

* **Data Type Conversion**

  * TEXT → INT, DATE, NUMERIC using `CAST()` and `TO_DATE()`

* **Handling Missing Values**

  * Replaced NULLs using `COALESCE()`

* **Text Standardization**

  * Removed extra spaces using `TRIM()`
  * Standardized casing using `INITCAP()`

* **Date Standardization**

  * Converted multiple formats into a single DATE format

* **Data Validation**

  * Used regex (`~`) to filter valid numeric values

* **Error Handling**

  * Removed invalid and non-numeric values

* **Duplicate Removal**

  * Removed duplicate rows using `ctid` and `GROUP BY`

👉 View SQL Code:  
📁 [Data Cleaning Script](Data-Cleaning/data_cleaning.sql)

---

## 🔹 Step 3: Data Analysis (SQL EDA)

Performed exploratory data analysis using SQL queries:

### 📊 Key Metrics

* Total Orders
* Total Revenue
* Average Order Value

### 📦 Product Analysis

* Revenue by product
* Quantity sold per product

### 🌍 City Analysis

* Revenue by city
* Order distribution by city

### 📅 Time Analysis

* Monthly revenue trends

### 👤 Customer Insights

* Top 5 customers based on spending

👉 View SQL Code:  
📁 [Data Analysis Script](Analysis/analysis.sql)

---

## 📈 Key Insights

* Identified top-performing products by revenue
* Analyzed city-wise contribution to total sales
* Observed trends in order volume over time
* Detected and handled multiple data quality issues

---

## 🚀 Key Learnings

* Real-world datasets often contain **inconsistent and messy data**
* Data cleaning is a **critical step before analysis**
* SQL is powerful for both **data transformation and analysis**
* Proper handling of data types improves accuracy of insights

---

## 💡 Future Improvements

* Implement advanced validation for date fields
* Use window functions for deeper analysis
* Scale project with larger datasets
* Integrate with data visualization tools

---

## 📬 Contact

Feel free to connect or provide feedback on this project!
