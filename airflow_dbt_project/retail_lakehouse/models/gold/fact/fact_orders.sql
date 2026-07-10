SELECT
    order_id,
    order_item_id,
    customer_id,
    product_id,
    store_id,
    employee_id,
    order_timestamp,
    total_amount,
    quantity,
    unit_price,
    line_amount,
    CURRENT_TIMESTAMP() AS fact_processed_at
FROM
    {{ ref('obt_b') }}