{{ config(materialized='table') }}

WITH orders AS (
  SELECT 
    order_id,
    customer_id,
    order_date,
    COUNT(order_item_id) AS number_of_items,
    SUM(SAFE_CAST(price AS FLOAT64)) AS total_price,
    SUM(SAFE_CAST(freight_value AS FLOAT64)) AS total_freight,
    MIN(product_id) AS product_id,
    MIN(seller_id) AS seller_id
  FROM {{ ref('dim_orders') }}
  GROUP BY order_id, customer_id, order_date
),

payments AS (
  SELECT * FROM {{ ref('stg_order_payments') }}
),

reviews AS (
  SELECT order_id, review_score
  FROM {{ ref('dim_reviews') }}
),

customers AS (
  SELECT customer_unique_id, zip_code_prefix
  FROM {{ ref('dim_customers') }}
),

products AS (
  SELECT product_id, product_category_name_english
  FROM {{ ref('dim_products') }}
),

sellers AS (
  SELECT seller_id, seller_zip_code_prefix
  FROM {{ ref('dim_sellers') }}
),

geos AS (
  SELECT zip_code_prefix, lat, lng
  FROM {{ ref('dim_geolocation') }}
),

dates AS (
  SELECT calendar_date, date_id
  FROM {{ ref('dim_dates') }}
)

SELECT
  o.order_id,
  o.customer_id,
  o.product_id,
  o.seller_id,
  d.date_id,
  d.calendar_date AS order_date,

  -- Customer geo
  c.zip_code_prefix AS customer_zip_code,
  gc.lat AS customer_lat,
  gc.lng AS customer_lng,

  -- Seller geo
  s.seller_zip_code_prefix AS seller_zip_code,
  gs.lat AS seller_lat,
  gs.lng AS seller_lng,

  -- Product category
  p.product_category_name_english,

  -- Metrics
  o.number_of_items,
  o.total_price,
  o.total_freight,
  pmt.total_payment,
  pmt.payment_type,
  r.review_score

FROM orders o
LEFT JOIN payments pmt ON o.order_id = pmt.order_id
LEFT JOIN reviews r ON o.order_id = r.order_id
LEFT JOIN customers c ON o.customer_id = c.customer_unique_id
LEFT JOIN products p ON o.product_id = p.product_id
LEFT JOIN sellers s ON o.seller_id = s.seller_id
LEFT JOIN geos gc ON c.zip_code_prefix = gc.zip_code_prefix
LEFT JOIN geos gs ON s.seller_zip_code_prefix = gs.zip_code_prefix
LEFT JOIN dates d ON o.order_date = d.calendar_date
