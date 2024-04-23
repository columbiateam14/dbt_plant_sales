SELECT
  SESSION_ID, 
  SESSION_AT_TS,
  PAGE_VIEW_NAMES,
  OS, 
  IP, 
  CLIENT_ID,
  ITEM_TYPE_NUM,
  TOTAL_ADDED_TO_CART,
  TOTAL_REMOVED_FROM_CART,
  TOTAL_ITEM,
  DID_ORDER,
  CASE WHEN DID_ORDER = true THEN 'Ordered'
    WHEN PAGE_VIEW_NAMES LIKE '%cart%' THEN 'Viewed Cart' 
    WHEN TOTAL_ADDED_TO_CART > 0 THEN 'Added to Cart'
    WHEN PAGE_VIEW_NAMES LIKE '%shop_plants%' THEN 'Explored'
    ELSE 'Started' 
  END AS FINAL_STATUS
FROM {{ ref('int_session') }}