-- =====================================================
-- FOOD DELIVERY SQL ANALYSIS PROJECT
-- Database: MySQL 8.0
-- Level: Basic to Advanced
-- =====================================================


-- =====================================================
-- 1. BASIC SQL QUERIES
-- =====================================================

-- 1. Display all customers
SELECT *
FROM customers;


-- 2. Display all restaurants
SELECT *
FROM restaurants;


-- 3. Display all orders
SELECT *
FROM orders;


-- 4. Display all order items
SELECT *
FROM order_items;


-- 5. Display customer names and cities
SELECT customer_name, city
FROM customers;


-- 6. Display restaurant names and cuisines
SELECT restaurant_name, cuisine
FROM restaurants;


-- 7. Display orders with amount greater than 500
SELECT *
FROM orders
WHERE order_amount > 500;


-- 8. Display completed orders
SELECT *
FROM orders
WHERE delivery_status = 'Delivered';


-- 9. Display orders sorted by highest amount
SELECT *
FROM orders
ORDER BY order_amount DESC;


-- 10. Display top 5 highest-value orders
SELECT *
FROM orders
ORDER BY order_amount DESC
LIMIT 5;



-- =====================================================
-- 2. AGGREGATE FUNCTIONS
-- =====================================================

-- 11. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;


-- 12. Total revenue
SELECT SUM(order_amount) AS total_revenue
FROM orders;


-- 13. Average order value
SELECT AVG(order_amount) AS average_order_value
FROM orders;


-- 14. Highest order amount
SELECT MAX(order_amount) AS highest_order
FROM orders;


-- 15. Lowest order amount
SELECT MIN(order_amount) AS lowest_order
FROM orders;


-- 16. Total quantity of food items ordered
SELECT SUM(quantity) AS total_quantity
FROM order_items;



-- =====================================================
-- 3. GROUP BY & HAVING
-- =====================================================

-- 17. Number of orders by delivery status
SELECT delivery_status, COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_status;


-- 18. Revenue by payment method
SELECT payment_method,
       SUM(order_amount) AS total_revenue
FROM orders
GROUP BY payment_method;


-- 19. Number of customers by city
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city;


-- 20. Number of restaurants by cuisine
SELECT cuisine, COUNT(*) AS total_restaurants
FROM restaurants
GROUP BY cuisine;


-- 21. Average restaurant rating by city
SELECT city, AVG(rating) AS average_rating
FROM restaurants
GROUP BY city;


-- 22. Customers who placed more than 2 orders
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;



-- =====================================================
-- 4. JOINS
-- =====================================================

-- 23. Orders with customer names
SELECT o.order_id,
       c.customer_name,
       o.order_date,
       o.order_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;


-- 24. Orders with restaurant names
SELECT o.order_id,
       r.restaurant_name,
       o.order_date,
       o.order_amount
FROM orders o
JOIN restaurants r
ON o.restaurant_id = r.restaurant_id;


-- 25. Orders with customer and restaurant names
SELECT o.order_id,
       c.customer_name,
       r.restaurant_name,
       o.order_date,
       o.order_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN restaurants r
ON o.restaurant_id = r.restaurant_id;


-- 26. Complete order details
SELECT o.order_id,
       c.customer_name,
       r.restaurant_name,
       r.cuisine,
       o.order_date,
       o.order_amount,
       o.delivery_status,
       o.payment_method
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN restaurants r
ON o.restaurant_id = r.restaurant_id;



-- =====================================================
-- 5. CUSTOMER ANALYSIS
-- =====================================================

-- 27. Total orders placed by each customer
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;


-- 28. Total spending by each customer
SELECT c.customer_id,
       c.customer_name,
       SUM(o.order_amount) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;


-- 29. Top 5 customers by spending
SELECT c.customer_id,
       c.customer_name,
       SUM(o.order_amount) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 5;


-- 30. Average spending per customer
SELECT c.customer_id,
       c.customer_name,
       AVG(o.order_amount) AS average_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;



-- =====================================================
-- 6. RESTAURANT ANALYSIS
-- =====================================================

-- 31. Total orders received by each restaurant
SELECT r.restaurant_id,
       r.restaurant_name,
       COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_orders DESC;


-- 32. Total revenue generated by each restaurant
SELECT r.restaurant_id,
       r.restaurant_name,
       SUM(o.order_amount) AS total_revenue
FROM restaurants r
JOIN orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC;


-- 33. Top 5 restaurants by revenue
SELECT r.restaurant_name,
       SUM(o.order_amount) AS total_revenue
FROM restaurants r
JOIN orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC
LIMIT 5;


-- 34. Restaurants with rating greater than 4
SELECT *
FROM restaurants
WHERE rating > 4;



-- =====================================================
-- 7. FOOD ITEM ANALYSIS
-- =====================================================

-- 35. Total quantity sold for each food item
SELECT food_items,
       SUM(quantity) AS total_quantity
FROM order_items
GROUP BY food_items
ORDER BY total_quantity DESC;


-- 36. Most ordered food items
SELECT food_items,
       SUM(quantity) AS total_quantity
FROM order_items
GROUP BY food_items
ORDER BY total_quantity DESC
LIMIT 5;


-- 37. Revenue generated by each food item
SELECT food_items,
       SUM(quantity * price) AS food_revenue
FROM order_items
GROUP BY food_items
ORDER BY food_revenue DESC;


-- 38. Highest priced food item
SELECT food_items, price
FROM order_items
ORDER BY price DESC
LIMIT 1;



-- =====================================================
-- 8. SUBQUERIES
-- =====================================================

-- 39. Orders greater than average order amount
SELECT *
FROM orders
WHERE order_amount >
      (SELECT AVG(order_amount)
       FROM orders);


-- 40. Customer who spent the most
SELECT customer_id,
       SUM(order_amount) AS total_spending
FROM orders
GROUP BY customer_id
HAVING SUM(order_amount) =
       (SELECT MAX(total_spending)
        FROM
        (
            SELECT SUM(order_amount) AS total_spending
            FROM orders
            GROUP BY customer_id
        ) x);


-- 41. Restaurants with revenue above average restaurant revenue
SELECT restaurant_id,
       SUM(order_amount) AS revenue
FROM orders
GROUP BY restaurant_id
HAVING SUM(order_amount) >
       (
           SELECT AVG(revenue)
           FROM
           (
               SELECT SUM(order_amount) AS revenue
               FROM orders
               GROUP BY restaurant_id
           ) x
       );



-- =====================================================
-- 9. CASE STATEMENT
-- =====================================================

-- 42. Categorize orders by amount
SELECT order_id,
       order_amount,
       CASE
           WHEN order_amount < 300 THEN 'Low'
           WHEN order_amount BETWEEN 300 AND 700 THEN 'Medium'
           ELSE 'High'
       END AS order_category
FROM orders;


-- 43. Categorize restaurants by rating
SELECT restaurant_name,
       rating,
       CASE
           WHEN rating >= 4.5 THEN 'Excellent'
           WHEN rating >= 4 THEN 'Good'
           ELSE 'Average'
       END AS rating_category
FROM restaurants;



-- =====================================================
-- 10. DATE ANALYSIS
-- =====================================================

-- 44. Orders by date
SELECT order_date,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;


-- 45. Revenue by date
SELECT order_date,
       SUM(order_amount) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;


-- 46. Monthly revenue
SELECT YEAR(order_date) AS year,
       MONTH(order_date) AS month,
       SUM(order_amount) AS monthly_revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;



-- =====================================================
-- 11. CTE
-- =====================================================

-- 47. Total spending of each customer using CTE
WITH customer_spending AS
(
    SELECT customer_id,
           SUM(order_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
ORDER BY total_spending DESC;


-- 48. Top customers using CTE
WITH customer_spending AS
(
    SELECT customer_id,
           SUM(order_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
WHERE total_spending > 1000
ORDER BY total_spending DESC;



-- =====================================================
-- 12. WINDOW FUNCTIONS
-- =====================================================

-- 49. Rank customers by total spending
WITH customer_spending AS
(
    SELECT customer_id,
           SUM(order_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id,
       total_spending,
       RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
FROM customer_spending;


-- 50. Rank restaurants by revenue
WITH restaurant_revenue AS
(
    SELECT restaurant_id,
           SUM(order_amount) AS total_revenue
    FROM orders
    GROUP BY restaurant_id
)
SELECT restaurant_id,
       total_revenue,
       RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM restaurant_revenue;



-- =====================================================
-- END OF FOOD DELIVERY SQL ANALYSIS PROJECT
-- =====================================================
