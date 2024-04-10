SELECT PAGE_NAME,
       SESSION_ID,
       VIEW_AT AS PAGE_VIEW_AT_TS,
       _FIVETRAN_DELETED,
       _FIVETRAN_ID,
       _FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS
FROM {{ source('snowflake', 'page_views') }}
