{{
    config(
        materialized="table"
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['customer.customerid']) }} as customer_key,
    customer.customerid as customer_id,
    concat(coalesce(person.firstname, 'unknown'), ' ', coalesce(person.middlename, 'unknown'), ' ', coalesce(person.lastname, 'unknown')) as full_name,
    store.storename as customer_store_name
from {{ ref('ops_customer') }} as customer
left join {{ ref('ops_person') }} as person
    on customer.personid = person.businessentityid
left join {{ ref('ops_store') }} as store
    on customer.storeid = store.businessentityid