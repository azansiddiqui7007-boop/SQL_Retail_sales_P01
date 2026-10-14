--SQL_Retail_Sales_Analysis--


Drop table if exists retail_sales;
--Create table
CREATE TABLE retail_sales(
			transactions_id int primary key,
			sale_date DATE,
			sale_time TIME,
 			customer_id INT,
			gender VARCHAR(10),
			age INT,
			category VARCHAR(15),
			quantiy int,
			price_per_unit float,
			cogs float,
			total_sale float
			);

select * from retail_sales;

copy retail_sales(transactions_id,	sale_date,	sale_time,	customer_id,	gender,	age,	category,	quantiy,	price_per_unit,	cogs,	total_sale)
from 'D:\SQL Projects portfolio\SQL - Retail Sales Analysis_utf .csv'
csv header;

--Data cleaning--
select * from retail_sales
where transactions_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where 
		transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or 
		customer_id is null
		or
		gender is null
		or
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or 
		total_sale is null;

alter table retail_sales
rename column quantiy to quantity;

delete from retail_sales
where
	transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or 
		customer_id is null
		or
		gender is null
		or
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or 
		total_sale is null;

select count(*) from retail_sales;

--Data Exploration--

--How many sales we have?--
select count(transactions_id) as total_sales
from retail_sales;

--How many unique customers do we have?--
 select count(distinct(customer_id)) as total_customers
 from retail_sales;

 --Unique categories
select distinct(category)
from retail_sales;

--Data Analysis & Business Key Problems and Answers

select * from retail_sales;

select * from retail_sales
where sale_date='2022-11-05';

select * from retail_sales
where 
	category='Clothing' and
	quantity>3 and
	to_char(sale_date, 'YYYY-MM')='2022-11';


select category, sum(total_sale) as total_sales
		,count(*) as total_orders
from retail_sales
group by 1;

select round(avg(age), 2) as avg_age
from retail_sales
where category='Beauty';

select * from retail_sales
where total_sale>1000;

select
	category,
	gender,
	count(transactions_id) as total_transactions
from retail_sales
group by 1,2
order by 1

select 
		year,
		month,
		avg_sale
from(
select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	round(avg(total_sale)) as avg_sale,
	rank() over(partition by extract(year from sale_date) order by round(avg(total_sale)) desc ) as rank
from retail_sales
group by 1,2) as t1
where rank=1

select * from retail_sales;

select customer_id, sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

select category, count(distinct customer_id) 
from retail_sales
group by 1


with Shiftwise_sale
as(
select *, 
	case
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
		end as sale_shift
from retail_sales)
select sale_shift, count(*)as total_orders
from Shiftwise_sale
group by sale_shift


--End of project































































