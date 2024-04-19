SELECT
    EMPLOYEE_ID,
    TITLE,
    ANNUAL_SALARY,
    HIRE_DATE,
    QUIT_DATE,
    DID_QUIT
FROM {{ ref('int_employee') }}