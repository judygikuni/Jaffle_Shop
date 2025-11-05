with orders as (
    select *
    from {{ ref('stg_orders') }}
    where status = 'completed'
),

payments as (
    select
        order_id,
        sum(amount) as total_amount
    from {{ ref('stg_payments') }}
    group by order_id
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        coalesce(payments.total_amount, 0) as total_amount
    from orders
    left join payments
        on orders.order_id = payments.order_id
)

select * from final