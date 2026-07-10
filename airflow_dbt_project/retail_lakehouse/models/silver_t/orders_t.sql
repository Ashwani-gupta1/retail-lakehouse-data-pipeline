{{
    config(
        materialized='incremental',
        unique_key='order_id',
        incremental_strategy='merge'
    )
}}

SELECT
    *,
    current_timestamp() AS processed_at
FROM
    {{ source('retail_source', 'orders') }}

{% if is_incremental() %}
WHERE updated_timestamp >= (
    SELECT COALESCE(
        MAX(updated_timestamp) - INTERVAL 1 DAY,
        CAST('1900-01-01' AS TIMESTAMP)
    )
    FROM {{ this }}
)
{% endif %}