{{ config(materialized='table') }}

WITH orders AS (
  SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
  FROM {{ ref('stg_orders') }}
),


order_items AS (
  SELECT
    order_id,
    order_item_id,
    MIN(product_id) AS product_id,
    MIN(seller_id) AS seller_id,
    MIN(shipping_limit_date) AS shipping_limit_date,
    SUM(SAFE_CAST(price AS FLOAT64)) AS price,
    SUM(SAFE_CAST(freight_value AS FLOAT64)) AS freight_value
  FROM {{ ref('stg_order_items') }}
  GROUP BY order_id, order_item_id
)


SELECT
  o.order_id,
  o.customer_id,
  o.order_status,
  o.order_purchase_timestamp,
  o.order_approved_at,
  o.order_delivered_carrier_date,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,
  EXTRACT(DATE FROM o.order_purchase_timestamp) AS order_date,

  oi.order_item_id,
  oi.shipping_limit_date,
  oi.product_id,
  oi.seller_id,
  oi.price,
  oi.freight_value

FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
