SELECT
    CLIENT_ID,
    STATE,
    SHIPPING_ADDRESS,
    PHONE,
    IP,
    OS,
    MOST_RECENT_ORDER_AT_TS
FROM
    {{ ref('int_client') }}