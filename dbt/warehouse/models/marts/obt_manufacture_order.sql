{{
    config(
        materialized="table"
    )
}}

select
    {{ dbt_utils.star(from=ref('fact_manufacture_order'), relation_alias='fact_manufacture_order', except=["product_key", "unit_manufacture_cost"]) }},
    {{ dbt_utils.star(from=ref('dim_product'), relation_alias='dim_product', except=["product_key"]) }},
    {{ dbt_utils.star(from=ref('dim_date'), relation_alias='dim_date', except=["date_day"]) }}
from {{ ref('fact_manufacture_order') }} as fact_manufacture_order
left join {{ ref('dim_product') }} as dim_product on fact_manufacture_order.product_key = dim_product.product_key
left join {{ ref('dim_date') }} as dim_date on fact_manufacture_order.order_recieved_date = dim_date.date_day
