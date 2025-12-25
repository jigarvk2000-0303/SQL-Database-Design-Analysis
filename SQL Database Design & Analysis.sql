#📌 PROBLEM STATEMENT

# A retail company wants to analyze its sales performance, product demand, supplier quality, and workforce patterns using the following datasets:
#Tables Available
#retail_data (5000 rows) – transactional sales
#products (700 rows)
#suppliers (200 rows)
#inventory (500 rows)
#employees (300 rows)
#Using these datasets, answer the following 30 SQL questions that cover filtering, joins, grouping, window functions, subqueries, CTEs and advanced analytics.

#Question 1
#List all transactions from Mumbai.
Select * from retail_data 
Select * from retail_data 
WHERE city = 'Mumbai';

#Question 2
#Find products priced above ₹3000.
Select * from products
WHERE unit_price > 3000;

#Question 3
#Count total transactions.
Select count(*) from retail_data;

#Question 4
#Show distinct product categories.
Select distinct category from retail_data;

#Question 5
#Find total quantity sold for each category.
select category, sum(quantity) as total_qty
from retail_data
group by category;

#Question 6
#Retrieve top 5 most expensive products.
select * from products
order by unit_price desc
limit 5;

#Question 7
#Get total sales (price × quantity).
select sum(price*quantity) as total_sales
from retail_data;

#Question 8
#Display all employees who joined after 2020.
select * from employees
where joining_date >= '2021-01-01';

#Question 9
#Count total products in each category.
select category, count(*) as product_count
from products
group by category;

#Question 10
#Show all suppliers located in Mumbai.
select * from suppliers
where city='Mumbai';

#Question 11
#Find the top 10 highest revenue transactions.
select transaction_id, (quantity * price) as revenue
from retail_data
order by revenue desc
limit 10;

#Question 12
#Join retail_data with products to display product names.
select r.transaction_id, p.product_name, r.quantity, r.price
from retail_data r
join products p on r.product_id = p.product_id;

#Question 13
#Find total sales by city.
select city, sum(price * quantity) as total_sales
from retail_data
group by city;

#Question 14
#Find which warehouse has the highest stock.
select warehouse_city, sum(stock_quantity) as total_stock
from inventory
group by warehouse_city
order by total_stock desc;

#Question 15
#Count how many products each supplier supplies.
select supplier_id, count(*) as total_products
from suppliers
group by supplier_id;

#Question 16
#Find total revenue for each product.
select product_id, sum(quantity * price) as revenue
from retail_data
group by product_id
order by revenue desc;

#Question 17
#Retrieve all transactions where quantity > average quantity sold.
select *
from retail_data
where quantity > (select avg(quantity) from retail_data);

#Question 18
#Find employees grouped by department.
select department, count(*) as emp_count
from employees
group by department;

#Question 19
#Show the stock level of each product with product names.
select p.product_name, i.stock_quantity
from inventory i
join products p on i.product_id = p.product_id;

#Question 20
#Find top 3 product categories with highest total revenue.
select category, sum(price * quantity) as total_revenue
from retail_data
group by category
order by total_revenue desc
limit 3;

#Question 21
#Get each product’s rank based on total revenue.
select product_id, 
       sum(quantity * price) as revenue,
       rank() over (order by sum(quantity * price) desc) as revenue_rank
from retail_data
group by product_id order by revenue_rank;

#Question 22
#Find daily sales and 7-day moving average.
with daily_sales as (
    select transaction_date, sum(quantity * price) as total_sales
    from retail_data
    group by transaction_date
)
select transaction_date, total_sales,
       avg(total_sales) over (order by transaction_date rows 6 preceding) as moving_avg_7_days
from daily_sales;

#Question 23
#Find products that never appear in retail_data.
select p.product_id, p.product_name
from products p
left join retail_data r on p.product_id = r.product_id
where r.product_id is null;

#Question 24
#Identify out-of-stock items (stock = 0).
select p.product_name, i.stock_quantity
from inventory i
join products p on i.product_id = p.product_id
where i.stock_quantity = 0;

#Question 25
#Find suppliers with above-average rating.
select *
from suppliers
where rating > (select avg(rating) from suppliers);

#Question 26
#Show top-selling product per city.
select city, product_id, total_qty
from (
    select city, product_id, sum(quantity) as total_qty,
           rank() over (partition by city order by sum(quantity) desc) as rnk
    from retail_data
    group by city, product_id
) t
where rnk = 1;

#Question 27
#Compare monthly sales across years.
select date_format(transaction_date, '%Y-%m') as month,
       sum(quantity * price) as revenue
from retail_data
group by month
order by month;

#Question 28
#Find employees with the longest tenure.
select employee_id, employee_name, joining_date
from employees
order by joining_date
limit 10;

#Question 29
#Show products generating more than ₹1,00,000 revenue.
select product_id, sum(quantity * price) as total_revenue
from retail_data
group by product_id
having total_revenue > 100000;

#Question 30
#Identify customers who made more than 20 purchases.
select customer_id, count(*) as total_transactions
from retail_data
group by customer_id
having count(*) > 20;

#Question 31
#List the top 5 highest-priced products sold in retail_data.
select p.product_name, p.unit_price
from products p
order by p.unit_price desc
limit 5;

#Question 32
#Find total quantity sold per city in retail_data.
select city, sum(quantity) as total_quantity
from retail_data
group by city;

#Question 33
#Show products that have never been sold (exist in products but not in retail_data).
select p.product_id, p.product_name
from products p
left join retail_data r on p.product_id = r.product_id
where r.product_id is null;

#Question 34
#Display top 3 cities with the highest total revenue.
select city, sum(quantity * price) as total_revenue
from retail_data
group by city
order by total_revenue desc
limit 3;

#Question 35
#List employees who joined in the same month the year started (January).
select employee_id, employee_name, joining_date
from employees
where month(joining_date) = 1;

#Question 36
#Find the supplier that provides the maximum number of unique products.
select supplier_id, count(product_id) as unique_products
from products
group by supplier_id
order by unique_products desc
limit 1;
select * from products;

#Questioin 37
#Find the average price of products by category.
select category, avg(unit_price) as avg_price
from products
group by category;

#Question 38
#Show inventory items that are below reorder level.
select inventory_id, product_id, stock_quantity, warehouse_city
from inventory;

#Question 39
#Show the best-selling category by total revenue.
select category, sum(quantity * price) as total_revenue
from retail_data
group by category
order by total_revenue desc
limit 1;

#Question 40
#Show employees whose salary is above the company average.
select *
from employees
where salary > (select avg(salary) from employees);

#Question 41
#List the daily total revenue for a specific city (Mumbai).
select transaction_date, sum(quantity * price) as daily_revenue
from retail_data
where city = 'Mumbai'
group by transaction_date
order by transaction_date;

#Question 42
#Find the top 10 customers who spent the most.
select customer_id, sum(quantity * price) as total_spent
from retail_data
group by customer_id
order by total_spent desc
limit 10;

#Question 43
#List products that have been sold in more than 20 different cities.
select p.product_name, count(distinct r.city) as cities_sold
from retail_data r
join products p on r.product_id = p.product_id
group by p.product_id
having count(distinct r.city) > 20;

#Question 44
#Calculate running total of daily revenue.
select transaction_date,
       sum(quantity * price) as daily_revenue,
       sum(sum(quantity * price)) over (order by transaction_date) as running_total
from retail_data
group by transaction_date
order by transaction_date;

#Question 45
#Find the most frequently purchased product.
select p.product_name, count(*) as times_purchased
from retail_data r
join products p on r.product_id = p.product_id
group by p.product_id
order by times_purchased desc
limit 1;
 
#Question 46
#Show the oldest employee in the company (by joining_date).
select *
from employees
order by joining_date
limit 1;

#Question 47
#Identify top 5 products causing maximum stockouts (highest demand − low inventory).
select p.product_name,
       sum(r.quantity) as total_sold,
       i.stock_quantity
from retail_data r
join products p on r.product_id = p.product_id
join inventory i on r.product_id = i.product_id
group by p.product_name, i.stock_quantity
order by total_sold desc, stock_quantity asc
limit 5;

#Question 48
#Show monthly revenue trends.
select date_format(transaction_date, '%Y-%m') as month,
       sum(quantity * price) as monthly_revenue
from retail_data
group by month
order by month;

#Question 49
#Find suppliers whose products generated more than ₹1,00,000 in sales.
select s.supplier_id, s.supplier_name, sum(r.quantity * r.price) as total_sales
from suppliers s
join products p on s.supplier_id = p.supplier_id
join retail_data r on p.product_id = r.product_id
group by s.supplier_id, s.supplier_name
having sum(r.quantity * r.price) > 100000;

#Question 50
#Show the top 5 days with the highest revenue spike using lag().
select transaction_date,
       sum(quantity * price) as daily_revenue,
       sum(quantity * price) - lag(sum(quantity * price)) 
           over (order by transaction_date) as revenue_spike
from retail_data
group by transaction_date
order by revenue_spike desc
limit 5;









