WITH PREP_SESSION AS (
    WITH RANK_SESSION AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY SESSION_ID ORDER BY SESSION_AT_TS ASC) AS RN
    FROM {{ ref('base_snowflake__sessions') }} AS SE
    )
    SELECT RS.SESSION_ID, 
           SESSION_AT_TS,
           OS, 
           IP,
           CLIENT_ID,
           COUNT(DISTINCT ITEM_NAME) AS ITEM_TYPE_NUM, -- how many types of items
           COALESCE(SUM(ADD_TO_CART_QUANTITY), 0) AS TOTAL_ADDED_TO_CART, -- how many items were added to the cart
           COALESCE(SUM(REMOVE_FROM_CART_QUANTITY), 0) AS TOTAL_REMOVED_FROM_CART, -- how many items were removed to the cart
           COALESCE(TOTAL_ADDED_TO_CART - TOTAL_REMOVED_FROM_CART, 0) AS TOTAL_ITEM -- how many items in total (after adding and removing)
    FROM RANK_SESSION AS RS
    LEFT JOIN {{ ref('base_snowflake__item_views') }} AS IV
    ON RS.SESSION_ID = IV.SESSION_ID
    WHERE RN = 1
    GROUP BY RS.SESSION_ID, RS.SESSION_AT_TS, OS, IP, CLIENT_ID
), PREP_ORDER AS (
    WITH RANK_ORDER AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY ORDER_ID ORDER BY ORDER_AT_TS ASC) AS RN
    FROM {{ ref('base_snowflake__orders') }} AS OD
    )
    SELECT ORDER_ID, 
           ORDER_AT_TS,
           SESSION_ID
    FROM RANK_ORDER
    WHERE RN = 1
)
SELECT
  PS.SESSION_ID, 
  PS.SESSION_AT_TS,
  LISTAGG(PAGE_NAME, ', ') WITHIN GROUP (ORDER BY PAGE_NAME) AS PAGE_VIEW_NAMES, -- which pages are viewed
  OS, 
  IP, 
  CLIENT_ID,
  ITEM_TYPE_NUM, -- how many items
  TOTAL_ADDED_TO_CART, -- how many items were added to the cart
  TOTAL_REMOVED_FROM_CART, -- how many items were removed to the cart
  TOTAL_ITEM,
  CASE WHEN ORDER_ID IS NOT NULL THEN TRUE ELSE FALSE END AS DID_ORDER
FROM PREP_SESSION AS PS
LEFT JOIN {{ ref('base_snowflake__page_views') }} AS PV
ON PS.SESSION_ID = PV.SESSION_ID
LEFT JOIN PREP_ORDER AS PO
ON PS.SESSION_ID = PO.SESSION_ID
GROUP BY PS.SESSION_ID, PS.SESSION_AT_TS, OS, IP, CLIENT_ID, ITEM_TYPE_NUM, TOTAL_ADDED_TO_CART, TOTAL_REMOVED_FROM_CART, TOTAL_ITEM, DID_ORDER
ORDER BY PS.SESSION_ID