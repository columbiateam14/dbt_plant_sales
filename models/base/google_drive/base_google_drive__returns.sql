SELECT _FILE,
       _LINE,
       RETURNED_AT as RETURNED_DATE,
       ORDER_ID,
       IS_REFUNDED,
       _MODIFIED as _MODIFIED_TS,
       _FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS,
FROM {{ source('google_drive', 'returns') }} 
