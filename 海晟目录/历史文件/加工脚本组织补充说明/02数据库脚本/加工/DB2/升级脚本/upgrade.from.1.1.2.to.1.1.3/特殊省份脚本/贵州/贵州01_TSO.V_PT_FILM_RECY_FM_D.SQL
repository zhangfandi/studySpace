-- DROP VIEW TSO.V_PT_FILM_RECY_FM_D;
CREATE VIEW TSO.V_PT_FILM_RECY_FM_D
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID AS FILM_RECY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         A.N1                     AS COVER_AREA,
         A.N2                     AS RECY_ARA,
         A.N3                     AS PROPESS_AREA,
         A.N4                     AS SUBSIDE_MONEY,
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
   WHERE A.BILL_NO = 'TJ00000000000059'
     AND A.CHECK_STATE = '1'
;