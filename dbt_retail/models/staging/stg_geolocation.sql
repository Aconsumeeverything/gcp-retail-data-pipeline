{{ config(materialized='view') }}

SELECT
  geolocation_zip_code_prefix,
  SAFE_CAST(geolocation_lat AS FLOAT64) AS geolocation_lat,
  SAFE_CAST(geolocation_lng AS FLOAT64) AS geolocation_lng,
  geolocation_city,
  geolocation_state
FROM {{ source('bronze', 'geolocation') }}
