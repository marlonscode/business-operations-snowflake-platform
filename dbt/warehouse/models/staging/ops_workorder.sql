{{
    config(
        materialized="table"
    )
}}

select
    duedate,
    enddate,
    modifieddate,
    orderqty,
    productid,
    scrappedqty,
    scrapreasonid,
    startdate,
    workorderid
from {{ source('bike_business', 'ops_workorder') }}
