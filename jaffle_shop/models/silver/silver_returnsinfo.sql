WITH returns AS (
    SELECT 
        sales_id, 
        product_sk,
        store_sk,
        returned_qty,
        refund_amount
    FROM {{ ref('bronze_returns') }}
),
stores AS (
    SELECT 
        store_sk, 
        store_name
    FROM {{ ref('bronze_store') }}
),
 products AS (
    SELECT 
        product_sk, 
        category
    FROM {{ ref('bronze_product') }}
),
sales AS (
    SELECT
        sales_id,
        gross_amount
    FROM {{ ref('bronze_sales') }}
),

Joined_query as (
SELECT 
    bs.sales_id, 
    bp.category, 
    st.store_name, 
    bs.refund_amount,
    bs.returned_qty,
    s.gross_amount
FROM returns AS bs
Join stores AS st ON bs.store_sk = st.store_sk
JOIN products AS bp ON bs.product_sk = bp.product_sk
JOIN sales AS s ON bs.sales_id = s.sales_id
)

SELECT 
    category, 
    store_name, 
    {{ refund_rate('refund_amount','returned_qty','gross_amount') }} AS refund_rate_pct
FROM Joined_query
GROUP BY category, store_name



