{{
    config(
        materialized="table"
    )
}}

with base_table as (
    select
        base as base_currency,
        'USD' as quote_currency,
        rates['USD']::float as exchange_rate,
        to_timestamp(timestamp::number) as timestamp,
        row_number() over (
            partition by
                base_currency,
                quote_currency,
                timestamp
            order by timestamp
        ) as row_number
    from {{ source('bike_business', 'fx_latest_rate') }}
)

select
    base_currency,
    quote_currency,
    exchange_rate,
    timestamp
from base_table
where row_number = 1
