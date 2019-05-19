--DROP PROCEDURE DCCELL.P_R_PT_TRANSPLANT_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_TRANSPLANT_FM_D
------------------------------------------------------------
--移栽普查
--LINGM    2018-01-05
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME        VARCHAR(32) DEFAULT 'P_R_PT_TRANSPLANT_FM_D';
  DECLARE V_YEAR             DECIMAL(4);
  DECLARE V_CURRENT_TIME     TIMESTAMP;

  SET V_CURRENT_TIME = CURRENT TIMESTAMP;

  SELECT BUSI_YEAR INTO V_YEAR
    FROM DCCELL.DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
  ;
   
  DELETE FROM DCCELL.R_PT_TRANSPLANT_FM_D
   WHERE BUSINESS_YEAR >= V_YEAR
  ;
  COMMIT;
  INSERT INTO DCCELL.R_PT_TRANSPLANT_FM_D
  (
    TRANSPLANT_FM_D_ID,
    BUSINESS_YEAR     ,
    BUSINESS_DATE     ,
    FARMER_CD         ,
    FARMER_NAME       ,
    FIELD_BLOCK_ID    ,
    FIELD_BLOCK_CD    ,
    FIELD_BLOCK_NAME  ,
    TRANSPLANT_QTY    ,
    TRANSPLANT_AREA   ,
    CENSUS_QTY        ,
    CENSUS_AREA       ,
    TECHNICIAN_ID     ,
    TECHNICIAN_NAME   ,
    SEND_STATE        ,
    DATA_STATE        ,
    MODIFY_TIME       ,
    LAST_TIME          
  )
  SELECT HEX(GENERATE_UNIQUE())   AS TRANSPLANT_FM_D_ID,
         A.PT_YEAR                AS BUSINESS_YEAR     ,
         A.CENSUS_DATE            AS BUSINESS_DATE     ,
         A.FRM_CD                 AS FARMER_CD         ,
         A.FRM_NAME               AS FARMER_NAME       ,
         A.BLOCK_ID               AS FIELD_BLOCK_ID    ,
         A.BLOCK_CD               AS FIELD_BLOCK_CD    ,
         A.BLOCK_NAME             AS FIELD_BLOCK_NAME  ,
         COALESCE(LEAF_NUM,0)     AS TRANSPLANT_QTY    ,
         COALESCE(AREA,0)         AS TRANSPLANT_AREA   ,
         0                        AS CENSUS_QTY        ,
         0                        AS CENSUS_AREA       ,
         A.TLG_ID                 AS TECHNICIAN_ID     ,
         A.TLG_NAME               AS TECHNICIAN_NAME   ,
         '0'                      AS SEND_STATE        ,
         '1'                      AS DATA_STATE        ,
         V_CURRENT_TIME           AS MODIFY_TIME       ,
         A.LAST_TIME              AS LAST_TIME         
    FROM DCCELL.PT_WC_FRM_BLOCK_CENSUS A
   WHERE A.PT_YEAR >= V_YEAR
     AND A.WATCH_FLAG = '0'
     AND A.DATA_STATE = '1'
  ;
  COMMIT;
  INSERT INTO DCCELL.R_PT_TRANSPLANT_FM_D
  (
    TRANSPLANT_FM_D_ID,
    BUSINESS_YEAR     ,
    BUSINESS_DATE     ,
    FARMER_CD         ,
    FARMER_NAME       ,
    FIELD_BLOCK_ID    ,
    FIELD_BLOCK_CD    ,
    FIELD_BLOCK_NAME  ,
    TRANSPLANT_QTY    ,
    TRANSPLANT_AREA   ,
    CENSUS_QTY        ,
    CENSUS_AREA       ,
    IS_AREA_TALLY     ,
    IS_LOCATION_TALLY ,
    TECHNICIAN_ID     ,
    TECHNICIAN_NAME   ,
    SEND_STATE        ,
    DATA_STATE        ,
    MODIFY_TIME       ,
    LAST_TIME          
  )
  SELECT  TRANSPLANT_FM_D_ID,
          BUSINESS_YEAR     ,
          BUSINESS_DATE     ,
          FARMER_CD         ,
          FARMER_NAME       ,
          FIELD_BLOCK_ID    ,
          FIELD_BLOCK_CD    ,
          FIELD_BLOCK_NAME  ,
          TRANSPLANT_QTY    ,
          TRANSPLANT_AREA   ,
          CENSUS_QTY        ,
          CENSUS_AREA       ,
          IS_AREA_TALLY     ,
          IS_LOCATION_TALLY ,
          TECHNICIAN_ID     ,
          TECHNICIAN_NAME   ,
          SEND_STATE        ,
          DATA_STATE        ,
          MODIFY_TIME       ,
          LAST_TIME          
    FROM DCCELL.V_PT_WC_FRM_BLOCK_CHECK A
   WHERE A.BUSINESS_YEAR >= V_YEAR
     AND A.DATA_STATE = '1'
  ;
  COMMIT;
  UPDATE DCCELL.R_PT_TRANSPLANT_FM_D A
     SET
         ( A.PROV     ,
           A.CITC     ,
           A.COUC     ,
           A.STAC     ,
           A.SSTC     ,
           A.SLIN     ,
           A.PROV_NAME,
           A.CITC_NAME,
           A.COUC_NAME,
           A.STAC_NAME,
           A.SSTC_NAME,
           A.SLIN_NAME,
           A.ORG_NAME,
           A.ORG_CD,
           A.AREA_PROV     ,
           A.AREA_CITC     ,
           A.AREA_COUC     ,
           A.AREA_TOWN     ,
           A.AREA_VAGE     ,
           A.AREA_GRUP     ,
           A.AREA_PROV_NAME,
           A.AREA_CITC_NAME,
           A.AREA_COUC_NAME,
           A.TOWN_NAME     ,
           A.VAGE_NAME     ,
           A.GRUP_NAME     ,
           A.AREA_NAME     ,
           A.AREA_CD
         ) = (
                SELECT CASE WHEN B.PROV = '0' THEN NULL ELSE B.PROV END AS PROV,
                       CASE WHEN B.CITC = '0' THEN NULL ELSE B.CITC END AS CITC,
                       CASE WHEN B.COUC = '0' THEN NULL ELSE B.COUC END AS COUC,
                       CASE WHEN B.STAC = '0' THEN NULL ELSE B.STAC END AS STAC,
                       CASE WHEN B.SSTC = '0' THEN NULL ELSE B.SSTC END AS SSTC,
                       CASE WHEN B.SLIN = '0' THEN NULL ELSE B.SLIN END AS SLIN,
                       PROV_NAME,
                       CITC_NAME,
                       COUC_NAME,
                       STAC_NAME,
                       SSTC_NAME,
                       SLIN_NAME,
                       ORG_NAME,
                       ORG_CD,
                       CASE WHEN B.AREA_PROV = '0' THEN NULL ELSE B.AREA_PROV END AS AREA_PROV,
                       CASE WHEN B.AREA_CITC = '0' THEN NULL ELSE B.AREA_CITC END AS AREA_CITC,
                       CASE WHEN B.AREA_COUC = '0' THEN NULL ELSE B.AREA_COUC END AS AREA_COUC,
                       CASE WHEN B.AREA_TOWN = '0' THEN NULL ELSE B.AREA_TOWN END AS AREA_TOWN,
                       CASE WHEN B.AREA_VAGE = '0' THEN NULL ELSE B.AREA_VAGE END AS AREA_VAGE,
                       CASE WHEN B.AREA_GRUP = '0' THEN NULL ELSE B.AREA_GRUP END AS AREA_GRUP,
                       AREA_PROV_NAME,
                       AREA_CITC_NAME,
                       AREA_COUC_NAME,
                       TOWN_NAME     ,
                       VAGE_NAME     ,
                       GRUP_NAME     ,
                       AREA_NAME     ,
                       AREA_CD
                  FROM DCCELL.R_FARMER B WHERE A.FARMER_CD = B.FARMER_CD
             )
   WHERE A.BUSINESS_YEAR >= V_YEAR
  ;
  COMMIT;
 -- --根据各市的亩种植株数计算移栽核查参数
 -- UPDATE DCCELL.R_PT_TRANSPLANT_FM_D A
 --    SET A.CENSUS_QTY = (
 --                         SELECT CAST(VALUE AS DECIMAL(24,6))
 --                           FROM DCCELL.CM_PI_PARAM B
 --                                INNER JOIN DCCELL.B_ORG C ON B.ORG_UNIQUE_CD = C.ORG_UNIQUE_CD
 --                                                       --  AND C.BUSINESS_YEAR = B.BIZ_YEAR
 --                          WHERE A.CITC = C.ORG_CD
 --                            AND UPPER(B.CODE) = 'PLANT_COUNT_PER_MU'
 --                            AND B.DATA_STATE = '1'
 --                       ) * A.CENSUS_AREA
 --  WHERE A.BUSINESS_YEAR >= V_YEAR
 --    AND EXISTS (
 --                 SELECT 1
 --                   FROM DCCELL.CM_PI_PARAM B
 --                        INNER JOIN DCCELL.B_ORG C ON B.ORG_UNIQUE_CD = C.ORG_UNIQUE_CD
 --                                              --   AND C.BUSINESS_YEAR = B.BIZ_YEAR  参数没有年度之分
 --                  WHERE A.CITC = C.ORG_CD
 --                    AND UPPER(B.CODE) = 'PLANT_COUNT_PER_MU'
 --                    AND B.DATA_STATE = '1'
 --               )
 -- ;
 -- --未设置亩种植株数的根据默认亩种植株数计算
 -- UPDATE DCCELL.R_PT_TRANSPLANT_FM_D A
 --    SET A.CENSUS_QTY = (
 --                         SELECT CAST(DEFAULT_VALUE AS DECIMAL(24,6))
 --                           FROM DCCELL.CM_PI_PARAM_INFO B
 --                          WHERE UPPER(B.CODE) = 'PLANT_COUNT_PER_MU'
 --                            AND IS_ENABLE_FLAG = '1'
 --                            AND DATA_STATE = '1'
 --                       ) * A.CENSUS_AREA
 --  WHERE A.BUSINESS_YEAR >= V_YEAR
 --    AND NOT EXISTS (
 --                     SELECT 1
 --                       FROM DCCELL.CM_PI_PARAM B
 --                            INNER JOIN DCCELL.B_ORG C ON B.ORG_UNIQUE_CD = C.ORG_UNIQUE_CD
 --                                                  --   AND C.BUSINESS_YEAR = B.BIZ_YEAR
 --                      WHERE A.CITC = C.ORG_CD
 --                        AND UPPER(B.CODE) = 'PLANT_COUNT_PER_MU'
 --                        AND B.DATA_STATE = '1'
 --                   )
 -- ;
  --汇总表采用全量加工
  DELETE FROM DCCELL.R_PT_TRANSPLANT_DV_D
   WHERE BUSINESS_YEAR >= V_YEAR
  ;

  INSERT INTO DCCELL.R_PT_TRANSPLANT_DV_D
  (
    TRANSPLANT_DV_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    TRANSPLANT_QTY,
    TRANSPLANT_AREA,
    CENSUS_QTY,
    CENSUS_AREA,
    ORG_CD,
    ORG_NAME,
    PROV,
    PROV_NAME,
    CITC,
    CITC_NAME,
    COUC,
    COUC_NAME,
    STAC,
    STAC_NAME,
    SSTC,
    SSTC_NAME,
    AREA_CD,
    AREA_NAME,
    AREA_PROV,
    AREA_PROV_NAME,
    AREA_CITC,
    AREA_CITC_NAME,
    AREA_COUC,
    AREA_COUC_NAME,
    AREA_TOWN,
    TOWN_NAME,
    AREA_VAGE,
    VAGE_NAME,
    AREA_GRUP,
    GRUP_NAME,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
  )
  SELECT HEX(GENERATE_UNIQUE())           AS TRANSPLANT_DV_D_ID,
         BUSINESS_YEAR                    AS BUSINESS_YEAR   ,
         BUSINESS_DATE                    AS BUSINESS_DATE   ,
         SUM(COALESCE(TRANSPLANT_QTY ,0)) AS TRANSPLANT_QTY  ,
         SUM(COALESCE(TRANSPLANT_AREA,0)) AS TRANSPLANT_AREA ,
         SUM(COALESCE(CENSUS_QTY     ,0)) AS CENSUS_QTY      ,
         SUM(COALESCE(CENSUS_AREA    ,0)) AS CENSUS_AREA     ,
         ORG_CD                           AS ORG_CD          ,
         ORG_NAME                         AS ORG_NAME        ,
         PROV                             AS PROV            ,
         PROV_NAME                        AS PROV_NAME       ,
         CITC                             AS CITC            ,
         CITC_NAME                        AS CITC_NAME       ,
         COUC                             AS COUC            ,
         COUC_NAME                        AS COUC_NAME       ,
         STAC                             AS STAC            ,
         STAC_NAME                        AS STAC_NAME       ,
         SSTC                             AS SSTC            ,
         SSTC_NAME                        AS SSTC_NAME       ,
         AREA_CD                          AS AREA_CD         ,
         AREA_NAME                        AS AREA_NAME       ,
         AREA_PROV                        AS AREA_PROV       ,
         AREA_PROV_NAME                   AS AREA_PROV_NAME  ,
         AREA_CITC                        AS AREA_CITC       ,
         AREA_CITC_NAME                   AS AREA_CITC_NAME  ,
         AREA_COUC                        AS AREA_COUC       ,
         AREA_COUC_NAME                   AS AREA_COUC_NAME  ,
         AREA_TOWN                        AS AREA_TOWN       ,
         TOWN_NAME                        AS TOWN_NAME       ,
         AREA_VAGE                        AS AREA_VAGE       ,
         VAGE_NAME                        AS VAGE_NAME       ,
         AREA_GRUP                        AS AREA_GRUP       ,
         GRUP_NAME                        AS GRUP_NAME       ,
         '0'                              AS SEND_STATE      ,
         '1'                              AS DATA_STATE      ,
         V_CURRENT_TIME                   AS MODIFY_TIME     ,
         MAX(LAST_TIME)                   AS LAST_TIME
    FROM DCCELL.R_PT_TRANSPLANT_FM_D
   WHERE BUSINESS_YEAR >= V_YEAR
   GROUP BY BUSINESS_YEAR,
            BUSINESS_DATE,
            ORG_CD,
            ORG_NAME,
            PROV,
            PROV_NAME,
            CITC,
            CITC_NAME,
            COUC,
            COUC_NAME,
            STAC,
            STAC_NAME,
            SSTC,
            SSTC_NAME,
            AREA_CD,
            AREA_NAME,
            AREA_PROV,
            AREA_PROV_NAME,
            AREA_CITC,
            AREA_CITC_NAME,
            AREA_COUC,
            AREA_COUC_NAME,
            AREA_TOWN,
            TOWN_NAME,
            AREA_VAGE,
            VAGE_NAME,
            AREA_GRUP,
            GRUP_NAME
  ;
    COMMIT;
  DELETE FROM DCCELL.R_PT_TRANSPLANT_CB_D
   WHERE BUSINESS_YEAR >= V_YEAR
     AND DATA_STATE = '1'
  ;

  INSERT INTO DCCELL.R_PT_TRANSPLANT_CB_D
  (
    TRANSPLANT_CB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    TRANSPLANT_QTY  ,
    TRANSPLANT_AREA ,
    CENSUS_QTY      ,
    CENSUS_AREA     ,
    ORG_CD,
    ORG_NAME,
    PROV,
    PROV_NAME,
    CITC,
    CITC_NAME,
    COUC,
    COUC_NAME,
    STAC,
    STAC_NAME,
    SSTC,
    SSTC_NAME,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
  )
  SELECT HEX(GENERATE_UNIQUE())           AS YY_GROW_CB_D_ID,
         BUSINESS_YEAR                    AS BUSINESS_YEAR,
         BUSINESS_DATE                    AS BUSINESS_DATE,
         SUM(COALESCE(TRANSPLANT_QTY ,0)) AS TRANSPLANT_QTY  ,
         SUM(COALESCE(TRANSPLANT_AREA,0)) AS TRANSPLANT_AREA ,
         SUM(COALESCE(CENSUS_QTY     ,0)) AS CENSUS_QTY      ,
         SUM(COALESCE(CENSUS_AREA    ,0)) AS CENSUS_AREA     ,
         ORG_CD                           AS ORG_CD   ,
         ORG_NAME                         AS ORG_NAME ,
         PROV                             AS PROV     ,
         PROV_NAME                        AS PROV_NAME,
         CITC                             AS CITC     ,
         CITC_NAME                        AS CITC_NAME,
         COUC                             AS COUC     ,
         COUC_NAME                        AS COUC_NAME,
         STAC                             AS STAC     ,
         STAC_NAME                        AS STAC_NAME,
         SSTC                             AS SSTC     ,
         SSTC_NAME                        AS SSTC_NAME,
         '0'                              AS SEND_STATE,
         '1'                              AS DATA_STATE,
         V_CURRENT_TIME                   AS MODIFY_TIME,
         MAX(LAST_TIME)                   AS LAST_TIME
    FROM DCCELL.R_PT_TRANSPLANT_FM_D
   WHERE BUSINESS_YEAR >= V_YEAR
   GROUP BY BUSINESS_YEAR,
            BUSINESS_DATE,
            ORG_CD,
            ORG_NAME,
            PROV,
            PROV_NAME,
            CITC,
            CITC_NAME,
            COUC,
            COUC_NAME,
            STAC,
            STAC_NAME,
            SSTC,
            SSTC_NAME
  ;

  COMMIT;
END
@