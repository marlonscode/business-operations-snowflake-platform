{{
    config(
        materialized="table"
    )
}}

select
    authors,
    banner_image,
    category_within_source,
    overall_sentiment_label,
    overall_sentiment_score,
    source,
    source_domain,
    summary,
    ticker_sentiment,
    time_published,
    title,
    url
from {{ source('bike_business', 'sentiment') }}
