--DROP PROCEDURE DCCELL.P_FRMR_TECH_REL;
CREATE PROCEDURE DCCELL.P_FRMR_TECH_REL   
  LANGUAGE SQL
  NOT DETERMINISTIC
  CALLED ON NULL INPUT
  EXTERNAL ACTION
  OLD SAVEPOINT LEVEL
  MODIFIES SQL DATA
  INHERIT SPECIAL REGISTERS
  ------------------------------------------------------------
--烟农与烟技员关系
--linds
--2016-03-04
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME           VARCHAR(32) DEFAULT 'P_FRMR_TECH_REL';
  DECLARE V_YEAR                DECIMAL(4);
  --标志位
  DECLARE C_ENABLE_FLAG         CHAR(1) DEFAULT '1';
  DECLARE C_DISABLE_FLAG        CHAR(1) DEFAULT '0';
  DECLARE C_EMPTYVALUE       VARCHAR(32) DEFAULT 'XXXXXXX';

  DECLARE SQLSTMT VARCHAR(2000) DEFAULT '';
  DECLARE STMT STATEMENT;
  
 
  ------------------------------------------------------------
  --
  ------------------------------------------------------------
  SELECT BUSI_YEAR INTO V_YEAR
    FROM DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = V_PROC_NAME
  ;
  --无日志删除N表
  SET SQLSTMT = 'ALTER TABLE R_FRMR_TECH_REL ACTIVATE NOT LOGGED INITIALLY WITH EMPTY TABLE';
  PREPARE STMT FROM SQLSTMT;
  EXECUTE STMT;
  COMMIT;

  MERGE INTO R_FRMR_TECH_REL A
  USING (
      SELECT FARMER_TECHNICIAN_ID,
             TECHNICIAN_ID       ,
             TECHNICIAN_NAME     ,
             FARMER_ID           ,
             FARMER_CD           ,
             FARMER_NAME         ,
             BUSINESS_YEAR       ,
             ORG_CD               
        FROM V_FRMR_TECH_REL  
       WHERE BUSINESS_YEAR_F = V_YEAR
  ) B  ON (A.FARMER_TECHNICIAN_ID = B.FARMER_TECHNICIAN_ID)
  WHEN NOT MATCHED THEN
    INSERT 
    (
      A.FARMER_TECHNICIAN_ID ,
      A.TECHNICIAN_ID        ,
      A.TECHNICIAN_NAME      ,
      A.FARMER_ID            ,
      A.FARMER_CD            ,
      A.FARMER_NAME          ,
      A.BUSINESS_YEAR        ,
      A.ORG_CD               ,
      A.DATA_STATE           ,
      A.PROC_NAME
    )VALUES
    (
      B.FARMER_TECHNICIAN_ID ,
      B.TECHNICIAN_ID        ,
      B.TECHNICIAN_NAME      ,
      B.FARMER_ID            ,
      B.FARMER_CD            ,
      B.FARMER_NAME          ,
      B.BUSINESS_YEAR        ,
      B.ORG_CD               ,
      C_ENABLE_FLAG          ,
      V_PROC_NAME
    )
    ;
  COMMIT;

  UPDATE R_FRMR_TECH_REL A
     SET (
           FARMER_NAME,
           ORG_NAME      ,
           PROV          ,
           PROV_NAME     ,
           CITC          ,
           CITC_NAME     ,
           COUC          ,
           COUC_NAME     ,
           STAC          ,
           STAC_NAME     ,
           SSTC          ,
           SSTC_NAME     ,
           SLIN          ,
           SLIN_NAME     ,
           AREA_CD       ,
           AREA_NAME     ,
           AREA_PROV     ,
           AREA_PROV_NAME,
           AREA_CITC     ,
           AREA_CITC_NAME,
           AREA_COUC     ,
           AREA_COUC_NAME,
           AREA_TOWN     ,
           TOWN_NAME     ,
           AREA_VAGE     ,
           VAGE_NAME     ,
           AREA_GRUP     ,
           GRUP_NAME     
         ) = (
               SELECT FARMER_NAME,
                      ORG_NAME      ,
                      PROV          ,
                      PROV_NAME     ,
                      CITC          ,
                      CITC_NAME     ,
                      COUC          ,
                      COUC_NAME     ,
                      STAC          ,
                      STAC_NAME     ,
                      SSTC          ,
                      SSTC_NAME     ,
                      SLIN          ,
                      SLIN_NAME     ,
                      AREA_CD       ,
                      AREA_NAME     ,
                      AREA_PROV     ,
                      AREA_PROV_NAME,
                      AREA_CITC     ,
                      AREA_CITC_NAME,
                      AREA_COUC     ,
                      AREA_COUC_NAME,
                      AREA_TOWN     ,
                      TOWN_NAME     ,
                      AREA_VAGE     ,
                      VAGE_NAME     ,
                      AREA_GRUP     ,
                      GRUP_NAME     
                 FROM R_FARMER B
                WHERE A.FARMER_CD = B.FARMER_CD
                  AND B.DATA_STATE = '1'
             )
   WHERE EXISTS (
                  SELECT 1
                    FROM R_FARMER B
                   WHERE A.FARMER_CD = B.FARMER_CD
                     AND B.DATA_STATE = '1'
                )
  ;
  COMMIT;

  UPDATE R_FRMR_TECH_REL A
     SET (TECHNICIAN_CD,TECHNICIAN_NAME) =(SELECT TECHNICIAN_CD,TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID AND B.DATA_STATE = '1')
   WHERE EXISTS (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID AND B.DATA_STATE = '1')
  ;
  COMMIT;

END;
@