SELECT * FROM northwind_dw.fact_orders;

SELECT * FROM northwind_dw.dim_date;

SELECT fo.order_date, dd.full_date, dd_date_key AS order_date_key 
FROM northwind_dw.dim_date AS fo
INNER JOIN northwind_dw.dim_date AS dd
ON DATE(fo.order_date) = dd.full_date;