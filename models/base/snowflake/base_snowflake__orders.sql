SELECT _FIVETRAN_ID, 
       PAYMENT_INFO,
       STATE, 
       SESSION_ID, 
       SHIPPING_COST, 
       CLIENT_NAME, 
       PAYMENT_METHOD, 
       TAX_RATE, 
       PHONE, 
       ORDER_ID, 
       _FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS,
       ORDER_AT AS ORDER_AT_TS, 
       SHIPPING_ADDRESS, 
       _FIVETRAN_DELETED
FROM {{ source('snowflake', 'orders') }}