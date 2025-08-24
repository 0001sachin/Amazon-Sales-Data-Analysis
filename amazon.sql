select * from amazon

--1. Show all the data from the table
Select * from amazon;

--2. Display only ProductName, Category, and Price.
select product_name,Main_Category,actual_price from amazon;

--3. Find all products with a Rating greater than 4.
select product_id,product_name from amazon where rating > 4;

--4. List products where Discount is greater than 20%.
select product_id,product_name,Discount_Percentage1 from amazon where Discount_Percentage1 > '20%' ;

--5. Show distinct Category values from the dataset.
select distinct Main_Category as category from amazon;

--6. Count how many products are listed in total.
select COUNT(product_id) as product_listed from amazon;
select COUNT(*) as product_listed from amazon;

--7. Find the minimum and maximum Price.
select MAX(actual_price) as Max_price,MIN(actual_price) as Min_price from amazon;

--8. Count the number of products with missing Rating.
select COUNT(*) product_missing_rating from amazon where rating is null;

--9 Find the average Price of products in each Category.
select  Main_Category,AVG(actual_price) as avg_price from amazon
group by Main_Category;

--10. Show top 5 most expensive products.
select top 5 product_name,actual_price from amazon 
order by actual_price  desc;

--11. Find the total Revenue  for each Category.
select  Main_Category,SUM(discounted_price) as total_revenue from amazon
group by Main_Category;

--12. Find categories that have more than 100 products.
select Main_Category,COUNT(product_id) as total_product from amazon 
group by Main_Category
having count(product_id) > 100;

-- 13. Show the average Discount given per Category.
select Main_Category,AVG(Discount_Percentage)*100 as avg_discount from amazon
group by Main_Category;

--14. Find the top 3 categories with the highest average Rating.
select top 3 Main_Category,AVG(rating) as avg_rating from amazon
group by Main_Category
order by avg_rating desc;

--15. Find the product with the highest revenue in each category.
select Main_Category,product_name,highest_revenue from(
select Main_Category,product_name,sum(discounted_price) as highest_revenue ,
ROW_NUMBER()over(partition by Main_Category order by sum(discounted_price) Desc)  as rn from amazon
group by Main_Category,product_name
) d
where rn = 1
order by highest_revenue desc;

--16. Find the percentage contribution of each category to the total revenue.
select Main_Category,SUM(discounted_price) as category_revenue,
ROUND (
(SUM(discounted_price)*100)/(select SUM(discounted_price) from amazon),2
)as percentage_contribution  from amazon
group by  Main_Category
order by percentage_contribution  desc;

--17. Write a query to rank products within each Category based on Revenue.
select top 5 Main_Category,product_name,total_revenue from (
select Main_Category,product_name,sum(discounted_price) as total_revenue,
RANK()over(partition by Main_Category order by sum(discounted_price)desc) as pn
from amazon
group by Main_Category,product_name
)t
where pn = 1
order by total_revenue desc;