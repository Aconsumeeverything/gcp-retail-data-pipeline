{{ config(materialized='view') }}

SELECT
  geolocation_zip_code_prefix AS zip_code_prefix,
  SAFE_CAST(geolocation_lat AS FLOAT64) AS lat,
  SAFE_CAST(geolocation_lng AS FLOAT64) AS lng,
  geolocation_city AS city ,
  geolocation_state  AS state
FROM {{ source('bronze', 'geolocation') }}
