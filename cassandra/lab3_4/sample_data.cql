-- ============================================================================
-- Hardware Store Database - Sample Data Insertion Script
-- ============================================================================
-- This script inserts sample data for testing and demonstration
-- Run AFTER executing ddl.cql
-- ============================================================================

USE cbd;

-- ============================================================================
-- 1. SAMPLE DATA FOR products_by_tag (15 entries)
-- ============================================================================

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('power-tools', 550e8400-e29b-41d4-a716-446655440001, 'Cordless Drill', 79.99,
    {'power-tools', 'cordless', 'diy'}, {'voltage': '20V', 'battery': 'Li-ion', 'chuck': '13mm'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('power-tools', 550e8400-e29b-41d4-a716-446655440002, 'Orbital Sander', 149.99,
    {'power-tools', 'sanding', 'electric'}, {'wattage': '400W', 'speed': '12000 RPM', 'pad': '125mm'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('hand-tools', 550e8400-e29b-41d4-a716-446655440003, 'Hammer Set', 24.99,
    {'hand-tools', 'hammer', 'multi-pack'}, {'pieces': '5', 'material': 'steel', 'weight': '500g'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('hardware', 550e8400-e29b-41d4-a716-446655440004, 'Screwdriver Set', 12.99,
    {'hardware', 'hand-tools', 'screwdriver'}, {'pieces': '10', 'types': 'Phillips, Flat, Pozidriv', 'handle': 'ergonomic'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('power-tools', 550e8400-e29b-41d4-a716-446655440005, 'Impact Driver', 89.99,
    {'power-tools', 'cordless', 'diy', 'fastening'}, {'voltage': '18V', 'torque': '160Nm', 'battery': 'Li-ion'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('hand-tools', 550e8400-e29b-41d4-a716-446655440006, 'Adjustable Wrench Set', 34.99,
    {'hand-tools', 'wrench', 'multi-pack'}, {'pieces': '8', 'sizes': '6-32mm', 'material': 'Chrome-plated'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('safety', 550e8400-e29b-41d4-a716-446655440007, 'Safety Glasses', 8.99,
    {'safety', 'protection', 'ppe'}, {'uv_protection': 'yes', 'anti_fog': 'yes', 'frame': 'polycarbonate'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('safety', 550e8400-e29b-41d4-a716-446655440008, 'Work Gloves', 14.99,
    {'safety', 'protection', 'ppe', 'gloves'}, {'material': 'Nitrile', 'size': 'M-L-XL', 'grip': 'non-slip'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('hardware', 550e8400-e29b-41d4-a716-446655440009, 'Nails Assortment', 9.99,
    {'hardware', 'nails', 'fasteners'}, {'sizes': '25-100mm', 'quantity': '500pc', 'material': 'steel'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('hardware', 550e8400-e29b-41d4-a716-446655440010, 'Bolts and Nuts Set', 19.99,
    {'hardware', 'bolts', 'fasteners', 'multi-pack'}, {'sizes': 'M6-M12', 'quantity': '200pc', 'material': 'galvanized'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('power-tools', 550e8400-e29b-41d4-a716-446655440011, 'Circular Saw', 119.99,
    {'power-tools', 'saw', 'electric', 'cutting'}, {'blade_size': '7-1/4 inch', 'wattage': '1200W', 'speed': '5500 RPM'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('hand-tools', 550e8400-e29b-41d4-a716-446655440012, 'Plier Set', 29.99,
    {'hand-tools', 'pliers', 'multi-pack'}, {'pieces': '6', 'types': 'slip-joint, needle-nose, diagonal', 'handle': 'comfortable'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('safety', 550e8400-e29b-41d4-a716-446655440013, 'Hard Hat', 24.99,
    {'safety', 'protection', 'ppe', 'construction'}, {'color': 'yellow', 'certification': 'ANSI', 'weight': '300g'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('hardware', 550e8400-e29b-41d4-a716-446655440014, 'Washers Assortment', 7.99,
    {'hardware', 'fasteners', 'small-parts'}, {'sizes': 'M5-M12', 'quantity': '300pc', 'material': 'steel'});

INSERT INTO products_by_tag (tag, product_id, name, price, all_tags, specs)
VALUES ('power-tools', 550e8400-e29b-41d4-a716-446655440015, 'Jigsaw', 99.99,
    {'power-tools', 'saw', 'electric', 'cutting'}, {'wattage': '500W', 'speed': '3000 SPM', 'blade_length': '75mm'});

-- ============================================================================
-- 2. SAMPLE DATA FOR products_by_aisle (15 entries)
-- ============================================================================

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (3, 550e8400-e29b-41d4-a716-446655440001, 'Cordless Drill', 45, {'A-3-1', 'A-3-2', 'A-3-3'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (3, 550e8400-e29b-41d4-a716-446655440002, 'Orbital Sander', 12, {'A-3-4', 'A-3-5'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (2, 550e8400-e29b-41d4-a716-446655440003, 'Hammer Set', 120, {'A-2-1', 'A-2-2'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (2, 550e8400-e29b-41d4-a716-446655440004, 'Screwdriver Set', 85, {'A-2-3', 'A-2-4', 'A-2-5'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (3, 550e8400-e29b-41d4-a716-446655440005, 'Impact Driver', 32, {'A-3-6', 'A-3-7'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (2, 550e8400-e29b-41d4-a716-446655440006, 'Adjustable Wrench Set', 56, {'A-2-6', 'A-2-7'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (1, 550e8400-e29b-41d4-a716-446655440007, 'Safety Glasses', 150, {'A-1-1', 'A-1-2', 'A-1-3'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (1, 550e8400-e29b-41d4-a716-446655440008, 'Work Gloves', 200, {'A-1-4', 'A-1-5'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (4, 550e8400-e29b-41d4-a716-446655440009, 'Nails Assortment', 500, {'A-4-1', 'A-4-2', 'A-4-3'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (4, 550e8400-e29b-41d4-a716-446655440010, 'Bolts and Nuts Set', 280, {'A-4-4', 'A-4-5'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (3, 550e8400-e29b-41d4-a716-446655440011, 'Circular Saw', 8, {'A-3-8', 'A-3-9'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (2, 550e8400-e29b-41d4-a716-446655440012, 'Plier Set', 75, {'A-2-8', 'A-2-9'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (1, 550e8400-e29b-41d4-a716-446655440013, 'Hard Hat', 50, {'A-1-6', 'A-1-7'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (4, 550e8400-e29b-41d4-a716-446655440014, 'Washers Assortment', 600, {'A-4-6', 'A-4-7', 'A-4-8'});

INSERT INTO products_by_aisle (aisle, product_id, name, quantity, bin_locations)
VALUES (3, 550e8400-e29b-41d4-a716-446655440015, 'Jigsaw', 15, {'A-3-10', 'A-3-11'});

-- ============================================================================
-- 3. SAMPLE DATA FOR purchases_by_user (16 entries)
-- ============================================================================

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('joao.silva@email.pt', '2026-04-20 14:30:00+0000', 550e8400-e29b-41d4-a716-446655440010,
    ['Cordless Drill', 'Hammer Set', 'Safety Goggles'], 124.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('joao.silva@email.pt', '2026-04-15 10:15:00+0000', 550e8400-e29b-41d4-a716-446655440011,
    ['Screwdriver Set', 'Work Gloves'], 28.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('joao.silva@email.pt', '2026-04-10 09:45:00+0000', 550e8400-e29b-41d4-a716-446655440100,
    ['Impact Driver', 'Nails Assortment'], 89.98);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('joao.silva@email.pt', '2026-03-28 16:20:00+0000', 550e8400-e29b-41d4-a716-446655440101,
    ['Safety Glasses', 'Work Gloves', 'Hard Hat'], 48.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('maria.costa@email.pt', '2026-04-22 16:45:00+0000', 550e8400-e29b-41d4-a716-446655440012,
    ['Orbital Sander', 'Sandpaper Assortment'], 165.45);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('maria.costa@email.pt', '2026-04-18 11:30:00+0000', 550e8400-e29b-41d4-a716-446655440102,
    ['Circular Saw', 'Safety Glasses'], 128.98);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('maria.costa@email.pt', '2026-04-05 13:00:00+0000', 550e8400-e29b-41d4-a716-446655440103,
    ['Plier Set', 'Adjustable Wrench Set'], 64.98);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('pedro.santos@email.pt', '2026-04-25 10:00:00+0000', 550e8400-e29b-41d4-a716-446655440104,
    ['Hammer Set', 'Nails Assortment', 'Work Gloves'], 49.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('pedro.santos@email.pt', '2026-04-19 14:15:00+0000', 550e8400-e29b-41d4-a716-446655440105,
    ['Jigsaw', 'Safety Glasses'], 108.98);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('ana.ferreira@email.pt', '2026-04-24 15:30:00+0000', 550e8400-e29b-41d4-a716-446655440106,
    ['Bolts and Nuts Set', 'Washers Assortment', 'Screwdriver Set'], 40.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('ana.ferreira@email.pt', '2026-04-12 09:20:00+0000', 550e8400-e29b-41d4-a716-446655440107,
    ['Hard Hat', 'Safety Glasses', 'Work Gloves'], 48.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('carlos.oliveira@email.pt', '2026-04-21 12:45:00+0000', 550e8400-e29b-41d4-a716-446655440108,
    ['Cordless Drill', 'Impact Driver', 'Hammer Set'], 194.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('carlos.oliveira@email.pt', '2026-04-08 08:30:00+0000', 550e8400-e29b-41d4-a716-446655440109,
    ['Orbital Sander', 'Safety Glasses'], 158.98);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('sofia.gomes@email.pt', '2026-04-23 17:00:00+0000', 550e8400-e29b-41d4-a716-446655440110,
    ['Plier Set', 'Hammer Set', 'Screwdriver Set'], 67.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('sofia.gomes@email.pt', '2026-04-06 14:40:00+0000', 550e8400-e29b-41d4-a716-446655440111,
    ['Circular Saw', 'Jigsaw', 'Safety Glasses'], 228.97);

INSERT INTO purchases_by_user (user_email, purchase_time, order_id, items_list, total_amount)
VALUES ('luis.martins@email.pt', '2026-04-17 11:25:00+0000', 550e8400-e29b-41d4-a716-446655440112,
    ['Work Gloves', 'Hard Hat', 'Safety Glasses'], 48.97);

-- ============================================================================
-- 4. SAMPLE DATA FOR low_stock_alerts (15 entries)
-- ============================================================================

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-north', 550e8400-e29b-41d4-a716-446655440002, 8,
    {'supplier_name': 'ElectroTools Ltd', 'contact': '+351-21-1234567', 'lead_time': '3 days'},
    ['2026-03-15 08:00:00+0000', '2026-04-10 09:30:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-south', 550e8400-e29b-41d4-a716-446655440001, 5,
    {'supplier_name': 'ToolMasters Inc', 'contact': '+351-21-7654321', 'lead_time': '2 days'},
    ['2026-04-01 10:00:00+0000', '2026-04-20 14:20:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-north', 550e8400-e29b-41d4-a716-446655440011, 3,
    {'supplier_name': 'PowerTools Distribution', 'contact': '+351-21-9876543', 'lead_time': '5 days'},
    ['2026-03-01 07:00:00+0000', '2026-04-05 11:15:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-west', 550e8400-e29b-41d4-a716-446655440015, 6,
    {'supplier_name': 'Precision Tools Co', 'contact': '+351-22-1112223', 'lead_time': '4 days'},
    ['2026-03-20 09:30:00+0000', '2026-04-15 08:45:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-east', 550e8400-e29b-41d4-a716-446655440005, 10,
    {'supplier_name': 'Industrial Tools Supply', 'contact': '+351-23-3334445', 'lead_time': '3 days'},
    ['2026-03-10 06:00:00+0000', '2026-04-08 10:20:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-north', 550e8400-e29b-41d4-a716-446655440007, 12,
    {'supplier_name': 'Safety Equipment Ltd', 'contact': '+351-24-5556667', 'lead_time': '1 day'},
    ['2026-04-18 13:00:00+0000', '2026-04-25 14:30:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-south', 550e8400-e29b-41d4-a716-446655440013, 7,
    {'supplier_name': 'Construction Safety Inc', 'contact': '+351-25-7778889', 'lead_time': '2 days'},
    ['2026-04-10 09:00:00+0000', '2026-04-22 15:45:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-west', 550e8400-e29b-41d4-a716-446655440003, 15,
    {'supplier_name': 'Hand Tools Distributor', 'contact': '+351-26-9990001', 'lead_time': '2 days'},
    ['2026-04-05 08:30:00+0000', '2026-04-20 11:00:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-east', 550e8400-e29b-41d4-a716-446655440009, 8,
    {'supplier_name': 'Fasteners Warehouse', 'contact': '+351-27-1112223', 'lead_time': '1 day'},
    ['2026-03-25 07:30:00+0000', '2026-04-12 09:15:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-north', 550e8400-e29b-41d4-a716-446655440004, 9,
    {'supplier_name': 'Hardware Central', 'contact': '+351-28-3334445', 'lead_time': '2 days'},
    ['2026-03-30 10:00:00+0000', '2026-04-18 12:30:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-south', 550e8400-e29b-41d4-a716-446655440006, 11,
    {'supplier_name': 'Wrench & Tools Ltd', 'contact': '+351-29-5556667', 'lead_time': '3 days'},
    ['2026-04-02 08:00:00+0000', '2026-04-19 13:20:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-west', 550e8400-e29b-41d4-a716-446655440012, 6,
    {'supplier_name': 'Pliers Specialist', 'contact': '+351-30-7778889', 'lead_time': '2 days'},
    ['2026-04-08 09:45:00+0000', '2026-04-23 14:15:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-east', 550e8400-e29b-41d4-a716-446655440010, 5,
    {'supplier_name': 'Bolt & Nut World', 'contact': '+351-31-9990001', 'lead_time': '1 day'},
    ['2026-04-14 07:00:00+0000', '2026-04-26 10:30:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-north', 550e8400-e29b-41d4-a716-446655440008, 14,
    {'supplier_name': 'PPE Distributors', 'contact': '+351-32-1112223', 'lead_time': '2 days'},
    ['2026-03-28 06:00:00+0000', '2026-04-21 12:00:00+0000']);

INSERT INTO low_stock_alerts (zone, product_id, current_stock, supplier_info, restock_history)
VALUES ('warehouse-south', 550e8400-e29b-41d4-a716-446655440014, 4,
    {'supplier_name': 'Washers & Fasteners', 'contact': '+351-33-3334445', 'lead_time': '1 day'},
    ['2026-04-16 08:15:00+0000', '2026-04-27 11:45:00+0000']);

-- ============================================================================
-- 5. TEST QUERIES
-- ============================================================================

-- Uncomment the following queries to test the schema:
--
-- SELECT * FROM products_by_tag WHERE tag = 'power-tools';
-- SELECT * FROM products_by_aisle WHERE aisle = 3;
-- SELECT * FROM purchases_by_user WHERE user_email = 'joao.silva@email.pt';
-- SELECT * FROM low_stock_alerts WHERE zone = 'warehouse-north';
--
-- SELECT * FROM products_by_tag WHERE name = 'Cordless Drill' ALLOW FILTERING;
-- SELECT * FROM purchases_by_user WHERE items_list CONTAINS 'Hammer Set' ALLOW FILTERING;
--
-- Test UDF:
-- SELECT fn_apply_vat(79.99) AS price_with_vat FROM purchases_by_user LIMIT 1;
-- SELECT fn_apply_discount(100.00, 10) AS discounted_price FROM purchases_by_user LIMIT 1;
--
-- Test UDA:
-- SELECT sum_revenue(total_amount) FROM purchases_by_user;

-- ============================================================================
-- END OF SAMPLE DATA SCRIPT
-- ============================================================================
