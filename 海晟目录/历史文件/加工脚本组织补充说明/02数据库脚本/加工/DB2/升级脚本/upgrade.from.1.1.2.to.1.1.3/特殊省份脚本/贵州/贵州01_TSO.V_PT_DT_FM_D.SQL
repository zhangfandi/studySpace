-- DROP VIEW TSO.V_PT_DT_FM_D;
CREATE VIEW TSO.V_PT_DT_FM_D
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID    AS DT_FM_D_ID,
         A.CLT_OBJ_ID                AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD                AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME              AS FIELD_BLOCK_NAME,
         A.PT_YEAR                   AS BUSINESS_YEAR,
         A.FEEDBACK_DATE             AS BUSINESS_DATE,
         CASE 
           WHEN A.C1 IS NULL OR A.C1 = '' OR A.C1 = '2' THEN
             0
           ELSE
             COALESCE(A.N1,0)
         END                         AS UNCOVER_AREA,
         CASE 
           WHEN A.C1 ='1' THEN
            COALESCE(A.N1,0)
           ELSE 0
         END                         AS UNCOVER_ROOFED_AREA,
         CASE 
           WHEN A.C2 IS NULL OR A.C2 = '' OR A.C2 = '2' THEN
             0
           ELSE
             COALESCE(A.N1,0)
         END                         AS BUTTON_POLE_AREA,
         CASE 
           WHEN A.C2 ='1' THEN
             COALESCE(A.N1,0)
           ELSE
             0
         END                         AS BUTTON_POLE_ROOFED_AREA,
         CASE 
           WHEN A.C3 IS NULL OR A.C3 = '' OR A.C3 = '2' THEN
             0
           ELSE 
             COALESCE(A.N1,0)
         END                         AS DEBRIS_CLEAN_AREA,
         CASE 
           WHEN A.C3 ='1' THEN
             COALESCE(A.N1,0)
           ELSE
             0
         END                         AS DEBRIS_CLEAN_ROOFED_AREA,
         0                           AS MANURE_AREA,
         0                           AS MANURE_ROOFED_AREA,
         0                           AS PTSX_AREA,
         0                           AS PTSX_ROOFED_AREA,
         0                           AS PREVENT_AREA,
         0                           AS PREVENT_ROOFED_AREA,
         A.RELA_OBJECT_ID            AS FARMER_ID,
         A.RELA_OBJECT_CD            AS FARMER_CD,
         A.RELA_OBJECT_NAME          AS FARMER_NAME,
         B.STATION_UNIQUE_CD         AS ORG_CD,
         B.DIVISION_UNIQUE_CD        AS AREA_CD,
         A.FEEDBACK_PSN_ID           AS TECHNICIAN_ID,
         '0'                         AS SEND_STATE,
         A.DATA_STATE                AS DATA_STATE,
         A.MODIFY_TIME               AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_H A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000060'
     AND A.CHECK_STATE = '1'
UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS DT_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         0                        AS UNCOVER_AREA,
         0                        AS UNCOVER_ROOFED_AREA,
         0                        AS BUTTON_POLE_AREA,
         0                        AS BUTTON_POLE_ROOFED_AREA,
         0                        AS DEBRIS_CLEAN_AREA,
         0                        AS DEBRIS_CLEAN_ROOFED_AREA,
         CASE 
           WHEN A.C1 IS NULL OR A.C1 = '' OR A.C1 = '2'
           THEN 0
           ELSE COALESCE(A.N1,0)
         END                      AS MANURE_AREA,
         CASE 
           WHEN A.C1 ='1'
           THEN COALESCE(A.N1,0)
           ELSE 0
         END                      AS MANURE_ROOFED_AREA,
         CASE 
           WHEN A.C2 IS NULL OR A.C2 = '' OR A.C2 = '2'
           THEN 0
           ELSE COALESCE(A.N1,0)
         END                      AS PTSX_AREA,
         CASE 
           WHEN A.C2 ='1'
           THEN COALESCE(A.N1,0)
           ELSE 0
         END                      AS PTSX_ROOFED_AREA,
         CASE 
           WHEN A.C4 IS NULL OR A.C4 = '' OR A.C4 = '2'
           THEN 0
           ELSE COALESCE(A.N1,0)
         END                      AS PREVENT_AREA,
         CASE 
           WHEN A.C4 ='1'
           THEN COALESCE(A.N1,0)
           ELSE 0
         END                      AS PREVENT_ROOFED_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_A A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000061'
     AND A.CHECK_STATE = '1'
;