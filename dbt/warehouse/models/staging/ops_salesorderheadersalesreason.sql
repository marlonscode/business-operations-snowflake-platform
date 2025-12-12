{{
    config(
        materialized="table"
    )
}}

select
    modifieddate,
    salesorderid,
    salesreasonid
from {{ source('bike_business', 'ops_salesorderheadersalesreason') }}
