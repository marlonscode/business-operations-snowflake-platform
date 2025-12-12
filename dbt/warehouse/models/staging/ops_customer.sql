{{
    config(
        materialized="table"
    )
}}

select
    customerid,
    personid,
    storeid,
    territoryid
from {{ source('bike_business', 'ops_customer') }}
