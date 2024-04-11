SELECT _FILE,
       _LINE,
       DATE,
       EXPENSE_TYPE,
       CAST(REPLACE(REPLACE(EXPENSE_AMOUNT, '$', ''), ' ', '') AS FLOAT) as EXPENSE_AMOUNT,
       _MODIFIED as _MODIFIED_TS,
       _FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS,
FROM {{ source('google_drive', 'expenses') }}  
