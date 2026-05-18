USE hardware_store;

-- Query 1: Browse all products by tag (e.g., find all power-tools)

SELECT product_id, name, price, all_tags, specs 
FROM products_by_tag 
WHERE tag = 'power-tools'
LIMIT 20;

-- Query 2: Find products by name using secondary index

SELECT tag, product_id, name, price, specs 
FROM products_by_tag 
WHERE name = 'Cordless Drill' 
;

-- Query 3: Find products with specific specification type using index
-- Note: Uses KEYS(specs) index

SELECT tag, product_id, name, price, specs 
FROM products_by_tag 
WHERE specs CONTAINS KEY 'voltage' 
;

-- Query 4: Browse inventory by aisle for staff management

SELECT product_id, name, quantity, bin_locations 
FROM products_by_aisle 
WHERE aisle = 3
LIMIT 20;


-- Query 5: Find customer's purchase history (most recent first)
-- Note: Results are automatically ordered by purchase_time DESC due to clustering order

SELECT purchase_time, order_id, items_list, total_amount 
FROM purchases_by_user 
WHERE user_email = 'joao.silva@email.pt'
LIMIT 10;

-- Query 6: Find purchases containing a specific item using list index
-- Note: Uses VALUES(items_list) index

SELECT user_email, purchase_time, order_id, items_list, total_amount 
FROM purchases_by_user 
WHERE items_list CONTAINS 'Hammer Set' 
;

-- Query 7: Check low stock alerts by warehouse zone

SELECT product_id, current_stock, supplier_info, restock_history 
FROM low_stock_alerts 
WHERE zone = 'warehouse-north'
LIMIT 20;

-- Query 8: Calculate total revenue from customer using UDA
-- Note: Uses custom UDA sum_revenue(decimal)

SELECT user_email, sum_revenue(total_amount) AS total_spent 
FROM purchases_by_user 
WHERE user_email = 'carlos.oliveira@email.pt'
GROUP BY user_email;

-- Query 9: Apply VAT calculation to product prices using UDF
-- Note: Uses custom UDF fn_apply_vat(decimal)

SELECT name, price, fn_apply_vat(price) AS price_with_vat 
FROM products_by_tag 
WHERE tag = 'hand-tools'
LIMIT 10;

-- Query 10: Apply discount and calculate final price using UDF
-- Note: Uses custom UDF fn_apply_discount(decimal, int) and fn_apply_vat(decimal)

SELECT name, price, 
    fn_apply_discount(price, 15) AS discounted_price,
    fn_apply_vat(fn_apply_discount(price, 15)) AS discounted_price_with_vat
FROM products_by_tag 
WHERE tag = 'safety'
LIMIT 10;

