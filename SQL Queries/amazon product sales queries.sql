-- Creating Table
use amazon_sales;
create table sales (
product_id varchar(100) unique primary key,	
product_name varchar(100),
category varchar(100),
discounted_price decimal (10,2),
actual_price decimal (10,2),
discount_percentage decimal(10,2),
rating	decimal (10,2),
rating_count decimal (10,2)
);

-- CLEARING DATA
delete from sales where product_id = '' OR product_id is null
or product_name = '' OR product_name is null
or category = '' OR category is null
or discounted_price is null  
or actual_price is null
or discount_percentage is null
or rating is null
or rating_count is null;
select count(*) from sales;
select * from sales;


-- Section 1: Data Exploration
-- 1.	How does the dataset look? (Preview the first 10 rows.) 
select * from sales limit 10;

-- 2.	How many unique products are in the dataset? 
select count(distinct product_name) from sales;

-- 3.	How many unique product categories are there? 
select count(distinct category)  from sales;

-- 4.	What are the different product categories? 
select distinct category from sales;

-- 5.	What is the price range of products? (Minimum and maximum discounted price.) 
select min(discounted_price) as lowest_price, max(discounted_price) as highest_price from sales;

-- 6.	What is the rating range? (Minimum and maximum rating.) 
select min(rating) as lowest_rating, max(rating) as highest_rating from sales;

-- 7.	Which products have missing ratings or rating counts? (If any.) 
select * from sales where rating is null or rating = '' 
or rating_count is null or rating_count='';

-- 8.	Which products belong to each category? (Optional, if you want to explore the data.) 
select distinct category,product_name from sales;


-- Section 2: Product Performance Analysis
-- 1.	What is the average discounted price of all products?
select avg(discounted_price) from sales as avg_discounted_price;

-- 2.	What is the average actual (original) price? 
select avg(actual_price) from sales as avg_actual_price;

-- 3.	What is the total value of all discounted prices? 
select sum(discounted_price) from sales as total_discounted_price;

-- 4.	Which are the top 10 most expensive products?
select product_name,actual_price from sales order by actual_price DESC limit 10;
 
-- 5.	Which are the 10 least expensive products? 
select product_name,actual_price from sales order by actual_price ASC limit 10 ;

-- 6.	Which categories have the most products? 
SELECT category, COUNT(*) AS total_products FROM sales GROUP BY category ORDER BY total_products DESC;

-- 7.	What is the average product rating for each category? 
Select category, avg(rating) as avg_rating from sales group by category;

-- 8.	Which categories have the highest average discount percentage? 
select category, avg(discount_percentage) as avg_discount_percentage from 
sales group by category order by avg_discount_percentage desc;


-- 9.	Which products have the highest ratings? 
select product_name, rating  from sales order by rating desc;

-- 10.	Which products have received the highest number of ratings? 
select product_name, rating_count  from sales  order by rating_count desc;

-- 11.	Which products have discounts greater than 50%? 
select product_name,discount_percentage from sales where discount_percentage > 0.5;

-- 12.	Which categories offer the biggest average discounts?
select distinct category, avg(discount_percentage) as avg_discount from sales group by category order by avg_discount desc;


-- Section 3: Advanced Business Insights
-- 1.	Which categories have an average rating greater than 4.0? 
select category,ratings from sales where 4.0 < (select avg(rating) from sales);

-- 2.	Which categories have an average discount percentage greater than 50%? 
select category,avg(discount_percentage) as avg_discount_percentage from sales 
group by category having avg_discount_percentage > 0.50;

-- 3.	Which categories contain more than 50 products? 
select category, count(product_name) as total_products from sales
group by category
having total_products > 50;

-- 4.	Which products have a rating higher than the overall average rating? 
select product_name,rating from sales 
where rating > ( select avg(rating) from sales);

-- 5.	Which products have an actual price higher than the overall average actual price? 
select product_name,actual_price from sales 
where actual_price > ( select avg(actual_price) from sales);

-- 6.	Which products have a discount percentage higher than the overall average discount percentage? 
select product_name,discount_percentage from sales 
where discount_percentage > ( select avg(discount_percentage) from sales);


-- 7.	Which products have both a rating above 4.5 and a discount greater than 50%? 
select product_name,discount_percentage,rating from sales 
where rating > 4.5 and discount_percentage> 0.50;

-- 8.	Which products have no discount? 
select product_name,discount_percentage from sales 
where discount_percentage = 0;

-- 9.	Which products have a price difference (actual price − discounted price) greater than 10,000? 
select product_name, actual_price, discounted_price, actual_price - discounted_price AS price_difference from sales
where actual_price - discounted_price > 10000;

-- 10.	Which are the top 5 highest-rated products? 
select product_name, rating from sales
order by rating desc
limit 5;

-- 11.	Which categories have the lowest average discount percentage? 
select category, avg(discount_percentage) as avg_discount_percentage from sales
group by category
order by avg_discount_percentage asc;

