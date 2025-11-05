SELECT
    id as payment_id,
    order_id,
    payment_method,
    amount / 100.0 as amount
FROM {{source('jaffle_shop', 'raw_payments')}}