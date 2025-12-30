{{
    config(
        materialized="table"
    )
}}

select
    productsubcategoryid,
    productcategoryid,
    name,
    modifieddate
from {{ source('bike_business', 'ops_product_subcategory') }}
