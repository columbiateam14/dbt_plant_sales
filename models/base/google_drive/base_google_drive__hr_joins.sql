SELECT _FILE,
       _LINE,
       CAST(EMPLOYEE_ID AS STRING) AS EMPLOYEE_ID,
       NAME,
       TITLE,
       CITY,
       ADDRESS,
       ANNUAL_SALARY,
       CAST(SUBSTRING(HIRE_DATE, 5, 12) AS DATE) as HIRE_DATE,
       _MODIFIED AS _MODIFIED_TS
       _FIVETRAN_SYNCED AS _FIVETRAN_SYNCED_TS,
FROM {{ source('google_drive', 'hr_joins') }}
