#!/bin/bash

PROJECT_ID="retail-data-pipeline-457208"
BUCKET_NAME="retail-bucket-anass-debug-457208"
DATASET="bronze"
LOCATION="US"

echo "📊 Recreating external tables in BigQuery..."

# === CUSTOMERS ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.customers\` (
  customer_id STRING,
  customer_unique_id STRING,
  customer_zip_code_prefix STRING,
  customer_city STRING,
  customer_state STRING
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_customers_dataset.csv']
);"

# === ORDERS ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.orders\` (
  order_id STRING,
  customer_id STRING,
  order_status STRING,
  order_purchase_timestamp TIMESTAMP,
  order_approved_at TIMESTAMP,
  order_delivered_carrier_date TIMESTAMP,
  order_delivered_customer_date TIMESTAMP,
  order_estimated_delivery_date TIMESTAMP
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_orders_dataset.csv']
);"

# === ORDER ITEMS ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.order_items\` (
  order_id STRING,
  order_item_id INT64,
  product_id STRING,
  seller_id STRING,
  shipping_limit_date TIMESTAMP,
  price FLOAT64,
  freight_value FLOAT64
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_order_items_dataset.csv']
);"

# === ORDER REVIEWS ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.reviews\` (
  review_id STRING,
  order_id STRING,
  review_score INT64,
  review_comment_title STRING,
  review_comment_message STRING,
  review_creation_date DATE,
  review_answer_timestamp TIMESTAMP
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_order_reviews_dataset.csv']
);"

# === PAYMENTS ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.payments\` (
  order_id STRING,
  payment_sequential INT64,
  payment_type STRING,
  payment_installments INT64,
  payment_value FLOAT64
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_order_payments_dataset.csv']
);"

# === PRODUCTS ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.products\` (
  product_id STRING,
  product_category_name STRING,
  product_name_length INT64,
  product_description_length INT64,
  product_photos_qty INT64,
  product_weight_g FLOAT64,
  product_length_cm FLOAT64,
  product_height_cm FLOAT64,
  product_width_cm FLOAT64
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_products_dataset.csv']
);"

# === SELLERS ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.sellers\` (
  seller_id STRING,
  seller_zip_code_prefix STRING,
  seller_city STRING,
  seller_state STRING
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_sellers_dataset.csv']
);"

# === PRODUCT CATEGORY TRANSLATION ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.product_category_translation\` (
  product_category_name STRING,
  product_category_name_english STRING
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/product_category_name_translation.csv']
);"

# === GEOLOCATION ===
bq query --use_legacy_sql=false "
CREATE OR REPLACE EXTERNAL TABLE \`${PROJECT_ID}.${DATASET}.geolocation\` (
  geolocation_zip_code_prefix STRING,
  geolocation_lat FLOAT64,
  geolocation_lng FLOAT64,
  geolocation_city STRING,
  geolocation_state STRING
)
OPTIONS (
  format = 'CSV',
  skip_leading_rows = 1,
  uris = ['gs://${BUCKET_NAME}/raw/olist_geolocation_dataset.csv']
);"

echo "✅ All external tables recreated in dataset: ${DATASET}"
