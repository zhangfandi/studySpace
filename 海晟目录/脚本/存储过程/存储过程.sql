--增加加工表（R_PT_FOR_SEED_FM_Y）字段（BIG_CANOPY_ID，BIG_CANOPY_NAME）
ALTER TABLE R_PT_FOR_SEED_FM_Y ADD BIG_CANOPY_ID VARCHAR(32);
ALTER TABLE R_PT_FOR_SEED_FM_Y ADD BIG_CANOPY_NAME VARCHAR(64);

------------------------------------------------------------
--
-- 创建视图+过程
--
--
------------------------------------------------------------
--DROP VIEW TSO.V_PT_FOR_SEED_AB_D;
CREATE VIEW TSO.V_PT_FOR_SEED_AB_D
 AS 
SELECT DISTINCT
    A.DATA_STORE_BASE_TBL_ID AS ID,
    A.PT_YEAR                AS BUSINESS_YEAR,
    A.C6                     AS FARMER_ID, --烟农ID
    A.C2                     AS FARMER_CD, --烟农编号
    A.C3                     AS FARMER_NAME, --烟农名称
    A.C4                     AS LEAF_VARIETY_CD, --烟叶品种代码
    N.LEAF_VARIETY_NAME      AS LEAF_VARIETY_NAME, --烟叶品种名称
    A.N1                     AS SUPPLY_AREA, --供苗面积(亩)
    A.N2                     AS SUPPLY_QTY, --供苗株数(株)
    A.RELA_OBJECT_ID     AS GROW_POINT_ID, --育苗点ID
    A.RELA_OBJECT_CD     AS GROW_POINT_CD, --育苗点编号
    A.RELA_OBJECT_NAME   AS GROW_POINT_NAME, --育苗点名称
    J.NAME               AS GROW_POINT_TYPE_NAME, --育苗点设施类型名称
    A.CLT_OBJ_ID         AS BIG_CANOPY_ID, --育苗棚ID(指标)
    A.CLT_OBJ_CD         AS BIG_CANOPY_CD, --育苗棚编号(指标)
    A.CLT_OBJ_NAME       AS BIG_CANOPY_NAME, --育苗棚名称(指标)
    H.BIG_CANOPY_TYPE_CD AS BIG_CANOPY_TYPE_CD, --育苗棚类型编号
    K.NAME               AS CANOPY_TYPE_NAME, --育苗棚设施类型名称
    A.FEEDBACK_PSN_ID   AS TECHNICAN_ID, --烟技员ID
    G.PSN_NAME          AS TECHNICAN_NAME, --烟技员名称
    G.MOBILE            AS TECHNICAN_PHONE, --烟技员电话
    I.STATION_UNIQUE_CD AS ORG_CD,
    I.VILLAGE_UNIQUE_CD AS AREA_CD,
    A.SEND_STATE,
    A.DATA_STATE,
    A.MODIFY_TIME,
    A.LAST_TIME
FROM
    PT_DC_STAT_DATA_B A
    /*职工档案信息*/
LEFT JOIN
    CM_OM_STAFF G ON A.FEEDBACK_PSN_ID = G.STAFF_ID
    /*育苗棚信息*/
LEFT JOIN
    TP_BIG_CANOPY H ON A.CLT_OBJ_ID = H.BIG_CANOPY_ID
    /*育苗点档案信息*/
LEFT JOIN
    TP_GROW_POINT I ON A.RELA_OBJECT_ID = I.GROW_POINT_ID
    /*育苗点设施类型信息*/
LEFT JOIN
    CM_OT_ENUM_TYPE J ON I.TYPE_CD = J.ENUM_KEY
    /*育苗棚设施类型信息*/
LEFT JOIN
    CM_OT_ENUM_TYPE K ON H.BIG_CANOPY_TYPE_CD = K.ENUM_KEY
LEFT JOIN
    PT_AS_CANOPY_SET M ON H.BIG_CANOPY_ID = M.CANOPY_ID
LEFT JOIN
    CM_TB_LEAF_VARIETY N ON A.C4 = N.LEAF_VARIETY_CD
WHERE
    A.DATA_STATE = '1'
AND A.BILL_NO = 'TJ23000000000021'
AND G.DATA_STATE='1'
AND H.DATA_STATE='1'
AND I.DATA_STATE='1'
    /*育苗点设施类型枚举*/
AND J.DATA_STATE='1'
AND J.ENUM_TYPE_CD = 'GROW_POINT_TYPE_EK_PD'
    /*育苗棚设施类型枚举*/
AND K.DATA_STATE='1'
AND K.ENUM_TYPE_CD = 'CANOPY_TYPE_EK'
    /*育苗棚苗床面积设置*/
AND M.DATA_STATE='1'
AND M.PT_YEAR = A.PT_YEAR
AND N.DATA_STATE='1'
AND N.RELATE_BIZ_EK LIKE '%CONTRACT%'
AND A.CHECK_STATE = '1'
AND EXISTS
    (
        SELECT
            1
        FROM
            TSO.PT_AS_TLG_FACILITY D
        WHERE
            D.FACILITY_ID = A.CLT_OBJ_ID
        AND D.DATA_STATE='1'
        AND D.PT_YEAR = A.PT_YEAR
        AND D.FACILITY_TYPE_EK='GROW_SHACK')
  ;

  DROP NICKNAME DCCELL.V_PT_FOR_SEED_AB_D ;
CREATE NICKNAME DCCELL.V_PT_FOR_SEED_AB_D      FOR TSOSERVER.TSO.V_PT_FOR_SEED_AB_D;

 DROP PROCEDURE DCCELL.P_R_PT_FOR_SEED_AB_D_HLJ;
CREATE PROCEDURE DCCELL.P_R_PT_FOR_SEED_AB_D_HLJ
-----------------------------------------------------
--LINGM 
-----------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME                 VARCHAR(1000) DEFAULT 'P_R_PT_FOR_SEED_AB_D';
  DECLARE V_STEP                      VARCHAR(500);
  DECLARE V_PT_YEAR                   INTEGER DEFAULT 2016;
  DECLARE V_BILL_NO                   VARCHAR(64) DEFAULT 'TJ23000000000021'; --单据编号


  DECLARE V_CURRENTTIMESTAMP       TIMESTAMP;
  
  DECLARE V_LOG_GROUP           VARCHAR(32);
  DECLARE V_LAST_STEP           VARCHAR(32);
  DECLARE V_LOG                 VARCHAR(32);


  SET V_CURRENTTIMESTAMP = CURRENT TIMESTAMP;
  SET V_LOG = ' ';
  SET V_LOG_GROUP = TO_CHAR(V_CURRENTTIMESTAMP,'YYYY-MM-DD HH24:MI:SS');

  SELECT BUSI_YEAR INTO V_PT_YEAR 
    FROM DC_PROC_BUSI_YEAR A 
   WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
  ;

  SET V_STEP = '1、R_PT_FOR_SEED_AB_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_FOR_SEED_AB_D T
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '2、R_PT_FOR_SEED_AB_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_FOR_SEED_FM_Y
  (
      FOR_SEED_FM_Y_ID, --ID
      BUSINESS_YEAR,
      GROW_CANOPY_ID,-- BIG_CANOPY_ID
      BIG_CANOPY_ID, 
      GROW_CANOPY_CD, -- BIG_CANOPY_CD
      GROW_CANOPY_NAME, --BIG_CANOPY_NAME
      BIG_CANOPY_NAME, 
      CANOPY_TYPE, --BIG_CANOPY_TYPE_CD
      GROW_POINT_ID, 
      GROW_POINT_CD, 
      GROW_POINT_NAME, 
      LEAF_VARIETY_CD, 
      TRANSPLANT_AREA, --SUPPLY_AREA
      FOR_SEED_QTY, --SUPPLY_QTY
      ORG_CD, -- ORG_CD
      AREA_CD, --AREA_CD
      TECHNICIAN_ID, --TECHNICAN_ID
      SEND_STATE, 
      DATA_STATE, 
      MODIFY_TIME,
      LAST_TIME,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      LEAF_VARIETY_NAME,
      GROW_TYPE_NAME, --GROW_POINT_TYPE_NAME
      CANOPY_TYPE_NAME
  )
  SELECT ID,
      BUSINESS_YEAR,
      BIG_CANOPY_ID,
      BIG_CANOPY_ID, 
      BIG_CANOPY_CD,
      BIG_CANOPY_NAME,
      BIG_CANOPY_NAME, 
      BIG_CANOPY_TYPE_CD,
      GROW_POINT_ID, 
      GROW_POINT_CD, 
      GROW_POINT_NAME, 
      LEAF_VARIETY_CD, 
      SUPPLY_AREA,
      SUPPLY_QTY,
      ORG_CD,
      AREA_CD,
      TECHNICAN_ID,
      SEND_STATE, 
      DATA_STATE, 
      MODIFY_TIME,
      CURRENT TIMESTAMP,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      LEAF_VARIETY_NAME,
      GROW_POINT_TYPE_NAME,
      CANOPY_TYPE_NAME
    FROM V_PT_FOR_SEED_AB_D
   WHERE BUSINESS_YEAR >= V_PT_YEAR
     AND DATA_STATE = '1'
  ;
  COMMIT;

  SET V_STEP = '3、R_PT_FOR_SEED_AB_D-U';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  UPDATE R_PT_FOR_SEED_AB_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;
  UPDATE R_PT_FOR_SEED_AB_D A
     SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
   WHERE A.BUSINESS_YEAR >= V_PT_YEAR
     AND A.LEAF_VARIETY_NAME IS NULL
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_FOR_SEED_AB_D A
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
 ON (B.ORG_UNIQUE_CD = A.ORG_CD AND A.DATA_STATE = '1'  AND A.BUSINESS_YEAR >= V_PT_YEAR AND (A.PROV IS NULL OR A.PROV_NAME IS NULL)) 
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
 ;
 COMMIT;
 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_FOR_SEED_AB_D A
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
 ON (B.DIVISION_UNIQUE_CD = A.AREA_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND (A.AREA_PROV IS NULL OR A.AREA_PROV_NAME IS NULL)) 
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
 ;
  COMMIT;

END;