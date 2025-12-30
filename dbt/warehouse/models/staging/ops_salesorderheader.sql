{{
    config(
        materialized="table"
    )
}}

select
    salesorderid,
    shipmethodid,
    billtoaddressid,
    rowguid,
    taxamt,
    shiptoaddressid,
    onlineorderflag,
    territoryid,
    status,
    orderdate::date as orderdate,
    creditcardapprovalcode,
    subtotal,
    creditcardid,
    currencyrateid,
    revisionnumber,
    freight,
    duedate::date as duedate,
    totaldue,
    customerid,
    salespersonid,
    shipdate::date as shipdate,
    accountnumber,
    modifieddate
from {{ source('bike_business', 'ops_salesorderheader') }}
