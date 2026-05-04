-- =========================================
-- STEP 4: Create CLEAN table with correct data types
-- =========================================
CREATE TABLE clean_sales (
    order_id INT,
    customer_name TEXT,
    city TEXT,
    order_date DATE,
    product TEXT,
    quantity INT,
    price NUMERIC
);

-- =========================================
-- STEP 5: Clean data while inserting
-- =========================================
INSERT INTO clean_sales
SELECT 

-- convert order_id from text → integer
CAST(order_id AS INT),

-- replace NULL names with 'Unknown'
COALESCE(customer_name, 'Unknown'),

-- remove spaces + fix casing (Karachi, Lahore)
INITCAP(TRIM(city)),

-- fix date formats and convert to DATE
CASE 
    WHEN order_date IS NULL THEN NULL
    
    -- format: 10/02/2024
    WHEN order_date LIKE '__/__/____' THEN 
        TO_DATE(order_date, 'DD/MM/YYYY')
    
    -- format: 2024-01-15
    WHEN order_date LIKE '____-__-__' THEN 
        TO_DATE(order_date, 'YYYY-MM-DD')
    
    -- format: 2024/03/10
    WHEN order_date LIKE '____/__/__' THEN 
        TO_DATE(order_date, 'YYYY/MM/DD')
    
    ELSE NULL
END,

-- product already clean
product,

-- fix quantity (text → number)
CASE 
    WHEN quantity ~ '^[0-9]+$' THEN CAST(quantity AS INT) -- valid numbers
    WHEN LOWER(quantity) = 'two' THEN 2 -- convert 'two' → 2
    ELSE NULL -- empty or invalid → NULL
END,

-- fix price (remove invalid values)
CASE 
    WHEN price ~ '^[0-9]+$' THEN CAST(price AS NUMERIC) -- keep valid numbers
    ELSE NULL -- remove 'abc' and negative values
END

FROM dirty_sales;

-- =========================================
-- STEP 6: Remove duplicate rows
-- keep only one row per order_id
-- =========================================
DELETE FROM clean_sales
WHERE ctid NOT IN (
    SELECT MIN(ctid)  -- keep first row
    FROM clean_sales
    GROUP BY order_id
);

-- =========================================
-- STEP 7: Final clean dataset
-- =========================================
SELECT * FROM clean_sales;


