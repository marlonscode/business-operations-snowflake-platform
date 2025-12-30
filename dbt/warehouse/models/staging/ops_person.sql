{{
    config(
        materialized="table"
    )
}}

select
    businessentityid,
    title,
    firstname,
    middlename,
    lastname,
    namestyle,
    suffix,
    rowguid,
    emailpromotion,
    modifieddate
from {{ source('bike_business', 'ops_person') }}
