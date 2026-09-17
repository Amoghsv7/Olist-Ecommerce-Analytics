# Olist E-commerce Customer & Sales Analytics

End-to-end data analytics project using **MySQL, SQL, Power BI and DAX** to analyze customer behavior, sales, payments, delivery performance and customer satisfaction.

## Workflow

**Raw CSV data → MySQL → Data quality checks → SQL analysis → Power BI data model → DAX → Interactive dashboard → Business insights**

## Business Questions

- How are sales and order volume changing over time?
- Which product categories and products generate the most sales?
- Which payment methods are most commonly used?
- What is the order-status distribution?
- How large is the repeat-customer segment?
- Which states contribute the most customers and revenue?
- Which sellers generate the highest sales?
- How long does delivery typically take?
- How does late delivery affect review scores?
- What data-quality issues should be considered before reporting?

## Tools

- **MySQL 8** — database creation, loading and validation
- **SQL** — joins, aggregations, CTEs, CASE, date analysis and data-quality checks
- **Power BI** — modeling, visualization and interactive reporting
- **DAX** — measures, filter context, time intelligence and customer analysis

## Dataset

Public Olist Brazilian E-Commerce dataset.

Final working row counts:

| Table | Rows |
|---|---:|
| Customers | 99,441 |
| Orders | 99,441 |
| Order Items | 112,650 |
| Order Payments | 103,886 |
| Order Reviews | 99,223 |
| Products | 32,951 |
| Sellers | 3,095 |
| Geolocation | 1,000,163 |
| Category Translation | 71 |

## Power BI Dashboard
The Power BI report contains four analytical pages covering executive performance, customer geography, product and sales analysis, and delivery/customer satisfaction.

### 1. Executive Overview
KPI cards, revenue trend, payment performance and order-status overview.

### 2. Customer Analysis
One-time vs repeat customers, customer geography and order lookup with drill-through.

### 3. Product & Sales Analysis
Category/product performance and seller/sales analysis.

### 4. Delivery & Customer Satisfaction
Delivery performance, late vs on-time orders and review-score analysis.

The report uses a dedicated Date table, relationships, DAX measures, synchronized Year filtering and drill-through.

## Key Insights

### Customer retention
The dataset is dominated by one-time customers, with a much smaller repeat-customer segment, highlighting customer retention as an important opportunity.

### Delivery affects satisfaction
Average review score was **2.57 for late deliveries** versus **4.21 for on-time deliveries**, showing a strong business case for improving delivery reliability.

### Order-status concentration
Delivered orders represent the overwhelming majority of the order base, while other statuses form much smaller segments.

### Data quality
The analysis identified **610 products with missing/blank categories** and **1 delivered order without a corresponding payment record**.

## SQL Scripts

The SQL analysis is organized into separate scripts covering database setup, data loading, validation, referential integrity and business analysis.

- **01 — Create Tables** — Database and table creation
- **02 — Data Import** — Loading the Olist CSV datasets
- **03 — Data Quality Checks** — Missing values, duplicates and validation checks
- **04 — Referential Integrity** — Relationship and key validation
- **05 — Business Analysis** — Customer, sales, product, payment, delivery and review analysis

All SQL scripts are available in the [`SQL`](SQL/) folder.

## Skills Demonstrated

**SQL:** database creation, joins, aggregations, CTEs, CASE expressions, date calculations, data-quality validation, referential integrity, customer segmentation and KPI analysis.

**Power BI/DAX:** data modeling, relationships, measures, filter context, CALCULATE, FILTER, ALL/REMOVEFILTERS, RELATED, RANKX, TOPN, SELECTEDVALUE, time intelligence, drill-through and dashboard design.

## Repository Structure

```text
Olist-Ecommerce-Customer-Sales-Analytics/
├── README.md
├── SQL/
│   ├── 01_Create_Tables.sql
│   ├── 02_Data_Import.sql
│   ├── 03_Data_Quality_Checks.sql
│   ├── 04_Referential_Integrity.sql
│   └── 05_Business_Analysis.sql
└── Screenshots/
    ├── Page_1_Executive_Overview.png
    ├── Page_2_Customer_Analysis.png
    ├── Page_3_Product_Sales_Analysis.png
    └── Page_4_Delivery_Customer_Satisfaction.png
```

## How to Reproduce

1. Download the Olist public dataset.
2. Run `01_Create_Tables.sql`.
3. Replace `<DATA_PATH>` in `02_Data_Import.sql`.
4. Load the CSV files using MySQL `LOAD DATA LOCAL INFILE`.
5. Run the data-quality and referential-integrity scripts.
6. Run `05_Business_Analysis.sql`.
7. Open the Power BI dashboard separately and configure the MySQL connection before refreshing.

## Portfolio Value

This project demonstrates an end-to-end analytics workflow:

**Data loading → validation → SQL analysis → data modeling → DAX → visualization → business interpretation**
