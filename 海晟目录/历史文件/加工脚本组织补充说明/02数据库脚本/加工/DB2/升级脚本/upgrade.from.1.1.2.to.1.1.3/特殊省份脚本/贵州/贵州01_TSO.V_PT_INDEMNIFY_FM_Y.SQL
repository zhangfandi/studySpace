-- DROP VIEW TSO.V_PT_INDEMNIFY_FM_Y;
CREATE VIEW TSO.V_PT_INDEMNIFY_FM_Y
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'FZ'                     AS DISASTE_TYPE, --FZ:风灾
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_C A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                            AND B.BIZ_YEAR = A.PT_YEAR
                                            AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000063'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'BP'                     AS DISASTE_TYPE, --BP:冰雹
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_D A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                            AND B.BIZ_YEAR = A.PT_YEAR
                                            AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000064'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'GH'                     AS DISASTE_TYPE, --GH:干旱
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_E A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000065'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'HZ'                     AS DISASTE_TYPE, --HZ:洪灾
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_H A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000068'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'OTHER'                  AS DISASTE_TYPE, --OTHER:其它灾害
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_G A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000067'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'BCH'                    AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         ''                       AS DISASTE_TYPE,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_F A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000066'
     AND A.CHECK_STATE = '1'
;