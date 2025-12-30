{{
    config(
        materialized="incremental",
        unique_key=["sale_order_detail_key"],
        incremental_strategy="delete+insert"
    )
}}

with product as (
    select
        product_key,
        product_id,
        unit_manufacture_cost,
        unit_sale_price,
        product_valid_from,
        product_valid_to
    from {{ ref('dim_product') }}
),

salesorderheader as (
    select
        salesorderid,
        orderdate,
        creditcardid,
        customerid,
        shiptoaddressid,
        status as order_status
    from {{ ref('ops_salesorderheader') }}
),

salesorderdetail as (
    select
        salesorderdetailid,
        salesorderid,
        productid,
        orderqty as order_quantity
    from {{ ref('ops_salesorderdetail') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['salesorderdetail.salesorderid', 'salesorderdetail.salesorderdetailid']) }} as sale_order_detail_key,
    product.product_key,
    {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['creditcardid']) }} as creditcard_key,
    {{ dbt_utils.generate_surrogate_key(['shiptoaddressid']) }} as shipping_address_key,
    {{ dbt_utils.generate_surrogate_key(['order_status']) }} as order_status_key,
    product.unit_manufacture_cost,
    product.unit_sale_price,
    salesorderdetail.order_quantity,
    round(salesorderdetail.order_quantity * product.unit_sale_price, 2) as total_revenue,
    round((salesorderdetail.order_quantity * (product.unit_sale_price - product.unit_manufacture_cost)), 2) as total_profit,
    round(
    {{ safe_divide(
        '(salesorderdetail.order_quantity * (product.unit_sale_price - product.unit_manufacture_cost))',
        '(salesorderdetail.order_quantity * product.unit_sale_price)'
    ) }}, 2) as profit_margin,
    salesorderheader.orderdate as order_recieved_date
from salesorderdetail
inner join salesorderheader
    on salesorderdetail.salesorderid = salesorderheader.salesorderid
inner join product
    on product.product_id = salesorderdetail.productid
    and salesorderheader.orderdate::timestamp between product.product_valid_from and coalesce(product.product_valid_to, '9999-01-01'::timestamp)

{% if is_incremental() %}
where salesorderheader.orderdate > (select max(order_recieved_date) from {{ this }})
{% endif %}
