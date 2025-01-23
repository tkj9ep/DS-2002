USE Northwind;

-- ----------------------------------------------------------------------------
-- 1). First, How Many Rows (Products) are in the Products Table?
-- ----------------------------------------------------------------------------
SELECT DISTINCT COUNT(*) AS product_count
FROM northwind.products;

-- ----------------------------------------------------------------------------
-- 2). Fetch Each Product Name and its Quantity per Unit
-- ----------------------------------------------------------------------------
SELECT northwind.products.product_name, northwind.products.quantity_per_unit 
FROM northwind.products;

-- ----------------------------------------------------------------------------
-- 3). Fetch the Product ID and Name of Currently Available Products
-- ----------------------------------------------------------------------------
SELECT id AS product_id, product_name
FROM northwind.products
WHERE discontinued = 0;

-- ----------------------------------------------------------------------------
-- 4). Fetch the Product ID, Name & List Price Costing Less Than $20
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
SELECT id as product_id, product_name, list_price
FROM northwind.products
WHERE list_price < 20.00
ORDER BY list_price DESC;

-- ----------------------------------------------------------------------------
-- 5). Fetch the Product ID, Name & List Price Costing Between $15 and $20
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
SELECT id,
		product_name,
		list_price
FROM northwind.products
WHERE list_price > 15.00 AND list_price < 20.00
ORDER BY list_price DESC;

-- Older (Equivalent) Syntax -----
SELECT id as product_id,
product_name,
list_price
FROM northwind.products
WHERE list_price BETWEEN 15.00 AND 20.00
ORDER BY list_price DESC;

-- ----------------------------------------------------------------------------
-- 6). Fetch the Product Name & List Price of the 10 Most Expensive Products 
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
SELECT product_name,
		list_price
FROM northwind.products
ORDER BY list_price DESC
LIMIT 10;

-- ----------------------------------------------------------------------------
-- 7). Fetch the Name & List Price of the Most & Least Expensive Products
-- ----------------------------------------------------------------------------
SELECT product_name,
		list_price
FROM northwind.products
WHERE list_price = (SELECT MAX(list_price) FROM northwind.products) 
OR list_price = (SELECT MIN(list_price) FROM northwind.products);

-- ----------------------------------------------------------------------------
-- 8). Fetch the Product Name & List Price Costing Above Average List Price
--     Sort the results with the most expensive Products first.
-- ----------------------------------------------------------------------------
SELECT product_name,
		list_price
FROM northwind.products
WHERE list_price > (SELECT AVG(list_price) FROM northwind.products);

-- ---------------------------------------------------------------------------- 
-- 9). Fetch & Label the Count of Current and Discontinued Products using
-- 	   the "CASE... WHEN" syntax to create a column named "availablity"
--     that contains the values "discontinued" and "current". 
-- ----------------------------------------------------------------------------
UPDATE northwind.products SET discontinued = 1 WHERE id IN (95, 96, 97);

-- TODO: Insert query here.
SELECT COUNT(*) 
FROM northwind.products AS P;

UPDATE northwind.products SET discontinued = 0 WHERE id in (95, 96, 97);

-- ----------------------------------------------------------------------------
-- 10). Fetch Product Name, Reorder Level, Target Level and "Reorder Threshold"
-- 	    Where Reorder Level is Less Than or Equal to 20% of Target Level
-- ----------------------------------------------------------------------------
SELECT product_name
	, reorder_level
    , target_level
    , ROUND(target_level/5, 2) as 'Reorder Threshold'
FROM northwind.products as P
WHERE reorder_level <= target_level/5;

-- ----------------------------------------------------------------------------
-- 11). Fetch the Number of Products per Category Priced Less Than $20.00
-- ----------------------------------------------------------------------------
SELECT COUNT(*) AS category_count
FROM northwind.products as P
WHERE P.list_price < 20.00
GROUP BY P.category;

-- ----------------------------------------------------------------------------
-- 12). Fetch the Number of Products per Category With Less Than 5 Units In Stock
-- ----------------------------------------------------------------------------
SELECT COUNT(*) FROM northwind.products as P;

-- ----------------------------------------------------------------------------
-- 13). Fetch Products along with their Supplier Company & Address Info
-- ----------------------------------------------------------------------------
SELECT P.product_code,
		P.product_name,
        S.company,
        S.address,
        S.city,
        S.state_province,
        S.zip_postal_code,
        S.country_region
        FROM northwind.products AS P
INNER JOIN northwind.suppliers as S
ON S.id = P.supplier_ids;

-- ----------------------------------------------------------------------------
-- 14). Fetch the Customer ID and Full Name for All Customers along with
-- 		the Order ID and Order Date for Any Orders they may have
-- ----------------------------------------------------------------------------
SELECT c.id,	
		CONCAT(c.first_name, " ", c.last_name) AS full_name,
		o.id,
        o.order_date
FROM northwind.customers as c
LEFT OUTER JOIN northwind.orders AS o
ON c.id = o.customer_id;
	

-- ----------------------------------------------------------------------------
-- 15). Fetch the Order ID and Order Date for All Orders along with
--   	the Customr ID and Full Name for Any Associated Customers
-- ----------------------------------------------------------------------------
SELECT O.id,
		O.order_date,
        C.id as customer_id,
        CONCAT(C.first_name, " ", C.last_name) AS customer_full_name
FROM northwind.customers as C
LEFT OUTER JOIN northwind.orders as O
ON C.id = O.customer_id
