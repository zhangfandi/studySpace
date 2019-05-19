--DROP VIEW TSO.V_PT_VELUM_FM_D;
CREATE VIEW TSO.V_PT_VELUM_FM_D
   AS
SELECT A.DATA_STORE_BASE_TBL_ID AS PREPAR_FM_D_ID,
       A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
       A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
       A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
       A.PT_YEAR                AS BUSINESS_YEAR,
       A.FEEDBACK_DATE          AS BUSINESS_DATE,
       CASE
         WHEN A.C3 = '1' THEN
           COALESCE(A.N30,0)
         ELSE
           0
       END                      AS PROPESS_AREA,
       CASE 
         WHEN A.C3 IS NULL OR A.C3 = '' OR A.C3 = '2'
         THEN 0
         ELSE COALESCE(A.N30,0)
       END                      AS VELUM_AREA,
       A.RELA_OBJECT_ID         AS FARMER_ID,
       A.RELA_OBJECT_CD         AS FARMER_CD,
       A.RELA_OBJECT_NAME       AS FARMER_NAME,
       B.STATION_UNIQUE_CD      AS ORG_CD,
       B.DIVISION_UNIQUE_CD     AS AREA_CD,
       A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
       '0'                             AS SEND_STATE,
       A.DATA_STATE,
       A.MODIFY_TIME,
       CURRENT TIMESTAMP             AS LAST_TIME
  FROM PT_DC_STAT_DATA_D A
       LEFT JOIN CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                 AND B.BIZ_YEAR = A.PT_YEAR
                                 AND B.DATA_STATE = '1'
 WHERE A.BILL_NO = 'TJ00000000000055'
   AND A.CHECK_STATE = '1'
;