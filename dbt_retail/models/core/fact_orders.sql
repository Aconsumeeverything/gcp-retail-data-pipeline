{{ config(materialized='table') }}

WITH orders AS (
  SELECT * FROM {{ ref('stg_orders') }}
),

order_items AS (
  SELECT * FROM {{ ref('stg_order_items') }}
),

payments AS (
  SELECT * FROM {{ ref('stg_order_payments') }}
),

reviews AS (
  SELECT * FROM {{ ref('stg_reviews') }}
)

SELECT
  o.order_id,
  o.customer_id,
  o.order_status,
  o.order_date,
  o.order_purchase_timestamp,
  o.order_approved_at,
  o.order_delivered_carrier_date,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,

  -- Payments
  p.total_payment,
  p.payment_type,

  -- Reviews
  r.review_score,
  r.review_creation_date,
  r.review_answer_timestamp,


  COUNT(oi.order_item_id) AS number_of_items,
  SUM(oi.price) AS total_price,
  SUM(oi.freight_value) AS total_freight,

  -- Foreign keys for dimensions
  MIN(oi.product_id) AS product_id,   
  MIN(oi.seller_id) AS seller_id      
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
LEFT JOIN reviews r ON o.order_id = r.order_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id

GROUP BY
  o.order_id,
  o.customer_id,
  o.order_status,
  o.order_date,
  o.order_purchase_timestamp,
  o.order_approved_at,
  o.order_delivered_carrier_date,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,
  p.total_payment,
  p.payment_type,
  r.review_score,
  r.review_creation_date,
  r.review_answer_timestamp
