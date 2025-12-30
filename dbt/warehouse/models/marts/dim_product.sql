{{
    config(
        materialized="table"
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['product.productid', 'product.valid_from']) }} as product_key,
    product.productid as product_id,
    product.name as product_name,
    productcategory.name as product_category,
    productsubcategory.name as product_subcategory,
    product.color,
    round(product.standardcost, 2) as unit_manufacture_cost,
    product.listprice as unit_sale_price,
    valid_from as product_valid_from,
    valid_to as product_valid_to
from {{ ref('ops_product_history') }} as product
left join {{ ref('ops_product_subcategory') }} as productsubcategory
    on product.productsubcategoryid = productsubcategory.productsubcategoryid
left join {{ ref('ops_product_category') }} as productcategory
    on productsubcategory.productcategoryid = productcategory.productcategoryid
