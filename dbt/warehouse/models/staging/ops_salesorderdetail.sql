{{
    config(
        materialized="table"
    )
}}

select
        salesorderdetailid,
        salesorderid,
        productid,
        orderqty,
        unitprice,
        specialofferid,
        unitpricediscount,
        rowguid,
        modifieddate
from {{ source('bike_business', 'ops_salesorderdetail') }}
