# 📊 End-to-End SQL Data Cleaning & Sales Analytics Project

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
├── 1_dataset_creation/
│   └── dataset_creation.sql
│
├── 2_data_cleaning/
│   └── data_cleaning.sql
│
├── 3_analysis/
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
