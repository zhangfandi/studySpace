--DROP VIEW TSO.V_PT_PREPAR_FM_D;
CREATE VIEW TSO.V_PT_PREPAR_FM_D
   AS
 SELECT  A.DATA_STORE_BASE_TBL_ID AS PREPAR_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         CASE 
           WHEN A.C2 = '1' THEN
             COALESCE(A.N30,0)
           ELSE
             0
         END                      AS PROPESS_AREA,
         CASE 
           WHEN A.C2 IS NULL OR A.C2 = '' OR A.C2 = '2'
           THEN 0
           ELSE COALESCE(A.N30,0)
         END                      AS PREPAR_AREA,
         A.C4                     AS PREPAR_TYPE,
         A.N1                     AS PREPAR_QTY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         F.STATION_UNIQUE_CD  AS ORG_CD,
         F.DIVISION_UNIQUE_CD AS AREA_CD,
         A.FEEDBACK_PSN_ID               AS TECHNICIAN_ID,
         A.SEND_STATE,
         A.DATA_STATE,
         A.MODIFY_TIME,
         A.LAST_TIME
    FROM PT_DC_STAT_DATA_D a
         LEFT JOIN CM_PM_FRM_FUND F ON F.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID AND F.BIZ_YEAR = A.PT_YEAR AND F.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000055'
     AND A.CHECK_STATE = '1' 
;