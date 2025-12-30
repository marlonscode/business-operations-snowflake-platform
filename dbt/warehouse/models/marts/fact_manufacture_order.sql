{{
    config(
        materialized="incremental",
        unique_key=["manufacture_order_key"],
        incremental_strategy="delete+insert"
    )
}}

with product as (
    select
        product_key,
        product_id,
        unit_manufacture_cost,
        product_valid_from,
        product_valid_to
    from {{ ref('dim_product') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['workorderid']) }} as manufacture_order_key,
    product.product_key,
    product.unit_manufacture_cost,
    orderqty as order_quantity,
    round(order_quantity * product.unit_manufacture_cost, 2) as total_manufacture_cost,
    startdate as order_recieved_date
from {{ ref('ops_workorder') }} as manufacture_order
inner join product
    on product.product_id = manufacture_order.productid
    and manufacture_order.startdate::timestamp between product.product_valid_from and coalesce(product.product_valid_to, '9999-01-01'::timestamp)

{% if is_incremental() %}
where manufacture_order.startdate > (select max(order_recieved_date) from {{ this }})
{% endif %}