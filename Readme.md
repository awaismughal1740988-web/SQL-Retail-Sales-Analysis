# 🛒 SQL Retail Sales Analysis | End-to-End Business Insights Using PostgreSQL

A professional end-to-end SQL analytics project focused on transforming raw retail transaction data into meaningful business insights using PostgreSQL.

This project demonstrates real-world analytical workflows including:

* Data cleaning & validation
* Exploratory data analysis (EDA)
* Revenue & profitability analysis
* Customer behavior analysis
* Business intelligence reporting
* SQL-based decision support

The primary goal of this project is to showcase how SQL can be used not only for querying data, but also for solving business problems and supporting strategic decisions.

This project demonstrates how raw retail transaction data can be transformed into actionable business insights through structured SQL queries and analytical thinking.

---

# 📌 Executive Summary

Retail companies generate large volumes of transactional data every day. However, raw data alone has little value unless it is transformed into actionable insights.

This project analyzes retail sales data to answer important business questions related to:

* Revenue performance
* Product profitability
* Customer purchasing patterns
* Seasonal sales trends
* Demographic analysis
* Operational insights

Using PostgreSQL, the dataset was cleaned, transformed, and analyzed to generate business-focused recommendations.

* Understand customer purchasing behavior
* Track profitability
* Identify top-performing product categories
* Monitor sales trends
* Make data-driven decisions

This project solves these challenges by performing end-to-end retail sales analysis using SQL.

---

# 🎯 Business Objectives

* Perform data cleaning and validation
* Analyze retail sales performance
* Calculate total profit and revenue
* Identify top-performing categories
* Understand customer demographics
* Generate business insights using SQL

---

# 🛠️ Technologies Used

| Tool        | Purpose                      |
| ----------- | ---------------------------- |
| PostgreSQL  | Data cleaning & analysis     |
| SQL         | Querying & business analysis |
| CSV Dataset | Raw retail transaction data  |
| VS Code     | SQL development environment  |

---

# 📁 Dataset Information

### Dataset Features

| Column Name     | Description             |
| --------------- | ----------------------- |
| transactions_id | Unique transaction ID   |
| sale_date       | Transaction date        |
| sale_time       | Transaction time        |
| customer_id     | Unique customer ID      |
| gender          | Customer gender         |
| age             | Customer age            |
| category        | Product category        |
| quantity        | Quantity sold           |
| price_per_unit  | Price per product       |
| cogs            | Cost of goods sold      |
| total_sale      | Total transaction value |

---

# 🧹 Step 1 — Database Design & Setup

### Create Retail Sales Table

```sql
Create table retail_data (
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	age INT,
	category TEXT,
	quantiy INT,
	price_per_unit INT,
	cogs INT,
	total_sale INT
)
```

### Modify Data Types

```sql
Alter Table retail_data
    Alter Column price_per_unit Type FLOAT,
    Alter Column cogs Type FLOAT,
    Alter Column total_sale Type FLOAT
```


---

# 🔍 Step 2 — Data Validation & Cleaning

Before performing analysis, the dataset was validated and cleaned to ensure data accuracy and consistency.

Data quality checks are critical because inaccurate data can lead to misleading business decisions.

## Key Cleaning Steps

* Checked total records
* Validated unique customers
* Identified null values
* Removed incomplete records
* Added calculated profit column

---

## 📊 Initial Data Exploration

| Metric               | Result |
| -------------------- | ------ |
| Total Rows           | 2000   |
| Unique Customers     | 155    |
| Product Categories   | 3      |
| Null Records Removed | 13     |

---

## Product Categories

| Category    |
| ----------- |
| Electronics |
| Clothing    |
| Beauty      |

---

## Null Value Detection Query

```sql
Select * from retail_data
Where transactions_id IS Null OR
sale_date IS Null OR
sale_time IS Null OR
customer_id IS Null OR
gender IS Null OR
age IS Null OR
category IS Null OR
quantiy IS Null OR
price_per_unit IS Null OR
cogs IS Null OR
total_sale IS Null;
```

---

## Remove Null Values

```sql
Delete from retail_data
Where transactions_id IS Null OR
sale_date IS Null OR
sale_time IS Null OR
customer_id IS Null OR
gender IS Null OR
age IS Null OR
category IS Null OR
quantiy IS Null OR
price_per_unit IS Null OR
cogs IS Null OR
total_sale IS Null;
```


# 💰 Step 3 — Revenue & Profit Engineering

A new column was added to calculate profit per transaction.

## SQL Query

```sql
Alter Table retail_data
Add column profit_per_sale Float

Update retail_data
Set profit_per_sale = ROUND(total_sale - (cogs*quantity))
```


# 📈 Step 4 — Advanced Business Analysis

The cleaned dataset was analyzed using SQL queries to uncover:

* Revenue trends
* Customer behavior patterns
* Category-level profitability
* Gender-based purchasing insights
* Seasonal sales performance
* Operational business opportunities

---

# 📊 Key Business Questions & Results

## 1️⃣ Total Unique Customers

```sql
Select count(Distinct customer_id)
from retail_data
```

| Metric           | Value |
| ---------------- | ----- |
| Unique Customers | 155   |

---

## 2️⃣ Total Sales

```sql
Select Sum(total_sale)
from retail_data
```

| Metric      | Value   |
| ----------- | ------- |
| Total Sales | 908,230 |

---

## 3️⃣ Total Profit

```sql
Select Sum(profit_per_sale)
from retail_data
```

| Metric       | Value   |
| ------------ | ------- |
| Total Profit | 421,371 |

---

## 4️⃣ Sales & Profit by Product Category

```sql
Select category,
Sum(profit_per_sale) as Total_profit,
Sum(total_sale) as total_sales
from retail_data
group by 1
```

| Category    | Total Profit | Total Sales |
| ----------- | ------------ | ----------- |
| Electronics | 140,693      | 311,445     |
| Clothing    | 143,234      | 309,995     |
| Beauty      | 137,444      | 286,790     |

### 📌 Business Insight

Although Electronics generated strong overall revenue, the Clothing category produced the highest profitability. This suggests that Clothing products may have stronger margins and better operational efficiency.

---

## 5️⃣ Average Age of Beauty Customers

```sql
Select Round(AVG(age))
from retail_data
where category = 'Beauty'
```

| Metric      | Result   |
| ----------- | -------- |
| Average Age | 40 Years |

---

## 6️⃣ Transactions by Gender

```sql
Select gender,
count(transactions_id) as total_transactions
from retail_data
group by 1
```

| Gender | Transactions |
| ------ | ------------ |
| Female | 1012         |
| Male   | 975          |

---

## 7️⃣ Customer Distribution by Category & Gender

| Category    | Male Customers | Female Customers | Total Customers |
| ----------- | -------------- | ---------------- | --------------- |
| Beauty      | 115            | 124              | 239             |
| Clothing    | 130            | 125              | 255             |
| Electronics | 115            | 123              | 238             |

---

## 8️⃣ Sales & Profit by Gender

| Gender | Total Sales | Total Profit |
| ------ | ----------- | ------------ |
| Female | 463,110     | 197,402      |
| Male   | 445,120     | 223,969      |

### 📌 Business Insight

Female customers generated slightly higher total revenue, while male customers contributed more overall profit. This indicates potential differences in purchasing behavior and product mix between customer groups.

---

## 9️⃣ Monthly Sales Trend

| Year | Best Selling Month | Average Sales |
| ---- | ------------------ | ------------- |
| 2022 | December           | 461           |
| 2023 | December           | 490           |

### 📌 Business Insight

December consistently delivered the strongest sales performance across multiple years, indicating strong seasonal demand and holiday-driven purchasing behavior.

---

# 📈 Strategic Business Insights

* The retail business generated more than **908K in total sales revenue** during the analysis period.
* Total estimated profit exceeded **421K**, demonstrating strong business profitability.
* Clothing emerged as the most profitable product category despite Electronics generating strong sales volume.
* Female customers contributed slightly higher sales revenue, highlighting a valuable target customer segment.
* December consistently outperformed other months, suggesting strong seasonal buying trends and opportunities for promotional campaigns.
* The dataset contained minimal null values, indicating strong data quality.

---

# 💡 Business Recommendations & Strategy

* Increase promotional and marketing efforts during December to capitalize on seasonal demand spikes.
* Expand inventory and promotional focus for high-performing Clothing products to maximize profitability.
* Develop loyalty and retention campaigns targeting high-value female customer segments.
* Reevaluate Electronics pricing and operational costs to improve category-level margins.
* Continue maintaining strong data quality standards.

---

# 📂 Project Structure

```bash
SQL-Retail-Sales-Analysis/
│── data/
│── sql/
│── images/
│── README.md
```

---

# 🚀 How to Run This Project

1. Import dataset into PostgreSQL
2. Create retail_data table
3. Run cleaning queries
4. Execute analysis queries
5. Review generated business insights

---

# 👤 Author

## Awais Mughal

Aspiring Data Analyst

---


