{{
    config(
        materialized="table"
    )
}}

select
    productcategoryid,
    name,
    modifieddate
from {{ source('bike_business', 'ops_product_category') }}
