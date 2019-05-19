--DROP PROCEDURE DCCELL.P_R_PT_PLOUGH_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_PLOUGH_FM_D
BEGIN
  ------------------------------------------------------------
  --LINDS
  ------------------------------------------------------------
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_PLOUGH_FM_D';--
  DECLARE V_STEP                    VARCHAR(500);--
  DECLARE V_PT_YEAR                 INTEGER ;--
  DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000055';--

  DECLARE C_ENABLE_FLAG         CHAR(1)     DEFAULT '1';--
  DECLARE V_CURRENTTIMESTAMP    TIMESTAMP  ; --
  DECLARE V_TIME_STOP           TIMESTAMP;--

  DECLARE V_LOG_GROUP           VARCHAR(32);--
  DECLARE V_LAST_STEP           VARCHAR(32);--
  DECLARE V_LOG                 VARCHAR(32);--


  SET V_CURRENTTIMESTAMP = CURRENT TIMESTAMP;--
  SET V_LOG = ' ';--
  SET V_LOG_GROUP = TO_CHAR(V_CURRENTTIMESTAMP,'YYYY-MM-DD HH24:MI:SS');--

  SELECT BUSI_YEAR INTO V_PT_YEAR 
    FROM DC_PROC_BUSI_YEAR A 
   WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
  ;--
  SET V_STEP = '1 R_PT_PLOUGH_FM_D-D';--
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  DELETE FROM R_PT_PLOUGH_FM_D WHERE BUSINESS_YEAR >= V_PT_YEAR;--
  
  SET V_STEP = '2 R_PT_PLOUGH_FM_D-I';--
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  INSERT INTO R_PT_PLOUGH_FM_D
  (
    PLOUGH_FM_D_ID,
    FIELD_BLOCK_ID,
    FIELD_BLOCK_CD,
    FIELD_BLOCK_NAME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PROPESS_AREA,
    PLOUGH_AREA,
    FARMER_ID,
    FARMER_CD,
    FARMER_NAME,
    ORG_CD,
    --ORG_NAME,
    --PROV,
    --PROV_NAME,
    --CITC,
    --CITC_NAME,
    --COUC,
    --COUC_NAME,
    --STAC,
    --STAC_NAME,
    --SSTC,
    --SSTC_NAME,
    AREA_CD,
    --AREA_NAME,
    --AREA_PROV,
    --AREA_PROV_NAME,
    --AREA_CITC,
    --AREA_CITC_NAME,
    --AREA_COUC,
    --AREA_COUC_NAME,
    --AREA_TOWN,
    --TOWN_NAME,
    --AREA_VAGE,
    --VAGE_NAME,
    --AREA_GRUP,
    --GRUP_NAME,
    TECHNICIAN_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
  )
  SELECT     PLOUGH_FM_D_ID,
    FIELD_BLOCK_ID,
    FIELD_BLOCK_CD,
    FIELD_BLOCK_NAME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PROPESS_AREA,
    PLOUGH_AREA,
    FARMER_ID,
    FARMER_CD,
    FARMER_NAME,
    ORG_CD,
    --ORG_NAME,
    --PROV,
    --PROV_NAME,
    --CITC,
    --CITC_NAME,
    --COUC,
    --COUC_NAME,
    --STAC,
    --STAC_NAME,
    --SSTC,
    --SSTC_NAME,
    AREA_CD,
    --AREA_NAME,
    --AREA_PROV,
    --AREA_PROV_NAME,
    --AREA_CITC,
    --AREA_CITC_NAME,
    --AREA_COUC,
    --AREA_COUC_NAME,
    --AREA_TOWN,
    --TOWN_NAME,
    --AREA_VAGE,
    --VAGE_NAME,
    --AREA_GRUP,
    --GRUP_NAME,
    TECHNICIAN_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
    FROM V_PT_PLOUGH_FM_D 
   WHERE BUSINESS_YEAR    >= V_PT_YEAR
     AND DATA_STATE = '1' 
  WITH UR
  ;--
  COMMIT;--

 
  --COMMIT;--
  update R_PT_PLOUGH_FM_D A
     set (
           PROV      ,
           CITC      ,
           COUC      ,
           STAC      ,
           SSTC      ,
           SLIN      ,
           PROV_NAME ,
           CITC_NAME ,
           COUC_NAME ,
           STAC_NAME ,
           SSTC_NAME ,
           SLIN_NAME ,
           AREA_PROV     ,
           AREA_CITC     ,
           AREA_COUC     ,
           AREA_TOWN     ,
           AREA_VAGE     ,
           AREA_GRUP     ,
           AREA_PROV_NAME,
           AREA_CITC_NAME,
           AREA_COUC_NAME,
           TOWN_NAME     ,
           VAGE_NAME     ,
           GRUP_NAME     ,
           AREA_NAME     
         )=
         (select  PROV      ,
               CITC      ,
               COUC      ,
               STAC      ,
               SSTC      ,
               SLIN      ,
               PROV_NAME ,
               CITC_NAME ,
               COUC_NAME ,
               STAC_NAME ,
               SSTC_NAME ,
               SLIN_NAME ,
               AREA_PROV     ,
               AREA_CITC     ,
               AREA_COUC     ,
               AREA_TOWN     ,
               AREA_VAGE     ,
               AREA_GRUP     ,
               AREA_PROV_NAME,
               AREA_CITC_NAME,
               AREA_COUC_NAME,
               TOWN_NAME     ,
               VAGE_NAME     ,
               GRUP_NAME     ,
               AREA_NAME     
          from R_FARMER B where A.FARMER_CD = B.FARMER_CD)
   where EXISTS
         (select 1 from R_FARMER B where A.FARMER_CD = B.FARMER_CD)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;--
  COMMIT;--

  UPDATE R_PT_PLOUGH_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;--
  COMMIT;--

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  MERGE INTO R_PT_PLOUGH_FM_D A
  USING
  (
    SELECT CASE WHEN B.PROV = '0' THEN NULL ELSE B.PROV END AS PROV,
           CASE WHEN B.CITC = '0' THEN NULL ELSE B.CITC END AS CITC,
           CASE WHEN B.COUC = '0' THEN NULL ELSE B.COUC END AS COUC,
           CASE WHEN B.STAC = '0' THEN NULL ELSE B.STAC END AS STAC,
           CASE WHEN B.SSTC = '0' THEN NULL ELSE B.SSTC END AS SSTC,
           CASE WHEN B.SLIN = '0' THEN NULL ELSE B.SLIN END AS SLIN,
           B.PROV_NAME,
           B.CITC_NAME,
           B.COUC_NAME,
           B.STAC_NAME,
           B.SSTC_NAME,
           B.SLIN_NAME, 
           B.ORG_UNIQUE_CD,
           B.ORG_NAME
      FROM B_ORG B
     WHERE B.ORG_TYPE = '2'
  ) B
  ON (B.ORG_UNIQUE_CD = A.ORG_CD AND A.DATA_STATE = '1'  AND A.BUSINESS_YEAR >= V_PT_YEAR AND A.PROV_NAME IS NULL) 
  WHEN MATCHED THEN
    UPDATE SET
           A.PROV       = B.PROV      ,
           A.CITC       = B.CITC      ,
           A.COUC       = B.COUC      ,
           A.STAC       = B.STAC      ,
           A.SSTC       = B.SSTC      ,
           A.SLIN       = B.SLIN      ,
           A.PROV_NAME  = B.PROV_NAME ,
           A.CITC_NAME  = B.CITC_NAME ,
           A.COUC_NAME  = B.COUC_NAME ,
           A.STAC_NAME  = B.STAC_NAME ,
           A.SSTC_NAME  = B.SSTC_NAME ,
           A.SLIN_NAME  = B.SLIN_NAME ,
           A.ORG_NAME   = B.ORG_NAME   
  ;--
  COMMIT;--
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  MERGE INTO R_PT_PLOUGH_FM_D A
  USING
  (
    SELECT CASE WHEN B.AREA_PROV = '0' THEN NULL ELSE B.AREA_PROV END AS AREA_PROV,
           CASE WHEN B.AREA_CITC = '0' THEN NULL ELSE B.AREA_CITC END AS AREA_CITC,
           CASE WHEN B.AREA_COUC = '0' THEN NULL ELSE B.AREA_COUC END AS AREA_COUC,
           CASE WHEN B.AREA_TOWN = '0' THEN NULL ELSE B.AREA_TOWN END AS AREA_TOWN,
           CASE WHEN B.AREA_VAGE = '0' THEN NULL ELSE B.AREA_VAGE END AS AREA_VAGE,
           CASE WHEN B.AREA_GRUP = '0' THEN NULL ELSE B.AREA_GRUP END AS AREA_GRUP,
           B.AREA_PROV_NAME,
           B.AREA_CITC_NAME,
           B.AREA_COUC_NAME,
           B.TOWN_NAME,
           B.VAGE_NAME,
           B.GRUP_NAME, 
           B.DIVISION_UNIQUE_CD,
           B.ORG_NAME
      FROM B_DIVISION B
  ) B
  ON (B.DIVISION_UNIQUE_CD = A.AREA_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND A.PROV_NAME IS NULL) 
  WHEN MATCHED THEN
    UPDATE SET
           A.AREA_PROV      = B.AREA_PROV     ,
           A.AREA_CITC      = B.AREA_CITC     ,
           A.AREA_COUC      = B.AREA_COUC     ,
           A.AREA_TOWN      = B.AREA_TOWN     ,
           A.AREA_VAGE      = B.AREA_VAGE     ,
           A.AREA_GRUP      = B.AREA_GRUP     ,
           A.AREA_PROV_NAME = B.AREA_PROV_NAME,
           A.AREA_CITC_NAME = B.AREA_CITC_NAME,
           A.AREA_COUC_NAME = B.AREA_COUC_NAME,
           A.TOWN_NAME      = B.TOWN_NAME     ,
           A.VAGE_NAME      = B.VAGE_NAME     ,
           A.GRUP_NAME      = B.GRUP_NAME     ,
           A.AREA_NAME      = B.ORG_NAME       
  ;--
  COMMIT;--
  --UPDATE R_PT_PLOUGH_FM_D A
  --   SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
  -- WHERE A.BUSINESS_YEAR >= V_PT_YEAR
  --   AND A.LEAF_VARIETY_NAME IS NULL
  --;--

  --COMMIT;--


  SET V_STEP = '3 R_PT_PLOUGH_DV_D-D';--
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  DELETE FROM R_PT_PLOUGH_DV_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;--
  

  SET V_STEP = '4 R_PT_PLOUGH_DV_D-I';--
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  INSERT INTO R_PT_PLOUGH_DV_D
  (
    PLOUGH_DV_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PLOUGH_AREA,
    PROPESS_AREA,
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
  )
  SELECT Hex(generate_unique())      AS PLOUGH_DV_D_ID,
         '0'                         AS SEND_STATE,
         '1'                         AS DATA_STATE,
         MAX(MODIFY_TIME)            AS MODIFY_TIME,
         V_CURRENTTIMESTAMP         AS LAST_TIME,
         BUSINESS_YEAR               AS BUSINESS_YEAR,
         BUSINESS_DATE               AS BUSINESS_DATE,
         SUM(PLOUGH_AREA)            AS PLOUGH_AREA,
         SUM(PROPESS_AREA)           AS PROPESS_AREA,
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
    FROM R_PT_PLOUGH_FM_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.BUSINESS_YEAR,
         T.BUSINESS_DATE,
         T.ORG_CD,
         T.ORG_NAME,
         T.PROV,
         T.PROV_NAME,
         T.CITC,
         T.CITC_NAME,
         T.COUC,
         T.COUC_NAME,
         T.STAC,
         T.STAC_NAME,
         T.SSTC,
         T.SSTC_NAME,
         T.AREA_CD,
         T.AREA_NAME,
         T.AREA_PROV,
         T.AREA_PROV_NAME,
         T.AREA_CITC,
         T.AREA_CITC_NAME,
         T.AREA_COUC,
         T.AREA_COUC_NAME,
         T.AREA_TOWN,
         T.TOWN_NAME,
         T.AREA_VAGE,
         T.VAGE_NAME,
         T.AREA_GRUP,
         T.GRUP_NAME
  WITH UR
  ;--
  COMMIT;--

  SET V_STEP = '5 R_PT_PLOUGH_CB_D-D';--
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  DELETE FROM R_PT_PLOUGH_CB_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;--
 
  SET V_STEP = '6 R_PT_PLOUGH_CB_D-I';--
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);--
  INSERT INTO R_PT_PLOUGH_CB_D
  (
    PLOUGH_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PLOUGH_AREA,
    PROPESS_AREA,
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
  )
  SELECT Hex(generate_unique())          AS PLOUGH_CB_D_ID,
         '0'                             AS SEND_STATE,
         '1'                             AS DATA_STATE,
         MAX(MODIFY_TIME)                AS MODIFY_TIME,
         V_CURRENTTIMESTAMP             AS LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE                   AS BUSINESS_DATE,
         SUM(PLOUGH_AREA)                AS PLOUGH_AREA,
         SUM(PROPESS_AREA)               AS PROPESS_AREA,
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
    FROM R_PT_PLOUGH_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.BUSINESS_YEAR,
         T.BUSINESS_DATE,
         T.ORG_CD,
         T.ORG_NAME,
         T.PROV,
         T.PROV_NAME,
         T.CITC,
         T.CITC_NAME,
         T.COUC,
         T.COUC_NAME,
         T.STAC,
         T.STAC_NAME,
         T.SSTC,
         T.SSTC_NAME
  WITH UR
  ;--
  COMMIT;--
END
@