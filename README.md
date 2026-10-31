# Retail Sales Intelligence Platform

An end-to-end retail analytics project built with **Python, MySQL and Power BI** using the Global Superstore dataset (2011–2014). The project examines how sales translate into profit across products, categories, customers, regions, markets and time.

 

---

## Business problem

Retail management needs a consistent, evidence-based view of how sales translate into profit across products, categories, customers, regions and time. Revenue and profit totals alone do not show where losses occur or which commercial and operational factors may be associated with weak profitability.

**Decision this project supports:** identify where the business generates sales and profit, where performance requires closer investigation, and which product, customer, regional or pricing areas deserve management attention.

The analysis distinguishes:
- **Observed patterns** — directly calculated from the supplied dataset.
- **Potential explanations** — hypotheses that need further evidence.
- **Verified root causes** — not claimed unless supported by additional analysis.

## Project objectives

- Establish a reproducible baseline for sales, profit, order volume, customers and average order value.
- Compare performance by category, sub-category, product, customer segment, region, market and time.
- Identify products with negative aggregate profit.
- Examine discount and shipping patterns in relation to profitability.
- Translate verified findings into prioritized management actions and monitoring KPIs.

---

## Dataset

**Source file:** `clean_global_superstore.csv`  
**Data grain:** transaction/order line  
**Period:** 01 Jan 2011 to 31 Dec 2014  
**Rows:** 51,290  
**Columns:** 24

Key fields include order and ship dates, order/customer/product identifiers, customer segment, country/city/state/region/market, category/sub-category, sales, quantity, discount, profit, shipping mode and shipping cost.

### Verified baseline (from the supplied CSV)

| KPI | Result |
|---|---:|
| Transaction lines | 51,290 |
| Total sales | $12,642,501.91 |
| Total profit | $1,467,457.29 |
| Aggregate profit margin | 11.61% |
| Distinct orders | 25,035 |
| Distinct customers | 1,590 |
| Distinct products (Product ID) | 10,292 |
| Units sold | 178,312 |
| Average order value | $504.99 |
| Average discount | 14.29% |

**Metric definitions**
- **Profit margin:** total profit divided by total sales, multiplied by 100. This is a weighted aggregate margin.
- **Average order value:** total sales divided by distinct order IDs.
- **Repeat customer rate:** customers with more than one distinct order ID divided by distinct customers, over the full dataset period. It is **not** a cohort-retention rate.
- **Product profitability counts:** products grouped by `Product_ID` and classified using their aggregate profit across all transaction lines.

### Data quality observations

- Exact duplicate rows in the supplied CSV: **0**.
- Missing `Postal_Code` values: **41,296** (80.5%).
- The other core fields used in the KPI analysis have no missing values in this CSV.
- Postal-code-level analysis should be avoided or handled explicitly because of the high missingness.

---

## Tools and workflow

| Tool | Role |
|---|---|
| Python (Pandas, Matplotlib) | Data inspection, cleaning, exploratory analysis and reproducible calculations |
| MySQL 8+ | SQL aggregations, ranking queries, data-quality checks and business analysis |
| Power BI | Interactive KPI reporting, time intelligence, product, customer and regional dashboards |

### Analytical workflow

1. Inspect the source dataset, schema, data types and date fields.
2. Check missing values and duplicate records.
3. Prepare and validate the analytical dataset.
4. Calculate KPI baselines and segment-level aggregations in Python.
5. Prepare SQL queries for reusable business questions.
6. Build Power BI measures, slicers and dashboard pages.
7. Reconcile outputs across CSV, SQL and Power BI before publishing final business conclusions.

---

## Power BI dashboard

The report is organized into four pages:

### Page 1 — Executive Overview
- Total Sales, Total Profit, Total Orders, Total Customers and Profit Margin.
- Monthly Sales & Profit Trend.
- Sales by Category and Sales by Region.
- Sales by Market.
- Orders by Customer Segment.
- Year-wise Sales & Profit.

### Page 2 — Product & Profitability
- Total Products, Units Sold, Profitable Products, Loss-Making Products and Average Discount.
- Profit by Sub-Category.
- Top 10 Products by Sales.
- Top 10 Profitable Products.
- Top 10 Loss-Making Products.
- Discount Analysis.
- Shipping Mode Analysis.

### Page 3 — Customer & Regional Analysis
- Total Customers, Total Orders, Average Sales per Customer, Top Customer Sales and Repeat Customer Rate.
- Sales by Region.
- Sales & Profit by Customer Segment.
- Top 10 Customers by Sales and by Profit.
- Orders by Market.
- Customer Segment Distribution.

### Page 4 — Time Intelligence Analysis
- Total Sales, Total Profit, Profit Margin, Highest Year Sales and Highest Year Profit.
- Monthly Sales & Profit Trend.
- Monthly Analysis table.
- Year-wise Sales & Profit.
- Quarter-wise Sales and Quarter-wise Profit.

> Dashboard screenshots are visual evidence of the report layout and displayed measures. Reconcile Power BI values to the CSV baseline before presenting every screenshot value as independently verified.

---

## Selected findings from the supplied CSV

- **Yearly growth:** total sales increased from $2.26M in 2011 to $4.30M in 2014. Sales and profit increased in each year of the observed period.
- **Category performance:** Technology led category sales; Technology led category profit.
- **Regional performance:** Central was the largest region by sales; Central led regional profit.
- **Customer segment:** Consumer generated the highest segment sales.
- **Customer repeat activity:** 1,580 of 1,590 customers had more than one distinct order (99.37% under the full-period definition).
- **Product-level profit classification:** 7,360 products had positive aggregate profit, 2,892 had negative aggregate profit and 40 had exactly zero aggregate profit.

Higher discount groups show weaker aggregate margins in parts of this dataset. This is a **descriptive association**: product mix, market, order composition and other factors may differ between discount groups. The analysis does not prove that discount alone caused the margin outcomes.

---

## Business recommendations

1. **Introduce discount visibility and review controls.** Monitor margin by discount band, category and product; investigate exceptions before changing discount policy.
2. **Review loss-making products.** Prioritize products with recurring negative aggregate profit and inspect sales mix, discounting and shipping-cost context.
3. **Investigate low-margin category/region combinations.** Separate volume contribution from profit contribution before taking action.
4. **Monitor customer quality, not only customer count.** Track repeat purchasing by cohort and compare sales and profit per customer.
5. **Maintain a shipping-mode scorecard.** Monitor order volume, elapsed shipping days, shipping costs and profit by mode.
6. **Govern the KPI baseline.** Reconcile Python, SQL and Power BI calculations to the same source, date logic, identifier grain and filter context.

No cost savings, ROI or revenue uplift is claimed because the dataset does not quantify the causal impact of these actions.

---

## Repository structure

The suggested repository layout is:

```text
retail-sales-intelligence/
├── README.md
├── data/
│   └── clean_global_superstore.csv
├── python/
│   └── Retail_Sales_Intelligence_Final_Python_Notebook.ipynb
├── sql/
│   └── Retail_Sales_Intelligence_SQL_Analysis_FIXED.sql
├── PowerBI/
│   └── Retail_Sales_Intelligence.pbix
├── dashboard_screenshots/
│   ├── page1-executive-overview.png
│   ├── page2-product-profitability.png
│   ├── page3-customer-regional.png
│   └── page4-time-intelligence.png
├── report/
│   ├── Retail_Sales_Intelligence_Project_Report.docx
│   └── Retail_Sales_Intelligence_Business_Problem.pdf
└── presentation/
    └── Retail_Sales_Intelligence_Executive_Presentation.pptx
```

Include the `.pbix` file only if you have saved and are sharing the actual Power BI report. Screenshots are not a substitute for the PBIX file. Use the actual filenames you upload; rename the screenshot files to the names above or update the paths in this README.

---

## SQL setup and validation

The SQL script is written for **MySQL 8+** and expects the `projectdata` schema and the raw-style column names used in the SQL file (for example, `Order ID`, `Customer ID`, `Order Date`, `Sub-Category`).

Before running the full script:

1. Confirm the database exists:

   ```sql
   SHOW DATABASES;
   ```

2. Confirm the exact table name:

   ```sql
   SHOW TABLES FROM projectdata;
   ```

3. The previous MySQL error was `1146: Table 'projectdata.global_superstore' doesn't exist`. The supplied SQL file contains a table reference with a **leading space inside the backticks**: `` ` global_superstore` ``. Check the result of `SHOW TABLES` carefully. If the actual table is `global_superstore` without a leading space, replace all occurrences of `` ` global_superstore` `` in the SQL file with `` `global_superstore` ``.
4. Confirm the imported column names with:

   ```sql
   DESCRIBE projectdata.global_superstore;
   ```

5. Run the baseline KPI query first and compare it to the verified CSV figures above. Only then run the remaining analysis sections.

**SQL status:** query logic has been reviewed, but live execution and reconciliation against MySQL are not yet verified. Do not describe SQL results as validated until the database import and baseline comparison succeed.

---

## Limitations

- The supplied dataset supports descriptive sales, profit, customer, product, discount and shipping analysis; it does not prove causal drivers.
- Inventory availability, campaign spend, returns and customer acquisition cost are not established by the available fields.
- Missing postal codes limit reliable postal-code-level analysis.
- The full-period repeat customer rate is not a cohort retention metric.
- Power BI screenshots may contain rounded or differently filtered values; use the CSV baseline for the current verified metrics until the model is reconciled.
- MySQL execution remains pending confirmation of the exact imported table and schema.

## How to reproduce

1. Download or place the dataset in the `data/` directory.
2. Open the notebook in Jupyter Notebook, JupyterLab or VS Code and run cells from top to bottom.
3. Import the raw dataset into MySQL and verify the schema/table name before running the SQL script.
4. Open the Power BI `.pbix` file (if included), refresh the data and validate the DAX measures against the CSV baseline.
5. Review all four dashboard pages and update screenshots after reconciliation.

---

## Project status

| Component | Status |
|---|---|
| Supplied CSV inspection and KPI recalculation | Completed for this analysis |
| Python notebook review | Supplied; calculations in this README are independently recalculated from CSV |
| SQL query review | Reviewed; live MySQL execution pending |
| Power BI dashboard design | Four pages supplied as screenshots |
| Cross-tool reconciliation | In progress / not yet complete |

**Project outcome:** a structured retail performance analysis that identifies where sales and profit are concentrated, highlights product and margin risks, and defines evidence-linked areas for management investigation.
