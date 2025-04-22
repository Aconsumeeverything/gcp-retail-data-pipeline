{{ config(materialized='view') }}

SELECT
  order_id,
  order_item_id,
  product_id,
  seller_id,
  SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', shipping_limit_date) AS shipping_limit_date,
  SAFE_CAST(price AS FLOAT64) AS price,
  SAFE_CAST(freight_value AS FLOAT64) AS freight_value
FROM {{ source('bronze', 'order_items') }}
