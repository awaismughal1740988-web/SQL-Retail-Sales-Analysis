-- 1.[DATABASE SETUP]
-- 1.1 Create a table using this query
Create table retail_data (
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	age INT,
	category TEXT,
	quantiy INT,-- 1.[DATABASE SETUP]
-- 1.1 Create a table using this query
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

-- 1.2 Changing the DATATYPES for these to avoid error next time
Alter Table retail_data 
    Alter Column price_per_unit Type FLOAT,
    Alter Column cogs Type FLOAT,
    Alter Column total_sale Type FLOAT

-- 2.[DATA EXPLORATION & ClEANING]
-- 2.1 Record the total number of Rows
SELECT count(*) from retail_data -- 2000 Rows

-- 2.2 Record the Number of Customers
Select Count(Distinct customer_id) from retail_data -- 155 customers

-- 2.3 What are the category of porducts
Select Distinct category from retail_data 
/*
	3 - Catergories
	1. Electronics
	2. Colthing
	3. Beauty
*/

-- 2.4 Check the Null Values
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

-- 2.5 Check Number of Null Values
Select count(*) from retail_data 
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
total_sale IS Null;   -- 13 values which are null or columns to delete

-- 2.6 Delete Null values
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
total_sale IS Null; -- Delete 13

-- 2.7 Add a new column for calculating profit(profit_per_sale) 

-- Create a new column profit_per_sale
Alter Table retail_data
Add column profit_per_sale Float
-- Now update the table with values
Update retail_data 
Set profit_per_sale =  ROUND(total_sale - (cogs*quantity))


-- 3[DATA ANALYSIS]
-- 3.1 Find the number of total Unique Customers:

Select count(Distinct customer_id) as Total_Unique_Customers
	from retail_data   -- 155 Unique Customers

-- 3.2 What is Total Sales?

Select Sum(total_sale) from retail_data -- Total Sales worth 908,230.

-- 3.3 What is Total Profit?

Select Sum(profit_per_sale)
	as Total_profit from retail_data -- Total Profit are 421,371

-- 3.4 What is total sales & Total Porfit from each item category

Select category , Sum(profit_per_sale)
	as Total_profit, Sum(total_sale) as total_sales
	from retail_data group by 1
	/*	[Category]	[Total_profit]	 [Total Sales]	
	1. Electronics	 140,693		  311,445
	2. Clothing		 143,234		  309,995
	3. Beauty		 137,444		  286,790
	*/

-- 3.5 Find the average age of customers who purchased items from the 'Beauty' category.

Select Round(AVG(age)) from retail_data where category = 'Beauty'  -- 40

-- 3.6 Find the total number of transactions (transaction_id) made by each gender in each category.

Select gender, count(transactions_id) as total_transactions  from retail_data
	group by 1
	/* [Gender]	[Total_Transactions]
	1.  Female               1012
	2.  Male				  975
	*/

--  3.7 Find the total number of Customers category by gender & Products.

Select category, count(Distinct Case when gender = 'Male' Then customer_id End) as male_customers, 
	count(Distinct Case When gender = 'Female' Then customer_id End) as female_customers,
	count(Distinct Case when gender = 'Male' Then customer_id End)
	+ count(Distinct Case When gender = 'Female' Then customer_id End)
	as Total_customers
	from retail_data group by 1
	/*	[Category]	[Male_Customers]  [Female_Customers]   [Total_customers]
	1.	Beauty		            115					124					239
	2.  Clothing 				130					125					225
	3.  Electronics				115  				123					238
	*/


--  3.8 What are Profit and Total Sales from Each Gender.

Select gender, Sum(total_sale) as Total_sales, Sum(profit_per_sale)
	as Total_Profit from retail_data group by 1

	/*	[Gender]	[Total_Sales]	[Total_Profit]
	1.	Female			 463,110		  197,402
	2.	Male			 445,120		  223,969
	*/

-- 3.9 Find the unique number of customers who purchased items from each category.

Select category, count(Distinct customer_id) as Number_of_customers from retail_data 
	group by 1
	/*  Unique Number of Customers in each category
		[Category] 	[Number_of_Customers]
	1.	Beauty		    			 141
	2.	Clothing					 149
	3. 	Electronics					 144
	*/

-- 3.10 Calculate the average sale for each month. Find out best selling month in each year.

Select Distinct on (Extract(YEAR from sale_date))
	Extract(YEAR from sale_date) as Sales_Year,
	Extract(MONTH from sale_date) as Sales_Month,
	Round(Avg(total_sale)) as Average_Sales
	from retail_data group by 1,2 order by Sales_year, Sales_Month DESC
	/*	[Sales_Year]	[Sales_Month]	[Average_Sales]
	1.   	   2022				  12			   461
	2.		   2023				  12  			   490
	*/














