--����
--DROP PROCEDURE DCCELL.P_PT_PLOUGH_FM_D;
 CREATE PROCEDURE DCCELL.P_PT_PLOUGH_FM_D 
---------------------------------------
--linds
---------------------------------------
BEGIN 
DECLARE V_PROC_NAME           VARCHAR(1000) DEFAULT 'P_PT_PLOUGH_FM_D';
DECLARE V_BILL_NO             VARCHAR(64) DEFAULT 'TJHNCD0000000001';
DECLARE V_STEP                VARCHAR(500);
DECLARE V_YEAR             INTEGER ;
DECLARE V_CURRENTTIMESTAMP    TIMESTAMP  ;
DECLARE V_LOG_GROUP           VARCHAR(32);
DECLARE V_LOG                 VARCHAR(32);


SET V_CURRENTTIMESTAMP = CURRENT TIMESTAMP;
SET V_LOG = ' ';
SET V_LOG_GROUP = TO_CHAR(V_CURRENTTIMESTAMP,'YYYY-MM-DD HH24:MI:SS');
SELECT BUSI_YEAR INTO V_YEAR 
  FROM DC_PROC_BUSI_YEAR A 
 WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
;


SET V_STEP = 'R_PT_PLOUGH_FM_D DELETE';
CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
DELETE FROM R_PT_PLOUGH_FM_D T WHERE T.BUSINESS_YEAR >= V_YEAR;
COMMIT;

SET V_STEP = 'R_PT_PLOUGH_FM_D MERGE';
CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
MERGE INTO R_PT_PLOUGH_FM_D A 
USING(
   SELECT 
PLOUGH_FM_D_ID,
FARMER_ID,
FARMER_CD,
FARMER_NAME,
BUSINESS_DATE,
BUSINESS_YEAR,
END_DATE,
PLOUGH_AREA,
IS_DEPTH_STAND,
IS_DEPTH_STAND_NAME,
IS_OPEN_TRENCH,
IS_OPEN_TRENCH_NAME,
IS_PROPESS,
IS_PROPESS_NAME,
WORK_EFFECT_EVAL,
WORK_EFFECT_EVAL_NAME,
SERV_ORG_ID,
ORG_CD,
AREA_CD 
  FROM V_PT_PLOUGH_FM_D 
 WHERE 1=1 AND DATA_STATE='1' AND BUSINESS_YEAR>= V_YEAR    
) B 
ON (A.PLOUGH_FM_D_ID = B.PLOUGH_FM_D_ID) 
WHEN MATCHED THEN 
UPDATE SET
  A.PLOUGH_FM_D_ID = B.PLOUGH_FM_D_ID,
  A.FARMER_ID = B.FARMER_ID,
  A.FARMER_CD = B.FARMER_CD,
  A.FARMER_NAME = B.FARMER_NAME,
  A.BUSINESS_DATE = B.BUSINESS_DATE,
  A.BUSINESS_YEAR = B.BUSINESS_YEAR,
  A.END_DATE = B.END_DATE,
  A.PLOUGH_AREA = B.PLOUGH_AREA,
  A.IS_DEPTH_STAND = B.IS_DEPTH_STAND,
  A.IS_DEPTH_STAND_NAME = B.IS_DEPTH_STAND_NAME,
  A.IS_OPEN_TRENCH = B.IS_OPEN_TRENCH,
  A.IS_OPEN_TRENCH_NAME = B.IS_OPEN_TRENCH_NAME,
  A.IS_PROPESS = B.IS_PROPESS,
  A.IS_PROPESS_NAME = B.IS_PROPESS_NAME,
  A.WORK_EFFECT_EVAL = B.WORK_EFFECT_EVAL,
  A.WORK_EFFECT_EVAL_NAME = B.WORK_EFFECT_EVAL_NAME,
  A.SERV_ORG_ID = B.SERV_ORG_ID,
  A.ORG_CD = B.ORG_CD,
  A.AREA_CD = B.AREA_CD 
WHEN NOT MATCHED THEN 
INSERT (
  A.PLOUGH_FM_D_ID,
  A.FARMER_ID,
  A.FARMER_CD,
  A.FARMER_NAME,
  A.BUSINESS_DATE,
  A.BUSINESS_YEAR,
  A.END_DATE,
  A.PLOUGH_AREA,
  A.IS_DEPTH_STAND,
  A.IS_DEPTH_STAND_NAME,
  A.IS_OPEN_TRENCH,
  A.IS_OPEN_TRENCH_NAME,
  A.IS_PROPESS,
  A.IS_PROPESS_NAME,
  A.WORK_EFFECT_EVAL,
  A.WORK_EFFECT_EVAL_NAME,
  A.SERV_ORG_ID,
  A.ORG_CD,
  A.AREA_CD
) 
 VALUES
 (
  B.PLOUGH_FM_D_ID,
  B.FARMER_ID,
  B.FARMER_CD,
  B.FARMER_NAME,
  B.BUSINESS_DATE,
  B.BUSINESS_YEAR,
  B.END_DATE,
  B.PLOUGH_AREA,
  B.IS_DEPTH_STAND,
  B.IS_DEPTH_STAND_NAME,
  B.IS_OPEN_TRENCH,
  B.IS_OPEN_TRENCH_NAME,
  B.IS_PROPESS,
  B.IS_PROPESS_NAME,
  B.WORK_EFFECT_EVAL,
  B.WORK_EFFECT_EVAL_NAME,
  B.SERV_ORG_ID,
  B.ORG_CD,
  B.AREA_CD
); 

COMMIT;
SET V_STEP = 'R_PT_PLOUGH_FM_D UPDATEORG';
CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
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
ON (B.ORG_UNIQUE_CD = A.ORG_CD AND A.DATA_STATE = '1'  AND A.BUSINESS_YEAR >= V_YEAR AND A.PROV_NAME IS NULL) 
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

SET V_STEP = 'R_PT_PLOUGH_FM_D UPDATEDIV';
CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
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
ON (B.ORG_UNIQUE_CD = A.ORG_CD AND A.DATA_STATE = '1'  AND A.BUSINESS_YEAR >= V_YEAR AND A.PROV_NAME IS NULL) 
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

END
@