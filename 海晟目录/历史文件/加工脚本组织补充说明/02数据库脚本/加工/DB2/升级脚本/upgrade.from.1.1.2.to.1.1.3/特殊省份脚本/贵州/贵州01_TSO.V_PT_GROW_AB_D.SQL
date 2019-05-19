--DROP VIEW TSO.V_PT_GROW_AB_D;
CREATE VIEW TSO.V_PT_GROW_AB_D
   AS
  SELECT DATA_STORE_BASE_TBL_ID                  AS GROW_AB_D_ID,
         A.PT_YEAR  AS BUSINESS_YEAR,
         A.FEEDBACK_DATE AS BUSINESS_DATE,
         A.CLT_OBJ_ID                         AS GROW_CANOPY_ID,
         A.CLT_OBJ_CD                         AS GROW_CANOPY_CD,
         A.CLT_OBJ_NAME                       AS GROW_CANOPY_NAME,
         A.C1                                 AS CANOPY_TYPE,
         B.NAME                               AS CANOPY_TYPE_NAME,
         A.C4                                 AS GROW_PLATE_TYPE,
         A.C5                                 AS SUPPLY_STANDARD_EK,
         CASE
          WHEN A.C7 = '941' THEN '358' 
          ELSE A.C7
         END                                 AS LEAF_VARIETY_CD,
         D.ENUM_NAME                         AS LEAF_VARIETY_NAME,
         A.RELA_OBJECT_ID                    AS GROW_POINT_ID,
         E.GROW_POINT_CD                     AS GROW_POINT_CD,
         E.LOGO_CODE                         AS GROW_POINT_NAME,
         COALESCE(A.N1, 0)                         AS GROW_PLATE_QTY,
         DECIMAL(C.ENUM_CD)*COALESCE(A.N1, 0)  AS GROW_QTY,
         COALESCE(A.N2, 0)                         AS TRANSPLANT_AREA,
         A.ORG_UNIQUE_CD as ORG_CD,
         E.VILLAGE_UNIQUE_CD as AREA_CD,
         A.FEEDBACK_PSN_ID AS TECHNICIAN_ID,
         A.SEND_STATE,
         A.DATA_STATE,
         A.MODIFY_TIME,
         A.LAST_TIME
    FROM PT_DC_STAT_DATA_E A
         LEFT JOIN CM_OT_ENUM_TYPE B ON B.ENUM_KEY = A.C1 AND B.ENUM_TYPE_CD = 'CANOPY_TYPE_EK'
         LEFT JOIN PT_IX_ENUM_DATA C ON C.ENUM_CD = A.C4  AND C.IDX_ID = '8a3c34f8581f65f701582f7da0f0002d'
         LEFT JOIN PT_IX_ENUM_DATA D ON D.ENUM_CD = A.C7  AND D.IDX_ID = '8a3c34f8581f65f701582f7efc690031'
         LEFT JOIN TP_GROW_POINT E ON E.GROW_POINT_ID = A.RELA_OBJECT_ID
   WHERE A.BILL_NO     = 'TJ00000000000056'
     AND A.CHECK_STATE = '1'
     AND EXISTS(SELECT 1 
                  FROM PT_AS_TLG_FACILITY TLGFAC
                 WHERE TLGFAC.FACILITY_ID = A.CLT_OBJ_ID 
                   AND TLGFAC.DATA_STATE='1' 
                   AND TLGFAC.PT_YEAR = A.PT_YEAR 
                   AND TLGFAC.FACILITY_TYPE_EK='GROW_SHACK')
;