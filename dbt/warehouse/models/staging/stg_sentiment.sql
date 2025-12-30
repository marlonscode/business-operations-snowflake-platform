{{
    config(
        materialized="table"
    )
}}

select
    authors,
    banner_image,
    category_within_source,
    overall_sentiment_label as sentiment_label,
    overall_sentiment_score as sentiment_score,
    source as news_source,
    source_domain,
    summary as news_summary,
    ticker_sentiment,
    to_timestamp(time_published, 'YYYYMMDDTHH24MISS') as time_published,
    title as news_headline,
    url as source_url
from {{ source('bike_business', 'sentiment') }}
