# Retail Sales Intelligence Platform

An end-to-end retail analytics project built with **Python, MySQL and Power BI** using the Global Superstore dataset. The project explores sales performance, profitability, product contribution, customer behaviour, regional trends and shipping performance across the 2011–2014 period.

The goal is simple: turn transaction-level retail data into clear business insights that can support better commercial and operational decisions.

---

## Project Overview

Retail businesses need to understand more than how much they sell. They also need to know which products and categories generate profit, which customer groups contribute most, how performance varies across regions, and how sales and profitability change over time.

This project brings those questions together through data preparation, SQL analysis, Python exploration and an interactive Power BI dashboard.

### Business Objectives

- Track overall sales, profit, order volume and customer performance.
- Compare sales and profitability across categories and sub-categories.
- Identify top-performing and loss-making products.
- Understand customer and regional contributions.
- Explore discount patterns and their relationship with profit margins.
- Compare shipping modes using sales, profit and delivery-time measures.
- Analyse monthly, quarterly and yearly business trends.

---

## Dataset at a Glance

**Dataset:** Global Superstore  
**Period:** 01 Jan 2011 – 31 Dec 2014  
**Records:** 51,290 transaction rows  
**Fields:** 24 columns

### Key Business Metrics

| Metric | Value |
|---|---:|
| Total Sales | $12,642,501.91 |
| Total Profit | $1,467,457.29 |
| Profit Margin | 11.61% |
| Total Orders | 25,035 |
| Total Customers | 1,590 |
| Total Products | 10,292 |
| Units Sold | 178,312 |
| Average Order Value | $504.99 |

*These figures describe the supplied dataset at the overall level. Dashboard values may change when filters are applied.*

---

## Tools & Technologies

| Tool | How it is used |
|---|---|
| **Python** | Data loading, cleaning, exploration, aggregations and visual analysis using Pandas and visualization libraries. |
| **MySQL** | Business-focused queries, KPI calculations, grouping, ranking and performance analysis. |
| **Power BI** | Interactive dashboards, DAX measures, slicers, time intelligence and business reporting. |
| **Excel / CSV** | Dataset inspection and supporting data preparation. |

---

## Power BI Dashboard

The report is organized into four connected pages.

### 1. Executive Overview
A high-level view of business performance.

- Total Sales, Total Profit, Total Orders, Total Customers and Profit Margin.
- Monthly Sales & Profit Trend.
- Sales by Category.
- Sales by Region.
- Sales by Market.
- Orders by Customer Segment.
- Year-wise Sales & Profit.

### 2. Product & Profitability
A deeper look at product contribution and profitability.

- Total Products, Units Sold, Profitable Products, Loss-Making Products and Average Discount.
- Profit by Sub-Category.
- Top 10 Products by Sales.
- Top 10 Profitable Products.
- Top 10 Loss-Making Products.
- Discount Analysis.
- Shipping Mode Analysis.

### 3. Customer & Regional Analysis
An analysis of customer contribution and geographic performance.

- Total Customers and Total Orders.
- Average Sales per Customer.
- Top Customer Sales.
- Repeat Customer Rate.
- Sales by Region.
- Sales & Profit by Customer Segment.
- Top 10 Customers by Sales and Profit.
- Orders by Market.
- Customer Segment Distribution.

### 4. Time Intelligence Analysis
A time-based view of performance and trends.

- Total Sales, Total Profit and Profit Margin.
- Highest Year Sales and Highest Year Profit.
- Monthly Sales & Profit Trend.
- Monthly Analysis.
- Year-wise Sales & Profit.
- Quarter-wise Sales.
- Quarter-wise Profit.

---

## Analytical Areas

### Sales & Profitability
Compare revenue and profit together to understand where sales volume is translating into stronger financial contribution.

### Product Performance
Rank products and sub-categories by sales and profit, and highlight products with negative aggregate profit.

### Customer Analysis
Compare customer segments, identify high-contribution customers and understand repeat purchasing patterns.

### Regional Performance
Explore differences in sales and profit across regions and markets.

### Discount & Shipping
Examine how profit margins vary across discount levels and compare shipping modes using order volume, sales, profit and average shipping days.

### Time Intelligence
Track monthly, quarterly and yearly performance to understand changes and recurring patterns.

---

## Repository Structure

```text
retail-sales-intelligence/
│
├── README.md
│
├── data/
│   └── clean_global_superstore.csv
│
├── python/
│   └── Retail_Sales_Intelligence_Final_Python_Notebook.ipynb
│
├── sql/
│   └── Retail_Sales_Intelligence_SQL_Analysis_FIXED.sql
│
├── PowerBI/
│   └── Retail_Sales_Intelligence.pbix
│
├── dashboard_screenshots/
│   ├── page1-executive-overview.png
│   ├── page2-product-profitability.png
│   ├── page3-customer-regional.png
│   └── page4-time-intelligence.png
│
├── report/
│   ├── Retail_Sales_Intelligence_Project_Report.docx
│   └── Retail_Sales_Intelligence_Business_Problem.pdf
│
└── presentation/
    └── Retail_Sales_Intelligence_Executive_Presentation.pptx
```

*Use the actual filenames you upload to GitHub. Add the `.pbix` file if you are including the Power BI report itself, and place your four dashboard screenshots in the screenshots folder.*

---

## How to Explore the Project

1. Start with the **Executive Overview** page to understand the overall business performance.
2. Open **Product & Profitability** to explore product contribution, discounts and loss-making products.
3. Use **Customer & Regional Analysis** to compare customers, segments, regions and markets.
4. Explore **Time Intelligence** to review monthly, quarterly and yearly trends.
5. Review the Python notebook for data exploration and the SQL file for the business queries behind the analysis.

---

## Key Takeaway

The project provides a unified view of retail performance across sales, profit, products, customers, geography and time. It demonstrates how data analysis can move beyond summary numbers to identify performance patterns, highlight areas that deserve attention and support more informed business decisions.

---

**Project:** Retail Sales Intelligence Platform  
**Domain:** Retail Analytics / Business Intelligence  
**Tools:** Python • MySQL • Power BI  
**Dataset:** Global Superstore (2011–2014)
