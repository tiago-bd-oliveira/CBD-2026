-- 1. KEYSPACE SETUP

CREATE KEYSPACE IF NOT EXISTS cbd 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1}
AND durable_writes = true;

USE cbd;

-- 2. TABLE CREATION

-- Table 1: Browse products by tag

CREATE TABLE IF NOT EXISTS products_by_tag (
    tag text,
    product_id uuid,
    name text,
    price decimal,
    all_tags set<text>,          
    specs map<text, text>,       
    PRIMARY KEY (tag, product_id)
) WITH CLUSTERING ORDER BY (product_id ASC);


-- Table 2: Staff inventory management by aisle

CREATE TABLE IF NOT EXISTS products_by_aisle (
    aisle int,
    product_id uuid,
    name text,
    quantity int,
    bin_locations set<text>,    
    PRIMARY KEY (aisle, product_id)
) WITH CLUSTERING ORDER BY (product_id ASC);

-- Table 3: Customer purchase history

CREATE TABLE IF NOT EXISTS purchases_by_user (
    user_email text,
    purchase_time timestamp,
    order_id uuid,
    items_list list<text>,     
    total_amount decimal,
    PRIMARY KEY (user_email, purchase_time)
) WITH CLUSTERING ORDER BY (purchase_time DESC);

-- Table 4: Low stock inventory alerts by zone

CREATE TABLE IF NOT EXISTS low_stock_alerts (
    zone text,
    product_id uuid,
    current_stock int,
    supplier_info map<text, text>,     
    restock_history list<timestamp>,   
    PRIMARY KEY (zone, product_id)
) WITH CLUSTERING ORDER BY (product_id ASC);

-- 3. SECONDARY INDEXES

CREATE INDEX IF NOT EXISTS idx_spec_keys ON products_by_tag (KEYS(specs));
CREATE INDEX IF NOT EXISTS idx_product_name ON products_by_tag (name);
CREATE INDEX IF NOT EXISTS idx_purchase_items ON purchases_by_user (VALUES(items_list));

-- 4. USER DEFINED FUNCTIONS (UDF)

-- UDF: Calculate final price with 23% VAT (Portugal standard)

DROP FUNCTION IF EXISTS fn_apply_iva(decimal);

CREATE FUNCTION IF NOT EXISTS fn_apply_iva(price decimal)
RETURNS NULL ON NULL INPUT
RETURNS decimal
LANGUAGE java
AS $$
    return price.multiply(new java.math.BigDecimal("1.23"));
$$;

-- UDF: Calculate discount based on amount
-- Input: amount (decimal), discount_percent (int)
-- Output: amount after discount applied
DROP FUNCTION IF EXISTS fn_apply_discount(decimal, int);

CREATE FUNCTION IF NOT EXISTS fn_apply_discount(amount decimal, discount_percent int)
RETURNS NULL ON NULL INPUT
RETURNS decimal
LANGUAGE java
AS $$
    java.math.BigDecimal discountFactor = 
        new java.math.BigDecimal(100 - discount_percent).divide(
            new java.math.BigDecimal(100), 
            2, 
            java.math.RoundingMode.HALF_UP
        );
    return amount.multiply(discountFactor);
$$;

-- UDF: Format product info as string
-- Input: name (text), price (decimal)
-- Output: formatted string representation
DROP FUNCTION IF EXISTS fn_format_product(text, decimal);

CREATE FUNCTION IF NOT EXISTS fn_format_product(name text, price decimal)
RETURNS NULL ON NULL INPUT
RETURNS text
LANGUAGE java
AS $$
    return name + " - €" + price.toString();
$$;

-- 5. USER DEFINED AGGREGATES (UDA)

-- UDA: Sum total revenue from decimal values

DROP AGGREGATE IF EXISTS sum_revenue(decimal);

CREATE FUNCTION IF NOT EXISTS fn_sum_revenue_state(state decimal, value decimal)
CALLED ON NULL INPUT
RETURNS decimal
LANGUAGE java
AS $$
    return state.add(value);
$$;

CREATE AGGREGATE IF NOT EXISTS sum_revenue(decimal)
SFUNC fn_sum_revenue_state
STYPE decimal
INITCOND 0;

-- UDA: Count items in list (utility aggregate)
DROP AGGREGATE IF EXISTS count_list_items(list<text>);

CREATE FUNCTION IF NOT EXISTS fn_count_list_items_state(state int, items list<text>)
CALLED ON NULL INPUT
RETURNS int
LANGUAGE java
AS $$
    if (items == null) return state;
    return state + items.size();
$$;

CREATE AGGREGATE IF NOT EXISTS count_list_items(list<text>)
SFUNC fn_count_list_items_state
STYPE int
INITCOND 0;

