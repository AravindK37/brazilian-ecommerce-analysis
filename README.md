
# Brazilian E-Commerce Data Analysis

An end-to-end data analytics project exploring the Brazilian e-commerce marketplace dataset by **Olist**. The project uses **Python, SQL Server and Power BI** to investigate sales performance, product categories, customer behaviour, payment patterns, delivery performance and customer reviews.

## Project Overview

The objective is to transform multiple raw e-commerce CSV files into validated analytical datasets, perform additional business analysis in SQL Server, and present the findings through an interactive two-page Power BI dashboard.

### Tools & Technologies
- **Python:** pandas, NumPy, Matplotlib and Seaborn
- **SQL:** Microsoft SQL Server and SQL Server Management Studio (SSMS)
- **BI & Reporting:** Microsoft Power BI
- **Version Control:** Git and GitHub

## Project Workflow

1. **Data Preparation and EDA – Python**
   - Loaded and inspected the seven Olist source CSV files.
   - Cleaned missing values, data types and date fields.
   - Merged order, customer, item, product, category, payment and review information.
   - Created consolidated, order-level and review-level analytical datasets.
   - Calculated delivery duration and delivery delay.
   - Exported prepared datasets for SQL Server and Power BI.

2. **Business Analysis – SQL Server**
   - Imported prepared analytical tables and the original payment transaction table.
   - Analysed revenue, orders, product categories, customer spending and repeat purchases.
   - Examined payment method distribution.
   - Evaluated delivery performance by state and its relationship with review scores.
   - Used aggregations and window functions to calculate contribution percentages.

3. **Interactive Reporting – Power BI**
   - Built a two-page dashboard.
   - Created DAX measures for key performance indicators.
   - Added date, state and payment-type slicers.
   - Designed visuals for sales, customers, reviews, payments and delivery insights.

## Power BI Dashboard

The report contains two pages.

### Page 1 – Sales & Revenue Overview

![Sales & Revenue Overview](screenshots/01_Sales_Revenue_Overview.png)

**Key elements:**
- Total revenue, total orders, unique customers, average review score and average delivery time.
- Top five product categories by revenue.
- Review score distribution.
- Top ten states by revenue.
- Payment method revenue distribution.
- Monthly revenue trend.

### Page 2 – Customer & Delivery Insights

![Customer & Delivery Insights](screenshots/02_Customer_Delivery_Insights.png)

**Key elements:**
- Unique customers by state.
- Geographical distribution of customers across Brazil.
- Monthly customer trend.
- Customer segmentation into New, Returning and Loyal groups.
- Review score distribution.
- Average order value.
- Repeat customer rate.
- Late delivery percentage.

Both pages include interactive filters for date range, state and payment type.

## Key Business Insights

### Sales & Product Performance
- Total revenue was approximately **R$15.42 million**, based on the project's order-level revenue calculation.
- **Health & Beauty** was the highest revenue-generating product category, with approximately R$1.23 million in revenue.
- The top three categories — Health & Beauty, Watches & Gifts, and Bed Bath Table — contributed approximately **26.24%** of category revenue.

### Customer Behaviour
- Approximately **97% of customers were one-time customers**.
- Repeat customers represented approximately **3%** of the customer base, highlighting a potential customer-retention opportunity.
- The highest-spending customer was not necessarily a frequent customer.

### Payment Patterns
- Credit cards accounted for approximately **78.34%** of total recorded payment value.
- Boleto accounted for approximately **17.92%**.
- Together, credit cards and boleto represented approximately **96.26%** of recorded payment value.

### Delivery & Customer Satisfaction
- Approximately **6.77% of orders experienced late delivery**.
- Alagoas (AL) recorded the highest late-delivery rate at **21.41%** among the states analysed.
- Orders delivered late had an average review score of **2.27**, compared with **4.29** for orders delivered on time or early.

*The delivery and review comparison indicates an association; it does not establish that late delivery alone caused lower review scores.*


## Repository Structure

```text
brazilian-ecommerce-analysis/
│
├── notebooks/
│   └── Brazilian_eCommerce.ipynb
│
├── sql/
│   └── Brazilian_eCommerce.sql
│
├── screenshots/
│   ├── 01_Sales_Revenue_Overview.png
│   └── 02_Customer_Delivery_Insights.png
│
└── README.md
```

### Power BI Dashboard

The Power BI report is hosted separately as a GitHub Release due to its file size.

- **Release:** [Brazilian E-Commerce Power BI Dashboard – v1.0.0](https://github.com/AravindK37/brazilian-ecommerce-analysis/releases/tag/v1.0.0)
- **Download:** [Brazilian_eCommerce.pbix](https://github.com/AravindK37/brazilian-ecommerce-analysis/releases/latest/download/Brazilian_eCommerce.pbix)

## Dataset

The project uses the **Brazilian E-Commerce Public Dataset by Olist**, available on Kaggle.

The Python workflow uses seven source CSV files covering:
- Customers
- Orders
- Order items
- Payments
- Reviews
- Products
- Product category name translation

The source tables have different levels of detail. An order can contain multiple items and multiple payment transactions. The project therefore uses an order-level dataset for order-level metrics and the original payment transaction table for payment-method analysis, helping avoid double-counting caused by flattened joins.

**Dataset source:** [Brazilian E-Commerce Public Dataset by Olist – Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Project Files

| Component | File | Description |
|---|---|---|
| Python | [Brazilian_eCommerce.ipynb](notebooks/Brazilian_eCommerce.ipynb) | Data cleaning, preparation and exploratory data analysis |
| SQL Server | [Brazilian_eCommerce.sql](sql/Brazilian_eCommerce.sql) | SQL queries for business analysis |
| Power BI | [Brazilian_eCommerce.pbix](https://github.com/AravindK37/brazilian-ecommerce-analysis/releases/latest/download/Brazilian_eCommerce.pbix) | Interactive two-page analytics dashboard |

## Notes

- The analysis focuses on delivered orders for completed-order and delivery metrics.
- Revenue is calculated using aggregated item price plus freight at order level.
- Payment-method contribution is based on the recorded payment transactions used in the SQL analysis.
- The dashboard is built on the prepared project data; refreshing it may require updating the SQL Server connection to your own database.

---

**Author:** AravindK37  
**Project:** Brazilian E-Commerce Data Analysis  
**Tools:** Python | SQL Server | Power BI
