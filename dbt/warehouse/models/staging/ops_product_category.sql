{{
    config(
        materialized="table"
    )
}}

select
    productcategoryid,
    modifieddate,
    name
from {{ source('bike_business', 'ops_product_category') }}
