--DROP PROCEDURE DCCELL.P_R_PT_GROW_AB_D;
CREATE PROCEDURE DCCELL.P_R_PT_GROW_AB_D
------------------------------------------------------------
--育苗播种情况表（按育苗点、日期、区分棚类型品种方式）加工过程_全量加工
--LINGM    2018-01-15
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME        VARCHAR(32) DEFAULT 'P_R_PT_GROW_AB_D';
  DECLARE V_BILL_NO          VARCHAR(64) DEFAULT 'TJ00000000000001';--播种,PT_DC_STAT_DATA_G
  -- DECLARE V_BILL_NO_2        VARCHAR(64) DEFAULT 'TJ00000000000002';--剪叶,PT_DC_STAT_DATA_H
  -- DECLARE V_BILL_NO_3        VARCHAR(64) DEFAULT 'TJ00000000000003';--出苗,PT_DC_STAT_DATA_A
  DECLARE V_YEAR             DECIMAL(4);
  DECLARE V_CURRENT_TIME     TIMESTAMP;

  SET V_CURRENT_TIME = CURRENT TIMESTAMP;

  SELECT BUSI_YEAR INTO V_YEAR
    FROM DCCELL.DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
  ;

  --先删除已经存在的数据，再重新插入
  DELETE FROM DCCELL.R_PT_GROW_AB_D B
   WHERE B.BUSINESS_YEAR >= V_YEAR
  ;

  INSERT INTO DCCELL.R_PT_GROW_AB_D
  (
    GROW_AB_D_ID       ,
    BUSINESS_YEAR      ,
    BUSINESS_DATE      ,
    GROW_CANOPY_ID     ,
    GROW_CANOPY_CD     ,
    GROW_CANOPY_NAME   ,
    TECHNICIAN_ID      ,
    CANOPY_TYPE        ,
    GROW_TYPE          ,
    LEAF_VARIETY_CD    ,
    GROW_PLATE_QTY     ,
    GROW_QTY           ,
    TRANSPLANT_AREA    ,
    ORG_CD             ,
    AREA_CD            ,
    SEND_STATE         ,
    DATA_STATE         ,
    MODIFY_TIME        ,
    LAST_TIME          
  )
  SELECT DATA_STORE_BASE_TBL_ID                                  AS GROW_AB_D_ID       ,
         PT_YEAR                                                 AS BUSINESS_YEAR      ,
         FEEDBACK_DATE                                           AS BUSINESS_DATE      ,
         CLT_OBJ_ID                                              AS GROW_CANOPY_ID     ,
         CLT_OBJ_CD                                              AS GROW_CANOPY_CD     ,--'育苗棚编号
         CLT_OBJ_NAME                                            AS GROW_CANOPY_NAME   ,--'育苗棚名称
         FEEDBACK_PSN_ID                                         AS TECHNICIAN_ID      ,--烟技员id
         C1                                                      AS CANOPY_TYPE        ,--棚类型
         C3                                                      AS GROW_TYPE          ,--育苗方式
         LEAF_VARIETY_CD                                         AS LEAF_VARIETY_CD    ,--烟叶品种
         COALESCE(N2,0)                                          AS GROW_PLATE_QTY     ,--盘数
        (case when C7 is null or c7 = '' then 0  else cast(C7 as decimal(24,6)) end)*COALESCE(N2,0)    AS GROW_QTY  ,--株数
         COALESCE(N3,0)                                          AS TRANSPLANT_AREA    ,--折算面积
         SITE_ORG_UNIQUE_CD                                      AS ORG_CD             ,
         V_DIVISION_UNIQUE_CD                                    AS AREA_CD            ,
         '0'                                                     AS SEND_STATE         ,
         '1'                                                     AS DATA_STATE         ,
         V_CURRENT_TIME                                          AS MODIFY_TIME        ,
         A.LAST_TIME                                             AS LAST_TIME          
    FROM DCCELL.PT_DC_STAT_DATA_G A 
   WHERE A.BILL_NO = V_BILL_NO
     AND A.PT_YEAR >= V_YEAR
     AND A.DATA_STATE = '1'
;
  --更新烟叶品种
  UPDATE DCCELL.R_PT_GROW_AB_D A
     SET LEAF_VARIETY_NAME = (
                               SELECT LEAF_VARIETY_NAME
                                 FROM R_LEAF_VARIETY B
                                WHERE A.LEAF_VARIETY_CD = B.LEAF_VARIETY_CD
                             )
   WHERE A.BUSINESS_YEAR >= V_YEAR
     AND EXISTS (
                  SELECT 1
                    FROM R_LEAF_VARIETY B
                   WHERE A.LEAF_VARIETY_CD = B.LEAF_VARIETY_CD
                )
  ;
  
  --更新育苗方式名称
  UPDATE DCCELL.R_PT_GROW_AB_D A
     SET GROW_TYPE_NAME = (
                            SELECT ENUM_NAME
                              FROM DCCELL.PT_IX_ENUM_DATA B
                             WHERE B.IDX_ID='8a3c235944d06a3a0144d07287600011'
                               AND B.ENUM_CD = A.GROW_TYPE
                               AND B.DATA_STATE = '1'
                          )
   WHERE A.BUSINESS_YEAR >= V_YEAR
     AND EXISTS (
                  SELECT 1
                    FROM DCCELL.PT_IX_ENUM_DATA B
                   WHERE B.IDX_ID='8a3c235944d06a3a0144d07287600011'
                     AND B.ENUM_CD = A.GROW_TYPE
                     AND B.DATA_STATE = '1'
                )
  ;

--更新棚类型名称
  UPDATE DCCELL.R_PT_GROW_AB_D A
     SET CANOPY_TYPE_NAME = (
                              SELECT ENUM_NAME
                                FROM DCCELL.PT_IX_ENUM_DATA B
                               WHERE B.IDX_ID='8a3c365944d06a3a0144d07287600001'
                                 AND B.ENUM_CD = A.CANOPY_TYPE
                                 AND B.DATA_STATE = '1'
                            )
   WHERE A.BUSINESS_YEAR >= V_YEAR
     AND EXISTS (
                  SELECT 1
                    FROM DCCELL.PT_IX_ENUM_DATA B
                   WHERE B.IDX_ID='8a3c365944d06a3a0144d07287600001'
                     AND B.ENUM_CD = A.CANOPY_TYPE
                     AND B.DATA_STATE = '1'
                )
  ;

  --更新烟技员名称
  UPDATE DCCELL.R_PT_GROW_AB_D A
     SET TECHNICIAN_NAME = (
                              SELECT TECHNICIAN_NAME
                                FROM DCCELL.R_TECHNICIAN B
                               WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID
                                 AND B.DATA_STATE = '1'
                            )
   WHERE A.BUSINESS_YEAR >= V_YEAR
     AND EXISTS (
                  SELECT 1
                    FROM DCCELL.R_TECHNICIAN B
                   WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID
                     AND B.DATA_STATE = '1'
                )
  ;

  --更新育苗点信息
  UPDATE DCCELL.R_PT_GROW_AB_D A
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
     AND EXISTS (
                  SELECT 1
                    FROM R_BIG_CANOPY B
                         INNER JOIN R_GROW_POINT C ON B.GROW_POINT_ID = C.GROW_POINT_ID
                   WHERE B.BIG_CANOPY_ID = A.GROW_CANOPY_ID
                )
  ;
  
  --根据ORG_CD更新组织单位
  UPDATE DCCELL.R_PT_GROW_AB_D A
     SET (
          A.PROV,
          A.CITC,
          A.COUC,
          A.STAC,
          A.SSTC,
          A.SLIN,
          A.PROV_NAME,
          A.CITC_NAME,
          A.COUC_NAME,
          A.STAC_NAME,
          A.SSTC_NAME,
          A.ORG_NAME
         ) = (
               SELECT B.PROV,
                      B.CITC,
                      B.COUC,
                      B.STAC,
                      B.SSTC,
                      B.SLIN,
                      B.PROV_NAME,
                      B.CITC_NAME,
                      B.COUC_NAME,
                      B.STAC_NAME,
                      B.SSTC_NAME,
                      B.ORG_NAME
                 FROM DCCELL.B_ORG B
                WHERE B.ORG_UNIQUE_CD = A.ORG_CD
             )
   WHERE A.BUSINESS_YEAR >= V_YEAR
     AND EXISTS (
                  SELECT 1
                    FROM DCCELL.B_ORG B
                   WHERE B.ORG_UNIQUE_CD = A.ORG_CD
                )
  ;

  --更新行政区划
  UPDATE DCCELL.R_PT_GROW_AB_D A
     SET (
            A.AREA_NAME     ,
            A.AREA_PROV     ,
            A.AREA_PROV_NAME,
            A.AREA_CITC     ,
            A.AREA_CITC_NAME,
            A.AREA_COUC     ,
            A.AREA_COUC_NAME,
            A.AREA_TOWN     ,
            A.TOWN_NAME     ,
            A.AREA_VAGE     ,
            A.VAGE_NAME     ,
            A.AREA_GRUP     ,
            A.GRUP_NAME     
          ) = (
                SELECT B.ORG_NAME      ,
                       B.AREA_PROV     ,
                       B.AREA_PROV_NAME,
                       B.AREA_CITC     ,
                       B.AREA_CITC_NAME,
                       B.AREA_COUC     ,
                       B.AREA_COUC_NAME,
                       B.AREA_TOWN     ,
                       B.TOWN_NAME     ,
                       B.AREA_VAGE     ,
                       B.VAGE_NAME     ,
                       B.AREA_GRUP     ,
                       B.GRUP_NAME     
                  FROM B_DIVISION B
                 WHERE B.DIVISION_UNIQUE_CD = A.AREA_CD
          )
   WHERE A.BUSINESS_YEAR >= V_YEAR
     AND EXISTS (
                  SELECT 1
                    FROM B_DIVISION B
                   WHERE B.DIVISION_UNIQUE_CD = A.AREA_CD
                )
  ;

  COMMIT;

END 
@