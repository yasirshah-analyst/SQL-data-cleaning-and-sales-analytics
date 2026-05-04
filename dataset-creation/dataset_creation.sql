-- =========================================
-- STEP 1: Create a RAW (dirty) table
-- This table stores messy real-world data (all columns as TEXT)
-- =========================================
CREATE TABLE dirty_sales (
    order_id TEXT,
    customer_name TEXT,
    city TEXT,
    order_date TEXT,
    product TEXT,
    quantity TEXT,
    price TEXT
);

-- =========================================
-- STEP 2: Insert 200 rows of fake dirty data
-- generate_series creates numbers from 1 to 200
-- each number becomes one row
-- =========================================
INSERT INTO dirty_sales
SELECT 
    gs::TEXT AS order_id,  -- convert number to text

    -- every 5th row has missing customer name
    CASE 
        WHEN gs % 5 = 0 THEN NULL
        ELSE 'Customer_' || gs
    END AS customer_name,

    -- cities are messy (different case + spaces)
    CASE 
        WHEN gs % 4 = 0 THEN 'karachi'
        WHEN gs % 4 = 1 THEN 'Karachi'
        WHEN gs % 4 = 2 THEN 'LAHORE '
        ELSE 'Islamabad'
    END AS city,

    -- dates are in different formats + some NULL
    CASE 
        WHEN gs % 6 = 0 THEN '10/02/2024'
        WHEN gs % 6 = 1 THEN '2024-01-15'
        WHEN gs % 6 = 2 THEN '2024/03/10'
        WHEN gs % 6 = 3 THEN NULL
        ELSE '2024-02-20'
    END AS order_date,

    -- products are clean (Laptop, Mobile, Tablet)
    CASE 
        WHEN gs % 3 = 0 THEN 'Laptop'
        WHEN gs % 3 = 1 THEN 'Mobile'
        ELSE 'Tablet'
    END AS product,

    -- quantity is messy (numbers + text + empty)
    CASE 
        WHEN gs % 7 = 0 THEN 'two'
        WHEN gs % 7 = 1 THEN ''
        ELSE (gs % 5 + 1)::TEXT
    END AS quantity,

    -- price is messy (valid + text + negative)
    CASE 
        WHEN gs % 8 = 0 THEN '-5000'
        WHEN gs % 8 = 1 THEN 'abc'
        ELSE (gs * 1000)::TEXT
    END AS price

FROM generate_series(1, 200) AS gs;

-- =========================================
-- STEP 3: Create duplicates (real-world issue)
-- duplicate rows for order_id 10, 20, 30
-- =========================================
INSERT INTO dirty_sales
SELECT * 
FROM dirty_sales 
WHERE order_id IN ('10','20','30');

-- check dirty data
SELECT * FROM dirty_sales;


