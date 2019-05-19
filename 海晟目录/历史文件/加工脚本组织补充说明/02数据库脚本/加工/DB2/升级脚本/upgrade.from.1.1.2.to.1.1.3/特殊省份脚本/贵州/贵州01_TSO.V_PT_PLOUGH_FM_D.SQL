--DROP VIEW TSO.V_PT_PLOUGH_FM_D;
CREATE VIEW TSO.V_PT_PLOUGH_FM_D
   AS
  SELECT A.DATA_STORE_BASE_TBL_ID     AS PLOUGH_FM_D_ID,
         A.CLT_OBJ_ID                 AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD                 AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME               AS FIELD_BLOCK_NAME,
         A.PT_YEAR                    AS BUSINESS_YEAR,
         A.FEEDBACK_DATE              AS BUSINESS_DATE,
         CASE
           WHEN A.C1 = '1' THEN
             COALESCE(A.N30,0)
           ELSE
             0
         END                          AS PROPESS_AREA,
         CASE 
           WHEN A.C1 IS NULL OR A.C1 = '' OR A.C1 = '2' THEN 0
           ELSE COALESCE(A.N30,0)
         END                         AS PLOUGH_AREA,
         A.RELA_OBJECT_ID             AS FARMER_ID,
         A.RELA_OBJECT_CD             AS FARMER_CD,
         A.RELA_OBJECT_NAME           AS FARMER_NAME,
         F.STATION_UNIQUE_CD  AS ORG_CD,
         --ORG.ORG_CD,
         --ORG.ORG_NAME,
         --ORG.PROV,
         --ORG.PROV_NAME,
         --ORG.CITC,
         --ORG.CITC_NAME,
         --ORG.COUC,
         --ORG.COUC_NAME,
         --ORG.STAC,
         --ORG.STAC_NAME,
         --ORG.SSTC,
         --ORG.SSTC_NAME,
         F.DIVISION_UNIQUE_CD AS AREA_CD,
         --DIVISION.DIVISION_UNIQUE_CD         AS AREA_CD,
         --DIVISION.ORG_NAME                   AS AREA_NAME,
         --DIVISION.AREA_PROV,
         --DIVISION.AREA_PROV_NAME,
         --DIVISION.AREA_CITC,
         --DIVISION.AREA_CITC_NAME,
         --DIVISION.AREA_COUC,
         --DIVISION.AREA_COUC_NAME,
         --DIVISION.AREA_TOWN,
         --DIVISION.TOWN_NAME,
         --DIVISION.AREA_VAGE,
         --DIVISION.VAGE_NAME,
         --DIVISION.AREA_GRUP,
         --DIVISION.GRUP_NAME,
         A.FEEDBACK_PSN_ID            AS TECHNICIAN_ID,
         A.SEND_STATE,
         A.DATA_STATE,
         A.MODIFY_TIME,
         A.LAST_TIME
    FROM PT_DC_STAT_DATA_D A
         LEFT JOIN CM_PM_FRM_FUND F ON F.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID AND F.BIZ_YEAR = A.PT_YEAR AND F.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000055'
     AND A.CHECK_STATE = '1' 
;