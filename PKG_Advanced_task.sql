-----------------------PHASE 1: COMPLEX DATA MODEL (RELATIONAL DEPTH)--------------------------
--🔹 Core Tables

--Suppliers
--supplier_id (PK)
--name
--rating (CHECK 1–5)

--Warehouses
--warehouse_id (PK)
--city

--Products
--product_id (PK)
--name
--category
--base_price

--Inventory
--inventory_id (PK)
--product_id (FK)
--warehouse_id (FK)
--stock

--Orders
--order_id (PK)
--customer_id
--order_date

--Order_Items
--order_id (FK)
--product_id (FK)
--quantity
--selling_price


--Add Advanced Constraints
--Composite PK (order_id, product_id)
--CHECK (stock ≥ 0)
--ON DELETE CASCADE
--UNIQUE constraints


CREATE TABLE SUPPLIERS(
SUPPLIERS_ID NUMBER(9),
NAME VARCHAR2(60),
RATING NUMBER(1) CONSTRAINT chk_rating_suppliers CHECK (rating IN (1,2,3,4,5))
);

CREATE TABLE WAREHOUSES(
Warehouse_id NUMBER(9) PRIMARY KEY,
CITY VARCHAR2(50) UNIQUE
);

CREATE TABLE PRODUCTS(
Product_id NUMBER(9) PRIMARY KEY,
Name VARCHAR2(90),
Category VARCHAR2(45),
Base_price NUMBER(10)
);

CREATE TABLE INVENTORY(
Inventory_id NUMBER(9) PRIMARY KEY,
Product_id NUMBER(9),
Warehouse_id NUMBER(9),
Stock NUMBER(9) CONSTRAINT chk_stock_inventory CHECK (Stock >= 0),
CONSTRAINT fk_prod_id_inventory FOREIGN KEY (product_id) REFERENCES PRODUCTS(Product_id),
CONSTRAINT fk_ware_id_inventory FOREIGN KEY (warehouse_id) REFERENCES WAREHOUSES(warehouse_id)
);

CREATE TABLE ORDERS(
Order_id NUMBER(9) PRIMARY KEY,
Customer_id NUMBER(9),
Order_date NUMBER(9)
);


CREATE TABLE ORDERS_ITEMS(
Order_id NUMBER(9),
Product_id NUMBER(9),
Quantity NUMBER(9),
Selling_Price NUMBER(9),
CONSTRAINT pk_order_idxproduct_id PRIMARY KEY (Order_id, Product_id),
CONSTRAINT fk_ordr_id_orders FOREIGN KEY (order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE,
CONSTRAINT fk_pro_id_product FOREIGN KEY (Product_id) REFERENCES PRODUCTS(Product_id)
);

CREATE TABLE SUPPLIER_PRODUCTS(
    suppliers_id NUMBER(9),
    product_id NUMBER(9),
    PRIMARY KEY (suppliers_id, product_id),
    FOREIGN KEY (suppliers_id) REFERENCES SUPPLIERS(suppliers_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);

--------------------------------------INSERTING RECORDS----------------------------------------
INSERT INTO SUPPLIERS VALUES (1, 'Alpha Traders', 5);
INSERT INTO SUPPLIERS VALUES (2, 'Beta Supplies', 4);
INSERT INTO SUPPLIERS VALUES (3, 'Gamma Distributors', 3);
INSERT INTO SUPPLIERS VALUES (4, 'Delta Wholesale', 2);
INSERT INTO SUPPLIERS VALUES (5, 'Epsilon Corp', 1);

INSERT INTO WAREHOUSES VALUES (101, 'Lahore');
INSERT INTO WAREHOUSES VALUES (102, 'Karachi');
INSERT INTO WAREHOUSES VALUES (103, 'Islamabad');
INSERT INTO WAREHOUSES VALUES (104, 'Faisalabad');
INSERT INTO WAREHOUSES VALUES (105, 'Multan');

INSERT INTO PRODUCTS VALUES (201, 'Laptop', 'Electronics', 120000);
INSERT INTO PRODUCTS VALUES (202, 'Smartphone', 'Electronics', 80000);
INSERT INTO PRODUCTS VALUES (203, 'Headphones', 'Electronics', 5000);
INSERT INTO PRODUCTS VALUES (204, 'Office Chair', 'Furniture', 15000);
INSERT INTO PRODUCTS VALUES (205, 'Desk Table', 'Furniture', 25000);
INSERT INTO PRODUCTS VALUES (206, 'Water Bottle', 'Accessories', 800);
INSERT INTO PRODUCTS VALUES (207, 'Backpack', 'Accessories', 3000);
INSERT INTO PRODUCTS VALUES (208, 'LED TV', 'Electronics', 150000);

INSERT INTO INVENTORY VALUES (301, 201, 101, 10);
INSERT INTO INVENTORY VALUES (302, 202, 102, 25);
INSERT INTO INVENTORY VALUES (303, 203, 103, 50);
INSERT INTO INVENTORY VALUES (304, 204, 104, 15);
INSERT INTO INVENTORY VALUES (305, 205, 105, 8);
INSERT INTO INVENTORY VALUES (306, 206, 101, 100);
INSERT INTO INVENTORY VALUES (307, 207, 102, 40);
INSERT INTO INVENTORY VALUES (308, 208, 103, 5);
INSERT INTO INVENTORY VALUES (309, 201, 104, 7);
INSERT INTO INVENTORY VALUES (310, 202, 105, 12);

INSERT INTO ORDERS VALUES (401, 1001, 20240101);
INSERT INTO ORDERS VALUES (402, 1002, 20240105);
INSERT INTO ORDERS VALUES (403, 1003, 20240110);
INSERT INTO ORDERS VALUES (404, 1001, 20240112);
INSERT INTO ORDERS VALUES (405, 1004, 20240115);

INSERT INTO ORDERS_ITEMS VALUES (401, 201, 1, 125000);
INSERT INTO ORDERS_ITEMS VALUES (401, 203, 2, 5500);

INSERT INTO ORDERS_ITEMS VALUES (402, 202, 1, 82000);
INSERT INTO ORDERS_ITEMS VALUES (402, 206, 3, 900);

INSERT INTO ORDERS_ITEMS VALUES (403, 204, 1, 16000);
INSERT INTO ORDERS_ITEMS VALUES (403, 205, 1, 26000);

INSERT INTO ORDERS_ITEMS VALUES (404, 208, 1, 155000);

INSERT INTO ORDERS_ITEMS VALUES (405, 207, 2, 3200);
INSERT INTO ORDERS_ITEMS VALUES (405, 203, 1, 5200);

INSERT INTO SUPPLIERS VALUES (6, 'Zeta Imports', 5);
INSERT INTO SUPPLIERS VALUES (7, 'Eta Logistics', 3);
INSERT INTO SUPPLIERS VALUES (8, 'Theta Global', 4);
INSERT INTO SUPPLIERS VALUES (9, 'Iota Traders', 2);
INSERT INTO SUPPLIERS VALUES (10, 'Kappa Supply Chain', 5);

INSERT INTO WAREHOUSES VALUES (106, 'Peshawar');
INSERT INTO WAREHOUSES VALUES (107, 'Quetta');
INSERT INTO WAREHOUSES VALUES (108, 'Sialkot');
INSERT INTO WAREHOUSES VALUES (109, 'Hyderabad');
INSERT INTO WAREHOUSES VALUES (110, 'Gujranwala');

INSERT INTO PRODUCTS VALUES (209, 'Tablet', 'Electronics', 60000);
INSERT INTO PRODUCTS VALUES (210, 'Gaming Console', 'Electronics', 90000);
INSERT INTO PRODUCTS VALUES (211, 'Sofa Set', 'Furniture', 80000);
INSERT INTO PRODUCTS VALUES (212, 'Dining Table', 'Furniture', 70000);
INSERT INTO PRODUCTS VALUES (213, 'Keyboard', 'Accessories', 2000);
INSERT INTO PRODUCTS VALUES (214, 'Mouse', 'Accessories', 1500);
INSERT INTO PRODUCTS VALUES (215, 'Smart Watch', 'Electronics', 25000);
INSERT INTO PRODUCTS VALUES (216, 'Air Conditioner', 'Electronics', 120000);

INSERT INTO INVENTORY VALUES (311, 209, 106, 20);
INSERT INTO INVENTORY VALUES (312, 210, 107, 6);
INSERT INTO INVENTORY VALUES (313, 211, 108, 4);
INSERT INTO INVENTORY VALUES (314, 212, 109, 9);
INSERT INTO INVENTORY VALUES (315, 213, 110, 150);
INSERT INTO INVENTORY VALUES (316, 214, 101, 200);
INSERT INTO INVENTORY VALUES (317, 215, 102, 18);
INSERT INTO INVENTORY VALUES (318, 216, 103, 3);   -- very low stock
INSERT INTO INVENTORY VALUES (319, 209, 104, 11);
INSERT INTO INVENTORY VALUES (320, 210, 105, 7);

INSERT INTO ORDERS VALUES (406, 1005, 20240118);
INSERT INTO ORDERS VALUES (407, 1002, 20240120);
INSERT INTO ORDERS VALUES (408, 1006, 20240122);
INSERT INTO ORDERS VALUES (409, 1001, 20240125);
INSERT INTO ORDERS VALUES (410, 1007, 20240128);
INSERT INTO ORDERS VALUES (411, 1003, 20240201);
INSERT INTO ORDERS VALUES (412, 1008, 20240203);

INSERT INTO ORDERS VALUES (406, 1005, 20240118);
INSERT INTO ORDERS VALUES (407, 1002, 20240120);
INSERT INTO ORDERS VALUES (408, 1006, 20240122);
INSERT INTO ORDERS VALUES (409, 1001, 20240125);
INSERT INTO ORDERS VALUES (410, 1007, 20240128);
INSERT INTO ORDERS VALUES (411, 1003, 20240201);
INSERT INTO ORDERS VALUES (412, 1008, 20240203);

------------------------------------------------------------------------------------------------------------------------
SELECT * FROM ORDERS;
SELECT * FROM INVENTORY;
SELECT * FROM PRODUCTS;
SELECT * FROM WAREHOUSES;
SELECT * FROM ORDERS_ITEMS;
SELECT * FROM SUPPLIERS;
SELECT * FROM SUPPLIER_PRODUCTS;

-----------------------------PHASE 2: SQL DEPTH CHALLENGES (THIS IS THE CORE 💀)---------------------
/*1. Multi-Level Nested Query (3 Layers)
👉 Find:
Customers who bought products that are:
supplied by top-rated suppliers
AND stored in warehouses with lowest stock

This requires:
nested subqueries inside subqueries
aggregation inside subquery

*/

SELECT CUSTOMER_ID FROM ORDERS 
WHERE ORDER_ID = (SELECT ORDER_ID FROM ORDERS_ITEMS 
WHERE  PRODUCT_ID IN (SELECT I.PRODUCT_ID FROM INVENTORY I
INNER JOIN WAREHOUSES W
ON I.WAREHOUSE_ID = W.WAREHOUSE_ID
INNER JOIN SUPPLIER_PRODUCTS SP
ON SP.PRODUCT_ID = I.PRODUCT_ID
WHERE I.STOCK IN (SELECT MIN(STOCK) FROM INVENTORY)
AND SP.SUPPLIERS_ID IN (SELECT SUPPLIERS_ID FROM SUPPLIERS
                    WHERE RATING = 5)));


--------------------------------------------------------------------------------------------------------------
--Products priced above average price of their category

SELECT * FROM PRODUCTS P
WHERE BASE_PRICE > (SELECT AVG(BASE_PRICE) AS E FROM PRODUCTS PS 
                WHERE PS.CATEGORY = P.CATEGORY);


--------------------------------------------------------------------------------------------------------------
--👉 Customers who bought all products of a category
SELECT CUSTOMER_ID FROM ORDERS O
INNER JOIN ORDERS_ITEMS OI
ON O.ORDER_ID = OI.ORDER_ID
RIGHT JOIN PRODUCTS P
ON OI.PRODUCT_ID = P.PRODUCT_ID
WHERE OI.PRODUCT_ID IS NOT NULL
GROUP BY CUSTOMER_ID;

--------------------------------------------------------------------------------------------------------------
--👉 Rank customers by total spending
SELECT O.CUSTOMER_ID, RANK() OVER (ORDER BY SUM(QUANTITY * BASE_PRICE) DESC) AS RANK
FROM ORDERS O 
INNER JOIN ORDERS_ITEMS OI
ON O.ORDER_ID = OI.ORDER_ID
INNER JOIN PRODUCTS P
ON OI.PRODUCT_ID = P.PRODUCT_ID
GROUP BY O.CUSTOMER_ID;

--------------------------------------------------------------------------------------------------------------
--👉 Find products frequently bought together
SELECT * FROM ORDERS O
INNER JOIN ORDERS_ITEMS OI
ON O.ORDER_ID = OI.ORDER_ID
ORDER BY ORDER_DATE;


--------------------------------------------------------------------------------------------------------------
--Customers who:
--bought Electronics
--but NOT Furniture

SELECT O.Customer_id FROM ORDERS O
INNER JOIN ORDERS_ITEMS OI
ON OI.ORDER_ID = O.ORDER_ID
INNER JOIN PRODUCTS P
ON P.PRODUCT_ID = OI.PRODUCT_ID
WHERE OI.PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCTS 
        WHERE CATEGORY = 'Electronics') AND
OI.PRODUCT_ID NOT IN (SELECT PRODUCT_ID FROM PRODUCTS
        WHERE CATEGORY = 'Furniture')
GROUP BY O.CUSTOMER_ID;


--------------------------------------------------------------------------------------------------------------
--Categorize products:
--High demand
--Medium
--Low

SELECT O.PRODUCT_ID,
CASE
    WHEN COUNT(PRODUCT_ID) <= 1 THEN 'Low'
    WHEN COUNT(PRODUCT_ID) BETWEEN 2 AND 3 THEN 'Medium'
    WHEN COUNT(PRODUCT_ID) > 3 THEN 'High demand' 
    ELSE 'NA'
    END AS DEMAND
FROM ORDERS_ITEMS O
GROUP BY O.PRODUCT_ID;
SELECT * FROM ORDERS_ITEMS;


--------------------------------------------------------------------------------------------------------------
--👉 Find:
--Active customers
--Inactive customers

SELECT * FROM ORDERS;
SELECT * FROM ORDERS_ITEMS;
 
SELECT DISTINCT CUSTOMER_ID FROM ORDERS O
WHERE EXISTS (SELECT ORDER_ID FROM ORDERS_ITEMS OI
                        WHERE O.ORDER_ID = OI.ORDER_ID);


---------------------------------------------------------------------------------------------------------
CREATE PACKAGE supply_chain_pkg
AS



END supply_chain_pkg;
/