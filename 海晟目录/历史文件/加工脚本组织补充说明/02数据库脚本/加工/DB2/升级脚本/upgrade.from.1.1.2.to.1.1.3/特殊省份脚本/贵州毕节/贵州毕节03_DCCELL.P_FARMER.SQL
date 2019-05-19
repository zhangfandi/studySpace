--DROP PROCEDURE DCCELL.P_FARMER;
CREATE PROCEDURE DCCELL.P_FARMER   
  LANGUAGE SQL
  NOT DETERMINISTIC
  CALLED ON NULL INPUT
  EXTERNAL ACTION
  OLD SAVEPOINT LEVEL
  MODIFIES SQL DATA
  INHERIT SPECIAL REGISTERS
  ------------------------------------------------------------
--烟农
--linds
--2016-03-04
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME           VARCHAR(32) DEFAULT 'P_FARMER';
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

  
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'FMR-EMPTY',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  SET SQLSTMT = 'ALTER TABLE R_FARMER ACTIVATE NOT LOGGED INITIALLY WITH EMPTY TABLE';
  PREPARE STMT FROM SQLSTMT;
  EXECUTE STMT;
  COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'FMR-MERGE',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_FARMER A
  USING (
     SELECT FARMER_ID            ,
            FARMER_CD            ,
            FARMER_NAME          ,
            FARMER_TEL           ,
            FARMER_ADDR          ,
            FARMER_IDTY_TYPE     ,
            FARMER_IDTY_ID       ,
            FARMER_IDTY_ID_18    ,
            CASE
              WHEN ISDATE(SUBSTR(FARMER_IDTY_ID_18,7,8)) >= 0 THEN
                TIMESTAMPDIFF
                (
                  256,
                  CHAR
                  (
                    CURRENT TIMESTAMP - TIMESTAMP(SUBSTR(FARMER_IDTY_ID_18,7,4)||'-'||
                                                  SUBSTR(FARMER_IDTY_ID_18,11,2)||'-'||
                                                  SUBSTR(FARMER_IDTY_ID_18,13,2)||' 00:00:00')
                  )
                )
              ELSE
                NULL
            END                      AS FARMER_AGE,--烟农年龄
            HOUSEHOLD_ID         ,
            AREA_CD              ,
            ORG_CD               ,
            SET_BANK_NAME        ,
            SET_BANK_ACCNT       ,
            BIRTH_DATE           ,
            EDUCTION             ,
            FAMY_PSN_QTY         ,
            WORK_PSN_QTY         ,
            PLOW_AREA            ,
            TB_AREA              ,
            FARMER_TYPE          ,
            IS_GOV_POOR_FLAG     ,
            IS_CAREER            ,
            '0' as send_state    ,
            '1' as data_state     
       FROM V_R_FARMER
      WHERE BUSINESS_YEAR = V_YEAR
        AND FARMER_CD IS NOT NULL
        AND FARMER_CD != ''
  ) B  ON (A.FARMER_ID = B.FARMER_ID)
  WHEN NOT MATCHED THEN
    INSERT 
    (
     A.FARMER_ID          ,
     A.FARMER_CD          ,
     A.FARMER_NAME        ,
     A.FARMER_TEL         ,
     A.FARMER_ADDR        ,
     A.FARMER_IDTY_TYPE   ,
     A.FARMER_IDTY_ID     ,
     A.FARMER_IDTY_ID_18  ,
     A.FARMER_AGE         ,
     A.HOUSEHOLD_ID       ,
     A.AREA_CD            ,
     A.ORG_CD             ,
     A.SET_BANK_NAME      ,
     A.SET_BANK_ACCNT     ,
     A.BIRTH_DATE         ,
     A.EDUCTION           ,
     A.FAMY_PSN_QTY       ,
     A.WORK_PSN_QTY       ,
     A.PLOW_AREA          ,
     A.TB_AREA            ,
     A.SEND_STATE         ,
     A.DATA_STATE         ,
     A.BUSINESS_YEAR      ,
     A.FARMER_TYPE        ,
     A.IS_GOV_POOR_FLAG   ,
     A.IS_CAREER          ,
     A.PROC_NAME 
    )VALUES
    (
     B.FARMER_ID          ,
     B.FARMER_CD          ,
     B.FARMER_NAME        ,
     B.FARMER_TEL         ,
     B.FARMER_ADDR        ,
     B.FARMER_IDTY_TYPE   ,
     B.FARMER_IDTY_ID     ,
     B.FARMER_IDTY_ID_18  ,
     B.FARMER_AGE         ,
     B.HOUSEHOLD_ID       ,
     B.AREA_CD            ,
     B.ORG_CD             ,
     B.SET_BANK_NAME      ,
     B.SET_BANK_ACCNT     ,
     B.BIRTH_DATE         ,
     B.EDUCTION           ,
     B.FAMY_PSN_QTY       ,
     B.WORK_PSN_QTY       ,
     B.PLOW_AREA          ,
     B.TB_AREA            ,
     B.SEND_STATE         ,
     B.DATA_STATE         ,
     V_YEAR               ,
     B.FARMER_TYPE        ,
     B.IS_GOV_POOR_FLAG   ,
     B.IS_CAREER          ,
     V_PROC_NAME
    )
    ;
   COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'FMR-ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_FARMER A
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
           B.ORG_NAME
      FROM B_ORG B
     WHERE B.ORG_TYPE = '2'
  ) B
  ON (B.ORG_CD = A.ORG_CD AND A.DATA_STATE = '1') 
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
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'FMR-DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_FARMER A
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
           B.ORG_CD,
           B.ORG_NAME
      FROM B_DIVISION B
  ) B
  ON (B.ORG_CD = A.AREA_CD AND A.DATA_STATE = '1') 
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
@