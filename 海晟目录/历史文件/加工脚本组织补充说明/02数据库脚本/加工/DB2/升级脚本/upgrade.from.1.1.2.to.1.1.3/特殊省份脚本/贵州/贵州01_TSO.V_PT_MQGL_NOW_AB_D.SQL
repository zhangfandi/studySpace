--DROP VIEW TSO.V_PT_MQGL_NOW_AB_D;
CREATE VIEW TSO.V_PT_MQGL_NOW_AB_D
 AS 
SELECT A.DATA_STORE_BASE_TBL_ID   AS MQGL_NOW_AB_D_ID,
       A.PT_YEAR                AS BUSINESS_YEAR,
       A.FEEDBACK_DATE          AS BUSINESS_DATE,
       A.CLT_OBJ_ID             AS GROW_CANOPY_ID,
       A.CLT_OBJ_CD             AS GROW_CANOPY_CD,
       A.CLT_OBJ_NAME           AS GROW_CANOPY_NAME,
       A.C1                     AS CANOPY_TYPE,
       C.NAME                   AS CANOPY_TYPE_NAME,
       A.RELA_OBJECT_ID         AS GROW_POINT_ID,
       B.GROW_POINT_CD          AS GROW_POINT_CD,
       B.LOGO_CODE              AS GROW_POINT_NAME,
       A.C5                     AS LEAF_VARIETY_CD,
       COALESCE(A.N3, 0)        AS EMERGE_AREA,
       COALESCE(A.N4, 0)        AS S_CROSS_AREA,
       COALESCE(A.N5, 0)        AS B_CROSS_AREA,
       COALESCE(A.N6, 0)        AS ONE_CLIP_AREA,
       COALESCE(A.N7, 0)        AS SEED_AREA,
       B.STATION_UNIQUE_CD      AS ORG_CD,
       B.VILLAGE_UNIQUE_CD      AS AREA_CD,
       A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
       '0'                      AS SEND_STATE,
       A.DATA_STATE,
       A.MODIFY_TIME
  FROM TSO.PT_DC_STAT_DATA_E A
       LEFT JOIN TSO.TP_GROW_POINT B ON B.GROW_POINT_ID = A.RELA_OBJECT_ID
       LEFT JOIN TSO.CM_OT_ENUM_TYPE C ON C.ENUM_KEY = A.C1 AND C.ENUM_TYPE_CD = 'CANOPY_TYPE_EK'
 WHERE A.BILL_NO      = 'TJ00000000000070'
   AND A.CHECK_STATE = '1'
   AND EXISTS(SELECT 1 
                FROM TSO.PT_AS_TLG_FACILITY D
               WHERE D.FACILITY_ID = A.CLT_OBJ_ID 
                 AND D.DATA_STATE='1' 
                 AND D.PT_YEAR = A.PT_YEAR 
                 AND D.FACILITY_TYPE_EK='GROW_SHACK')
;