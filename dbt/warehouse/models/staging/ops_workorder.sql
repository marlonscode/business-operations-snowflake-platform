{{
    config(
        materialized="table"
    )
}}

select
    workorderid,
    productid,
    orderqty,
    scrappedqty,
    startdate::date as startdate,
    enddate,
    duedate,
    scrapreasonid,
    modifieddate
from {{ source('bike_business', 'ops_workorder') }}
