-- DROP VIEW V_PT_FOR_SEED_FM_Y;
CREATE VIEW V_PT_FOR_SEED_FM_Y
   AS
SELECT A.DATA_STORE_BASE_TBL_ID AS FOR_SEED_FM_Y_ID,
       A.PT_YEAR                AS BUSINESS_YEAR,
       A.CLT_OBJ_ID             AS FARMER_ID,
       A.CLT_OBJ_CD             AS FARMER_CD,
       A.CLT_OBJ_NAME           AS FARMER_NAME,
       A.C1                     AS GROW_POINT_ID,
       A.C2                     AS GROW_POINT_CD,
       A.C3                     AS GROW_POINT_NAME,
       A.C4                     AS GROW_CANOPY_ID,
       A.C5                     AS GROW_CANOPY_CD,
       A.C6                     AS GROW_CANOPY_NAME,
       A.C7                     AS LEAF_VARIETY_CD,
       COALESCE(A.n1, 0)        AS TRANSPLANT_AREA,
       COALESCE(A.N2, 0)        AS FOR_SEED_PLATE_QTY,
       COALESCE(A.N3, 0)        AS FOR_SEED_QTY,
       CAST(NULL  AS TIMESTAMP) AS FOR_SEED_DATE,
       B.STATION_UNIQUE_CD      AS ORG_CD,
       B.DIVISION_UNIQUE_CD     AS AREA_CD,
       A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
       '0'                      AS SEND_STATE,
       A.DATA_STATE             AS DATA_STATE,
       A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_F A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.CLT_OBJ_ID
                                   AND B.BIZ_YEAR = A.PT_YEAR
                                   AND B.DATA_STATE = '1'
   WHERE A.BILL_NO     = 'TJ00000000000057'
     AND A.CHECK_STATE = '1'
     AND EXISTS(SELECT 1 
                  FROM PT_AS_TLG_FACILITY C
                 WHERE C.FACILITY_ID = A.C4 
                   AND C.DATA_STATE='1' 
                   AND C.PT_YEAR = A.PT_YEAR
                   AND C.FACILITY_TYPE_EK='GROW_SHACK')
 UNION ALL 
  SELECT A.DATA_STORE_BASE_TBL_ID AS FOR_SEED_FM_Y_ID,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.CLT_OBJ_ID             AS FARMER_ID,
         A.CLT_OBJ_CD             AS FARMER_CD,
         A.CLT_OBJ_NAME           AS FARMER_NAME,
         C.GROW_POINT_ID          AS GROW_POINT_ID,
         C.GROW_POINT_CD          AS GROW_POINT_CD,
         C.LOGO_CODE              AS GROW_POINT_NAME,
         CAST(NULL AS VARCHAR(32))AS GROW_CANOPY_ID,
         CAST(NULL AS VARCHAR(32))AS GROW_CANOPY_CD,
         CAST(NULL AS VARCHAR(64))AS GROW_CANOPY_NAME,
         A.C3                     AS LEAF_VARIETY_CD,
         CAST(0 AS DECIMAL(24,6)) AS TRANSPLANT_AREA,
         COALESCE(A.n1, 0)        AS FOR_SEED_PLATE_QTY,
         CAST(0 AS DECIMAL(12))   AS FOR_SEED_QTY,
         A.D1                     AS FOR_SEED_DATE,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_A A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.CLT_OBJ_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
         LEFT JOIN TSO.TP_GROW_POINT C ON C.GROW_POINT_ID = A.C1
   WHERE A.BILL_NO      = 'TJ00000000000072'
     AND A.CHECK_STATE = '1'
  ;