SELECT _FIVETRAN_ID, 
       SESSION_ID, 
       OS, 
       IP, 
       _FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS,
       SESSION_AT AS SESSION_AT_TS, 
       CAST(CLIENT_ID AS STRING) AS CLIENT_ID, 
       _FIVETRAN_DELETED
FROM {{ source('snowflake', 'sessions') }}