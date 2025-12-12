{{
    config(
        materialized="table"
    )
}}

select
    modifieddate,
    name,
    reasontype,
    salesreasonid
from {{ source('bike_business', 'ops_salesreason') }}
