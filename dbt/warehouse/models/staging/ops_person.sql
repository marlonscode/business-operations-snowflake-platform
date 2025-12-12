{{
    config(
        materialized="table"
    )
}}

select
    businessentityid,
    emailpromotion,
    firstname,
    lastname,
    middlename,
    modifieddate,
    namestyle,
    persontype,
    rowguid,
    suffix,
    title
from {{ source('bike_business', 'ops_person') }}
