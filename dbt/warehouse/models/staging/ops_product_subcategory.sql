{{
    config(
        materialized="table"
    )
}}

select
    modifieddate,
    name,
    productcategoryid,
    productsubcategoryid
from {{ source('bike_business', 'ops_product_subcategory') }}
