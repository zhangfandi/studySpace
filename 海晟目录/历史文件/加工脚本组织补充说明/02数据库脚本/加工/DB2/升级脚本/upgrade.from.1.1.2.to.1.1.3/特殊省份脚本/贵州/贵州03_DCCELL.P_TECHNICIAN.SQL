--DROP PROCEDURE DCCELL.P_TECHNICIAN;
CREATE PROCEDURE DCCELL.P_TECHNICIAN
------------------------------------------------------------
--烟农
--linds
--2016-03-04
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME           VARCHAR(32) DEFAULT 'P_TECHNICIAN';
  DECLARE V_YEAR                DECIMAL(4);
  --标志位
  DECLARE C_ENABLE_FLAG         CHAR(1) DEFAULT '1';
  DECLARE C_DISABLE_FLAG        CHAR(1) DEFAULT '0';
  DECLARE C_EMPTYVALUE          VARCHAR(32) DEFAULT 'XXXXXXX';
  
  DECLARE V_CURRENTTIMESTAMP    TIMESTAMP  ; 
  DECLARE V_LOG_GROUP           VARCHAR(32);
  DECLARE V_LAST_STEP           VARCHAR(32);
  DECLARE V_LOG                 VARCHAR(32);
 
  DECLARE SQLSTMT VARCHAR(2000) DEFAULT '';
  DECLARE STMT STATEMENT;
 
  ------------------------------------------------------------
  --
  ------------------------------------------------------------
  SET V_CURRENTTIMESTAMP = CURRENT TIMESTAMP;
  SET V_LOG = ' ';
  SET V_LOG_GROUP = TO_CHAR(V_CURRENTTIMESTAMP,'YYYY-MM-DD HH24:MI:SS');

  --无日志删除N表
  SELECT BUSI_YEAR INTO V_YEAR
    FROM DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = V_PROC_NAME
  ;

  
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'TECHNICIAN-EMPTY',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  SET SQLSTMT = 'ALTER TABLE R_TECHNICIAN ACTIVATE NOT LOGGED INITIALLY WITH EMPTY TABLE';
  PREPARE STMT FROM SQLSTMT;
  EXECUTE STMT;
  COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'TECHNICIAN-MERGE',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_TECHNICIAN A
  USING (
    SELECT TECHNICIAN_ID AS TECHNICIAN_ID,
           TECHNICIAN_CD AS TECHNICIAN_CD,
           TECHNICIAN_NAME AS TECHNICIAN_NAME,
           ORG_UNIQUE_CD AS ORG_UNIQUE_CD,
           TEL,
           ADDR,
           IDTY_TYPE,
           IDTY_ID,
           SEX,
           BIRTH_DATE
      FROM V_TECHNICIAN 
  ) B  ON (A.TECHNICIAN_ID = B.TECHNICIAN_ID)
  WHEN NOT MATCHED THEN
    INSERT 
    (
     A.TECHNICIAN_ID          ,
     A.TECHNICIAN_CD          ,
     A.TECHNICIAN_NAME        ,
     A.ORG_UNIQUE_CD          , 
     A.TEL                    ,
     A.ADDR                   ,
     A.IDTY_TYPE              ,
     A.IDTY_ID                ,
     A.SEX                    ,
     A.BIRTH_DATE             ,
     A.BUSINESS_YEAR          ,
     A.PROC_NAME 
    )VALUES
    (
     B.TECHNICIAN_ID          ,
     B.TECHNICIAN_CD          ,
     B.TECHNICIAN_NAME        ,
     B.ORG_UNIQUE_CD          ,
     B.TEL                    ,
     B.ADDR                   ,
     B.IDTY_TYPE              ,
     B.IDTY_ID                ,
     B.SEX                    ,
     B.BIRTH_DATE             ,
     V_YEAR               ,
     V_PROC_NAME
    )
    ;
   COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'TECHNICIAN-ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_TECHNICIAN A
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
           B.ORG_CD,
           B.ORG_NAME,
           B.ORG_UNIQUE_CD
      FROM B_ORG B
     WHERE B.ORG_TYPE = '2'
  ) B
  ON (B.ORG_UNIQUE_CD = A.ORG_UNIQUE_CD AND A.DATA_STATE = '1') 
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
  --call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'TECHNICIAN-DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  --MERGE INTO R_TECHNICIAN A
  --USING
  --(
  --  SELECT CASE WHEN B.AREA_PROV = '0' THEN NULL ELSE B.AREA_PROV END AS AREA_PROV,
  --         CASE WHEN B.AREA_CITC = '0' THEN NULL ELSE B.AREA_CITC END AS AREA_CITC,
  --         CASE WHEN B.AREA_COUC = '0' THEN NULL ELSE B.AREA_COUC END AS AREA_COUC,
  --         CASE WHEN B.AREA_TOWN = '0' THEN NULL ELSE B.AREA_TOWN END AS AREA_TOWN,
  --         CASE WHEN B.AREA_VAGE = '0' THEN NULL ELSE B.AREA_VAGE END AS AREA_VAGE,
  --         CASE WHEN B.AREA_GRUP = '0' THEN NULL ELSE B.AREA_GRUP END AS AREA_GRUP,
  --         B.AREA_PROV_NAME,
  --         B.AREA_CITC_NAME,
  --         B.AREA_COUC_NAME,
  --         B.TOWN_NAME,
  --         B.VAGE_NAME,
  --         B.GRUP_NAME,
  --         B.ORG_CD,
  --         B.ORG_NAME
  --    FROM B_DIVISION B
  --) B
  --ON (B.ORG_CD = A.AREA_CD AND A.DATA_STATE = '1') 
  --WHEN MATCHED THEN
  --  UPDATE SET
  --         A.AREA_PROV      = B.AREA_PROV     ,
  --         A.AREA_CITC      = B.AREA_CITC     ,
  --         A.AREA_COUC      = B.AREA_COUC     ,
  --         A.AREA_TOWN      = B.AREA_TOWN     ,
  --         A.AREA_VAGE      = B.AREA_VAGE     ,
  --         A.AREA_GRUP      = B.AREA_GRUP     ,
  --         A.AREA_PROV_NAME = B.AREA_PROV_NAME,
  --         A.AREA_CITC_NAME = B.AREA_CITC_NAME,
  --         A.AREA_COUC_NAME = B.AREA_COUC_NAME,
  --         A.TOWN_NAME      = B.TOWN_NAME     ,
  --         A.VAGE_NAME      = B.VAGE_NAME     ,
  --         A.GRUP_NAME      = B.GRUP_NAME     ,
  --         A.AREA_NAME      = B.ORG_NAME       
  --;
  --COMMIT;

END
@