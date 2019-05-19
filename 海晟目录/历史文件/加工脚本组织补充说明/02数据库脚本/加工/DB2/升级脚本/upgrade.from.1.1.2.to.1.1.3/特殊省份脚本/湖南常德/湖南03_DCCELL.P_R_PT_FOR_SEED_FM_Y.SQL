--DROP PROCEDURE DCCELL.P_R_PT_FOR_SEED_FM_Y;
CREATE PROCEDURE DCCELL.P_R_PT_FOR_SEED_FM_Y
------------------------------------------------------------
--供苗阶段情况表加工过程_全量加工
--LINGM    2018-01-11
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME        VARCHAR(32) DEFAULT 'P_R_PT_FOR_SEED_FM_Y';
  DECLARE V_BILL_NO          VARCHAR(64) DEFAULT 'TJ00000000000004';--PT_DC_STAT_DATA_B
  DECLARE V_YEAR             DECIMAL(4);
  DECLARE V_CURRENT_TIME     TIMESTAMP;

  SET V_CURRENT_TIME = CURRENT TIMESTAMP;

  SELECT BUSI_YEAR INTO V_YEAR
    FROM DCCELL.DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
  ;

  --先删除已经存在的数据，再重新插入
  DELETE FROM DCCELL.R_PT_FOR_SEED_FM_Y B
   WHERE B.BUSINESS_YEAR >= V_YEAR
  ;

  INSERT INTO DCCELL.R_PT_FOR_SEED_FM_Y
  (
    FOR_SEED_FM_Y_ID    ,
    BUSINESS_YEAR       ,
    FOR_SEED_DATE       ,--供苗日期
    FARMER_CD           ,
    FARMER_NAME         ,
    GROW_CANOPY_ID      ,
    GROW_CANOPY_CD      ,--育苗棚CD
    GROW_CANOPY_NAME    ,--育苗棚名称
    FOR_SEED_PLATE_QTY  ,--发放盘数（张）
    FOR_SEED_QTY        ,--发放株数（株）
    TRANSPLANT_AREA     ,--供苗面积（亩）
    CANOPY_TYPE         ,--棚类型
    GROW_TYPE           ,--育苗方式
    TECHNICIAN_ID       ,
    SEND_STATE          ,
    DATA_STATE          ,
    MODIFY_TIME         ,
    LAST_TIME           
  )
  SELECT DATA_STORE_BASE_TBL_ID    AS FOR_SEED_FM_Y_ID    ,
         PT_YEAR                   AS BUSINESS_YEAR       ,
         D3                        AS FOR_SEED_DATE       ,--供苗日期
         C4                        AS FARMER_CD           ,
         C5                        AS FARMER_NAME         ,
         CLT_OBJ_ID                AS GROW_CANOPY_ID      ,
         CLT_OBJ_CD                AS GROW_CANOPY_CD      ,--育苗棚CD
         CLT_OBJ_NAME              AS GROW_CANOPY_NAME    ,--育苗棚名称
         N3                        AS FOR_SEED_PLATE_QTY  ,--发放盘数（张）
         N1                        AS FOR_SEED_QTY        ,--发放株数（株）
         N4                        AS TRANSPLANT_AREA     ,--供苗面积（亩）
         C1                        AS CANOPY_TYPE         ,--棚类型
         C3                        AS GROW_TYPE           ,--育苗方式
         FEEDBACK_PSN_ID           AS TECHNICIAN_ID,
         '0'                       AS SEND_STATE          ,
         '1'                       AS DATA_STATE          ,
         V_CURRENT_TIME            AS MODIFY_TIME         ,
         LAST_TIME                 AS LAST_TIME           
    FROM DCCELL.PT_DC_STAT_DATA_B A
   WHERE A.PT_YEAR >= V_YEAR
     AND A.BILL_NO = V_BILL_NO
     AND A.DATA_STATE = '1'
  ;

  --更新育苗点信息
  UPDATE DCCELL.R_PT_FOR_SEED_FM_Y A
     SET (
            A.GROW_POINT_ID  ,
            A.GROW_POINT_CD  ,
            A.GROW_POINT_NAME
         ) = (
                SELECT C.GROW_POINT_ID    AS GROW_POINT_ID  ,
                       C.GROW_POINT_CD    AS GROW_POINT_CD  ,
                       C.GROW_POINT_NAME  AS GROW_POINT_NAME
                  FROM R_BIG_CANOPY B
                       INNER JOIN R_GROW_POINT C ON B.GROW_POINT_ID = C.GROW_POINT_ID
                 WHERE B.BIG_CANOPY_ID = A.GROW_CANOPY_ID
         )
   WHERE A.BUSINESS_YEAR >= V_YEAR
  ;

  
  --更新育苗方式名称
  UPDATE DCCELL.R_PT_FOR_SEED_FM_Y A
     SET GROW_TYPE_NAME = (
                            SELECT ENUM_NAME
                              FROM DCCELL.PT_IX_ENUM_DATA B
                             WHERE B.IDX_ID='8a3c235944d06a3a0144d07287600011'
                               AND B.ENUM_CD = A.GROW_TYPE
                               AND B.DATA_STATE = '1'
                          )
   WHERE A.BUSINESS_YEAR >= V_YEAR
  ;

--更新棚类型名称
  UPDATE DCCELL.R_PT_FOR_SEED_FM_Y A
     SET CANOPY_TYPE_NAME = (
                              SELECT ENUM_NAME
                                FROM DCCELL.PT_IX_ENUM_DATA B
                               WHERE B.IDX_ID='8a3c365944d06a3a0144d07287600001'
                                 AND B.ENUM_CD = A.CANOPY_TYPE
                                 AND B.DATA_STATE = '1'
                            )
   WHERE A.BUSINESS_YEAR >= V_YEAR
  ;

  --更新烟技员名称
  UPDATE DCCELL.R_PT_FOR_SEED_FM_Y A
     SET TECHNICIAN_NAME = (
                              SELECT TECHNICIAN_NAME
                                FROM DCCELL.R_TECHNICIAN B
                               WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID
                                 AND B.DATA_STATE = '1'
                            )
   WHERE A.BUSINESS_YEAR >= V_YEAR
  ;

  --更新组织单位、行政区划信息
  UPDATE DCCELL.R_PT_FOR_SEED_FM_Y A
     SET (
           A.FARMER_ID,
           A.PROV     ,
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
           A.AREA_CD       ,
           A.AREA_NAME
         ) = (
               SELECT FARMER_ID,
                      CASE WHEN B.PROV = '0' THEN NULL ELSE B.PROV END AS PROV,
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
                      AREA_CD       ,
                      AREA_NAME
                 FROM DCCELL.R_FARMER B
                WHERE A.FARMER_CD = B.FARMER_CD
             )
   WHERE BUSINESS_YEAR >= V_YEAR
     AND EXISTS (
                  SELECT 1
                    FROM DCCELL.R_FARMER B
                   WHERE A.FARMER_CD = B.FARMER_CD
                )
  ;

  COMMIT;

END
@