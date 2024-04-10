SELECT _FILE,
       _LINE,
       CAST(EMPLOYEE_ID AS STRING) AS EMPLOYEE_ID,
       QUIT_DATE,
       _MODIFIED AS _MODIFIED_TS,
       _FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS
FROM {{ source('google_drive', 'hr_quits') }}
