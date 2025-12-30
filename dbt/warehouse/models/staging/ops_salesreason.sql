{{
    config(
        materialized="table"
    )
}}

select
    salesreasonid,
    name,
    reasontype,
    modifieddate
from {{ source('bike_business', 'ops_salesreason') }}
