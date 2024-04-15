Select
    jj.EMPLOYEE_ID,
    jj.TITLE,
    jj.ANNUAL_SALARY,
    jj.HIRE_DATE,
    qq.QUIT_DATE,
    CASE WHEN qq.QUIT_DATE IS NOT NULL THEN TRUE ELSE FALSE END as DID_QUIT

FROM {{ ref('base_google_drive__hr_joins') }} AS jj
LEFT JOIN {{ ref('base_google_drive__hr_quits') }} AS qq
ON jj.EMPLOYEE_ID = qq.EMPLOYEE_ID