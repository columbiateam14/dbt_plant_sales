SELECT
    EMPLOYEE_ID,
    TITLE,
    ANNUAL_SALARY,
    HIRE_DATE AS EVENT_DATE,
    'hire' AS EVENT_TYPE
FROM {{ ref('int_employee') }}

UNION ALL

SELECT
    EMPLOYEE_ID,
    TITLE,
    ANNUAL_SALARY,
    QUIT_DATE AS EVENT_DATE,
    'quit' AS EVENT_TYPE
FROM {{ ref('int_employee') }}
WHERE DID_QUIT = 'yes'

ORDER BY event_date DESC