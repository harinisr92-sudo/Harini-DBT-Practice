WITH sales AS (
    SELECT 
        sales_id, 
        product_sk,
        customer_sk,
        {{  multiply('unit_price', 'quantity') }} AS calculated_gross_amount,
        gross_amount, 
        payment_method
    FROM {{ ref('bronze_sales') }}
),
 products AS (
    SELECT 
        product_sk, 
        category
    FROM {{ ref('bronze_product') }}
),
customers AS (
    SELECT 
        customer_sk, 
        gender
    FROM {{ ref('bronze_customer') }}
),
Joined_query as (
SELECT 
    bs.sales_id, 
    bp.category, 
    bc.gender, 
    bs.calculated_gross_amount,
    bs.payment_method
FROM sales AS bs
JOIN products AS bp ON bs.product_sk = bp.product_sk
JOIN customers AS bc ON bs.customer_sk = bc.customer_sk
)

SELECT 
    category, 
    gender, 
    SUM(calculated_gross_amount) AS total_gross_amount
FROM Joined_query
GROUP BY category, gender



