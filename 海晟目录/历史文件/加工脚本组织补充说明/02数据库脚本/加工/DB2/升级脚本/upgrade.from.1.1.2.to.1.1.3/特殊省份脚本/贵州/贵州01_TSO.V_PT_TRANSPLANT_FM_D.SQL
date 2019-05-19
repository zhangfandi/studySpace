--DROP VIEW TSO.V_PT_TRANSPLANT_FM_D;
CREATE VIEW TSO.V_PT_TRANSPLANT_FM_D
   AS
SELECT A.DATA_STORE_BASE_TBL_ID,
       A.PT_YEAR,
       A.FEEDBACK_DATE,
       A.CLT_OBJ_ID          AS FIELD_BLOCK_ID,
       A.CLT_OBJ_CD          AS FIELD_BLOCK_CD,
       A.CLT_OBJ_NAME        AS FIELD_BLOCK_NAME,
       A.RELA_OBJECT_ID      AS FARMER_ID,
       A.RELA_OBJECT_CD      AS FARMER_CD,
       A.RELA_OBJECT_NAME    AS FARMER_NAME,
       A.C1                  AS LEAF_VARIETY_CD,
       CAST(NULL AS VARCHAR(32))  AS LEAF_VARIETY_NAME,
       A.N1                  AS TRANSPLANT_QTY,
       CASE
         WHEN A.C2 = '1' THEN
           COALESCE(A.N2, 0)
         ELSE
           0
       END                   AS PROPESS_AREA,
       COALESCE(A.N2, 0)     AS TRANSPLANT_AREA,
       COALESCE(A.N3, 0)     AS CENSUS_QTY,
       B.STATION_UNIQUE_CD ,
       --C.ORG_NAME,
       --C.PROV,
       --C.PROV_NAME,
       --C.CITC,
       --C.CITC_NAME,
       --C.COUC,
       --C.COUC_NAME,
       --C.STAC,
       --C.STAC_NAME,
       --C.SSTC,
       --C.SSTC_NAME,
       B.DIVISION_UNIQUE_CD,
       --D.ORG_NAME,
       --D.AREA_PROV,
       --D.AREA_PROV_NAME,
       --D.AREA_CITC,
       --D.AREA_CITC_NAME,
       --D.AREA_COUC,
       --D.AREA_COUC_NAME,
       --D.AREA_TOWN,
       --D.TOWN_NAME,
       --D.AREA_VAGE,
       --D.VAGE_NAME,
       --D.AREA_GRUP,
       --D.GRUP_NAME,
       A.FEEDBACK_PSN_ID,
       '0'                   AS SEND_STATE,
       A.DATA_STATE,
       A.MODIFY_TIME,
       CURRENT TIMESTAMP     AS LAST_TIME
  FROM PT_DC_STAT_DATA_Z A
       LEFT JOIN CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID AND B.BIZ_YEAR = A.PT_YEAR AND B.DATA_STATE = '1'
 WHERE A.BILL_NO     = 'TJ00000000000058'
   AND A.CHECK_STATE = '1'
;