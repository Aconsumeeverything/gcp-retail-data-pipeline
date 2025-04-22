{{ config(materialized='view') }}

SELECT
  order_id,
  customer_id,
  order_status,
  SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', order_purchase_timestamp) AS order_purchase_timestamp,
  EXTRACT(DATE FROM SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', order_purchase_timestamp)) AS order_date,
  SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', order_approved_at) AS order_approved_at,
  SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', order_delivered_carrier_date) AS order_delivered_carrier_date,
  SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', order_delivered_customer_date) AS order_delivered_customer_date,
  SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', order_estimated_delivery_date) AS order_estimated_delivery_date
FROM {{ source('bronze', 'orders') }}
