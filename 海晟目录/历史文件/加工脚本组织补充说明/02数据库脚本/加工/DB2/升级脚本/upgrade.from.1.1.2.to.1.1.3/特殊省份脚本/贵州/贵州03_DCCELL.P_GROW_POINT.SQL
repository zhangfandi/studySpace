--DROP PROCEDURE DCCELL.P_GROW_POINT;
CREATE PROCEDURE DCCELL.P_GROW_POINT
------------------------------------------------------------
--育苗点
--LINHQ,LINDS
--2017-02-20
------------------------------------------------------------
BEGIN
   DECLARE V_YEAR             DECIMAL(4);
   DECLARE V_GROW_POINT_ID    VARCHAR(32);
   DECLARE V_SERVER_ORG_CD    VARCHAR(32);
   
   DECLARE cur_no              int DEFAULT 0; 
   DECLARE sqlcode             integer   default 0;
   DECLARE not_found           condition for sqlstate '02000'; 


   DECLARE CUR_1 CURSOR WITH HOLD FOR
    SELECT GROW_POINT_ID,ORG_UNIQUE_CD
      FROM R_GROW_POINT_Y01 A
     WHERE ORG_UNIQUE_CD IS NOT NULL AND LENGTH(ORG_UNIQUE_CD) > 0
   ;
       
  DECLARE continue handler for not_found BEGIN set cur_no=1; END;

  SELECT BUSI_YEAR INTO V_YEAR
    FROM DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = 'P_GROW_POINT'
  ;

  DELETE FROM R_GROW_POINT_Y01;
  COMMIT;
    
  MERGE INTO R_GROW_POINT_Y01 A
  USING(
    SELECT  
        C.GROW_POINT_ID AS GROW_POINT_ID,
        C.GROW_POINT_CD AS GROW_POINT_CD,
        C.TYPE_CD_PD AS GROW_POINT_TYPE,
        C.BUILD_DATE AS BUILD_YEAR,
        C.FACILITY_STATE AS FACILITY_STATE,
        C.SERVER_ORG_CD AS ORG_UNIQUE_CD,
        C.VILLAGE_UNIQUE_CD AS DIVISION_UNIQUE_CD,
        '0' AS SEND_STATE,
        '1' AS DATA_STATE
     FROM TP_GROW_POINT C
    WHERE C.DATA_STATE = '1'
      AND C.USE_TYPE = 'PT'
      AND TYPE_CD_PD IN ('GROW_GC','GROW_POINT')
      AND SERVER_ORG_CD IS NOT NULL
    --AND CASE(C.BUILD_DATE AS DECIMAL(4)) = V_YEAR
    ) B ON (A.GROW_POINT_ID=B.GROW_POINT_ID  )
   WHEN MATCHED THEN
    UPDATE SET          
       A.GROW_POINT_CD = B.GROW_POINT_CD,
       A.GROW_POINT_TYPE = B.GROW_POINT_TYPE,          
       A.BUILD_YEAR = B.BUILD_YEAR,        
       A.FACILITY_STATE = B.FACILITY_STATE,
       A.ORG_UNIQUE_CD = B.ORG_UNIQUE_CD,
       A.DIVISION_UNIQUE_CD = B.DIVISION_UNIQUE_CD,
       A.SEND_STATE = B.SEND_STATE,
       A.DATA_STATE = B.DATA_STATE        
   WHEN NOT MATCHED THEN
    INSERT
    (
        A.GROW_POINT_ID,
        A.GROW_POINT_CD,
        A.GROW_POINT_TYPE,
        A.BUILD_YEAR,
        A.FACILITY_STATE,   
        A.ORG_UNIQUE_CD,
        A.DIVISION_UNIQUE_CD,
        A.SEND_STATE,
        A.DATA_STATE        
    )
    VALUES
    (
        B.GROW_POINT_ID,
        B.GROW_POINT_CD,
        B.GROW_POINT_TYPE,
        B.BUILD_YEAR,
        B.FACILITY_STATE,            
        B.ORG_UNIQUE_CD,
        B.DIVISION_UNIQUE_CD,
        B.SEND_STATE,
        B.DATA_STATE            
    );
    COMMIT;

    
    MERGE INTO R_GROW_POINT_Y01 A
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

    MERGE INTO R_GROW_POINT_Y01 A
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
       B.ORG_NAME,
       B.DIVISION_UNIQUE_CD
    FROM B_DIVISION B
    ) B
    ON (B.DIVISION_UNIQUE_CD = A.DIVISION_UNIQUE_CD AND A.DATA_STATE = '1') 
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
       A.DIVISION_NAME  = B.ORG_NAME       
    ;
    COMMIT;
   ------------------------------------------------------------
   --育苗点与组织单位关系 
   ------------------------------------------------------------
   UPDATE R_GROW_POINT_ORG_REL_Y01
      set DATA_STATE = '0'
   ;
   
   SET cur_no = 0;
   OPEN CUR_1;
   CUR_1_LOOP:
   LOOP
     FETCH CUR_1 INTO  V_GROW_POINT_ID,V_SERVER_ORG_CD;
     IF cur_no = 1 THEN
          CLOSE CUR_1;
          LEAVE CUR_1_LOOP;
     END IF;

    MERGE INTO R_GROW_POINT_ORG_REL_Y01 A
    USING
    (
      select cast(V_GROW_POINT_ID||a.param as varchar(128)) as REL_ID,
             V_GROW_POINT_ID as GROW_POINT_ID,
             a.param as ORG_UNIQUE_CD
        from table(split(V_SERVER_ORG_CD)) a
    ) B
    ON (A.REL_ID = B.REL_ID) 
    WHEN MATCHED THEN
    UPDATE SET
       A.GROW_POINT_ID      = B.GROW_POINT_ID     ,
       A.ORG_UNIQUE_CD      = B.ORG_UNIQUE_CD     ,
       A.DATA_STATE         = '1' 
    WHEN NOT MATCHED THEN
    INSERT
    (
     A.REL_ID,
     A.GROW_POINT_ID,
     A.ORG_UNIQUE_CD,
     A.SEND_STATE     ,
     A.DATA_STATE     ,
     A.MODIFY_TIME    ,
     A.LAST_TIME      
    )VALUES
    (
     B.REL_ID,
     B.GROW_POINT_ID,
     B.ORG_UNIQUE_CD,
     '0',
     '1',
     current timestamp,
     current timestamp
    )
    ;
   COMMIT;
   END LOOP CUR_1_LOOP;
   DELETE FROM R_GROW_POINT_ORG_REL_Y01 WHERE DATA_STATE = '0';
   COMMIT;

    MERGE INTO R_GROW_POINT_ORG_REL_Y01 A
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
    ON (B.ORG_UNIQUE_CD = A.ORG_UNIQUE_CD) 
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

    MERGE INTO R_GROW_POINT_ORG_REL_Y01 A
    USING
    (
    SELECT GROW_POINT_ID  ,
           GROW_POINT_CD  ,
           GROW_POINT_NAME
    FROM R_GROW_POINT_Y01 B
    ) B
    ON (B.GROW_POINT_ID = A.GROW_POINT_ID) 
    WHEN MATCHED THEN
    UPDATE SET
       A.GROW_POINT_CD       = B.GROW_POINT_CD      ,
       A.GROW_POINT_NAME       = B.GROW_POINT_NAME      
    ;
    COMMIT;

    DELETE FROM R_GROW_POINT;
    INSERT INTO R_GROW_POINT   SELECT * FROM R_GROW_POINT_Y01;
    COMMIT;

    DELETE FROM R_GROW_POINT_ORG_REL;
    INSERT INTO R_GROW_POINT_ORG_REL   SELECT * FROM R_GROW_POINT_ORG_REL_Y01;
    COMMIT;
END
@