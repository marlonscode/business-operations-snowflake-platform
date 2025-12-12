{{
    config(
        materialized="table"
    )
}}

select
    modifieddate,
    orderqty,
    productid,
    rowguid,
    salesorderdetailid,
    salesorderid,
    specialofferid,
    unitprice,
    unitpricediscount
from {{ source('bike_business', 'ops_salesorderdetail') }}
