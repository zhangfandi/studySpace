/** 存储过程删除脚本
DROP PROCEDURE DCCELL.P_R_PT_PLOUGH_FM_D;       --翻耕
DROP PROCEDURE DCCELL.P_R_PT_PREPAR_FM_D;       --起垄
DROP PROCEDURE DCCELL.P_R_PT_VELUM_FM_D;        --盖膜
DROP PROCEDURE DCCELL.P_R_PT_GROW_AB_D;         --育苗
DROP PROCEDURE DCCELL.P_R_PT_FOR_SEED_FM_Y;     --供苗（种植主体）
DROP PROCEDURE DCCELL.P_R_PT_TRANSPLANT_FM_D;   --移栽
DROP PROCEDURE DCCELL.P_R_PT_MQGL_NOW_AB_D;     --苗期管理

DROP PROCEDURE DCCELL.P_R_PT_FOR_SEED_AB_D;     --供苗(育苗点)
DROP PROCEDURE DCCELL.P_R_PT_FILM_RECY_FM_D;    --地膜回收
DROP PROCEDURE DCCELL.P_R_PT_DT_FM_D;           --田间卫生
DROP PROCEDURE DCCELL.P_R_PT_YY_GROW_FM_D;      --田间长势
DROP PROCEDURE DCCELL.P_R_PT_CALAMITY_FM_D;     --灾害信息
DROP PROCEDURE DCCELL.P_R_PT_INDEMNIFY_FM_Y;    --定损理赔情况信息
DROP PROCEDURE DCCELL.P_R_PT_TR_FOR_SEED_FM_Y;  --铜仁地区供苗（种植主体）
DROP PROCEDURE DCCELL.P_R_PT_SC_QXN;            --黔西南生产加工（加工莱易接口生产数据）
DROP PROCEDURE DCCELL.P_DC_CALL_ID_02_SC;       --DC定时调用总过程
*/



--翻耕检查任务        TA16520000000020
--起垄检查任务        TA16520000000021
--覆膜检查任务        TA16520000000022
--移栽检查任务        TA16520000000023
--追肥检查任务        TA16520000000024
--培土上厢检查任务    TA16520000000025
--打顶抹芽检查任务    TA16520000000026
--地膜回收检查任务    TA16520000000027
--育苗检查任务        TA16520000000028
--洪涝灾害检查任务    TA16520000000029
--病虫灾害检查任务    TA16520000000030
--干旱灾害检查任务    TA16520000000031
--冰雹灾害检查任务    TA16520000000032
--风灾灾害检查任务    TA16520000000033
--合同检查任务        TA17520000000002
--烘烤检查任务        TA17520000000003

------------------------------------------------------------
--TSO
------------------------------------------------------------
/**
 * 黔南州数据中间表，
 * 黔南州使用专属
 * 表建于TSO库中

  DROP TABLE PT_EXTRA;
CREATE TABLE PT_EXTRA
(
    ID                   VARCHAR(32)      NOT NULL PRIMARY KEY,
    STAGE_TYPE           VARCHAR(32)      NOT NULL,
    ORG_CD               VARCHAR(32)      NOT NULL,
    ORG_NAME             VARCHAR(32)      NOT NULL,
    PT_YEAR              DECIMAL(4,0)     DEFAULT 2017,
    FEEDBACK_DATE        TIMESTAMP,
    MODIFY_TIME          TIMESTAMP        DEFAULT CURRENT TIMESTAMP,
    LAST_TIME            TIMESTAMP        DEFAULT CURRENT TIMESTAMP,
    CHECK_STATE          CHARACTER(1)     DEFAULT '1',
    DATA_STATE           CHARACTER(1)     DEFAULT '1',
    N1                   DECIMAL(20,5),
    N2                   DECIMAL(20,5),
    N3                   DECIMAL(20,5),
    N4                   DECIMAL(20,5),
    N5                   DECIMAL(20,5),
    N6                   DECIMAL(20,5),
    N7                   DECIMAL(20,5),
    N8                   DECIMAL(20,5),
    N9                   DECIMAL(20,5),
    N10                  DECIMAL(20,5),
    N11                  DECIMAL(20,5),
    N12                  DECIMAL(20,5),
    N13                  DECIMAL(20,5),
    N14                  DECIMAL(20,5),
    N15                  DECIMAL(20,5),
    N16                  DECIMAL(20,5),
    N17                  DECIMAL(20,5),
    N18                  DECIMAL(20,5),
    N19                  DECIMAL(20,5),
    N20                  DECIMAL(20,5),
    C1                   VARCHAR(255),
    C2                   VARCHAR(255),
    C3                   VARCHAR(255),
    C4                   VARCHAR(255),
    C5                   VARCHAR(255),
    C6                   VARCHAR(255),
    C7                   VARCHAR(255),
    C8                   VARCHAR(255),
    C9                   VARCHAR(255),
    C10                  VARCHAR(255)
)
;

COMMENT ON TABLE  PT_EXTRA               IS '黔南州生产业务数据表';
COMMENT ON COLUMN PT_EXTRA.ID            IS '主键';
COMMENT ON COLUMN PT_EXTRA.STAGE_TYPE    IS '生产阶段类型';
COMMENT ON COLUMN PT_EXTRA.ORG_CD        IS '单位编号';
COMMENT ON COLUMN PT_EXTRA.ORG_NAME      IS '单位名称';
COMMENT ON COLUMN PT_EXTRA.PT_YEAR       IS '生产年度';
COMMENT ON COLUMN PT_EXTRA.FEEDBACK_DATE IS '采集日期';
COMMENT ON COLUMN PT_EXTRA.MODIFY_TIME   IS '修改时间';
COMMENT ON COLUMN PT_EXTRA.LAST_TIME     IS '最后入库时间';
COMMENT ON COLUMN PT_EXTRA.CHECK_STATE   IS '核对状态';
COMMENT ON COLUMN PT_EXTRA.DATA_STATE    IS '数据状态';
COMMENT ON COLUMN PT_EXTRA.N1            IS '数值型字段：保存数值型信息项';
COMMENT ON COLUMN PT_EXTRA.C1            IS '字符型字段：保存字符型信息项';

*/
 
------------------------------------------------------------
--DCCELL
------------------------------------------------------------
/**
 * 存储过程加工和视图引用的数据源表
 */
CREATE NICKNAME DCCELL.TP_GROW_POINT         FOR TSOSERVER.TSO.TP_GROW_POINT;
CREATE NICKNAME DCCELL.TP_BIG_CANOPY         FOR TSOSERVER.TSO.TP_BIG_CANOPY;
CREATE NICKNAME DCCELL.PT_IX_ENUM_DATA       FOR TSOSERVER.TSO.PT_IX_ENUM_DATA;
CREATE NICKNAME DCCELL.CM_OT_ENUM_TYPE       FOR TSOSERVER.TSO.CM_OT_ENUM_TYPE;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_A     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_A;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_B     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_B;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_C     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_C;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_D     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_D;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_E     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_E;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_F     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_F;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_G     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_G;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_H     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_H;
CREATE NICKNAME DCCELL.PT_DC_STAT_DATA_Z     FOR TSOSERVER.TSO.PT_DC_STAT_DATA_Z;
CREATE NICKNAME DCCELL.PT_WC_STAT_DATA_A     FOR TSOSERVER.TSO.PT_WC_STAT_DATA_A;


  DROP VIEW V_R_PT_GROW_AB_D;
CREATE VIEW V_R_PT_GROW_AB_D 
AS
SELECT *
  FROM R_PT_GROW_AB_D A
  ;


--DROP VIEW V_PT_WC_STAT_DATA_A;
CREATE VIEW V_PT_WC_STAT_DATA_A 
AS
SELECT A.DATA_STORE_BASE_TBL_ID        ,
       A.N1                            ,
       A.N2                            ,
       A.N3                            ,
       A.N4                            ,
       A.N5                            ,
       A.N6                            ,
       A.N7                            ,
       A.N8                            ,
       A.N9                            ,
       A.N10                           ,
       A.N11                           ,
       A.N12                           ,
       A.N13                           ,
       A.N14                           ,
       A.N15                           ,
       A.N16                           ,
       A.N17                           ,
       A.N18                           ,
       A.N19                           ,
       A.N20                           ,
       A.N21                           ,
       A.N22                           ,
       A.N23                           ,
       A.N24                           ,
       A.N25                           ,
       A.N26                           ,
       A.N27                           ,
       A.N28                           ,
       A.N29                           ,
       A.N30                           ,
       A.C1                            ,
       A.C2                            ,
       A.C3                            ,
       A.C4                            ,
       A.C5                            ,
       A.C6                            ,
       A.C7                            ,
       A.C8                            ,
       A.C9                            ,
       A.C10                           ,
       A.C11                           ,
       A.C12                           ,
       A.C13                           ,
       A.C14                           ,
       A.C15                           ,
       A.D1                            ,
       A.D2                            ,
       A.D3                            ,
       A.D4                            ,
       A.D5                            ,
       A.D6                            ,
       A.D7                            ,
       A.D8                            ,
       A.D9                            ,
       A.FRM_TEL                       ,
       A.D10                           ,
       A.BILL_NO                       ,
       A.CLT_OBJ_ID                    ,
       A.CLT_OBJ_CD                    ,
       A.CLT_OBJ_NAME                  ,
       A.DC_CLT_OBJ_TYPE_EK            ,
       A.CLT_FREQ_EK                   ,
       A.SITE_ORG_UNIQUE_CD            ,
       A.STATION_ORG_UNIQUE_CD         ,
       A.COUC_ORG_UNIQUE_CD            ,
       A.CITY_ORG_UNIQUE_CD            ,
       A.PROV_ORG_UNIQUE_CD            ,
       A.V_DIVISION_UNIQUE_CD          ,
       A.T_DIVISION_UNIQUE_CD          ,
       A.X_DIVISION_UNIQUE_CD          ,
       A.C_DIVISION_UNIQUE_CD          ,
       A.P_DIVISION_UNIQUE_CD          ,
       A.LEAF_VARIETY_CD               ,
       A.LEAF_TYPE_CD                  ,
       A.LEAF_POSITION_CD              ,
       A.FRM_CD                        ,
       A.SERV_ORG_ID                   ,
       A.GROW_SITE_CD                  ,
       A.BAKE_HOUSE_CD                 ,
       A.IS_DATA_VALID_FLAG            ,
       A.DATA_SOURCE_TYPE_EK           ,
       A.CHECK_STATE                   ,
       A.IS_UPLOAD_FLAG                ,
       A.IS_RETURN_FLAG                ,
       A.PT_YEAR                       ,
       A.FEEDBACK_PERIOD               ,
       A.FEEDBACK_DATE                 ,
       A.RECORD_PERIOD                 ,
       A.FEEDBACK_PSN_ID               ,
       A.ORG_UNIQUE_CD                 ,
       A.SEND_STATE                    ,
       A.MODIFY_TIME                   ,
       A.DATA_STATE                    ,
       A.LAST_TIME                     ,
       A.N31                           ,
       A.N32                           ,
       A.N33                           ,
       A.N34                           ,
       A.N35                           ,
       A.N36                           ,
       A.N37                           ,
       A.N38                           ,
       A.N39                           ,
       A.N40                           ,
       A.N41                           ,
       A.N42                           ,
       A.N43                           ,
       A.N44                           ,
       A.N45                           ,
       A.N46                           ,
       A.N47                           ,
       A.N48                           ,
       A.N49                           ,
       A.N50                           ,
       A.C16                           ,
       A.C17                           ,
       A.C18                           ,
       A.C19                           ,
       A.C20                           ,
       A.IS_FINISH_FLAG                ,
       A.C21                           ,
       A.C22                           ,
       A.C23                           ,
       A.C24                           ,
       A.C25                           ,
       A.ORDER_NO                      ,
       A.CLT_N1                        ,
       A.CLT_N2                        ,
       A.CLT_N3                        ,
       A.CLT_N4                        ,
       A.CLT_N5                        ,
       A.CLT_N6                        ,
       A.CLT_N7                        ,
       A.CLT_N8                        ,
       A.CLT_N9                        ,
       A.CLT_N10                       ,
       A.CLT_N11                       ,
       A.CLT_N12                       ,
       A.CLT_N13                       ,
       A.CLT_N14                       ,
       A.CLT_N15                       ,
       A.CLT_N16                       ,
       A.CLT_N17                       ,
       A.CLT_N18                       ,
       A.CLT_N19                       ,
       A.CLT_N20                       ,
       A.CLT_N21                       ,
       A.CLT_N22                       ,
       A.CLT_N23                       ,
       A.CLT_N24                       ,
       A.CLT_N25                       ,
       A.CLT_N26                       ,
       A.CLT_N27                       ,
       A.CLT_N28                       ,
       A.CLT_N29                       ,
       A.CLT_N30                       ,
       A.CLT_N31                       ,
       A.CLT_N32                       ,
       A.CLT_N33                       ,
       A.CLT_N34                       ,
       A.CLT_N35                       ,
       A.CLT_N36                       ,
       A.CLT_N37                       ,
       A.CLT_N38                       ,
       A.CLT_N39                       ,
       A.CLT_N40                       ,
       A.CLT_N41                       ,
       A.CLT_N42                       ,
       A.CLT_N43                       ,
       A.CLT_N44                       ,
       A.CLT_N45                       ,
       A.CLT_N46                       ,
       A.CLT_N47                       ,
       A.CLT_N48                       ,
       A.CLT_N49                       ,
       A.CLT_N50                       ,
       A.PT_YEAR       AS BUSINESS_YEAR,
       A.FEEDBACK_DATE AS BUSINESS_DATE,
       ORG.PROV                        ,
       ORG.PROV_NAME                   ,
       ORG.CITC                        ,
       ORG.CITC_NAME                   ,
       ORG.COUC                        ,
       ORG.COUC_NAME                   ,
       ORG.STAC                        ,
       ORG.STAC_NAME                   ,
       ORG.SSTC                        ,
       ORG.SSTC_NAME                   ,
       DIVISION.AREA_PROV              ,
       DIVISION.AREA_PROV_NAME         ,
       DIVISION.AREA_CITC              ,
       DIVISION.AREA_CITC_NAME         ,
       DIVISION.AREA_COUC              ,
       DIVISION.AREA_COUC_NAME         ,
       DIVISION.AREA_TOWN              ,
       DIVISION.TOWN_NAME              ,
       DIVISION.AREA_VAGE              ,
       DIVISION.VAGE_NAME
  FROM PT_WC_STAT_DATA_A A
       LEFT JOIN B_ORG ORG ON ORG.ORG_UNIQUE_CD = A.ORG_UNIQUE_CD
       LEFT JOIN B_DIVISION DIVISION ON DIVISION.DIVISION_UNIQUE_CD = A.V_DIVISION_UNIQUE_CD
 WHERE A.PT_YEAR = (SELECT BUSI_YEAR FROM DC_PROC_BUSI_YEAR A WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC')
;


------------------------------------------------------------
--LINDS
--2017年2月14日
------------------------------------------------------------
 
------------------------------------------------------------
--DROP
------------------------------------------------------------
--DROP TABLE R_PT_ARCH_QTY;
 
------------------------------------------------------------
--CREATE 贵州省局_生产设施数量统计
------------------------------------------------------------
CREATE TABLE R_PT_ARCH_QTY
(
   PT_ARCH_QTY_ID       VARCHAR(128)           NOT NULL,
   GROW_POINT_QTY       DECIMAL(24,6),
   BIG_CANOPY_QTY       DECIMAL(24,6),
   B_BIG_CANOPY_QTY     DECIMAL(24,6),
   M_BIG_CANOPY_QTY     DECIMAL(24,6),
   S_BIG_CANOPY_QTY     DECIMAL(24,6),
   PROV                 VARCHAR(32)            DEFAULT '0',
   PROV_NAME            VARCHAR(128),
   CITC                 VARCHAR(32)            DEFAULT '0',
   CITC_NAME            VARCHAR(128),
   COUC                 VARCHAR(32)            DEFAULT '0',
   COUC_NAME            VARCHAR(128),
   STAC                 VARCHAR(32)            DEFAULT '0',
   STAC_NAME            VARCHAR(128),
   SSTC                 VARCHAR(32)            DEFAULT '0',
   SSTC_NAME            VARCHAR(128),
   SLIN                 VARCHAR(32)            DEFAULT '0',
   SLIN_NAME            VARCHAR(128),
   DIVISION_UNIQUE_CD   VARCHAR(32)            DEFAULT '0',
   DIVISION_NAME        VARCHAR(32),
   AREA_PROV            VARCHAR(32)            DEFAULT '0',
   AREA_PROV_NAME       VARCHAR(128),
   AREA_CITC            VARCHAR(32)            DEFAULT '0',
   AREA_CITC_NAME       VARCHAR(128),
   AREA_COUC            VARCHAR(32)            DEFAULT '0',
   AREA_COUC_NAME       VARCHAR(128),
   AREA_TOWN            VARCHAR(32)            DEFAULT '0',
   TOWN_NAME            VARCHAR(128),
   AREA_VAGE            VARCHAR(32)            DEFAULT '0',
   VAGE_NAME            VARCHAR(128),
   AREA_GRUP            VARCHAR(32)            DEFAULT '0',
   GRUP_NAME            VARCHAR(128),
   BUSINESS_YEAR        DECIMAL(4)  ,
   SEND_STATE           CHAR(1)                default '0',
   DATA_STATE           CHAR(1)                default '1',
   MODIFY_TIME          TIMESTAMP,
   SEND_TIME            TIMESTAMP,
   PACKAGE_TIME         TIMESTAMP,
   LAST_TIME            TIMESTAMP              default CURRENT TIMESTAMP
)
 IN DCCELL_SPACE INDEX IN INDEX_SPACE
;
 
------------------------------------------------------------
--
------------------------------------------------------------
ALTER TABLE R_PT_ARCH_QTY ADD PRIMARY KEY (PT_ARCH_QTY_ID); 
 
------------------------------------------------------------
--INDEX
------------------------------------------------------------
--Y01
CREATE INDEX I_PT_ARCH_QTY_3  ON R_PT_ARCH_QTY(CITC);
CREATE INDEX I_PT_ARCH_QTY_4  ON R_PT_ARCH_QTY(COUC);
CREATE INDEX I_PT_ARCH_QTY_5  ON R_PT_ARCH_QTY(STAC);
CREATE INDEX I_PT_ARCH_QTY_6  ON R_PT_ARCH_QTY(SSTC);
CREATE INDEX I_PT_ARCH_QTY_7  ON R_PT_ARCH_QTY(AREA_CITC);
CREATE INDEX I_PT_ARCH_QTY_8  ON R_PT_ARCH_QTY(AREA_COUC);
CREATE INDEX I_PT_ARCH_QTY_9  ON R_PT_ARCH_QTY(AREA_TOWN);
CREATE INDEX I_PT_ARCH_QTY_10 ON R_PT_ARCH_QTY(AREA_VAGE);
CREATE INDEX I_PT_ARCH_QTY_11 ON R_PT_ARCH_QTY(AREA_GRUP); 


  DROP VIEW V_PT_ARCH_QTY;
CREATE VIEW V_PT_ARCH_QTY
 AS
SELECT 0 AS GROW_POINT_QTY_ALL,
       0 AS BIG_CANOPY_QTY_ALL,
       0 AS B_BIG_CANOPY_QTY_ALL,
       0 AS M_BIG_CANOPY_QTY_ALL,
       0 AS S_BIG_CANOPY_QTY_ALL,
       GROW_POINT_QTY,
       BIG_CANOPY_QTY,
       B_BIG_CANOPY_QTY,
       M_BIG_CANOPY_QTY,
       S_BIG_CANOPY_QTY,
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       BUSINESS_YEAR,
       DATA_STATE
  FROM R_PT_ARCH_QTY
  
 UNION ALL
SELECT COUNT(GROW_POINT_CD) AS GROW_POINT_QTY_ALL,
       0                    AS BIG_CANOPY_QTY_ALL,
       0                    AS B_BIG_CANOPY_QTY_ALL,
       0                    AS M_BIG_CANOPY_QTY_ALL,
       0                    AS S_BIG_CANOPY_QTY_ALL,
       0                    AS GROW_POINT_QTY,
       0                    AS BIG_CANOPY_QTY,
       0                    AS B_BIG_CANOPY_QTY,
       0                    AS M_BIG_CANOPY_QTY,
       0                    AS S_BIG_CANOPY_QTY,
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       (
           SELECT BUSI_YEAR
             FROM DC_PROC_BUSI_YEAR
            WHERE PROC_NAME = 'P_GROW_POINT'
       )                    AS BUSINESS_YEAR,
       DATA_STATE
  FROM R_GROW_POINT
 GROUP BY
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       DATA_STATE
 UNION ALL
SELECT 0 AS GROW_POINT_QTY_ALL,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('BIG_CANOPY',
                                        'MID_CANOPY',
                                        'SMALL_CANOPY')
               THEN 1
               ELSE 0
           END ) AS BIG_CANOPY_QTY_ALL,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('BIG_CANOPY')
               THEN 1
               ELSE 0
           END ) AS B_BIG_CANOPY_QTY_ALL,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('MID_CANOPY')
               THEN 1
               ELSE 0
           END ) AS M_BIG_CANOPY_QTY_ALL,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('SMALL_CANOPY')
               THEN 1
               ELSE 0
           END ) AS S_BIG_CANOPY_QTY_ALL,
       0         AS GROW_POINT_QTY,
       0         AS BIG_CANOPY_QTY,
       0         AS B_BIG_CANOPY_QTY,
       0         AS M_BIG_CANOPY_QTY,
       0         AS S_BIG_CANOPY_QTY,
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       (
           SELECT
               BUSI_YEAR
           FROM
               DC_PROC_BUSI_YEAR
           WHERE
               PROC_NAME = 'P_BIG_CANOPY'
        ) AS BUSINESS_YEAR,
       DATA_STATE
  FROM R_BIG_CANOPY
 GROUP BY
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       DATA_STATE
       
 UNION ALL
SELECT 0                    AS GROW_POINT_QTY_ALL,
       0                    AS BIG_CANOPY_QTY_ALL,
       0                    AS B_BIG_CANOPY_QTY_ALL,
       0                    AS M_BIG_CANOPY_QTY_ALL,
       0                    AS S_BIG_CANOPY_QTY_ALL,
       COUNT(GROW_POINT_CD) AS GROW_POINT_QTY,
       0                    AS BIG_CANOPY_QTY,
       0                    AS B_BIG_CANOPY_QTY,
       0                    AS M_BIG_CANOPY_QTY,
       0                    AS S_BIG_CANOPY_QTY,
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       (
           SELECT BUSI_YEAR
             FROM DC_PROC_BUSI_YEAR
            WHERE PROC_NAME = 'P_GROW_POINT'
       )                    AS BUSINESS_YEAR,
       DATA_STATE
  FROM R_GROW_POINT POINT
 WHERE EXISTS (
         SELECT 1
           FROM R_PT_GROW_AB_D DATA
          WHERE DATA.GROW_POINT_ID = POINT.GROW_POINT_ID
       )
   AND EXISTS (
         SELECT 1 
           FROM PT_AS_TLG_FACILITY TLGFAC 
          WHERE TLGFAC.FACILITY_ID=POINT.GROW_POINT_ID 
            AND TLGFAC.DATA_STATE='1' 
            AND TLGFAC.FACILITY_TYPE_EK='GROW_SITE'
            AND TLGFAC.PT_YEAR =(
                  SELECT BUSI_YEAR
                    FROM DC_PROC_BUSI_YEAR
                   WHERE PROC_NAME = 'P_GROW_POINT'
                )   
       )
GROUP BY PROV ,
         PROV_NAME ,
         CITC ,
         CITC_NAME ,
         COUC ,
         COUC_NAME ,
         STAC ,
         STAC_NAME ,
         SSTC ,
         SSTC_NAME ,
         DATA_STATE
 UNION ALL
SELECT 0 AS GROW_POINT_QTY_ALL,
       0 AS BIG_CANOPY_QTY_ALL,
       0 AS B_BIG_CANOPY_QTY_ALL,
       0 AS M_BIG_CANOPY_QTY_ALL,
       0 AS S_BIG_CANOPY_QTY_ALL,
       0 AS GROW_POINT_QTY,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('BIG_CANOPY',
                                        'MID_CANOPY',
                                        'SMALL_CANOPY')
               THEN 1
               ELSE 0
           END ) AS BIG_CANOPY_QTY,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('BIG_CANOPY')
               THEN 1
               ELSE 0
           END ) AS B_BIG_CANOPY_QTY,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('MID_CANOPY')
               THEN 1
               ELSE 0
           END ) AS M_BIG_CANOPY_QTY,
       SUM(
           CASE
               WHEN BIG_CANOPY_TYPE IN ('SMALL_CANOPY')
               THEN 1
               ELSE 0
           END ) AS S_BIG_CANOPY_QTY,
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       (
           SELECT BUSI_YEAR
             FROM DC_PROC_BUSI_YEAR
            WHERE PROC_NAME = 'P_BIG_CANOPY'
       ) AS BUSINESS_YEAR,
       DATA_STATE
  FROM R_BIG_CANOPY CANOPY
 WHERE EXISTS (
         SELECT 1
           FROM R_PT_GROW_AB_D DATA
          WHERE DATA.GROW_CANOPY_ID=CANOPY.BIG_CANOPY_ID
       )
   AND EXISTS (
         SELECT 1 
           FROM PT_AS_TLG_FACILITY TLGFAC 
          WHERE TLGFAC.FACILITY_ID=CANOPY.BIG_CANOPY_ID 
            AND TLGFAC.DATA_STATE='1' 
            AND TLGFAC.FACILITY_TYPE_EK='GROW_SHACK'
            AND TLGFAC.PT_YEAR =(
                  SELECT BUSI_YEAR
                    FROM DC_PROC_BUSI_YEAR
                   WHERE PROC_NAME = 'P_BIG_CANOPY'
                )
       )
 GROUP BY
       PROV ,
       PROV_NAME ,
       CITC ,
       CITC_NAME ,
       COUC ,
       COUC_NAME ,
       STAC ,
       STAC_NAME ,
       SSTC ,
       SSTC_NAME ,
       DATA_STATE
  ;


/**
 *    初始化存储过程加工时间表
 */
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_PLOUGH_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_PREPAR_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_GROW_AB_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_FOR_SEED_FM_Y', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_VELUM_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_TRANSPLANT_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_MQGL_NOW_AB_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_FOR_SEED_AB_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_FILM_RECY_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_DT_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_YY_GROW_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_CALAMITY_FM_D', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_INDEMNIFY_FM_Y', '2000-01-01 00:00:00');
INSERT INTO DC_PROC_TIME_STOP (PROC_NAME, TIME_STOP) VALUES ('P_R_PT_TR_FOR_SEED_FM_Y', '2000-01-01 00:00:00');


/**
 * 采用增量加工时，用于记录本次增量数据所涉及到的组织和行政
 */
CREATE TABLE ORG_AREA_TMP
(
    ORG_CD     VARCHAR(32),
    AREA_CD    VARCHAR(32),
    PROC_NAME  VARCHAR(32),
    EXEC_TIME  TIMESTAMP,
    DATA_STATE CHAR(1) default '1'
)
;

CREATE INDEX IDX_ORGAREATMP_ORGCD     ON ORG_AREA_TMP ( ORG_CD )     ALLOW REVERSE SCANS;
CREATE INDEX IDX_ORGAREATMP_AREACD    ON ORG_AREA_TMP ( AREA_CD )    ALLOW REVERSE SCANS;
CREATE INDEX IDX_ORGAREATMP_PROCNAME  ON ORG_AREA_TMP ( PROC_NAME )  ALLOW REVERSE SCANS;
CREATE INDEX IDX_ORGAREATMP_DATASTATE ON ORG_AREA_TMP ( DATA_STATE ) ALLOW REVERSE SCANS;

COMMENT ON TABLE  DCCELL.ORG_AREA_TMP            IS '存储过程增量组织行政临时表';
COMMENT ON COLUMN DCCELL.ORG_AREA_TMP.PROC_NAME  IS '存储过程名称';
COMMENT ON COLUMN DCCELL.ORG_AREA_TMP.ORG_CD     IS '组织编号';
COMMENT ON COLUMN DCCELL.ORG_AREA_TMP.AREA_CD    IS '行政编号';
COMMENT ON COLUMN DCCELL.ORG_AREA_TMP.EXEC_TIME  IS '当前存储过程开始执行时间';
COMMENT ON COLUMN DCCELL.ORG_AREA_TMP.DATA_STATE IS '数据有效状态（0无效，1有效）';


/**
 *    存储过程语句块执行时长
 */
CREATE TABLE DCCELL.PROC_TIME_TOTAL
(
   PROC_NAME       VARCHAR(128)      NOT NULL,
   EXEC_TIME       TIMESTAMP,
   REMARK          VARCHAR(500),
   BEGIN_TIME      TIMESTAMP,
   END_TIME        TIMESTAMP         DEFAULT CURRENT TIMESTAMP
)
;

COMMENT ON TABLE  DCCELL.PROC_TIME_TOTAL            IS '存储过程语句块执行时长';
COMMENT ON COLUMN DCCELL.PROC_TIME_TOTAL.PROC_NAME  IS '存储过程名称';
COMMENT ON COLUMN DCCELL.PROC_TIME_TOTAL.EXEC_TIME  IS '存储过程开始时间';
COMMENT ON COLUMN DCCELL.PROC_TIME_TOTAL.REMARK     IS '备注';
COMMENT ON COLUMN DCCELL.PROC_TIME_TOTAL.BEGIN_TIME IS '执行开始时间';
COMMENT ON COLUMN DCCELL.PROC_TIME_TOTAL.END_TIME   IS '执行结束时间';


/**
 *    NVL函数。DB2 9.5以下版本需要建此函数，9.5及以上不需要
 */
CREATE FUNCTION DCCELL.NVL(IN_NUM DECIMAL(20,5), OUT_NUM DECIMAL(20,5))
RETURNS DECIMAL(20,5)
LANGUAGE SQL
SPECIFIC NVL
D: BEGIN ATOMIC
  RETURN
  CASE
    WHEN IN_NUM IS NULL THEN OUT_NUM
    ELSE IN_NUM
  END;
END D


------------------------------------------------------------
--
--
--
--
------------------------------------------------------------

  DROP VIEW TSO.V_PT_PLOUGH_FM_D;
CREATE VIEW TSO.V_PT_PLOUGH_FM_D
   AS
  SELECT A.DATA_STORE_BASE_TBL_ID     AS PLOUGH_FM_D_ID,
         A.CLT_OBJ_ID                 AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD                 AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME               AS FIELD_BLOCK_NAME,
         A.PT_YEAR                    AS BUSINESS_YEAR,
         A.FEEDBACK_DATE              AS BUSINESS_DATE,
         CASE
           WHEN A.C1 = '1' THEN
             COALESCE(A.N30,0)
           ELSE
             0
         END                          AS PROPESS_AREA,
         CASE 
           WHEN A.C1 IS NULL OR A.C1 = '' OR A.C1 = '2' THEN 0
           ELSE COALESCE(A.N30,0)
         END                         AS PLOUGH_AREA,
         A.RELA_OBJECT_ID             AS FARMER_ID,
         A.RELA_OBJECT_CD             AS FARMER_CD,
         A.RELA_OBJECT_NAME           AS FARMER_NAME,
         F.STATION_UNIQUE_CD  AS ORG_CD,
         --ORG.ORG_CD,
         --ORG.ORG_NAME,
         --ORG.PROV,
         --ORG.PROV_NAME,
         --ORG.CITC,
         --ORG.CITC_NAME,
         --ORG.COUC,
         --ORG.COUC_NAME,
         --ORG.STAC,
         --ORG.STAC_NAME,
         --ORG.SSTC,
         --ORG.SSTC_NAME,
         F.DIVISION_UNIQUE_CD AS AREA_CD,
         --DIVISION.DIVISION_UNIQUE_CD         AS AREA_CD,
         --DIVISION.ORG_NAME                   AS AREA_NAME,
         --DIVISION.AREA_PROV,
         --DIVISION.AREA_PROV_NAME,
         --DIVISION.AREA_CITC,
         --DIVISION.AREA_CITC_NAME,
         --DIVISION.AREA_COUC,
         --DIVISION.AREA_COUC_NAME,
         --DIVISION.AREA_TOWN,
         --DIVISION.TOWN_NAME,
         --DIVISION.AREA_VAGE,
         --DIVISION.VAGE_NAME,
         --DIVISION.AREA_GRUP,
         --DIVISION.GRUP_NAME,
         A.FEEDBACK_PSN_ID            AS TECHNICIAN_ID,
         A.SEND_STATE,
         A.DATA_STATE,
         A.MODIFY_TIME,
         A.LAST_TIME
    FROM PT_DC_STAT_DATA_D A
         LEFT JOIN CM_PM_FRM_FUND F ON F.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID AND F.BIZ_YEAR = A.PT_YEAR AND F.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000055'
     AND A.CHECK_STATE = '1' 
;


  DROP NICKNAME DCCELL.V_PT_PLOUGH_FM_D ;
CREATE NICKNAME DCCELL.V_PT_PLOUGH_FM_D      FOR TSOSERVER.TSO.V_PT_PLOUGH_FM_D;


  DROP PROCEDURE DCCELL.P_R_PT_PLOUGH_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_PLOUGH_FM_D
BEGIN
  ------------------------------------------------------------
  --LINDS
  ------------------------------------------------------------
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_PLOUGH_FM_D';
  DECLARE V_STEP                    VARCHAR(500);
  DECLARE V_PT_YEAR                 INTEGER ;
  DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000055';

  DECLARE C_ENABLE_FLAG         CHAR(1)     DEFAULT '1';
  DECLARE V_CURRENTTIMESTAMP    TIMESTAMP  ; 
  DECLARE V_TIME_STOP           TIMESTAMP;

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
  SET V_STEP = '1 R_PT_PLOUGH_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_PLOUGH_FM_D WHERE BUSINESS_YEAR >= V_PT_YEAR;
  
  SET V_STEP = '2 R_PT_PLOUGH_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
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
  ;
  COMMIT;

 
  --COMMIT;
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
  ;
  COMMIT;

  UPDATE R_PT_PLOUGH_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
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
  ;
  COMMIT;
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
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
  ON (B.DIVISION_UNIQUE_CD = A.AREA_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND A.AREA_PROV_NAME IS NULL) 
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
  --UPDATE R_PT_PLOUGH_FM_D A
  --   SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
  -- WHERE A.BUSINESS_YEAR >= V_PT_YEAR
  --   AND A.LEAF_VARIETY_NAME IS NULL
  --;

  --COMMIT;


  SET V_STEP = '3 R_PT_PLOUGH_DV_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_PLOUGH_DV_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;
  

  SET V_STEP = '4 R_PT_PLOUGH_DV_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
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
  ;
  COMMIT;

  SET V_STEP = '5 R_PT_PLOUGH_CB_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_PLOUGH_CB_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;
 
  SET V_STEP = '6 R_PT_PLOUGH_CB_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
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
  ;
  COMMIT;
END
@

------------------------------------------------------------
--
--
--
--
------------------------------------------------------------

  DROP VIEW TSO.V_PT_PREPAR_FM_D;
CREATE VIEW TSO.V_PT_PREPAR_FM_D
   AS
 SELECT  A.DATA_STORE_BASE_TBL_ID AS PREPAR_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         CASE 
           WHEN A.C2 = '1' THEN
             COALESCE(A.N30,0)
           ELSE
             0
         END                      AS PROPESS_AREA,
         CASE 
           WHEN A.C2 IS NULL OR A.C2 = '' OR A.C2 = '2'
           THEN 0
           ELSE COALESCE(A.N30,0)
         END                      AS PREPAR_AREA,
         A.C4                     AS PREPAR_TYPE,
         A.N1                     AS PREPAR_QTY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         F.STATION_UNIQUE_CD  AS ORG_CD,
         F.DIVISION_UNIQUE_CD AS AREA_CD,
         A.FEEDBACK_PSN_ID               AS TECHNICIAN_ID,
         A.SEND_STATE,
         A.DATA_STATE,
         A.MODIFY_TIME,
         A.LAST_TIME
    FROM PT_DC_STAT_DATA_D a
         LEFT JOIN CM_PM_FRM_FUND F ON F.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID AND F.BIZ_YEAR = A.PT_YEAR AND F.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000055'
     AND A.CHECK_STATE = '1' 
;


  DROP NICKNAME DCCELL.V_PT_PREPAR_FM_D ;
CREATE NICKNAME DCCELL.V_PT_PREPAR_FM_D      FOR TSOSERVER.TSO.V_PT_PREPAR_FM_D;


  DROP PROCEDURE DCCELL.P_R_PT_PREPAR_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_PREPAR_FM_D
BEGIN
  ------------------------------------------------------------
  --LINDS
  ------------------------------------------------------------
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_PREPAR_FM_D';
  DECLARE V_STEP                    VARCHAR(500);
  DECLARE V_PT_YEAR                 INTEGER ;
  DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000055';

  DECLARE C_ENABLE_FLAG         CHAR(1)     DEFAULT '1';
  DECLARE V_CURRENTTIMESTAMP    TIMESTAMP  ; 
  DECLARE V_TIME_STOP           TIMESTAMP;

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
  SET V_STEP = '1 R_PT_PREPAR_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_PREPAR_FM_D WHERE BUSINESS_YEAR >= V_PT_YEAR;
  
  SET V_STEP = '2 R_PT_PREPAR_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_PREPAR_FM_D
  (
      PREPAR_FM_D_ID,
      FIELD_BLOCK_ID,
      FIELD_BLOCK_CD,
      FIELD_BLOCK_NAME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      PROPESS_AREA,
      PREPAR_AREA,
      PREPAR_TYPE,
      PREPAR_QTY,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT           PREPAR_FM_D_ID,
      FIELD_BLOCK_ID,
      FIELD_BLOCK_CD,
      FIELD_BLOCK_NAME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      PROPESS_AREA,
      PREPAR_AREA,
      PREPAR_TYPE,
      PREPAR_QTY,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
    FROM V_PT_PREPAR_FM_D 
   WHERE BUSINESS_YEAR    >= V_PT_YEAR
     AND DATA_STATE = '1' 
  WITH UR
  ;
  COMMIT;

 
  --COMMIT;
  update R_PT_PREPAR_FM_D A
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
  ;
  COMMIT;

  UPDATE R_PT_PREPAR_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_PT_PREPAR_FM_D A
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
  ;
  COMMIT;
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_PT_PREPAR_FM_D A
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
  ON (B.DIVISION_UNIQUE_CD = A.AREA_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND A.AREA_PROV_NAME IS NULL) 
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
  --UPDATE R_PT_PREPAR_FM_D A
  --   SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
  -- WHERE A.BUSINESS_YEAR >= V_PT_YEAR
  --   AND A.LEAF_VARIETY_NAME IS NULL
  --;

  --COMMIT;


  SET V_STEP = '3 R_PT_PREPAR_DV_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_PREPAR_DV_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;
  

  SET V_STEP = '4 R_PT_PREPAR_DV_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_PREPAR_DV_D
  (
    PREPAR_DV_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PREPAR_AREA,
    PROPESS_AREA,
    PREPAR_TYPE,
    PREPAR_QTY,
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
  SELECT Hex(generate_unique())  AS PREPAR_DV_D_ID,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         MAX(MODIFY_TIME)        AS MODIFY_TIME,
         V_CURRENTTIMESTAMP     AS LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE           AS BUSINESS_DATE,
         SUM(PREPAR_AREA)        AS PREPAR_AREA,
         SUM(PROPESS_AREA)       AS PROPESS_AREA,
         PREPAR_TYPE,
         SUM(PREPAR_QTY)         AS PREPAR_QTY,
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
    FROM R_PT_PREPAR_FM_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.BUSINESS_YEAR,
         T.BUSINESS_DATE,
         T.PREPAR_TYPE,
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
  ;
  COMMIT;

  SET V_STEP = '5 R_PT_PREPAR_CB_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_PREPAR_CB_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;
 
  SET V_STEP = '6 R_PT_PREPAR_CB_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_PREPAR_CB_D
  (
    PREPAR_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PREPAR_AREA,
    PROPESS_AREA,
    PREPAR_TYPE,
    PREPAR_QTY,
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
  SELECT Hex(generate_unique())        AS PREPAR_CB_D_ID,
         '0'                           AS SEND_STATE,
         '1'                           AS DATA_STATE,
         MAX(MODIFY_TIME)              AS MODIFY_TIME,
         V_CURRENTTIMESTAMP           AS LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE                 AS BUSINESS_DATE,
         SUM(PREPAR_AREA)              AS PREPAR_AREA,
         SUM(PROPESS_AREA)             AS PROPESS_AREA,
         PREPAR_TYPE,
         SUM(PREPAR_QTY)               AS PREPAR_QTY,
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
    FROM R_PT_PREPAR_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.BUSINESS_YEAR,
         T.BUSINESS_DATE,
         T.PREPAR_TYPE,
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
  ;
  COMMIT;
END
@

------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
--DROP VIEW TSO.V_PT_VELUM_FM_D;
CREATE VIEW TSO.V_PT_VELUM_FM_D
   AS
SELECT A.DATA_STORE_BASE_TBL_ID AS PREPAR_FM_D_ID,
       A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
       A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
       A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
       A.PT_YEAR                AS BUSINESS_YEAR,
       A.FEEDBACK_DATE          AS BUSINESS_DATE,
       CASE
         WHEN A.C3 = '1' THEN
           COALESCE(A.N30,0)
         ELSE
           0
       END                      AS PROPESS_AREA,
       CASE 
         WHEN A.C3 IS NULL OR A.C3 = '' OR A.C3 = '2'
         THEN 0
         ELSE COALESCE(A.N30,0)
       END                      AS VELUM_AREA,
       A.RELA_OBJECT_ID         AS FARMER_ID,
       A.RELA_OBJECT_CD         AS FARMER_CD,
       A.RELA_OBJECT_NAME       AS FARMER_NAME,
       B.STATION_UNIQUE_CD      AS ORG_CD,
       B.DIVISION_UNIQUE_CD     AS AREA_CD,
       A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
       '0'                             AS SEND_STATE,
       A.DATA_STATE,
       A.MODIFY_TIME,
       CURRENT TIMESTAMP             AS LAST_TIME
  FROM PT_DC_STAT_DATA_D A
       LEFT JOIN CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                 AND B.BIZ_YEAR = A.PT_YEAR
                                 AND B.DATA_STATE = '1'
 WHERE A.BILL_NO = 'TJ00000000000055'
   AND A.CHECK_STATE = '1'
;

  DROP NICKNAME DCCELL.V_PT_VELUM_FM_D ;
CREATE NICKNAME DCCELL.V_PT_VELUM_FM_D      FOR TSOSERVER.TSO.V_PT_VELUM_FM_D;


DROP PROCEDURE DCCELL.P_R_PT_VELUM_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_VELUM_FM_D
------------------------------------------------------------
--lingm
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME          VARCHAR(1000) DEFAULT 'P_R_PT_VELUM_FM_D';
  DECLARE V_STEP               VARCHAR(500);
  DECLARE V_PT_YEAR            INTEGER DEFAULT 2017;
  DECLARE V_BILL_NO            VARCHAR(64) DEFAULT 'TJ00000000000055'; --单据编号
  DECLARE V_TIME_LAST          TIMESTAMP;
  
  DECLARE V_TIME_BEGIN         TIMESTAMP; --语句块开始执行时间
  DECLARE V_TIME_END           TIMESTAMP;   --语句块结束执行时间

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

  SET V_STEP = '1 R_PT_VELUM_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_VELUM_FM_D T
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;
 
  SET V_STEP = '2 R_PT_VELUM_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_VELUM_FM_D
  (
      VELUM_FM_D_ID,
      FIELD_BLOCK_ID,
      FIELD_BLOCK_CD,
      FIELD_BLOCK_NAME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      PROPESS_AREA,
      VELUM_AREA,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      ORG_CD,
      -- ORG_NAME,
      -- PROV,
      -- PROV_NAME,
      -- CITC,
      -- CITC_NAME,
      -- COUC,
      -- COUC_NAME,
      -- STAC,
      -- STAC_NAME,
      -- SSTC,
      -- SSTC_NAME,
      AREA_CD,
      -- AREA_NAME,
      -- AREA_PROV,
      -- AREA_PROV_NAME,
      -- AREA_CITC,
      -- AREA_CITC_NAME,
      -- AREA_COUC,
      -- AREA_COUC_NAME,
      -- AREA_TOWN,
      -- TOWN_NAME,
      -- AREA_VAGE,
      -- VAGE_NAME,
      -- AREA_GRUP,
      -- GRUP_NAME,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT PREPAR_FM_D_ID,
         FIELD_BLOCK_ID,
         FIELD_BLOCK_CD,
         FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         PROPESS_AREA,
         VELUM_AREA,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         ORG_CD,
         -- ORG.ORG_NAME,
         -- ORG.PROV,
         -- ORG.PROV_NAME,
         -- ORG.CITC,
         -- ORG.CITC_NAME,
         -- ORG.COUC,
         -- ORG.COUC_NAME,
         -- ORG.STAC,
         -- ORG.STAC_NAME,
         -- ORG.SSTC,
         -- ORG.SSTC_NAME,
         AREA_CD,
         -- DIVISION.ORG_NAME,
         -- DIVISION.AREA_PROV,
         -- DIVISION.AREA_PROV_NAME,
         -- DIVISION.AREA_CITC,
         -- DIVISION.AREA_CITC_NAME,
         -- DIVISION.AREA_COUC,
         -- DIVISION.AREA_COUC_NAME,
         -- DIVISION.AREA_TOWN,
         -- DIVISION.TOWN_NAME,
         -- DIVISION.AREA_VAGE,
         -- DIVISION.VAGE_NAME,
         -- DIVISION.AREA_GRUP,
         -- DIVISION.GRUP_NAME,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         CURRENT TIMESTAMP               AS LAST_TIME
    FROM V_PT_VELUM_FM_D 
   WHERE DATA_STATE = '1'
     AND BUSINESS_YEAR    >= V_PT_YEAR
  ;
  COMMIT;

  update R_PT_VELUM_FM_D A
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
  ;
  COMMIT;

  UPDATE R_PT_VELUM_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_VELUM_FM_D A
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
 MERGE INTO R_PT_VELUM_FM_D A
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

  
  SET V_STEP = 'R_PT_VELUM_DV_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_VELUM_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;
  SET V_STEP = 'R_PT_VELUM_DV_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_VELUM_DV_D
  (
    VELUM_DV_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    VELUM_AREA,
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
  SELECT Hex(generate_unique())    AS VELUM_DV_D_ID,
         '0'                       AS SEND_STATE,
         '1'                       AS DATA_STATE,
         MAX(MODIFY_TIME)          AS MODIFY_TIME,
         CURRENT TIMESTAMP       AS LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE             AS BUSINESS_DATE,
         SUM(VELUM_AREA)           AS VELUM_AREA,
         SUM(PROPESS_AREA)         AS PROPESS_AREA,
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
    FROM R_PT_VELUM_FM_D T
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
  ;


  SET V_STEP = '8、R_PT_VELUM_CB_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_VELUM_CB_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;
  SET V_STEP = '9、R_PT_VELUM_CB_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_VELUM_CB_D
  (
    VELUM_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    VELUM_AREA,
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
  SELECT Hex(generate_unique())  AS VELUM_CB_D_ID,
         '0'                     AS SEND_STATE,
         '1'                     AS DATA_STATE,
         MAX(MODIFY_TIME)        AS MODIFY_TIME,
         CURRENT TIMESTAMP     AS LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE           AS BUSINESS_DATE,
         SUM(VELUM_AREA)         AS VELUM_AREA,
         SUM(PROPESS_AREA)       AS PROPESS_AREA,
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
    FROM R_PT_VELUM_DV_D T
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
  ;
  COMMIT;

END
@

------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
DROP VIEW TSO.V_PT_GROW_AB_D;
CREATE VIEW TSO.V_PT_GROW_AB_D
   AS
  SELECT DATA_STORE_BASE_TBL_ID                  AS GROW_AB_D_ID,
         A.PT_YEAR  AS BUSINESS_YEAR,
         A.FEEDBACK_DATE AS BUSINESS_DATE,
         A.CLT_OBJ_ID                         AS GROW_CANOPY_ID,
         A.CLT_OBJ_CD                         AS GROW_CANOPY_CD,
         A.CLT_OBJ_NAME                       AS GROW_CANOPY_NAME,
         A.C1                                 AS CANOPY_TYPE,
         B.NAME                               AS CANOPY_TYPE_NAME,
         A.C4                                 AS GROW_PLATE_TYPE,
         A.C5                                 AS SUPPLY_STANDARD_EK,
         CASE
          WHEN A.C7 = '941' THEN '358' 
          ELSE A.C7
         END                                 AS LEAF_VARIETY_CD,
         D.ENUM_NAME                         AS LEAF_VARIETY_NAME,
         A.RELA_OBJECT_ID                    AS GROW_POINT_ID,
         E.GROW_POINT_CD                     AS GROW_POINT_CD,
         E.LOGO_CODE                         AS GROW_POINT_NAME,
         COALESCE(A.N1, 0)                         AS GROW_PLATE_QTY,
         DECIMAL(C.ENUM_CD)*COALESCE(A.N1, 0)  AS GROW_QTY,
         COALESCE(A.N2, 0)                         AS TRANSPLANT_AREA,
         A.ORG_UNIQUE_CD as ORG_CD,
         E.VILLAGE_UNIQUE_CD as AREA_CD,
         A.FEEDBACK_PSN_ID AS TECHNICIAN_ID,
         A.SEND_STATE,
         A.DATA_STATE,
         A.MODIFY_TIME,
         A.LAST_TIME
    FROM PT_DC_STAT_DATA_E A
         LEFT JOIN CM_OT_ENUM_TYPE B ON B.ENUM_KEY = A.C1 AND B.ENUM_TYPE_CD = 'CANOPY_TYPE_EK'
         LEFT JOIN PT_IX_ENUM_DATA C ON C.ENUM_CD = A.C4  AND C.IDX_ID = '8a3c34f8581f65f701582f7da0f0002d'
         LEFT JOIN PT_IX_ENUM_DATA D ON D.ENUM_CD = A.C7  AND D.IDX_ID = '8a3c34f8581f65f701582f7efc690031'
         LEFT JOIN TP_GROW_POINT E ON E.GROW_POINT_ID = A.RELA_OBJECT_ID
   WHERE A.BILL_NO     = 'TJ00000000000056'
     AND A.CHECK_STATE = '1'
     AND EXISTS(SELECT 1 
                  FROM PT_AS_TLG_FACILITY TLGFAC
                 WHERE TLGFAC.FACILITY_ID = A.CLT_OBJ_ID 
                   AND TLGFAC.DATA_STATE='1' 
                   AND TLGFAC.PT_YEAR = A.PT_YEAR 
                   AND TLGFAC.FACILITY_TYPE_EK='GROW_SHACK')
;


  DROP NICKNAME DCCELL.V_PT_GROW_AB_D ;
CREATE NICKNAME DCCELL.V_PT_GROW_AB_D      FOR TSOSERVER.TSO.V_PT_GROW_AB_D;


  DROP PROCEDURE DCCELL.P_R_PT_GROW_AB_D;
CREATE PROCEDURE DCCELL.P_R_PT_GROW_AB_D
BEGIN
  ------------------------------------------------------------
  --LINDS
  ------------------------------------------------------------
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_GROW_AB_D';
  DECLARE V_STEP                    VARCHAR(500);
  DECLARE V_PT_YEAR                 INTEGER ;
  DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000056';

  DECLARE C_ENABLE_FLAG         CHAR(1)     DEFAULT '1';
  DECLARE V_CURRENTTIMESTAMP    TIMESTAMP  ; 
  DECLARE V_TIME_STOP           TIMESTAMP;

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
  SET V_STEP = '1 R_PT_GROW_AB_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_GROW_AB_D WHERE BUSINESS_YEAR >= V_PT_YEAR;
  
  SET V_STEP = '2 R_PT_GROW_AB_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_GROW_AB_D
  (
    GROW_AB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    GROW_CANOPY_ID,
    GROW_CANOPY_CD,
    GROW_CANOPY_NAME,
    CANOPY_TYPE,
    CANOPY_TYPE_NAME,
    GROW_PLATE_TYPE,
    SUPPLY_STANDARD_EK,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    GROW_POINT_ID,
    GROW_POINT_CD,
    GROW_POINT_NAME,
    GROW_PLATE_QTY,
    GROW_QTY,
    TRANSPLANT_AREA,
    ORG_CD,
    AREA_CD,
    TECHNICIAN_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
  )
  SELECT         GROW_AB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    GROW_CANOPY_ID,
    GROW_CANOPY_CD,
    GROW_CANOPY_NAME,
    CANOPY_TYPE,
    CANOPY_TYPE_NAME,
    GROW_PLATE_TYPE,
    SUPPLY_STANDARD_EK,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    GROW_POINT_ID,
    GROW_POINT_CD,
    GROW_POINT_NAME,
    GROW_PLATE_QTY,
    GROW_QTY,
    TRANSPLANT_AREA,
    ORG_CD,
    AREA_CD,
    TECHNICIAN_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
    FROM V_PT_GROW_AB_D 
   WHERE BUSINESS_YEAR    >= V_PT_YEAR
     AND DATA_STATE = '1' 
  WITH UR
  ;
  COMMIT;

 

  UPDATE R_PT_GROW_AB_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_PT_GROW_AB_D A
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
  ;
  COMMIT;
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_PT_GROW_AB_D A
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
  ON (B.DIVISION_UNIQUE_CD = A.AREA_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND A.AREA_PROV_NAME IS NULL) 
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
  UPDATE R_PT_GROW_AB_D A
    SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
  WHERE A.BUSINESS_YEAR >= V_PT_YEAR
   -- AND A.LEAF_VARIETY_NAME IS NULL
  ;

 
  COMMIT;
END
@

------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
-- DROP VIEW V_PT_FOR_SEED_FM_Y;
CREATE VIEW V_PT_FOR_SEED_FM_Y
   AS
SELECT A.DATA_STORE_BASE_TBL_ID AS FOR_SEED_FM_Y_ID,
       A.PT_YEAR                AS BUSINESS_YEAR,
       A.CLT_OBJ_ID             AS FARMER_ID,
       A.CLT_OBJ_CD             AS FARMER_CD,
       A.CLT_OBJ_NAME           AS FARMER_NAME,
       A.C1                     AS GROW_POINT_ID,
       A.C2                     AS GROW_POINT_CD,
       A.C3                     AS GROW_POINT_NAME,
       A.C4                     AS GROW_CANOPY_ID,
       A.C5                     AS GROW_CANOPY_CD,
       A.C6                     AS GROW_CANOPY_NAME,
       A.C7                     AS LEAF_VARIETY_CD,
       COALESCE(A.n1, 0)        AS TRANSPLANT_AREA,
       COALESCE(A.N2, 0)        AS FOR_SEED_PLATE_QTY,
       COALESCE(A.N3, 0)        AS FOR_SEED_QTY,
       CAST(NULL  AS TIMESTAMP) AS FOR_SEED_DATE,
       B.STATION_UNIQUE_CD      AS ORG_CD,
       B.DIVISION_UNIQUE_CD     AS AREA_CD,
       A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
       '0'                      AS SEND_STATE,
       A.DATA_STATE             AS DATA_STATE,
       A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_F A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.CLT_OBJ_ID
                                   AND B.BIZ_YEAR = A.PT_YEAR
                                   AND B.DATA_STATE = '1'
   WHERE A.BILL_NO     = 'TJ00000000000057'
     AND A.CHECK_STATE = '1'
     AND EXISTS(SELECT 1 
                  FROM PT_AS_TLG_FACILITY C
                 WHERE C.FACILITY_ID = A.C4 
                   AND C.DATA_STATE='1' 
                   AND C.PT_YEAR = A.PT_YEAR
                   AND C.FACILITY_TYPE_EK='GROW_SHACK')
 UNION ALL 
  SELECT A.DATA_STORE_BASE_TBL_ID AS FOR_SEED_FM_Y_ID,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.CLT_OBJ_ID             AS FARMER_ID,
         A.CLT_OBJ_CD             AS FARMER_CD,
         A.CLT_OBJ_NAME           AS FARMER_NAME,
         C.GROW_POINT_ID          AS GROW_POINT_ID,
         C.GROW_POINT_CD          AS GROW_POINT_CD,
         C.LOGO_CODE              AS GROW_POINT_NAME,
         CAST(NULL AS VARCHAR(32))AS GROW_CANOPY_ID,
         CAST(NULL AS VARCHAR(32))AS GROW_CANOPY_CD,
         CAST(NULL AS VARCHAR(64))AS GROW_CANOPY_NAME,
         A.C3                     AS LEAF_VARIETY_CD,
         CAST(0 AS DECIMAL(24,6)) AS TRANSPLANT_AREA,
         COALESCE(A.n1, 0)        AS FOR_SEED_PLATE_QTY,
         CAST(0 AS DECIMAL(12))   AS FOR_SEED_QTY,
         A.D1                     AS FOR_SEED_DATE,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_A A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.CLT_OBJ_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
         LEFT JOIN TSO.TP_GROW_POINT C ON C.GROW_POINT_ID = A.C1
   WHERE A.BILL_NO      = 'TJ00000000000072'
     AND A.CHECK_STATE = '1'
  ;

  DROP NICKNAME DCCELL.V_PT_FOR_SEED_FM_Y ;
CREATE NICKNAME DCCELL.V_PT_FOR_SEED_FM_Y      FOR TSOSERVER.TSO.V_PT_FOR_SEED_FM_Y;

--DROP PROCEDURE DCCELL.P_R_PT_FOR_SEED_FM_Y;
CREATE PROCEDURE DCCELL.P_R_PT_FOR_SEED_FM_Y
-----------------------------------------------------
--LINGM 
--PT_3.3.供苗阶段情况表（按烟农、年度）加工过程，以增量方式进行
-----------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME                  VARCHAR(1000) DEFAULT 'P_R_PT_FOR_SEED_FM_Y';
  DECLARE V_STEP                       VARCHAR(500);
  DECLARE V_PT_YEAR                    INTEGER       DEFAULT 2016;
  DECLARE V_BILL_NO                    VARCHAR(64)   DEFAULT 'TJ00000000000057';

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

  SET V_STEP = '1、R_PT_FOR_SEED_FM_Y-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_FOR_SEED_FM_Y T
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '2.';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_FOR_SEED_FM_Y
  (
      FOR_SEED_FM_Y_ID,
      BUSINESS_YEAR,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      GROW_POINT_ID,
      GROW_POINT_CD,
      GROW_POINT_NAME,
      GROW_CANOPY_ID,
      GROW_CANOPY_CD,
      GROW_CANOPY_NAME,
      LEAF_VARIETY_CD,
      TRANSPLANT_AREA,
      FOR_SEED_PLATE_QTY,
      FOR_SEED_QTY,
      FOR_SEED_DATE,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT FOR_SEED_FM_Y_ID,
         BUSINESS_YEAR,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         GROW_POINT_ID,
         GROW_POINT_CD,
         GROW_POINT_NAME,
         GROW_CANOPY_ID,
         GROW_CANOPY_CD,
         GROW_CANOPY_NAME,
         LEAF_VARIETY_CD,
         TRANSPLANT_AREA,
         FOR_SEED_PLATE_QTY,
         FOR_SEED_QTY,
         FOR_SEED_DATE,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         V_CURRENTTIMESTAMP AS LAST_TIME
    FROM V_PT_FOR_SEED_FM_Y
   WHERE BUSINESS_YEAR >= V_PT_YEAR
     AND DATA_STATE = '1'
  ;
  COMMIT;

  update R_PT_FOR_SEED_FM_Y A
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
  ;
  COMMIT;

  SET V_STEP = '3.R_PT_FOR_SEED_FM_Y-U';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  UPDATE R_PT_FOR_SEED_FM_Y A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;
  UPDATE R_PT_FOR_SEED_FM_Y A
     SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
   WHERE A.BUSINESS_YEAR >= V_PT_YEAR
     AND A.LEAF_VARIETY_NAME IS NULL
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_FOR_SEED_FM_Y A
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
 MERGE INTO R_PT_FOR_SEED_FM_Y A
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



END
@
------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
  DROP VIEW TSO.V_PT_TRANSPLANT_FM_D;
CREATE VIEW TSO.V_PT_TRANSPLANT_FM_D
   AS
SELECT A.DATA_STORE_BASE_TBL_ID,
       A.PT_YEAR,
       A.FEEDBACK_DATE,
       A.CLT_OBJ_ID          AS FIELD_BLOCK_ID,
       A.CLT_OBJ_CD          AS FIELD_BLOCK_CD,
       A.CLT_OBJ_NAME        AS FIELD_BLOCK_NAME,
       A.RELA_OBJECT_ID      AS FARMER_ID,
       A.RELA_OBJECT_CD      AS FARMER_CD,
       A.RELA_OBJECT_NAME    AS FARMER_NAME,
       A.C1                  AS LEAF_VARIETY_CD,
       CAST(NULL AS VARCHAR(32))  AS LEAF_VARIETY_NAME,
       A.N1                  AS TRANSPLANT_QTY,
       CASE
         WHEN A.C2 = '1' THEN
           COALESCE(A.N2, 0)
         ELSE
           0
       END                   AS PROPESS_AREA,
       COALESCE(A.N2, 0)     AS TRANSPLANT_AREA,
       COALESCE(A.N3, 0)     AS CENSUS_QTY,
       B.STATION_UNIQUE_CD ,
       --C.ORG_NAME,
       --C.PROV,
       --C.PROV_NAME,
       --C.CITC,
       --C.CITC_NAME,
       --C.COUC,
       --C.COUC_NAME,
       --C.STAC,
       --C.STAC_NAME,
       --C.SSTC,
       --C.SSTC_NAME,
       B.DIVISION_UNIQUE_CD,
       --D.ORG_NAME,
       --D.AREA_PROV,
       --D.AREA_PROV_NAME,
       --D.AREA_CITC,
       --D.AREA_CITC_NAME,
       --D.AREA_COUC,
       --D.AREA_COUC_NAME,
       --D.AREA_TOWN,
       --D.TOWN_NAME,
       --D.AREA_VAGE,
       --D.VAGE_NAME,
       --D.AREA_GRUP,
       --D.GRUP_NAME,
       A.FEEDBACK_PSN_ID,
       '0'                   AS SEND_STATE,
       A.DATA_STATE,
       A.MODIFY_TIME,
       CURRENT TIMESTAMP     AS LAST_TIME
  FROM PT_DC_STAT_DATA_Z A
       LEFT JOIN CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID AND B.BIZ_YEAR = A.PT_YEAR AND B.DATA_STATE = '1'
 WHERE A.BILL_NO     = 'TJ00000000000058'
   AND A.CHECK_STATE = '1'
;


  DROP NICKNAME DCCELL.V_PT_TRANSPLANT_FM_D ;
CREATE NICKNAME DCCELL.V_PT_TRANSPLANT_FM_D      FOR TSOSERVER.TSO.V_PT_TRANSPLANT_FM_D;


  DROP PROCEDURE DCCELL.P_R_PT_TRANSPLANT_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_TRANSPLANT_FM_D
BEGIN
  ------------------------------------------------------------
  --LINDS
  ------------------------------------------------------------
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_TRANSPLANT_FM_D';
  DECLARE V_STEP                    VARCHAR(500);
  DECLARE V_PT_YEAR                 INTEGER ;
  DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000058';

  DECLARE C_ENABLE_FLAG         CHAR(1)     DEFAULT '1';
  DECLARE V_CURRENTTIMESTAMP    TIMESTAMP  ; 
  DECLARE V_TIME_STOP           TIMESTAMP;

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
  SET V_STEP = '1 R_PT_TRANSPLANT_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_TRANSPLANT_FM_D WHERE BUSINESS_YEAR >= V_PT_YEAR;
  
  SET V_STEP = '2 R_PT_TRANSPLANT_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_TRANSPLANT_FM_D
  (
      TRANSPLANT_FM_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      FIELD_BLOCK_ID,
      FIELD_BLOCK_CD,
      FIELD_BLOCK_NAME,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      LEAF_VARIETY_CD,
      LEAF_VARIETY_NAME,
      TRANSPLANT_QTY,
      PROPESS_AREA,
      TRANSPLANT_AREA,
      CENSUS_QTY,
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
  SELECT DATA_STORE_BASE_TBL_ID,
         PT_YEAR,
         FEEDBACK_DATE,
         FIELD_BLOCK_ID,
         FIELD_BLOCK_CD,
         FIELD_BLOCK_NAME,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         LEAF_VARIETY_CD,
         LEAF_VARIETY_NAME,
         TRANSPLANT_QTY,
         PROPESS_AREA,
         TRANSPLANT_AREA,
         CENSUS_QTY,
         STATION_UNIQUE_CD ,
         --C.ORG_NAME,
         --C.PROV,
         --C.PROV_NAME,
         --C.CITC,
         --C.CITC_NAME,
         --C.COUC,
         --C.COUC_NAME,
         --C.STAC,
         --C.STAC_NAME,
         --C.SSTC,
         --C.SSTC_NAME,
         DIVISION_UNIQUE_CD,
         --D.ORG_NAME,
         --D.AREA_PROV,
         --D.AREA_PROV_NAME,
         --D.AREA_CITC,
         --D.AREA_CITC_NAME,
         --D.AREA_COUC,
         --D.AREA_COUC_NAME,
         --D.AREA_TOWN,
         --D.TOWN_NAME,
         --D.AREA_VAGE,
         --D.VAGE_NAME,
         --D.AREA_GRUP,
         --D.GRUP_NAME,
         FEEDBACK_PSN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         CURRENT TIMESTAMP     AS LST_TIME
    FROM V_PT_TRANSPLANT_FM_D 
   WHERE PT_YEAR    >= V_PT_YEAR
     AND DATA_STATE = '1' 
  WITH UR
  ;
  COMMIT;

 
  --COMMIT;
  update R_PT_TRANSPLANT_FM_D A
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
  ;
  COMMIT;

  UPDATE R_PT_TRANSPLANT_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_TRANSPLANT_FM_D A
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
 ;
 COMMIT;
 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'DIV',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_TRANSPLANT_FM_D A
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
 ON (B.DIVISION_UNIQUE_CD = A.AREA_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND A.AREA_PROV_NAME IS NULL) 
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
  UPDATE R_PT_TRANSPLANT_FM_D A
     SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
   WHERE A.BUSINESS_YEAR >= V_PT_YEAR
     AND A.LEAF_VARIETY_NAME IS NULL
  ;

  COMMIT;


  SET V_STEP = '3 R_PT_TRANSPLANT_DV_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_TRANSPLANT_DV_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;
  

  SET V_STEP = '4 R_PT_TRANSPLANT_DV_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_TRANSPLANT_DV_D
  (
      TRANSPLANT_DV_D_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      LEAF_VARIETY_CD,
      LEAF_VARIETY_NAME,
      TRANSPLANT_QTY,
      TRANSPLANT_AREA,
      PROPESS_AREA,
      CENSUS_QTY,
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
  SELECT HEX(GENERATE_UNIQUE())   AS TRANSPLANT_DV_D_ID,
         '0'                      AS SEND_STATE,
         '1'                      AS DATA_STATE,
         MAX(MODIFY_TIME)         AS MODIFY_TIME,
         CURRENT TIMESTAMP        AS LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE            AS BUSINESS_DATE,
         LEAF_VARIETY_CD,
         LEAF_VARIETY_NAME,
         SUM(TRANSPLANT_QTY)      AS TRANSPLANT_QTY,
         SUM(TRANSPLANT_AREA)     AS TRANSPLANT_AREA,
         SUM(PROPESS_AREA)        AS PROPESS_AREA,
         SUM(CENSUS_QTY)          AS CENSUS_QTY,
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
    FROM R_PT_TRANSPLANT_FM_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.BUSINESS_YEAR,
         T.BUSINESS_DATE,
         T.LEAF_VARIETY_CD,
         T.LEAF_VARIETY_NAME,
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
  ;
  COMMIT;

  SET V_STEP = '5 R_PT_TRANSPLANT_CB_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_TRANSPLANT_CB_D T WHERE T.BUSINESS_YEAR >= V_PT_YEAR;
 
  SET V_STEP = '6 R_PT_TRANSPLANT_CB_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_TRANSPLANT_CB_D
  (
      TRANSPLANT_CB_D_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      LEAF_VARIETY_CD,
      LEAF_VARIETY_NAME,
      TRANSPLANT_QTY,
      TRANSPLANT_AREA,
      PROPESS_AREA,
      CENSUS_QTY,
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
  SELECT HEX(GENERATE_UNIQUE())   AS TRANSPLANT_CB_D_ID,
         '0',
         '1',
         MAX(MODIFY_TIME),
         CURRENT TIMESTAMP,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         LEAF_VARIETY_CD,
         LEAF_VARIETY_NAME,
         SUM(TRANSPLANT_QTY)      AS TRANSPLANT_QTY,
         SUM(TRANSPLANT_AREA)     AS TRANSPLANT_AREA,
         SUM(PROPESS_AREA)        AS PROPESS_AREA,
         SUM(CENSUS_QTY)          AS CENSUS_QTY,
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
    FROM R_PT_TRANSPLANT_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         LEAF_VARIETY_CD,
         LEAF_VARIETY_NAME,
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
  ;
  COMMIT;
END
@


------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
--DROP VIEW TSO.V_PT_MQGL_NOW_AB_D;
CREATE VIEW TSO.V_PT_MQGL_NOW_AB_D
 AS 
SELECT A.DATA_STORE_BASE_TBL_ID   AS MQGL_NOW_AB_D_ID,
       A.PT_YEAR                AS BUSINESS_YEAR,
       A.FEEDBACK_DATE          AS BUSINESS_DATE,
       A.CLT_OBJ_ID             AS GROW_CANOPY_ID,
       A.CLT_OBJ_CD             AS GROW_CANOPY_CD,
       A.CLT_OBJ_NAME           AS GROW_CANOPY_NAME,
       A.C1                     AS CANOPY_TYPE,
       C.NAME                   AS CANOPY_TYPE_NAME,
       A.RELA_OBJECT_ID         AS GROW_POINT_ID,
       B.GROW_POINT_CD          AS GROW_POINT_CD,
       B.LOGO_CODE              AS GROW_POINT_NAME,
       A.C5                     AS LEAF_VARIETY_CD,
       COALESCE(A.N3, 0)        AS EMERGE_AREA,
       COALESCE(A.N4, 0)        AS S_CROSS_AREA,
       COALESCE(A.N5, 0)        AS B_CROSS_AREA,
       COALESCE(A.N6, 0)        AS ONE_CLIP_AREA,
       COALESCE(A.N7, 0)        AS SEED_AREA,
       B.STATION_UNIQUE_CD      AS ORG_CD,
       B.VILLAGE_UNIQUE_CD      AS AREA_CD,
       A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
       '0'                      AS SEND_STATE,
       A.DATA_STATE,
       A.MODIFY_TIME
  FROM TSO.PT_DC_STAT_DATA_E A
       LEFT JOIN TSO.TP_GROW_POINT B ON B.GROW_POINT_ID = A.RELA_OBJECT_ID
       LEFT JOIN TSO.CM_OT_ENUM_TYPE C ON C.ENUM_KEY = A.C1 AND C.ENUM_TYPE_CD = 'CANOPY_TYPE_EK'
 WHERE A.BILL_NO      = 'TJ00000000000070'
   AND A.CHECK_STATE = '1'
   AND EXISTS(SELECT 1 
                FROM TSO.PT_AS_TLG_FACILITY D
               WHERE D.FACILITY_ID = A.CLT_OBJ_ID 
                 AND D.DATA_STATE='1' 
                 AND D.PT_YEAR = A.PT_YEAR 
                 AND D.FACILITY_TYPE_EK='GROW_SHACK')
;

  DROP NICKNAME DCCELL.V_PT_MQGL_NOW_AB_D ;
CREATE NICKNAME DCCELL.V_PT_MQGL_NOW_AB_D      FOR TSOSERVER.TSO.V_PT_MQGL_NOW_AB_D;


DROP PROCEDURE DCCELL.P_R_PT_MQGL_NOW_AB_D;
CREATE PROCEDURE DCCELL.P_R_PT_MQGL_NOW_AB_D
------------------------------------------------------------
--lingm
------------------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME                VARCHAR(1000) DEFAULT 'P_R_PT_MQGL_NOW_AB_D';
  DECLARE V_STEP                     VARCHAR(500);
  DECLARE V_PT_YEAR                  INTEGER DEFAULT 2016;
  DECLARE V_BILL_NO                  VARCHAR(64) DEFAULT 'TJ00000000000070'; --单据编号

  
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

  SET V_STEP = '1、本次需要加工的数据如果已存在，则删除';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_MQGL_NOW_AB_D T
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '2、写入本次需要加工的数据';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_MQGL_NOW_AB_D
  (
      MQGL_NOW_AB_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      GROW_CANOPY_ID,
      GROW_CANOPY_CD,
      GROW_CANOPY_NAME,
      CANOPY_TYPE,
      CANOPY_TYPE_NAME,
      GROW_POINT_ID,
      GROW_POINT_CD,
      GROW_POINT_NAME,
      LEAF_VARIETY_CD,
      EMERGE_AREA,
      S_CROSS_AREA,
      B_CROSS_AREA,
      ONE_CLIP_AREA,
      SEED_AREA,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT MQGL_NOW_AB_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         GROW_CANOPY_ID,
         GROW_CANOPY_CD,
         GROW_CANOPY_NAME,
         CANOPY_TYPE,
         CANOPY_TYPE_NAME,
         GROW_POINT_ID,
         GROW_POINT_CD,
         GROW_POINT_NAME,
         LEAF_VARIETY_CD,
         EMERGE_AREA,
         S_CROSS_AREA,
         B_CROSS_AREA,
         ONE_CLIP_AREA,
         SEED_AREA,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         CURRENT TIMESTAMP AS LAST_TIME
    FROM V_PT_MQGL_NOW_AB_D
   WHERE BUSINESS_YEAR >= V_PT_YEAR
     AND DATA_STATE = '1'
  ;
  COMMIT;

  UPDATE R_PT_MQGL_NOW_AB_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;
  UPDATE R_PT_MQGL_NOW_AB_D A
     SET A.LEAF_VARIETY_NAME = (select LEAF_VARIETY_NAME from R_LEAF_VARIETY B where B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD )
   WHERE A.BUSINESS_YEAR >= V_PT_YEAR
     AND A.LEAF_VARIETY_NAME IS NULL
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_MQGL_NOW_AB_D A
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
 MERGE INTO R_PT_MQGL_NOW_AB_D A
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
END
@

------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
--DROP VIEW TSO.V_PT_FOR_SEED_AB_D;
CREATE VIEW TSO.V_PT_FOR_SEED_AB_D
 AS 
 SELECT A.DATA_STORE_BASE_TBL_ID AS FOR_SEED_AB_D_ID,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         A.CLT_OBJ_ID             AS GROW_CANOPY_ID,
         A.CLT_OBJ_CD             AS GROW_CANOPY_CD,
         A.CLT_OBJ_NAME           AS GROW_CANOPY_NAME,
         A.C1                     AS CANOPY_TYPE,
         B.NAME                   AS CANOPY_TYPE_NAME,
         A.RELA_OBJECT_ID         AS GROW_POINT_ID,
         C.GROW_POINT_CD          AS GROW_POINT_CD,
         C.LOGO_CODE              AS GROW_POINT_NAME,
         A.C5                     AS LEAF_VARIETY_CD,
         COALESCE(A.N8, 0)        AS TRANSPLANT_AREA,
         COALESCE(A.N9, 0)        AS DESTORY_AREA,
         COALESCE(A.N10, 0)       AS DESTORY_QTY,
         C.STATION_UNIQUE_CD      AS ORG_CD,
         C.VILLAGE_UNIQUE_CD      AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE,
         A.MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_E A
         LEFT JOIN TSO.CM_OT_ENUM_TYPE B ON B.ENUM_KEY = A.C1 AND B.ENUM_TYPE_CD = 'CANOPY_TYPE_EK'
         LEFT JOIN TSO.TP_GROW_POINT C ON C.GROW_POINT_ID = A.RELA_OBJECT_ID
   WHERE A.BILL_NO     = 'TJ00000000000071'
     AND A.CHECK_STATE = '1'
     AND EXISTS(SELECT 1 
                  FROM TSO.PT_AS_TLG_FACILITY D
                 WHERE D.FACILITY_ID = A.CLT_OBJ_ID 
                   AND D.DATA_STATE='1' 
                   AND D.PT_YEAR = A.PT_YEAR 
                   AND D.FACILITY_TYPE_EK='GROW_SHACK')
  ;

  DROP NICKNAME DCCELL.V_PT_FOR_SEED_AB_D ;
CREATE NICKNAME DCCELL.V_PT_FOR_SEED_AB_D      FOR TSOSERVER.TSO.V_PT_FOR_SEED_AB_D;


  DROP PROCEDURE DCCELL.P_R_PT_FOR_SEED_AB_D;
CREATE PROCEDURE DCCELL.P_R_PT_FOR_SEED_AB_D
-----------------------------------------------------
--LINGM 
-----------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME                 VARCHAR(1000) DEFAULT 'P_R_PT_FOR_SEED_AB_D';
  DECLARE V_STEP                      VARCHAR(500);
  DECLARE V_PT_YEAR                   INTEGER DEFAULT 2016;
  DECLARE V_BILL_NO                   VARCHAR(64) DEFAULT 'TJ00000000000071'; --单据编号


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
  INSERT INTO R_PT_FOR_SEED_AB_D
  (
      FOR_SEED_AB_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      GROW_CANOPY_ID,
      GROW_CANOPY_CD,
      GROW_CANOPY_NAME,
      CANOPY_TYPE,
      CANOPY_TYPE_NAME,
      GROW_POINT_ID,
      GROW_POINT_CD,
      GROW_POINT_NAME,
      LEAF_VARIETY_CD,
      TRANSPLANT_AREA,
      DESTORY_AREA,
      DESTORY_QTY,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT FOR_SEED_AB_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         GROW_CANOPY_ID,
         GROW_CANOPY_CD,
         GROW_CANOPY_NAME,
         CANOPY_TYPE,
         CANOPY_TYPE_NAME,
         GROW_POINT_ID,
         GROW_POINT_CD,
         GROW_POINT_NAME,
         LEAF_VARIETY_CD,
         TRANSPLANT_AREA,
         DESTORY_AREA,
         DESTORY_QTY,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         CURRENT TIMESTAMP
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

END
@

------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
-- DROP VIEW TSO.V_PT_FILM_RECY_FM_D;
CREATE VIEW TSO.V_PT_FILM_RECY_FM_D
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID AS FILM_RECY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         A.N1                     AS COVER_AREA,
         A.N2                     AS RECY_ARA,
         A.N3                     AS PROPESS_AREA,
         A.N4                     AS SUBSIDE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_G A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000059'
     AND A.CHECK_STATE = '1'
;


  DROP NICKNAME DCCELL.V_PT_FILM_RECY_FM_D ;
CREATE NICKNAME DCCELL.V_PT_FILM_RECY_FM_D     FOR TSOSERVER.TSO.V_PT_FILM_RECY_FM_D;

------------------------------------------------------------
DROP PROCEDURE DCCELL.P_R_PT_FILM_RECY_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_FILM_RECY_FM_D
--PT_6.4地膜回收_加工存储过程，包括组织和行政表，
-----------------------------------------------------
--LINGM 
-----------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_FILM_RECY_FM_D';
  DECLARE V_STEP                    VARCHAR(500);
  DECLARE V_PT_YEAR                 INTEGER;
  DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000059'; --单据编号
  
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

  SET V_STEP = '1.R_PT_FILM_RECY_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_FILM_RECY_FM_D
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '2.R_PT_FILM_RECY_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_FILM_RECY_FM_D
  (
      FILM_RECY_FM_D_ID,
      FIELD_BLOCK_ID,
      FIELD_BLOCK_CD,
      FIELD_BLOCK_NAME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      COVER_AREA,
      RECY_ARA,
      PROPESS_AREA,
      SUBSIDE_MONEY,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT FILM_RECY_FM_D_ID,
         FIELD_BLOCK_ID,
         FIELD_BLOCK_CD,
         FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         COVER_AREA,
         RECY_ARA,
         PROPESS_AREA,
         SUBSIDE_MONEY,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         CURRENT TIMESTAMP AS LAST_TIME
    FROM V_PT_FILM_RECY_FM_D 
   WHERE DATA_STATE = '1'
     AND BUSINESS_YEAR >= V_PT_YEAR
  ;

  update R_PT_FILM_RECY_FM_D A
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
  ;
  COMMIT;

  SET V_STEP = '3.R_PT_FILM_RECY_FM_D-U';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  UPDATE R_PT_FILM_RECY_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_FILM_RECY_FM_D A
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
 MERGE INTO R_PT_FILM_RECY_FM_D A
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

  
  SET V_STEP = '6、R_PT_FILM_RECY_DV_D-D';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_FILM_RECY_DV_D
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;
  
  SET V_STEP = '7、R_PT_FILM_RECY_DV_D-I';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_FILM_RECY_DV_D
  (
      FILM_RECY_DV_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      COVER_AREA,
      RECY_ARA,
      PROPESS_AREA,
      SUBSIDE_MONEY,
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
  SELECT HEX(GENERATE_UNIQUE()) AS FILM_RECY_DV_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         SUM(COVER_AREA)        AS COVER_AREA,
         SUM(RECY_ARA)          AS RECY_ARA,
         SUM(PROPESS_AREA)      AS PROPESS_AREA,
         SUM(SUBSIDE_MONEY)     AS SUBSIDE_MONEY,
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
         '0',
         '1',
         MAX(MODIFY_TIME),
         V_CURRENTTIMESTAMP
    FROM R_PT_FILM_RECY_FM_D T
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
  ;

  SET V_STEP = '8、R_PT_FILM_RECY_CB_D-D';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_FILM_RECY_CB_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '9、R_PT_FILM_RECY_CB_D-I';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_FILM_RECY_CB_D
  (
      FILM_RECY_CB_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      COVER_AREA,
      RECY_ARA,
      PROPESS_AREA,
      SUBSIDE_MONEY,
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
  SELECT HEX(GENERATE_UNIQUE()) AS FILM_RECY_CB_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         SUM(COVER_AREA),
         SUM(RECY_ARA),
         SUM(PROPESS_AREA),
         SUM(SUBSIDE_MONEY),
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
         '0',
         '1',
         MAX(MODIFY_TIME),
         V_CURRENTTIMESTAMP
    FROM R_PT_FILM_RECY_DV_D T
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
  ;
  COMMIT;

END
@
--PT_6.4地膜回收_加工存储过程，包括组织和行政表，以增量方式进行
-- CREATE PROCEDURE DCCELL.P_R_PT_FILM_RECY_FM_D
-- BEGIN
--   DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_FILM_RECY_FM_D';
--   DECLARE V_STEP                    VARCHAR(500);
--   DECLARE V_PT_YEAR                 INTEGER DEFAULT 2016;
--   DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000059'; --单据编号
--   DECLARE V_TIME_LAST               TIMESTAMP;
--   DECLARE V_TIME_CURRENT            TIMESTAMP;
--   DECLARE V_TIME_BEGIN              TIMESTAMP; --语句块开始执行时间
--   DECLARE V_TIME_END                TIMESTAMP;   --语句块结束执行时间

--   SET V_STEP = '1、取系统当前时间，和存储过程上次加工时间';
--   SET V_TIME_CURRENT = CURRENT TIMESTAMP;

--   SELECT TIME_STOP INTO V_TIME_LAST 
--     FROM DCCELL.DC_PROC_TIME_STOP 
--    WHERE PROC_NAME=V_PROC_NAME
--   ;
--   SELECT BUSI_YEAR INTO V_PT_YEAR 
--     FROM DC_PROC_BUSI_YEAR A 
--    WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
--   ;

--   SET V_STEP = '3、将有修改过的数据涉及到的组织和行政，记录到临时表当中';


--   SET V_STEP = '4、本次需要加工的数据如果已存在，则删除';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   DELETE FROM R_PT_FILM_RECY_FM_D T
--    WHERE EXISTS (
--            SELECT 1 
--              FROM PT_DC_STAT_DATA_G DATA_TAB
--             WHERE DATA_TAB.BILL_NO      = V_BILL_NO
--               AND DATA_TAB.PT_YEAR    >= V_PT_YEAR
--               AND DATA_TAB.CHECK_STATE = '1'
--               AND DATA_TAB.MODIFY_TIME  > V_TIME_LAST
--               AND T.FILM_RECY_FM_D_ID = DATA_TAB.DATA_STORE_BASE_TBL_ID
--          )
--      AND (CITC <> '5227' OR ORG_CD IS NULL OR ORG_CD = '0')
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '已从业务表中删除的数据，需要从加工表中同步删除';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   DELETE FROM R_PT_FILM_RECY_FM_D T
--    WHERE NOT EXISTS (
--                SELECT 1 
--                  FROM PT_DC_STAT_DATA_G DATA_TAB
--                 WHERE T.FILM_RECY_FM_D_ID = DATA_TAB.DATA_STORE_BASE_TBL_ID
--          )
--      AND (CITC <> '5227' OR ORG_CD IS NULL OR ORG_CD = '0')
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '5、写入本次需要加工的数据';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   INSERT INTO R_PT_FILM_RECY_FM_D
--   (
--       FILM_RECY_FM_D_ID,
--       FIELD_BLOCK_ID,
--       FIELD_BLOCK_CD,
--       FIELD_BLOCK_NAME,
--       BUSINESS_YEAR,
--       BUSINESS_DATE,
--       COVER_AREA,
--       RECY_ARA,
--       PROPESS_AREA,
--       SUBSIDE_MONEY,
--       FARMER_ID,
--       FARMER_CD,
--       FARMER_NAME,
--       ORG_CD,
--       ORG_NAME,
--       PROV,
--       PROV_NAME,
--       CITC,
--       CITC_NAME,
--       COUC,
--       COUC_NAME,
--       STAC,
--       STAC_NAME,
--       SSTC,
--       SSTC_NAME,
--       AREA_CD,
--       AREA_NAME,
--       AREA_PROV,
--       AREA_PROV_NAME,
--       AREA_CITC,
--       AREA_CITC_NAME,
--       AREA_COUC,
--       AREA_COUC_NAME,
--       AREA_TOWN,
--       TOWN_NAME,
--       AREA_VAGE,
--       VAGE_NAME,
--       AREA_GRUP,
--       GRUP_NAME,
--       TECHNICIAN_ID,
--       SEND_STATE,
--       DATA_STATE,
--       MODIFY_TIME,
--       LAST_TIME
--   )
--   SELECT DATA_TAB.DATA_STORE_BASE_TBL_ID AS FILM_RECY_FM_D_ID,
--          DATA_TAB.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
--          DATA_TAB.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
--          DATA_TAB.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
--          DATA_TAB.PT_YEAR,
--          DATA_TAB.FEEDBACK_DATE,
--          DATA_TAB.N1                     AS COVER_AREA,
--          DATA_TAB.N2                     AS RECY_ARA,
--          DATA_TAB.N3                     AS PROPESS_AREA,
--          DATA_TAB.N4                     AS SUBSIDE_MONEY,
--          DATA_TAB.RELA_OBJECT_ID         AS FARMER_ID,
--          DATA_TAB.RELA_OBJECT_CD         AS FARMER_CD,
--          DATA_TAB.RELA_OBJECT_NAME FARMER_NAME,
--          ORG.ORG_CD,
--          ORG.ORG_NAME,
--          ORG.PROV,
--          ORG.PROV_NAME,
--          ORG.CITC,
--          ORG.CITC_NAME,
--          ORG.COUC,
--          ORG.COUC_NAME,
--          ORG.STAC,
--          ORG.STAC_NAME,
--          ORG.SSTC,
--          ORG.SSTC_NAME,
--          DIVISION.ORG_CD,
--          DIVISION.ORG_NAME,
--          DIVISION.AREA_PROV,
--          DIVISION.AREA_PROV_NAME,
--          DIVISION.AREA_CITC,
--          DIVISION.AREA_CITC_NAME,
--          DIVISION.AREA_COUC,
--          DIVISION.AREA_COUC_NAME,
--          DIVISION.AREA_TOWN,
--          DIVISION.TOWN_NAME,
--          DIVISION.AREA_VAGE,
--          DIVISION.VAGE_NAME,
--          DIVISION.AREA_GRUP,
--          DIVISION.GRUP_NAME,
--          DATA_TAB.FEEDBACK_PSN_ID,
--          '0',
--          '1',
--          DATA_TAB.MODIFY_TIME,
--          V_TIME_CURRENT
--     FROM PT_DC_STAT_DATA_G DATA_TAB
--          --LEFT JOIN V_R_FARMER FARMER ON FARMER.FARMER_ID = DATA_TAB.RELA_OBJECT_ID AND FARMER.BUSINESS_YEAR = V_PT_YEAR
--          LEFT JOIN CM_PM_FRM_FUND FARMER  ON FARMER.FRM_FUND_UNIQUE_ID = DATA_TAB.RELA_OBJECT_ID AND FARMER.BIZ_YEAR = V_PT_YEAR AND FARMER.DATA_STATE = '1'
--          LEFT JOIN B_ORG ORG ON ORG.ORG_UNIQUE_CD = FARMER.STATION_UNIQUE_CD
--          LEFT JOIN B_DIVISION DIVISION ON DIVISION.DIVISION_UNIQUE_CD = FARMER.DIVISION_UNIQUE_CD
--    WHERE DATA_TAB.BILL_NO      = V_BILL_NO
--      AND DATA_TAB.DATA_STATE = '1'
--      AND DATA_TAB.CHECK_STATE = '1'
--      AND DATA_TAB.PT_YEAR    >= V_PT_YEAR
--      AND DATA_TAB.MODIFY_TIME  > V_TIME_LAST
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '6、删除行政表所有数据，采用全量加工';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   DELETE FROM R_PT_FILM_RECY_DV_D T
--    WHERE T.BUSINESS_YEAR >= V_PT_YEAR
--      AND DATA_STATE    = '1'
--      AND (CITC <> '5227' OR ORG_CD IS NULL OR ORG_CD = '0')
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '7、重新统计行政表数据';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   INSERT INTO R_PT_FILM_RECY_DV_D
--   (
--       FILM_RECY_DV_D_ID,
--       BUSINESS_YEAR,
--       BUSINESS_DATE,
--       COVER_AREA,
--       RECY_ARA,
--       PROPESS_AREA,
--       SUBSIDE_MONEY,
--       ORG_CD,
--       ORG_NAME,
--       PROV,
--       PROV_NAME,
--       CITC,
--       CITC_NAME,
--       COUC,
--       COUC_NAME,
--       STAC,
--       STAC_NAME,
--       SSTC,
--       SSTC_NAME,
--       AREA_CD,
--       AREA_NAME,
--       AREA_PROV,
--       AREA_PROV_NAME,
--       AREA_CITC,
--       AREA_CITC_NAME,
--       AREA_COUC,
--       AREA_COUC_NAME,
--       AREA_TOWN,
--       TOWN_NAME,
--       AREA_VAGE,
--       VAGE_NAME,
--       AREA_GRUP,
--       GRUP_NAME,
--       SEND_STATE,
--       DATA_STATE,
--       MODIFY_TIME,
--       LAST_TIME
--   )
--   SELECT HEX(GENERATE_UNIQUE()) AS FILM_RECY_DV_D_ID,
--          BUSINESS_YEAR,
--          BUSINESS_DATE,
--          SUM(COVER_AREA)        AS COVER_AREA,
--          SUM(RECY_ARA)          AS RECY_ARA,
--          SUM(PROPESS_AREA)      AS PROPESS_AREA,
--          SUM(SUBSIDE_MONEY)     AS SUBSIDE_MONEY,
--          ORG_CD,
--          ORG_NAME,
--          PROV,
--          PROV_NAME,
--          CITC,
--          CITC_NAME,
--          COUC,
--          COUC_NAME,
--          STAC,
--          STAC_NAME,
--          SSTC,
--          SSTC_NAME,
--          AREA_CD,
--          AREA_NAME,
--          AREA_PROV,
--          AREA_PROV_NAME,
--          AREA_CITC,
--          AREA_CITC_NAME,
--          AREA_COUC,
--          AREA_COUC_NAME,
--          AREA_TOWN,
--          TOWN_NAME,
--          AREA_VAGE,
--          VAGE_NAME,
--          AREA_GRUP,
--          GRUP_NAME,
--          '0',
--          '1',
--          MAX(MODIFY_TIME),
--          V_TIME_CURRENT
--     FROM R_PT_FILM_RECY_FM_D T
--    WHERE T.BUSINESS_YEAR >= V_PT_YEAR
--    GROUP BY
--          T.BUSINESS_YEAR,
--          T.BUSINESS_DATE,
--          T.ORG_CD,
--          T.ORG_NAME,
--          T.PROV,
--          T.PROV_NAME,
--          T.CITC,
--          T.CITC_NAME,
--          T.COUC,
--          T.COUC_NAME,
--          T.STAC,
--          T.STAC_NAME,
--          T.SSTC,
--          T.SSTC_NAME,
--          T.AREA_CD,
--          T.AREA_NAME,
--          T.AREA_PROV,
--          T.AREA_PROV_NAME,
--          T.AREA_CITC,
--          T.AREA_CITC_NAME,
--          T.AREA_COUC,
--          T.AREA_COUC_NAME,
--          T.AREA_TOWN,
--          T.TOWN_NAME,
--          T.AREA_VAGE,
--          T.VAGE_NAME,
--          T.AREA_GRUP,
--          T.GRUP_NAME
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '8、删除组织表所有数据，采用全量加工';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   DELETE FROM R_PT_FILM_RECY_CB_D T
--    WHERE T.BUSINESS_YEAR >= V_PT_YEAR
--      AND (CITC <> '5227' OR ORG_CD IS NULL OR ORG_CD = '0')
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '9、重新统计组织表数据';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   INSERT INTO R_PT_FILM_RECY_CB_D
--   (
--       FILM_RECY_CB_D_ID,
--       BUSINESS_YEAR,
--       BUSINESS_DATE,
--       COVER_AREA,
--       RECY_ARA,
--       PROPESS_AREA,
--       SUBSIDE_MONEY,
--       ORG_CD,
--       ORG_NAME,
--       PROV,
--       PROV_NAME,
--       CITC,
--       CITC_NAME,
--       COUC,
--       COUC_NAME,
--       STAC,
--       STAC_NAME,
--       SSTC,
--       SSTC_NAME,
--       SEND_STATE,
--       DATA_STATE,
--       MODIFY_TIME,
--       LAST_TIME
--   )
--   SELECT HEX(GENERATE_UNIQUE()) AS FILM_RECY_CB_D_ID,
--          BUSINESS_YEAR,
--          BUSINESS_DATE,
--          SUM(COVER_AREA),
--          SUM(RECY_ARA),
--          SUM(PROPESS_AREA),
--          SUM(SUBSIDE_MONEY),
--          ORG_CD,
--          ORG_NAME,
--          PROV,
--          PROV_NAME,
--          CITC,
--          CITC_NAME,
--          COUC,
--          COUC_NAME,
--          STAC,
--          STAC_NAME,
--          SSTC,
--          SSTC_NAME,
--          '0',
--          '1',
--          MAX(MODIFY_TIME),
--          V_TIME_CURRENT
--     FROM R_PT_FILM_RECY_DV_D T
--    WHERE T.BUSINESS_YEAR >= V_PT_YEAR
--    GROUP BY
--          T.BUSINESS_YEAR,
--          T.BUSINESS_DATE,
--          T.ORG_CD,
--          T.ORG_NAME,
--          T.PROV,
--          T.PROV_NAME,
--          T.CITC,
--          T.CITC_NAME,
--          T.COUC,
--          T.COUC_NAME,
--          T.STAC,
--          T.STAC_NAME,
--          T.SSTC,
--          T.SSTC_NAME
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);

--   COMMIT;


--   SET V_STEP = '10、更新存储过程执行时间';
--   UPDATE DCCELL.DC_PROC_TIME_STOP 
--      SET TIME_STOP = V_TIME_CURRENT 
--    WHERE PROC_NAME=V_PROC_NAME
--   ;


--   SET V_STEP = '11、将本次加工后，ORG_CD为空的业务数据，modify_time重置为current timestamp';
--   UPDATE PT_DC_STAT_DATA_G G SET MODIFY_TIME = CURRENT TIMESTAMP
--   WHERE EXISTS (
--           SELECT 1 
--             FROM R_PT_FILM_RECY_FM_D D
--            WHERE D.FILM_RECY_FM_D_ID = G.DATA_STORE_BASE_TBL_ID
--              AND (D.ORG_CD IS NULL OR D.ORG_CD = '0')
--         )
--   ;
  
--   COMMIT;
-- END
-- @
------------------------------------------------------------
--
--
--
--P_R_PT_YY_GROW_FM_D
------------------------------------------------------------
-- DROP VIEW TSO.V_PT_YY_GROW_FM_D;
CREATE VIEW TSO.V_PT_YY_GROW_FM_D
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID AS YY_GROW_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         CASE
           WHEN  A.C3 = '1' THEN
             COALESCE(A.N1,0)
           ELSE 0
         END                      AS ROOFED_PROPESS_AREA,
         CASE 
           WHEN A.C3 IS NULL OR A.C3 = '' OR A.C3 = '2'
           THEN 0
           ELSE COALESCE(A.N1,0)
         END                      AS ROOFED_AREA,
         A.C5                     AS GROW_STATUS,
         A.N2                     AS LEAF_NUM,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_A A
    LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                  AND B.BIZ_YEAR = A.PT_YEAR
                                  AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000061'
     AND A.CHECK_STATE = '1'
;


  DROP NICKNAME DCCELL.V_PT_YY_GROW_FM_D ;
CREATE NICKNAME DCCELL.V_PT_YY_GROW_FM_D       FOR TSOSERVER.TSO.V_PT_YY_GROW_FM_D;

DROP PROCEDURE DCCELL.P_R_PT_YY_GROW_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_YY_GROW_FM_D
--PT_1.1田间长势情况表（按烟农、日期）_加工存储过程，包括组织和行政表，以增量方式进行
BEGIN
  DECLARE V_PROC_NAME                  VARCHAR(1000) DEFAULT 'P_R_PT_YY_GROW_FM_D';
  DECLARE V_STEP                       VARCHAR(500);
  DECLARE V_PT_YEAR                    INTEGER ;
  DECLARE V_BILL_NO                    VARCHAR(64) DEFAULT 'TJ00000000000061';

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

  SET V_STEP = '1.R_PT_YY_GROW_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_YY_GROW_FM_D T
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '2.R_PT_YY_GROW_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_YY_GROW_FM_D
  (
    YY_GROW_FM_D_ID,
    FIELD_BLOCK_ID,
    FIELD_BLOCK_CD,
    FIELD_BLOCK_NAME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    ROOFED_PROPESS_AREA,
    ROOFED_AREA,
    GROW_STATUS,
    LEAF_NUM,
    FARMER_ID,
    FARMER_CD,
    FARMER_NAME,
    ORG_CD,
    AREA_CD,
    TECHNICIAN_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
  )
  SELECT YY_GROW_FM_D_ID,
         FIELD_BLOCK_ID,
         FIELD_BLOCK_CD,
         FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         ROOFED_PROPESS_AREA,
         ROOFED_AREA,
         GROW_STATUS,
         LEAF_NUM,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         V_CURRENTTIMESTAMP
    FROM V_PT_YY_GROW_FM_D
   WHERE DATA_STATE = '1'
     AND BUSINESS_YEAR >= V_PT_YEAR
  ;

  UPDATE R_PT_YY_GROW_FM_D A
     SET (
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
  ;
  COMMIT;

  SET V_STEP = '3.R_PT_YY_GROW_FM_D-U';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  UPDATE R_PT_YY_GROW_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_YY_GROW_FM_D A
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
 MERGE INTO R_PT_YY_GROW_FM_D A
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

  SET V_STEP = '6、R_PT_YY_GROW_DV_D-D';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_YY_GROW_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '7、R_PT_YY_GROW_DV_D-I';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_YY_GROW_DV_D
  (
    YY_GROW_DV_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    ROOFED_PROPESS_AREA,
    ROOFED_AREA,
    LEAF_NUM,
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
  SELECT HEX(GENERATE_UNIQUE())   AS YY_GROW_DV_D_ID,
         '0',
         '1',
         MAX(MODIFY_TIME),
         V_CURRENTTIMESTAMP,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         SUM(ROOFED_PROPESS_AREA) AS ROOFED_PROPESS_AREA,
         SUM(ROOFED_AREA)         AS ROOFED_AREA,
         AVG(LEAF_NUM)            AS LEAF_NUM,
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
    FROM R_PT_YY_GROW_FM_D T
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
  ;

  SET V_STEP = '8、R_PT_YY_GROW_CB_D-D';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_YY_GROW_CB_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
     AND YY_GROW_CB_D_ID not like 'TJGL%'
  ;

  SET V_STEP = '9、R_PT_YY_GROW_CB_D-I';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_YY_GROW_CB_D
  (
    YY_GROW_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    ROOFED_PROPESS_AREA,
    ROOFED_AREA,
    LEAF_NUM,
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
  SELECT HEX(GENERATE_UNIQUE())      AS YY_GROW_CB_D_ID,
         '0',
         '1',
         MAX(MODIFY_TIME),
         V_CURRENTTIMESTAMP,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         SUM(ROOFED_PROPESS_AREA)    AS ROOFED_PROPESS_AREA,
         SUM(ROOFED_AREA)            AS ROOFED_AREA,
         AVG(LEAF_NUM)               AS LEAF_NUM,
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
    FROM R_PT_YY_GROW_DV_D T
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
  ;
  COMMIT;

END
@
------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
-- DROP VIEW TSO.V_PT_DT_FM_D;
CREATE VIEW TSO.V_PT_DT_FM_D
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID    AS DT_FM_D_ID,
         A.CLT_OBJ_ID                AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD                AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME              AS FIELD_BLOCK_NAME,
         A.PT_YEAR                   AS BUSINESS_YEAR,
         A.FEEDBACK_DATE             AS BUSINESS_DATE,
         CASE 
           WHEN A.C1 IS NULL OR A.C1 = '' OR A.C1 = '2' THEN
             0
           ELSE
             COALESCE(A.N1,0)
         END                         AS UNCOVER_AREA,
         CASE 
           WHEN A.C1 ='1' THEN
            COALESCE(A.N1,0)
           ELSE 0
         END                         AS UNCOVER_ROOFED_AREA,
         CASE 
           WHEN A.C2 IS NULL OR A.C2 = '' OR A.C2 = '2' THEN
             0
           ELSE
             COALESCE(A.N1,0)
         END                         AS BUTTON_POLE_AREA,
         CASE 
           WHEN A.C2 ='1' THEN
             COALESCE(A.N1,0)
           ELSE
             0
         END                         AS BUTTON_POLE_ROOFED_AREA,
         CASE 
           WHEN A.C3 IS NULL OR A.C3 = '' OR A.C3 = '2' THEN
             0
           ELSE 
             COALESCE(A.N1,0)
         END                         AS DEBRIS_CLEAN_AREA,
         CASE 
           WHEN A.C3 ='1' THEN
             COALESCE(A.N1,0)
           ELSE
             0
         END                         AS DEBRIS_CLEAN_ROOFED_AREA,
         0                           AS MANURE_AREA,
         0                           AS MANURE_ROOFED_AREA,
         0                           AS PTSX_AREA,
         0                           AS PTSX_ROOFED_AREA,
         0                           AS PREVENT_AREA,
         0                           AS PREVENT_ROOFED_AREA,
         A.RELA_OBJECT_ID            AS FARMER_ID,
         A.RELA_OBJECT_CD            AS FARMER_CD,
         A.RELA_OBJECT_NAME          AS FARMER_NAME,
         B.STATION_UNIQUE_CD         AS ORG_CD,
         B.DIVISION_UNIQUE_CD        AS AREA_CD,
         A.FEEDBACK_PSN_ID           AS TECHNICIAN_ID,
         '0'                         AS SEND_STATE,
         A.DATA_STATE                AS DATA_STATE,
         A.MODIFY_TIME               AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_H A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000060'
     AND A.CHECK_STATE = '1'
UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS DT_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         0                        AS UNCOVER_AREA,
         0                        AS UNCOVER_ROOFED_AREA,
         0                        AS BUTTON_POLE_AREA,
         0                        AS BUTTON_POLE_ROOFED_AREA,
         0                        AS DEBRIS_CLEAN_AREA,
         0                        AS DEBRIS_CLEAN_ROOFED_AREA,
         CASE 
           WHEN A.C1 IS NULL OR A.C1 = '' OR A.C1 = '2'
           THEN 0
           ELSE COALESCE(A.N1,0)
         END                      AS MANURE_AREA,
         CASE 
           WHEN A.C1 ='1'
           THEN COALESCE(A.N1,0)
           ELSE 0
         END                      AS MANURE_ROOFED_AREA,
         CASE 
           WHEN A.C2 IS NULL OR A.C2 = '' OR A.C2 = '2'
           THEN 0
           ELSE COALESCE(A.N1,0)
         END                      AS PTSX_AREA,
         CASE 
           WHEN A.C2 ='1'
           THEN COALESCE(A.N1,0)
           ELSE 0
         END                      AS PTSX_ROOFED_AREA,
         CASE 
           WHEN A.C4 IS NULL OR A.C4 = '' OR A.C4 = '2'
           THEN 0
           ELSE COALESCE(A.N1,0)
         END                      AS PREVENT_AREA,
         CASE 
           WHEN A.C4 ='1'
           THEN COALESCE(A.N1,0)
           ELSE 0
         END                      AS PREVENT_ROOFED_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_A A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000061'
     AND A.CHECK_STATE = '1'
;


  DROP NICKNAME DCCELL.V_PT_DT_FM_D ;
CREATE NICKNAME DCCELL.V_PT_DT_FM_D     FOR TSOSERVER.TSO.V_PT_DT_FM_D;

DROP PROCEDURE DCCELL.P_R_PT_DT_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_DT_FM_D
--PT_6.4田间卫生_加工存储过程，包括组织和行政表，以增量方式进行
--大田管理与田间卫生共用R_PT_DT_FM_D加工表，此存储过程一并处理
BEGIN
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_DT_FM_D';
  DECLARE V_STEP                    VARCHAR(500);
  DECLARE V_PT_YEAR                 INTEGER DEFAULT 2016;
  DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000060';
  DECLARE V_BILL_NO_61              VARCHAR(64) DEFAULT 'TJ00000000000061';

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

  SET V_STEP = '1.R_PT_DT_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_DT_FM_D T
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '2.R_PT_DT_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_DT_FM_D
  (
      DT_FM_D_ID,
      FIELD_BLOCK_ID,
      FIELD_BLOCK_CD,
      FIELD_BLOCK_NAME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      UNCOVER_AREA,
      UNCOVER_ROOFED_AREA,
      BUTTON_POLE_AREA,
      BUTTON_POLE_ROOFED_AREA,
      DEBRIS_CLEAN_AREA,
      DEBRIS_CLEAN_ROOFED_AREA,
      MANURE_AREA,
      MANURE_ROOFED_AREA,
      PTSX_AREA,
      PTSX_ROOFED_AREA,
      PREVENT_AREA,
      PREVENT_ROOFED_AREA,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT DT_FM_D_ID,
         FIELD_BLOCK_ID,
         FIELD_BLOCK_CD,
         FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         UNCOVER_AREA,
         UNCOVER_ROOFED_AREA,
         BUTTON_POLE_AREA,
         BUTTON_POLE_ROOFED_AREA,
         DEBRIS_CLEAN_AREA,
         DEBRIS_CLEAN_ROOFED_AREA,
         MANURE_AREA,
         MANURE_ROOFED_AREA,
         PTSX_AREA,
         PTSX_ROOFED_AREA,
         PREVENT_AREA,
         PREVENT_ROOFED_AREA,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         CURRENT TIMESTAMP AS LAST_TIME
    FROM V_PT_DT_FM_D
   WHERE DATA_STATE = '1'
     AND BUSINESS_YEAR >= V_PT_YEAR
  ;

  UPDATE R_PT_DT_FM_D A
     SET (
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
  ;
  COMMIT;

  SET V_STEP = '3.R_PT_DT_FM_D-U';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  UPDATE R_PT_DT_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

 call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
 MERGE INTO R_PT_DT_FM_D A
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
 MERGE INTO R_PT_DT_FM_D A
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
  
  SET V_STEP = '7、R_PT_DT_DV_D-D';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_DT_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '8、R_PT_DT_DV_D-I';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_DT_DV_D
  (
      DT_DV_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      UNCOVER_AREA,
      UNCOVER_ROOFED_AREA,
      BUTTON_POLE_AREA,
      BUTTON_POLE_ROOFED_AREA,
      DEBRIS_CLEAN_AREA,
      DEBRIS_CLEAN_ROOFED_AREA,
      MANURE_AREA,
      MANURE_ROOFED_AREA,
      PTSX_AREA,
      PTSX_ROOFED_AREA,
      PREVENT_AREA,
      PREVENT_ROOFED_AREA,
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
  SELECT HEX(GENERATE_UNIQUE()) AS DT_DV_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         SUM(UNCOVER_AREA) AS UNCOVER_AREA,
         SUM(UNCOVER_ROOFED_AREA) AS UNCOVER_ROOFED_AREA,
         SUM(BUTTON_POLE_AREA) AS BUTTON_POLE_AREA,
         SUM(BUTTON_POLE_ROOFED_AREA) AS BUTTON_POLE_ROOFED_AREA,
         SUM(DEBRIS_CLEAN_AREA) AS DEBRIS_CLEAN_AREA,
         SUM(DEBRIS_CLEAN_ROOFED_AREA) AS DEBRIS_CLEAN_ROOFED_AREA,
         SUM(MANURE_AREA) AS MANURE_AREA,
         SUM(MANURE_ROOFED_AREA) AS MANURE_ROOFED_AREA,
         SUM(PTSX_AREA) AS PTSX_AREA,
         SUM(PTSX_ROOFED_AREA) AS PTSX_ROOFED_AREA,
         SUM(PREVENT_AREA) AS PREVENT_AREA,
         SUM(PREVENT_ROOFED_AREA) AS PREVENT_ROOFED_AREA,
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
         '0',
         '1',
         MAX(MODIFY_TIME),
         V_CURRENTTIMESTAMP
    FROM R_PT_DT_FM_D T
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
  ;

  SET V_STEP = '9、R_PT_DT_CB_D-D';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_DT_CB_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '10、R_PT_DT_CB_D-I';
  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_DT_CB_D
  (
      DT_CB_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      UNCOVER_AREA,
      UNCOVER_ROOFED_AREA,
      BUTTON_POLE_AREA,
      BUTTON_POLE_ROOFED_AREA,
      DEBRIS_CLEAN_AREA,
      DEBRIS_CLEAN_ROOFED_AREA,
      MANURE_AREA,
      MANURE_ROOFED_AREA,
      PTSX_AREA,
      PTSX_ROOFED_AREA,
      PREVENT_AREA,
      PREVENT_ROOFED_AREA,
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
  SELECT HEX(GENERATE_UNIQUE()) AS DT_CB_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         SUM(UNCOVER_AREA) AS UNCOVER_AREA,
         SUM(UNCOVER_ROOFED_AREA) AS UNCOVER_ROOFED_AREA,
         SUM(BUTTON_POLE_AREA) AS BUTTON_POLE_AREA,
         SUM(BUTTON_POLE_ROOFED_AREA) AS BUTTON_POLE_ROOFED_AREA,
         SUM(DEBRIS_CLEAN_AREA) AS DEBRIS_CLEAN_AREA,
         SUM(DEBRIS_CLEAN_ROOFED_AREA) AS DEBRIS_CLEAN_ROOFED_AREA,
         SUM(MANURE_AREA) AS MANURE_AREA,
         SUM(MANURE_ROOFED_AREA) AS MANURE_ROOFED_AREA,
         SUM(PTSX_AREA) AS PTSX_AREA,
         SUM(PTSX_ROOFED_AREA) AS PTSX_ROOFED_AREA,
         SUM(PREVENT_AREA) AS PREVENT_AREA,
         SUM(PREVENT_ROOFED_AREA) AS PREVENT_ROOFED_AREA,
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
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         MAX(MODIFY_TIME),
         V_CURRENTTIMESTAMP
    FROM R_PT_DT_DV_D T
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
  ;
  COMMIT;

END
@

------------------------------------------------------------
--
--
--
--P_R_PT_CALAMITY_FM_D
------------------------------------------------------------
-- DROP VIEW TSO.V_PT_CALAMITY_FM_D;
CREATE VIEW TSO.V_PT_CALAMITY_FM_D
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID AS CALAMITY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'FZ'                     AS DISASTE_TYPE, --FZ:风灾
         A.C1                     AS CALAMITY_LEVEL_EK,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N2, 0)        AS DAMAGE_LOSE_WGHT,
         COALESCE(A.N4, 0)        AS FIELD_BLOCK_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_C A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000063'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS CALAMITY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'BP'                     AS DISASTE_TYPE, --BP:冰雹
         A.C1                     AS CALAMITY_LEVEL_EK,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N2, 0)        AS DAMAGE_LOSE_WGHT,
         COALESCE(A.N4, 0)        AS FIELD_BLOCK_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_D A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000064'
     AND A.CHECK_STATE = '1'
 UNION ALL 
  SELECT A.DATA_STORE_BASE_TBL_ID AS CALAMITY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'GH'                     AS DISASTE_TYPE, --GH:干旱
         A.C1                     AS CALAMITY_LEVEL_EK,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N2, 0)        AS DAMAGE_LOSE_WGHT,
         COALESCE(A.N4, 0)        AS FIELD_BLOCK_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_E A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000065'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS CALAMITY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'HZ'                     AS DISASTE_TYPE, --HZ:洪灾
         A.C1                     AS CALAMITY_LEVEL_EK,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N2, 0)        AS DAMAGE_LOSE_WGHT,
         COALESCE(A.N4, 0)        AS FIELD_BLOCK_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_H A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000068'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS CALAMITY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'OTHER'                  AS DISASTE_TYPE, --OTHER:其它灾害
         A.C1                     AS CALAMITY_LEVEL_EK,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N2, 0)        AS DAMAGE_LOSE_WGHT,
         COALESCE(A.N4, 0)        AS FIELD_BLOCK_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_G A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000067'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS CALAMITY_FM_D_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         A.FEEDBACK_DATE          AS BUSINESS_DATE,
         'BCH'                    AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         ''                       AS DISASTE_TYPE,
         A.C1                     AS CALAMITY_LEVEL_EK,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N2, 0)        AS DAMAGE_LOSE_WGHT,
         COALESCE(A.N4, 0)        AS FIELD_BLOCK_AREA,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_F A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000066'
     AND A.CHECK_STATE = '1'
;


  DROP NICKNAME DCCELL.V_PT_CALAMITY_FM_D ;
CREATE NICKNAME DCCELL.V_PT_CALAMITY_FM_D      FOR TSOSERVER.TSO.V_PT_CALAMITY_FM_D;

DROP PROCEDURE DCCELL.P_R_PT_CALAMITY_FM_D;
CREATE PROCEDURE DCCELL.P_R_PT_CALAMITY_FM_D
--PT_7灾害信息_加工存储过程，包括组织和行政表
-----------------------------------------------------
--LINGM 
-----------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME                   VARCHAR(1000) DEFAULT 'P_R_PT_CALAMITY_FM_D';
  DECLARE V_STEP                        VARCHAR(500);
  DECLARE V_PT_YEAR                     INTEGER DEFAULT 2016;    --业务年度
  DECLARE V_BILL_NO_FZ                  VARCHAR(64) DEFAULT 'TJ00000000000063'; --风灾单据编号
  DECLARE V_BILL_NO_BP                  VARCHAR(64) DEFAULT 'TJ00000000000064'; --冰雹单据编号
  DECLARE V_BILL_NO_GH                  VARCHAR(64) DEFAULT 'TJ00000000000065'; --干旱单据编号
  DECLARE V_BILL_NO_BCH                 VARCHAR(64) DEFAULT 'TJ00000000000066'; --病虫害单据编号
  DECLARE V_BILL_NO_OTHER               VARCHAR(64) DEFAULT 'TJ00000000000067'; --其它灾害单据编号
  DECLARE V_BILL_NO_HZ                  VARCHAR(64) DEFAULT 'TJ00000000000068'; --洪涝单据编号
  DECLARE V_BILL_NO_SD                  VARCHAR(64) DEFAULT '0'; --霜冻单据编号
  

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

  SET V_STEP = '1.R_PT_CALAMITY_FM_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_CALAMITY_FM_D 
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '2.R_PT_CALAMITY_FM_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_CALAMITY_FM_D
  (
      CALAMITY_FM_D_ID,
      FIELD_BLOCK_ID,
      FIELD_BLOCK_CD,
      FIELD_BLOCK_NAME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      CALAMITY_TYPE,
      DISASTE_TYPE,
      CALAMITY_LEVEL_EK,
      CALAMITY_AREA,
      DAMAGE_LOSE_WGHT,
      FIELD_BLOCK_AREA,
      FARMER_ID,
      FARMER_CD,
      FARMER_NAME,
      ORG_CD,
      AREA_CD,
      TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT CALAMITY_FM_D_ID,
         FIELD_BLOCK_ID,
         FIELD_BLOCK_CD,
         FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         CALAMITY_TYPE,
         DISASTE_TYPE,
         CALAMITY_LEVEL_EK,
         CALAMITY_AREA,
         DAMAGE_LOSE_WGHT,
         FIELD_BLOCK_AREA,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         V_CURRENTTIMESTAMP
    FROM V_PT_CALAMITY_FM_D
   WHERE DATA_STATE = '1'
     AND BUSINESS_YEAR >= V_PT_YEAR
  ;

  UPDATE R_PT_CALAMITY_FM_D A
     SET (
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
  ;
  COMMIT;

  SET V_STEP = '3.R_PT_CALAMITY_FM_D-U';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  UPDATE R_PT_CALAMITY_FM_D A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_PT_CALAMITY_FM_D A
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
  MERGE INTO R_PT_CALAMITY_FM_D A
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

  SET V_STEP = '3.R_PT_CALAMITY_DV_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_CALAMITY_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;
  
  SET V_STEP = '4.R_PT_CALAMITY_DV_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_CALAMITY_DV_D
  (
      CALAMITY_DV_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      CALAMITY_TYPE,
      DISASTE_TYPE,
      DISEASE_TYPE,
      CALAMITY_LEVEL_EK,
      CALAMITY_AREA,
      DAMAGE_LOSE_WGHT,
      CALAMITY_FRM_QTY,
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
  SELECT HEX(GENERATE_UNIQUE())    AS CALAMITY_DV_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         CALAMITY_TYPE,
         DISASTE_TYPE,
         DISEASE_TYPE,
         CALAMITY_LEVEL_EK,
         SUM(CALAMITY_AREA),
         SUM(DAMAGE_LOSE_WGHT),
         COUNT(DISTINCT FARMER_ID) AS CALAMITY_FRM_QTY,
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
         '0'                     AS SEND_STATE,
         '1'                     AS DATA_STATE,
         MAX(MODIFY_TIME)        AS MODIFY_TIME,
         V_CURRENTTIMESTAMP      AS LAST_TIME
    FROM R_PT_CALAMITY_FM_D T
    WHERE T.BUSINESS_YEAR >= V_PT_YEAR
    GROUP BY
          T.CALAMITY_TYPE,
          T.DISASTE_TYPE,
          T.DISEASE_TYPE,
          T.CALAMITY_LEVEL_EK,
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
  ;
  COMMIT;

  SET V_STEP = '5.R_PT_CALAMITY_CB_D-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_CALAMITY_CB_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '6.R_PT_CALAMITY_CB_D-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_CALAMITY_CB_D
  (
      CALAMITY_CB_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      CALAMITY_TYPE,
      DISASTE_TYPE,
      DISEASE_TYPE,
      CALAMITY_LEVEL_EK,
      CALAMITY_AREA,
      DAMAGE_LOSE_WGHT,
      CALAMITY_FRM_QTY,
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
  SELECT HEX(GENERATE_UNIQUE()) AS CALAMITY_CB_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         CALAMITY_TYPE,
         DISASTE_TYPE,
         DISEASE_TYPE,
         CALAMITY_LEVEL_EK,
         SUM(CALAMITY_AREA),
         SUM(DAMAGE_LOSE_WGHT),
         SUM(CALAMITY_FRM_QTY)  AS CALAMITY_FRM_QTY,
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
         '0'                   AS SEND_STATE,
         '1'                   AS DATA_STATE,
         MAX(MODIFY_TIME)      AS MODIFY_TIME,
         V_CURRENTTIMESTAMP   AS LAST_TIME
    FROM R_PT_CALAMITY_DV_D T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.CALAMITY_TYPE,
         T.DISASTE_TYPE,
         T.DISEASE_TYPE,
         T.CALAMITY_LEVEL_EK,
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
  ;
  COMMIT;

END
@
------------------------------------------------------------
--
--
--
--P_R_PT_INDEMNIFY_FM_Y
------------------------------------------------------------
-- DROP VIEW TSO.V_PT_INDEMNIFY_FM_Y;
CREATE VIEW TSO.V_PT_INDEMNIFY_FM_Y
 AS 
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'FZ'                     AS DISASTE_TYPE, --FZ:风灾
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_C A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                            AND B.BIZ_YEAR = A.PT_YEAR
                                            AND B.DATA_STATE = '1'
   WHERE A.BILL_NO = 'TJ00000000000063'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'BP'                     AS DISASTE_TYPE, --BP:冰雹
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_D A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                            AND B.BIZ_YEAR = A.PT_YEAR
                                            AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000064'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'GH'                     AS DISASTE_TYPE, --GH:干旱
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_E A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000065'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'HZ'                     AS DISASTE_TYPE, --HZ:洪灾
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_H A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000068'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'ZH'                     AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         'OTHER'                  AS DISASTE_TYPE, --OTHER:其它灾害
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_G A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000067'
     AND A.CHECK_STATE = '1'
 UNION ALL
  SELECT A.DATA_STORE_BASE_TBL_ID AS INDEMNIFY_FM_Y_ID,
         A.CLT_OBJ_ID             AS FIELD_BLOCK_ID,
         A.CLT_OBJ_CD             AS FIELD_BLOCK_CD,
         A.CLT_OBJ_NAME           AS FIELD_BLOCK_NAME,
         A.PT_YEAR                AS BUSINESS_YEAR,
         'BCH'                    AS CALAMITY_TYPE,  --灾害：ZH，病虫害：BCH
         ''                       AS DISASTE_TYPE,
         COALESCE(A.N1, 0)        AS CALAMITY_AREA,
         COALESCE(A.N3, 0)        AS LOSE_MONEY,
         A.RELA_OBJECT_ID         AS FARMER_ID,
         A.RELA_OBJECT_CD         AS FARMER_CD,
         A.RELA_OBJECT_NAME       AS FARMER_NAME,
         B.STATION_UNIQUE_CD      AS ORG_CD,
         B.DIVISION_UNIQUE_CD     AS AREA_CD,
         A.FEEDBACK_PSN_ID        AS TECHNICIAN_ID,
         '0'                      AS SEND_STATE,
         A.DATA_STATE             AS DATA_STATE,
         A.MODIFY_TIME            AS MODIFY_TIME
    FROM TSO.PT_DC_STAT_DATA_F A
         LEFT JOIN TSO.CM_PM_FRM_FUND B ON B.FRM_FUND_UNIQUE_ID = A.RELA_OBJECT_ID
                                       AND B.BIZ_YEAR = A.PT_YEAR
                                       AND B.DATA_STATE = '1'
   WHERE A.BILL_NO      = 'TJ00000000000066'
     AND A.CHECK_STATE = '1'
;


  DROP NICKNAME DCCELL.V_PT_INDEMNIFY_FM_Y ;
CREATE NICKNAME DCCELL.V_PT_INDEMNIFY_FM_Y     FOR TSOSERVER.TSO.V_PT_INDEMNIFY_FM_Y;

DROP PROCEDURE DCCELL.P_R_PT_INDEMNIFY_FM_Y;
CREATE PROCEDURE DCCELL.P_R_PT_INDEMNIFY_FM_Y
--PT_7.3定损理赔情况表(按烟农、年度)_加工存储过程，包括组织和行政表，以增量方式进行
-----------------------------------------------------
--LINGM 
-----------------------------------------------------
BEGIN
  DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_INDEMNIFY_FM_Y';
  DECLARE V_STEP                    VARCHAR(500);
  DECLARE V_PT_YEAR                 INTEGER DEFAULT 2016;    --业务年度
  DECLARE V_BILL_NO_FZ              VARCHAR(64) DEFAULT 'TJ00000000000063'; --风灾单据编号
  DECLARE V_BILL_NO_BP              VARCHAR(64) DEFAULT 'TJ00000000000064'; --冰雹单据编号
  DECLARE V_BILL_NO_GH              VARCHAR(64) DEFAULT 'TJ00000000000065'; --干旱单据编号
  DECLARE V_BILL_NO_BCH             VARCHAR(64) DEFAULT 'TJ00000000000066'; --病虫害单据编号
  DECLARE V_BILL_NO_OTHER           VARCHAR(64) DEFAULT 'TJ00000000000067'; --其它灾害单据编号
  DECLARE V_BILL_NO_HZ              VARCHAR(64) DEFAULT 'TJ00000000000068'; --洪涝单据编号
  DECLARE V_BILL_NO_SD              VARCHAR(64) DEFAULT '0'; --霜冻单据编号
  
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

  SET V_STEP = '1、R_PT_INDEMNIFY_FM_Y-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_INDEMNIFY_FM_Y T
   WHERE BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '已从业务表中删除的数据，需要从加工表中同步删除';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_INDEMNIFY_FM_Y
  (
    INDEMNIFY_FM_Y_ID,
    FIELD_BLOCK_ID,
    FIELD_BLOCK_CD,
    FIELD_BLOCK_NAME,
    BUSINESS_YEAR,
    CALAMITY_TYPE,
    DISASTE_TYPE,
    CALAMITY_AREA,
    LOSE_MONEY,
    FARMER_ID,
    FARMER_CD,
    FARMER_NAME,
    ORG_CD,
    AREA_CD,
    TECHNICIAN_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
  )
  SELECT INDEMNIFY_FM_Y_ID,
         FIELD_BLOCK_ID,
         FIELD_BLOCK_CD,
         FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         CALAMITY_TYPE,
         DISASTE_TYPE,
         CALAMITY_AREA,
         LOSE_MONEY,
         FARMER_ID,
         FARMER_CD,
         FARMER_NAME,
         ORG_CD,
         AREA_CD,
         TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         CURRENT TIMESTAMP AS LAST_TIME
    FROM V_PT_INDEMNIFY_FM_Y
   WHERE DATA_STATE = '1'
     AND BUSINESS_YEAR >= V_PT_YEAR
  ;

  UPDATE R_PT_INDEMNIFY_FM_Y A
     SET (
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
  ;
  COMMIT;

  SET V_STEP = '3.R_PT_INDEMNIFY_FM_Y-U';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  UPDATE R_PT_INDEMNIFY_FM_Y A
     SET TECHNICIAN_NAME  = (SELECT TECHNICIAN_NAME FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
   WHERE EXISTS
         (SELECT 1 FROM R_TECHNICIAN B WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
     AND A.BUSINESS_YEAR >= V_PT_YEAR
  ;
  COMMIT;

  call P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,'ORG',TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  MERGE INTO R_PT_INDEMNIFY_FM_Y A
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
  MERGE INTO R_PT_INDEMNIFY_FM_Y A
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

  SET V_STEP = '11、R_PT_INDEMNIFY_DV_Y-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_INDEMNIFY_DV_Y T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;
  

  SET V_STEP = '12、R_PT_INDEMNIFY_DV_Y-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_INDEMNIFY_DV_Y
  (
    INDEMNIFY_DV_Y_ID,
    BUSINESS_YEAR,
    CALAMITY_TYPE,
    DISASTE_TYPE,
    DISEASE_TYPE,
    CALAMITY_AREA,
    LOSE_MONEY,
    CALAMITY_FRM_QTY,
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
  SELECT Hex(generate_unique()) AS INDEMNIFY_DV_Y_ID,
         BUSINESS_YEAR,
         CALAMITY_TYPE,
         DISASTE_TYPE,
         DISEASE_TYPE,
         SUM(CALAMITY_AREA),
         SUM(LOSE_MONEY),
         COUNT(DISTINCT FARMER_ID) AS CALAMITY_FRM_QTY,
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
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         MAX(MODIFY_TIME) AS MODIFY_TIME,
         V_CURRENTTIMESTAMP AS LAST_TIME
    FROM R_PT_INDEMNIFY_FM_Y T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.BUSINESS_YEAR,
         T.CALAMITY_TYPE,
         T.DISASTE_TYPE,
         T.DISEASE_TYPE,
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
  ;

  SET V_STEP = '13、R_PT_INDEMNIFY_CB_Y-D';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  DELETE FROM R_PT_INDEMNIFY_CB_Y T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
  ;

  SET V_STEP = '14、R_PT_INDEMNIFY_CB_Y-I';
  CALL P_DEBUG_LOG(V_LOG_GROUP,V_PROC_NAME,V_PROC_NAME,V_STEP,TO_CHAR(CURRENT TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')||V_LOG);
  INSERT INTO R_PT_INDEMNIFY_CB_Y
  (
      INDEMNIFY_CB_Y_ID,
      BUSINESS_YEAR,
      CALAMITY_TYPE,
      DISASTE_TYPE,
      DISEASE_TYPE,
      CALAMITY_AREA,
      LOSE_MONEY,
      CALAMITY_FRM_QTY,
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
  SELECT HEX(GENERATE_UNIQUE()) AS INDEMNIFY_CB_Y_ID,
         BUSINESS_YEAR,
         CALAMITY_TYPE,
         DISASTE_TYPE,
         DISEASE_TYPE,
         SUM(CALAMITY_AREA),
         SUM(LOSE_MONEY),
         SUM(CALAMITY_FRM_QTY)  AS CALAMITY_FRM_QTY,
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
         '0'                   AS SEND_STATE,
         '1'                   AS DATA_STATE,
         MAX(MODIFY_TIME)      AS MODIFY_TIME,
         V_CURRENTTIMESTAMP   AS LAST_TIME
    FROM R_PT_INDEMNIFY_DV_Y T
   WHERE T.BUSINESS_YEAR >= V_PT_YEAR
   GROUP BY
         T.BUSINESS_YEAR,
         T.CALAMITY_TYPE,
         T.DISASTE_TYPE,
         T.DISEASE_TYPE,
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
  ;
  COMMIT;

END
@


------------------------------------------------------------
--
--
--黔西南生产数据加工存储过程（取莱易接口数据）
--P_R_PT_SC_QXN
------------------------------------------------------------

CREATE PROCEDURE DCCELL.P_R_PT_SC_QXN
BEGIN
  DECLARE V_PT_YEAR INTEGER DEFAULT 2018;

  SELECT BUSI_YEAR INTO V_PT_YEAR
    FROM DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
  ;

  --翻耕
  DELETE FROM R_PT_PLOUGH_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND PLOUGH_CB_D_ID LIKE 'FG%'
  ;

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
  SELECT T.ID AS PLOUGH_CB_D_ID,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1 AS PLOUGH_AREA,
         T.N2 AS PROPESS_AREA,
         T.ORG_CD,
         T.ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'FG'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;


  DELETE FROM R_PT_PLOUGH_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND PLOUGH_DV_D_ID LIKE 'FG%'
  ;

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
    SSTC_NAME
  )
  SELECT HEX(GENERATE_UNIQUE())  AS PLOUGH_DV_D_ID,
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
    FROM R_PT_PLOUGH_CB_D T
   WHERE T.BUSINESS_YEAR = V_PT_YEAR
     AND T.CITC = '5223'
  ;

  DELETE FROM R_PT_PLOUGH_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND PLOUGH_FM_D_ID LIKE 'FG%'
  ;

  INSERT INTO R_PT_PLOUGH_FM_D
  (
    PLOUGH_FM_D_ID,
    --FIELD_BLOCK_ID,
    --FIELD_BLOCK_CD,
    --FIELD_BLOCK_NAME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PROPESS_AREA,
    PLOUGH_AREA,
    --FARMER_ID,
    --FARMER_CD,
    --FARMER_NAME,
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
    --TECHNICIAN_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME
  )
  SELECT HEX(GENERATE_UNIQUE())  AS PLOUGH_FM_D_ID,
         --FIELD_BLOCK_ID,
         --FIELD_BLOCK_CD,
         --FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         PROPESS_AREA,
         PLOUGH_AREA,
         --FARMER_ID,
         --FARMER_CD,
         --FARMER_NAME,
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
         --AREA_CD,
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
         --TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         LAST_TIME
    FROM R_PT_PLOUGH_CB_D 
   WHERE BUSINESS_YEAR    = V_PT_YEAR
     AND CITC = '5223'
  ;

  --起垄
  DELETE FROM R_PT_PREPAR_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND PREPAR_CB_D_ID LIKE 'QL%'
  ;
  INSERT INTO R_PT_PREPAR_CB_D(
    PREPAR_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PREPAR_AREA,
    PROPESS_AREA,
    PREPAR_TYPE,
    PREPAR_QTY,
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
  SELECT ID AS PREPAR_CB_D_ID,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1 AS PREPAR_AREA,
         T.N2 AS PROPESS_AREA,
         T.C1 AS PREPAR_TYPE,
         T.N3 AS PREPAR_QTY,
         T.ORG_CD,
         T.ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'QL'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_PREPAR_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND PREPAR_DV_D_ID LIKE 'QL%'
  ;

  INSERT INTO R_PT_PREPAR_DV_D
  (
    PREPAR_DV_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    PREPAR_AREA,
    PROPESS_AREA,
    PREPAR_TYPE,
    PREPAR_QTY,
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
  SELECT HEX(GENERATE_UNIQUE()) AS PREPAR_DV_D_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         PREPAR_AREA,
         PROPESS_AREA,
         PREPAR_TYPE,
         PREPAR_QTY,
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
    FROM R_PT_PREPAR_CB_D T
   WHERE T.BUSINESS_YEAR = V_PT_YEAR
     AND T.CITC = '5223'
  ;

  DELETE FROM R_PT_PREPAR_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND PREPAR_FM_D_ID LIKE 'QL%'
  ;

  INSERT INTO R_PT_PREPAR_FM_D
  (
      PREPAR_FM_D_ID,
      --FIELD_BLOCK_ID,
      --FIELD_BLOCK_CD,
      --FIELD_BLOCK_NAME,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      PROPESS_AREA,
      PREPAR_AREA,
      PREPAR_TYPE,
      PREPAR_QTY,
      --FARMER_ID,
      --FARMER_CD,
      --FARMER_NAME,
      ORG_CD,
      --AREA_CD,
      --TECHNICIAN_ID,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME
  )
  SELECT Hex(generate_unique())  AS PREPAR_FM_D_ID,
         --FIELD_BLOCK_ID,
         --FIELD_BLOCK_CD,
         --FIELD_BLOCK_NAME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         PROPESS_AREA,
         PREPAR_AREA,
         PREPAR_TYPE,
         PREPAR_QTY,
         --FARMER_ID,
         --FARMER_CD,
         --FARMER_NAME,
         ORG_CD,
         --AREA_CD,
         --TECHNICIAN_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         LAST_TIME
    FROM R_PT_PREPAR_CB_D 
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  --覆膜
  DELETE FROM R_PT_VELUM_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND VELUM_CB_D_ID LIKE 'FM%'
  ;
  INSERT INTO R_PT_VELUM_CB_D
  (
    VELUM_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    VELUM_AREA,
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
  SELECT T.ID            AS VELUM_CB_D_ID,
         '0'             AS SEND_STATE,
         '1'             AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR       AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1            AS VELUM_AREA,
         T.N2            AS PROPESS_AREA,
         T.ORG_CD,
         T.ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'FM'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_VELUM_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND VELUM_DV_D_ID LIKE 'FM%'
  ;

  INSERT INTO R_PT_VELUM_DV_D
  (
    VELUM_DV_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    VELUM_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS VELUM_DV_D_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         VELUM_AREA,
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
    FROM R_PT_VELUM_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  DELETE FROM R_PT_VELUM_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND VELUM_FM_D_ID LIKE 'FM%'
  ;

  INSERT INTO R_PT_VELUM_FM_D
  (
    VELUM_FM_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    VELUM_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS VELUM_FM_D_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         VELUM_AREA,
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
    FROM R_PT_VELUM_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  --育苗与育苗棚数量
  DELETE FROM R_PT_ARCH_QTY
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND PT_ARCH_QTY_ID LIKE 'QTY%'
  ;
  INSERT INTO R_PT_ARCH_QTY
  (
    PT_ARCH_QTY_ID,
    GROW_POINT_QTY,
    BIG_CANOPY_QTY,
    B_BIG_CANOPY_QTY,
    M_BIG_CANOPY_QTY,
    S_BIG_CANOPY_QTY,
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
    BUSINESS_YEAR
  )
  SELECT T.ID             AS PT_ARCH_QTY_ID,
         T.N1             AS GROW_POINT_QTY,
         T.N2             AS BIG_CANOPY_QTY,
         T.N3             AS B_BIG_CANOPY_QTY,
         T.N4             AS M_BIG_CANOPY_QTY,
         T.N5             AS S_BIG_CANOPY_QTY,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         T.PT_YEAR        AS BUSINESS_YEAR
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'QTY'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  --育苗信息
  DELETE FROM R_PT_GROW_AB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND GROW_AB_D_ID LIKE 'YM%'
  ;
  INSERT INTO R_PT_GROW_AB_D
  (
    GROW_AB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    GROW_PLATE_QTY,
    TRANSPLANT_AREA,
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
  SELECT T.ID              AS GROW_AB_D_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.C1              AS LEAF_VARIETY_CD,
         T.C2              AS LEAF_VARIETY_NAME,
         T.N1              AS GROW_PLATE_QTY,
         T.N2              AS TRANSPLANT_AREA,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'YM'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;


  --苗期管理
  DELETE FROM R_PT_MQGL_NOW_AB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND MQGL_NOW_AB_D_ID LIKE 'MQ%'
  ;
  INSERT INTO R_PT_MQGL_NOW_AB_D
  (
    MQGL_NOW_AB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    EMERGE_AREA,
    S_CROSS_AREA,
    B_CROSS_AREA,
    ONE_CLIP_AREA,
    SEED_AREA,
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
  SELECT T.ID               AS GROW_AB_D_ID,
         T.PT_YEAR          AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.C1               AS LEAF_VARIETY_CD,
         T.C2               AS LEAF_VARIETY_NAME,
         T.N1               AS EMERGE_AREA,
         T.N2               AS S_CROSS_AREA,
         T.N3               AS S_CROSS_AREA,
         T.N4               AS B_CROSS_AREA,
         T.N5               AS ONE_CLIP_AREA,
         T.ORG_CD           AS ORG_CD,
         T.ORG_NAME         AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'                AS SEND_STATE,
         '1'                AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'MQ'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_FOR_SEED_FM_Y
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND FOR_SEED_FM_Y_ID LIKE 'GM%'
  ;
  INSERT INTO R_PT_FOR_SEED_FM_Y
  (
    FOR_SEED_FM_Y_ID,
    BUSINESS_YEAR,
    FOR_SEED_PLATE_QTY,
    FOR_SEED_QTY,
    TRANSPLANT_AREA,
    --DESTORY_QTY,
    --DESTORY_AREA,
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
  SELECT T.ID               AS FOR_SEED_FM_Y_ID,
         T.PT_YEAR          AS BUSINESS_YEAR,
         --'2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1               AS FOR_SEED_PLATE_QTY,
         T.N2               AS FOR_SEED_QTY,
         T.N3               AS TRANSPLANT_AREA,
         --T.N4               AS DESTORY_QTY,
         --T.N5               AS DESTORY_AREA,
         T.ORG_CD           AS ORG_CD,
         T.ORG_NAME         AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'                AS SEND_STATE,
         '1'                AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'GM'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;


  --供苗管理
  DELETE FROM R_PT_FOR_SEED_AB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND FOR_SEED_AB_D_ID LIKE 'GM%'
  ;
  INSERT INTO R_PT_FOR_SEED_AB_D
  (
    FOR_SEED_AB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    FOR_SEED_PLATE_QTY,
    FOR_SEED_QTY,
    TRANSPLANT_AREA,
    DESTORY_QTY,
    DESTORY_AREA,
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
  SELECT T.ID               AS GROW_AB_D_ID,
         T.PT_YEAR          AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1               AS FOR_SEED_PLATE_QTY,
         T.N2               AS FOR_SEED_QTY,
         T.N3               AS TRANSPLANT_AREA,
         T.N4               AS DESTORY_QTY,
         T.N5               AS DESTORY_AREA,
         T.ORG_CD           AS ORG_CD,
         T.ORG_NAME         AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'                AS SEND_STATE,
         '1'                AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'GM'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;


  --移栽
  DELETE FROM R_PT_TRANSPLANT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND TRANSPLANT_CB_D_ID LIKE 'YZ%'
  ;
  INSERT INTO R_PT_TRANSPLANT_CB_D
  (
    TRANSPLANT_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    TRANSPLANT_QTY,
    CENSUS_QTY,
    TRANSPLANT_AREA,
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
  SELECT T.ID AS TRANSPLANT_CB_D_ID,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.C1 AS LEAF_VARIETY_CD,
         T.C2 AS LEAF_VARIETY_NAME,
         T.N1 AS TRANSPLANT_QTY,
         T.N2 AS CENSUS_QTY,
         T.N3 AS TRANSPLANT_AREA,
         T.N4 AS PROPESS_AREA,
         T.ORG_CD AS ORG_CD,
         T.ORG_NAME AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'YZ'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_TRANSPLANT_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND TRANSPLANT_DV_D_ID LIKE 'YZ%'
  ;
  INSERT INTO R_PT_TRANSPLANT_DV_D
  (
    TRANSPLANT_DV_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    TRANSPLANT_QTY,
    CENSUS_QTY,
    TRANSPLANT_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS TRANSPLANT_DV_D_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         LEAF_VARIETY_CD,
         LEAF_VARIETY_NAME,
         TRANSPLANT_QTY,
         CENSUS_QTY,
         TRANSPLANT_AREA,
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
    FROM R_PT_TRANSPLANT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  DELETE FROM R_PT_TRANSPLANT_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND TRANSPLANT_FM_D_ID LIKE 'YZ%'
  ;
  INSERT INTO R_PT_TRANSPLANT_FM_D
  (
    TRANSPLANT_FM_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    TRANSPLANT_QTY,
    CENSUS_QTY,
    TRANSPLANT_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS TRANSPLANT_FM_D_ID,
         SEND_STATE,
         DATA_STATE,
         MODIFY_TIME,
         LAST_TIME,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         LEAF_VARIETY_CD,
         LEAF_VARIETY_NAME,
         TRANSPLANT_QTY,
         CENSUS_QTY,
         TRANSPLANT_AREA,
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
    FROM R_PT_TRANSPLANT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  --地膜回收
  DELETE FROM R_PT_FILM_RECY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND FILM_RECY_CB_D_ID LIKE 'DM%'
  ;
  INSERT INTO R_PT_FILM_RECY_CB_D
  (
    FILM_RECY_CB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    COVER_AREA,
    RECY_ARA,
    PROPESS_AREA,
    SUBSIDE_MONEY,
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
  SELECT T.ID              AS FILM_RECY_CB_D_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1              AS COVER_AREA,
         T.N2              AS RECY_ARA,
         T.N3              AS PROPESS_AREA,
         T.N4              AS SUBSIDE_MONEY,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'DM'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_FILM_RECY_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND FILM_RECY_DV_D_ID LIKE 'DM%'
  ;
  INSERT INTO R_PT_FILM_RECY_DV_D
  (
    FILM_RECY_DV_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    COVER_AREA,
    RECY_ARA,
    PROPESS_AREA,
    SUBSIDE_MONEY,
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
  SELECT HEX(GENERATE_UNIQUE())  AS FILM_RECY_DV_D_ID,
         BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         COVER_AREA,
         RECY_ARA,
         PROPESS_AREA,
         SUBSIDE_MONEY,
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
    FROM R_PT_FILM_RECY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  DELETE FROM R_PT_FILM_RECY_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND FILM_RECY_FM_D_ID LIKE 'DM%'
  ;
  INSERT INTO R_PT_FILM_RECY_FM_D
  (
    FILM_RECY_FM_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    COVER_AREA,
    RECY_ARA,
    PROPESS_AREA,
    SUBSIDE_MONEY,
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
  SELECT HEX(GENERATE_UNIQUE())  AS FILM_RECY_FM_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         COVER_AREA,
         RECY_ARA,
         PROPESS_AREA,
         SUBSIDE_MONEY,
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
    FROM R_PT_FILM_RECY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  --田间卫生
  DELETE FROM R_PT_DT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND DT_CB_D_ID LIKE 'TJWS%'
  ;
  INSERT INTO R_PT_DT_CB_D
  (
    DT_CB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    UNCOVER_AREA,
    MANURE_AREA,
    PTSX_AREA,
    PREVENT_AREA,
    BUTTON_POLE_AREA,
    DEBRIS_CLEAN_AREA,
    UNCOVER_ROOFED_AREA,
    MANURE_ROOFED_AREA,
    PTSX_ROOFED_AREA,
    PREVENT_ROOFED_AREA,
    BUTTON_POLE_ROOFED_AREA,
    DEBRIS_CLEAN_ROOFED_AREA,
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
  SELECT T.ID AS DT_CB_D_ID,
         T.PT_YEAR AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1 AS UNCOVER_AREA,
         T.N2 AS MANURE_AREA,
         T.N3 AS PTSX_AREA,
         T.N4 AS PREVENT_AREA,
         T.N5 AS BUTTON_POLE_AREA,
         T.N6 AS DEBRIS_CLEAN_AREA,
         T.N7 AS UNCOVER_ROOFED_AREA,
         T.N8 AS MANURE_ROOFED_AREA,
         T.N9 AS PTSX_ROOFED_AREA,
         T.N10 AS PREVENT_ROOFED_AREA,
         T.N11 AS BUTTON_POLE_ROOFED_AREA,
         T.N12 AS DEBRIS_CLEAN_ROOFED_AREA,
         T.ORG_CD AS ORG_CD,
         T.ORG_NAME AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'TJWS'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_DT_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND DT_DV_D_ID LIKE 'TJWS%'
  ;
  INSERT INTO R_PT_DT_DV_D
  (
    DT_DV_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    UNCOVER_AREA,
    MANURE_AREA,
    PTSX_AREA,
    PREVENT_AREA,
    BUTTON_POLE_AREA,
    DEBRIS_CLEAN_AREA,
    UNCOVER_ROOFED_AREA,
    MANURE_ROOFED_AREA,
    PTSX_ROOFED_AREA,
    PREVENT_ROOFED_AREA,
    BUTTON_POLE_ROOFED_AREA,
    DEBRIS_CLEAN_ROOFED_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS DT_DV_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         UNCOVER_AREA,
         MANURE_AREA,
         PTSX_AREA,
         PREVENT_AREA,
         BUTTON_POLE_AREA,
         DEBRIS_CLEAN_AREA,
         UNCOVER_ROOFED_AREA,
         MANURE_ROOFED_AREA,
         PTSX_ROOFED_AREA,
         PREVENT_ROOFED_AREA,
         BUTTON_POLE_ROOFED_AREA,
         DEBRIS_CLEAN_ROOFED_AREA,
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
    FROM R_PT_DT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  DELETE FROM R_PT_DT_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND DT_FM_D_ID LIKE 'TJWS%'
  ;
  INSERT INTO R_PT_DT_FM_D
  (
    DT_FM_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    UNCOVER_AREA,
    MANURE_AREA,
    PTSX_AREA,
    PREVENT_AREA,
    BUTTON_POLE_AREA,
    DEBRIS_CLEAN_AREA,
    UNCOVER_ROOFED_AREA,
    MANURE_ROOFED_AREA,
    PTSX_ROOFED_AREA,
    PREVENT_ROOFED_AREA,
    BUTTON_POLE_ROOFED_AREA,
    DEBRIS_CLEAN_ROOFED_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS  DT_FM_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         UNCOVER_AREA,
         MANURE_AREA,
         PTSX_AREA,
         PREVENT_AREA,
         BUTTON_POLE_AREA,
         DEBRIS_CLEAN_AREA,
         UNCOVER_ROOFED_AREA,
         MANURE_ROOFED_AREA,
         PTSX_ROOFED_AREA,
         PREVENT_ROOFED_AREA,
         BUTTON_POLE_ROOFED_AREA,
         DEBRIS_CLEAN_ROOFED_AREA,
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
    FROM R_PT_DT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  --田间管理
  DELETE FROM R_PT_YY_GROW_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND YY_GROW_CB_D_ID LIKE 'TJGL%'
  ;
  INSERT INTO R_PT_YY_GROW_CB_D
  (
    YY_GROW_CB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    ROOFED_AREA,
    ROOFED_PROPESS_AREA,
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
  SELECT T.ID AS YY_GROW_CB_D_ID,
         T.PT_YEAR AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.N1 AS ROOFED_AREA,
         T.N2 AS ROOFED_PROPESS_AREA,
         T.ORG_CD AS ORG_CD,
         T.ORG_NAME AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'TJGL'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_YY_GROW_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND YY_GROW_DV_D_ID LIKE 'TJGL%'
  ;
  INSERT INTO R_PT_YY_GROW_DV_D
  (
    YY_GROW_DV_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    ROOFED_AREA,
    ROOFED_PROPESS_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS YY_GROW_DV_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         ROOFED_AREA,
         ROOFED_PROPESS_AREA,
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
    FROM R_PT_YY_GROW_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  DELETE FROM R_PT_YY_GROW_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND YY_GROW_FM_D_ID LIKE 'TJGL%'
  ;
  INSERT INTO R_PT_YY_GROW_FM_D
  (
    YY_GROW_FM_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    ROOFED_AREA,
    ROOFED_PROPESS_AREA,
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
  SELECT HEX(GENERATE_UNIQUE())  AS  YY_GROW_FM_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         ROOFED_AREA,
         ROOFED_PROPESS_AREA,
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
    FROM R_PT_YY_GROW_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  --灾害
  DELETE FROM R_PT_CALAMITY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND CALAMITY_CB_D_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_CALAMITY_CB_D
  (
    CALAMITY_CB_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_QTY,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    DAMAGE_LOSE_WGHT,
    CALAMITY_LEVEL_EK,
    CALAMITY_FRM_QTY,
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
  SELECT T.ID              AS CALAMITY_CB_D_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         '2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.C1              AS CALAMITY_TYPE,
         T.C2              AS DISEASE_TYPE,
         T.C3              AS DISASTE_TYPE,
         T.N1              AS CALAMITY_QTY,
         T.N2              AS CALAMITY_AREA,
         T.N3              AS ASSIGN_CALAMITY_AREA,
         T.N4              AS DAMAGE_LOSE_WGHT,
         T.C4              AS CALAMITY_LEVEL_EK,
         T.N6              AS CALAMITY_FRM_QTY,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'ZH'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_CALAMITY_DV_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND CALAMITY_DV_D_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_CALAMITY_DV_D
  (
    CALAMITY_DV_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_QTY,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    DAMAGE_LOSE_WGHT,
    CALAMITY_LEVEL_EK,
    CALAMITY_FRM_QTY,
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
  SELECT HEX(GENERATE_UNIQUE())  AS CALAMITY_DV_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         CALAMITY_TYPE,
         DISEASE_TYPE,
         DISASTE_TYPE,
         CALAMITY_QTY,
         CALAMITY_AREA,
         ASSIGN_CALAMITY_AREA,
         DAMAGE_LOSE_WGHT,
         CALAMITY_LEVEL_EK,
         CALAMITY_FRM_QTY,
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
    FROM R_PT_CALAMITY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  DELETE FROM R_PT_CALAMITY_FM_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND CALAMITY_FM_D_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_CALAMITY_FM_D
  (
    CALAMITY_FM_D_ID,
    BUSINESS_YEAR,
    BUSINESS_DATE,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_QTY,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    DAMAGE_LOSE_WGHT,
    CALAMITY_LEVEL_EK,
    --CALAMITY_FRM_QTY,
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
  SELECT HEX(GENERATE_UNIQUE())  AS CALAMITY_FM_D_ID,
         BUSINESS_YEAR,
         BUSINESS_DATE,
         CALAMITY_TYPE,
         DISEASE_TYPE,
         DISASTE_TYPE,
         CALAMITY_QTY,
         CALAMITY_AREA,
         ASSIGN_CALAMITY_AREA,
         DAMAGE_LOSE_WGHT,
         CALAMITY_LEVEL_EK,
         --CALAMITY_FRM_QTY,
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
    FROM R_PT_CALAMITY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  --定损理赔
  DELETE FROM R_PT_INDEMNIFY_CB_Y
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND INDEMNIFY_CB_Y_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_INDEMNIFY_CB_Y
  (
    INDEMNIFY_CB_Y_ID,
    BUSINESS_YEAR,
    --BUSINESS_DATE,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    CALAMITY_WGHT,
    LOSE_MONEY,
    CALAMITY_FRM_QTY,
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
  SELECT T.ID              AS INDEMNIFY_CB_Y_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         --'2018-01-21 00:00:00' AS BUSINESS_DATE,
         T.C1              AS CALAMITY_TYPE,
         T.C2              AS DISEASE_TYPE,
         T.C3              AS DISASTE_TYPE,
         T.N2              AS CALAMITY_AREA,
         T.N3              AS ASSIGN_CALAMITY_AREA,
         T.N4              AS CALAMITY_WGHT,
         T.N5              AS LOSE_MONEY,
         T.N6              AS CALAMITY_FRM_QTY,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE T.STAGE_TYPE = 'ZH'
     AND T.PT_YEAR = V_PT_YEAR
     AND ORG.CITC = '5223'
  ;

  DELETE FROM R_PT_INDEMNIFY_DV_Y
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND INDEMNIFY_DV_Y_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_INDEMNIFY_DV_Y
  (
    INDEMNIFY_DV_Y_ID,
    BUSINESS_YEAR,
    --BUSINESS_DATE,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    CALAMITY_WGHT,
    LOSE_MONEY,
    CALAMITY_FRM_QTY,
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
  SELECT HEX(GENERATE_UNIQUE())  AS INDEMNIFY_DV_Y_ID,
         BUSINESS_YEAR,
         --BUSINESS_DATE,
         CALAMITY_TYPE,
         DISEASE_TYPE,
         DISASTE_TYPE,
         CALAMITY_AREA,
         ASSIGN_CALAMITY_AREA,
         CALAMITY_WGHT,
         LOSE_MONEY,
         CALAMITY_FRM_QTY,
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
    FROM R_PT_INDEMNIFY_CB_Y
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  DELETE FROM R_PT_INDEMNIFY_FM_Y
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
     AND INDEMNIFY_FM_Y_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_INDEMNIFY_FM_Y
  (
    INDEMNIFY_FM_Y_ID,
    BUSINESS_YEAR,
    --BUSINESS_DATE,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    CALAMITY_WGHT,
    LOSE_MONEY,
    --CALAMITY_FRM_QTY,
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
  SELECT HEX(GENERATE_UNIQUE())  AS INDEMNIFY_FM_Y_ID,
         BUSINESS_YEAR,
        -- BUSINESS_DATE,
         CALAMITY_TYPE,
         DISEASE_TYPE,
         DISASTE_TYPE,
         CALAMITY_AREA,
         ASSIGN_CALAMITY_AREA,
         CALAMITY_WGHT,
         LOSE_MONEY,
         --CALAMITY_FRM_QTY,
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
    FROM R_PT_INDEMNIFY_CB_Y
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5223'
  ;

  COMMIT;

END
@


------------------------------------------------------------
--
--
--
--
------------------------------------------------------------
--PT_3.3.铜仁供苗阶段情况表（按烟农、年度）加工过程，以增量方式进行
-- CREATE PROCEDURE DCCELL.P_R_PT_TR_FOR_SEED_FM_Y
-- -----------------------------------------------------
-- --LINGM  合并至供苗阶段加工过程中。
-- -----------------------------------------------------
-- BEGIN
--   DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_TR_FOR_SEED_FM_Y';
--   DECLARE V_STEP                    VARCHAR(500);
--   DECLARE V_PT_YEAR                 INTEGER DEFAULT 2016;
--   DECLARE V_BILL_NO                 VARCHAR(64) DEFAULT 'TJ00000000000072'; --单据编号
--   DECLARE V_TIME_LAST               TIMESTAMP;
--   DECLARE V_TIME_CURRENT            TIMESTAMP;
--   DECLARE V_PROC_NAME               VARCHAR(1000) DEFAULT 'P_R_PT_TR_FOR_SEED_FM_Y';
--   DECLARE V_TIME_BEGIN              TIMESTAMP; --语句块开始执行时间
--   DECLARE V_TIME_END                TIMESTAMP;   --语句块结束执行时间

--   SET V_STEP = '1、取系统当前时间，和存储过程上次加工时间';
--   SET V_TIME_CURRENT = CURRENT TIMESTAMP;

--   SELECT TIME_STOP INTO V_TIME_LAST
--     FROM DCCELL.DC_PROC_TIME_STOP
--    WHERE PROC_NAME=V_PROC_NAME
--   ;
--   SELECT BUSI_YEAR INTO V_PT_YEAR 
--     FROM DC_PROC_BUSI_YEAR A 
--    WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
--   ;


--   SET V_STEP = '2、创建临时表，将MODIFY_TIME大于上次加工时间的数据，所涉及的组织和行政查询出来';

--   SET V_STEP = '3、将有修改过的数据涉及到的组织和行政，记录到临时表当中';


--   SET V_STEP = '4、本次需要加工的数据如果已存在，则删除';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   DELETE FROM R_PT_FOR_SEED_FM_Y T
--    WHERE EXISTS (
--              SELECT 1 
--                FROM PT_DC_STAT_DATA_A DATA_TAB
--              WHERE DATA_TAB.BILL_NO      = V_BILL_NO
--                AND DATA_TAB.PT_YEAR    >= V_PT_YEAR
--                AND DATA_TAB.CHECK_STATE = '1'
--                AND DATA_TAB.MODIFY_TIME  > V_TIME_LAST
--                AND DATA_TAB.DATA_STORE_BASE_TBL_ID = T.FOR_SEED_FM_Y_ID
--          )
--      AND CITC <> '5227'
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '已从业务表中删除的数据，需要从加工表中同步删除';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   DELETE FROM R_PT_FOR_SEED_FM_Y T
--    WHERE NOT EXISTS (
--                SELECT 1 
--                  FROM PT_DC_STAT_DATA_A DATA_TAB
--                 WHERE DATA_TAB.DATA_STORE_BASE_TBL_ID = T.FOR_SEED_FM_Y_ID
--          )
--      AND NOT EXISTS (
--                SELECT 1 
--                  FROM PT_DC_STAT_DATA_F DATA_TAB
--                 WHERE DATA_TAB.DATA_STORE_BASE_TBL_ID = T.FOR_SEED_FM_Y_ID
--          )
--      AND CITC <> '5227'
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   SET V_STEP = '5、写入本次需要加工的数据';
--   SET V_TIME_BEGIN = CURRENT TIMESTAMP;
--   INSERT INTO R_PT_FOR_SEED_FM_Y
--   (
--       FOR_SEED_FM_Y_ID,
--       BUSINESS_YEAR,
--       FARMER_ID,
--       FARMER_CD,
--       FARMER_NAME,
--       GROW_POINT_ID,
--       GROW_POINT_CD,
--       GROW_POINT_NAME,
--       LEAF_VARIETY_CD,
--       LEAF_VARIETY_NAME,
--       FOR_SEED_PLATE_QTY,
--       FOR_SEED_DATE,
--       ORG_CD,
--       ORG_NAME,
--       PROV,
--       PROV_NAME,
--       CITC,
--       CITC_NAME,
--       COUC,
--       COUC_NAME,
--       STAC,
--       STAC_NAME,
--       SSTC,
--       SSTC_NAME,
--       AREA_CD,
--       AREA_NAME,
--       AREA_PROV,
--       AREA_PROV_NAME,
--       AREA_CITC,
--       AREA_CITC_NAME,
--       AREA_COUC,
--       AREA_COUC_NAME,
--       AREA_TOWN,
--       TOWN_NAME,
--       AREA_VAGE,
--       VAGE_NAME,
--       AREA_GRUP,
--       GRUP_NAME,
--       TECHNICIAN_ID,
--       SEND_STATE,
--       DATA_STATE,
--       MODIFY_TIME,
--       LAST_TIME
--   )
--   SELECT DATA_STORE_BASE_TBL_ID,
--          TMP1.PT_YEAR,
--          TMP1.CLT_OBJ_ID,
--          TMP1.CLT_OBJ_CD,
--          TMP1.CLT_OBJ_NAME,
--          POINT.GROW_POINT_ID,
--          POINT.GROW_POINT_CD,
--          POINT.LOGO_CODE,
--          ENUM.ENUM_CD,
--          ENUM.ENUM_NAME,
--          NVL(tmp1.n1, 0) AS FOR_SEED_PLATE_QTY,
--          TMP1.D1 AS FOR_SEED_DATE,
--          ORG.ORG_CD,
--          ORG.ORG_NAME,
--          ORG.PROV,
--          ORG.PROV_NAME,
--          ORG.CITC,
--          ORG.CITC_NAME,
--          ORG.COUC,
--          ORG.COUC_NAME,
--          ORG.STAC,
--          ORG.STAC_NAME,
--          ORG.SSTC,
--          ORG.SSTC_NAME,
--          DIVISION.ORG_CD,
--          DIVISION.ORG_NAME,
--          DIVISION.AREA_PROV,
--          DIVISION.AREA_PROV_NAME,
--          DIVISION.AREA_CITC,
--          DIVISION.AREA_CITC_NAME,
--          DIVISION.AREA_COUC,
--          DIVISION.AREA_COUC_NAME,
--          DIVISION.AREA_TOWN,
--          DIVISION.TOWN_NAME,
--          DIVISION.AREA_VAGE,
--          DIVISION.VAGE_NAME,
--          DIVISION.AREA_GRUP,
--          DIVISION.GRUP_NAME,
--          TMP1.FEEDBACK_PSN_ID,
--          '0',
--          TMP1.DATA_STATE,
--          TMP1.MODIFY_TIME,
--          V_TIME_CURRENT AS LAST_TIME
--     FROM PT_DC_STAT_DATA_A TMP1
--          --LEFT JOIN V_R_FARMER FARMER ON FARMER.FARMER_ID = TMP1.CLT_OBJ_ID AND FARMER.BUSINESS_YEAR = V_PT_YEAR
--          LEFT JOIN CM_PM_FRM_FUND FARMER ON FARMER.FRM_FUND_UNIQUE_ID = TMP1.CLT_OBJ_ID AND FARMER.BIZ_YEAR = V_PT_YEAR AND FARMER.DATA_STATE = '1'
--          LEFT JOIN B_ORG ORG ON ORG.ORG_UNIQUE_CD = FARMER.STATION_UNIQUE_CD
--          LEFT JOIN B_DIVISION DIVISION ON DIVISION.DIVISION_UNIQUE_CD = FARMER.DIVISION_UNIQUE_CD
--          LEFT JOIN TP_GROW_POINT POINT ON POINT.GROW_POINT_ID = TMP1.C1
--          LEFT JOIN PT_IX_ENUM_DATA ENUM ON ENUM.ENUM_CD = TMP1.C3 AND ENUM.IDX_ID = '8a3c34f8581f65f701582f7efc690031'
--    WHERE TMP1.BILL_NO      = V_BILL_NO
--      AND TMP1.PT_YEAR    >= V_PT_YEAR
--      AND TMP1.DATA_STATE = '1'
--      AND TMP1.CHECK_STATE = '1'
--      AND TMP1.MODIFY_TIME  > V_TIME_LAST
--   WITH UR
--   ;
--   INSERT INTO PROC_TIME_TOTAL(PROC_NAME, REMARK, BEGIN_TIME, EXEC_TIME) VALUES (V_PROC_NAME, V_STEP, V_TIME_BEGIN, V_TIME_CURRENT);


--   COMMIT;

--   SET V_STEP = '6、更新存储过程执行时间';
--   UPDATE DCCELL.DC_PROC_TIME_STOP
--      SET TIME_STOP = V_TIME_CURRENT
--    where PROC_NAME=V_PROC_NAME
--   ;

--   COMMIT;
-- END
-- @


CREATE PROCEDURE P_DC_CALL_ID_02_SC
------------------------------------------------------------
-- #  内容：调用汇总
-- #  作者：郑瑞坤
--          linds  增异常处理 
-- #  日期：2016-12-1
------------------------------------------------------------
BEGIN
  DECLARE V_JOB_CODE    VARCHAR(32);
  DECLARE V_ITEM_CODE   VARCHAR(32);
  DECLARE V_ITEM_NAME   VARCHAR(32);
  DECLARE V_RESULT_TYPE CHAR(1);
  DECLARE V_RESULT_DESC VARCHAR(1024);
  DECLARE V_TIME_BEGIN  TIMESTAMP;
  DECLARE V_TIME_END    TIMESTAMP;

  DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
  DECLARE L_SQLSTATE CHAR(5) DEFAULT '00000';
  DECLARE SQLCODE INTEGER DEFAULT 0;
  DECLARE L_SQLCODE INTEGER DEFAULT 0; 

  DECLARE ERR_1 INTEGER DEFAULT 0; 
  DECLARE ERR_2 INTEGER DEFAULT 0; 


  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
   VALUES (SQLSTATE, SQLCODE) INTO L_SQLSTATE, L_SQLCODE;
   SET V_RESULT_TYPE = '0';
   SET V_RESULT_DESC = '执行失败,'||'停止在过程：'||V_ITEM_CODE||',错误代码'|| L_SQLSTATE;
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   COMMIT;
   IF ERR_2 = 1 AND ERR_1 = 1 THEN
     RESIGNAL;
   ELSE 
     IF ERR_2 = 0 THEN
       SET ERR_1 = 1;
     END IF;
   END IF;
  END;

  BEGIN

   SET V_JOB_CODE    = 'P_DC_CALL_ID_02_SC';

   SET V_ITEM_CODE   = 'P_GROW_POINT';
   SET V_ITEM_NAME   = '育苗点加工过程';
   SET V_TIME_BEGIN  = current timestamp;
   call P_GROW_POINT();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_BIG_CANOPY';
   SET V_ITEM_NAME   = '育苗棚';
   SET V_TIME_BEGIN  = current timestamp;
   call P_BIG_CANOPY();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_TECHNICIAN';
   SET V_ITEM_NAME   = '烟技员加工过程';
   SET V_TIME_BEGIN  = current timestamp;
   call P_TECHNICIAN();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_R_PT_PLOUGH_FM_D';
   SET V_ITEM_NAME   = '翻耕过程';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_PLOUGH_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_PREPAR_FM_D';
   SET V_ITEM_NAME   = '起垄';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_PREPAR_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_VELUM_FM_D';
   SET V_ITEM_NAME   = '盖膜';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_VELUM_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_GROW_AB_D';
   SET V_ITEM_NAME   = '育苗';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_GROW_AB_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_FOR_SEED_FM_Y';
   SET V_ITEM_NAME   = '供苗（种植主体）';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_FOR_SEED_FM_Y();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_TRANSPLANT_FM_D';
   SET V_ITEM_NAME   = '移栽';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_TRANSPLANT_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_MQGL_NOW_AB_D';
   SET V_ITEM_NAME   = '苗期管理';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_MQGL_NOW_AB_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_FOR_SEED_AB_D';
   SET V_ITEM_NAME   = '供苗(育苗点)';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_FOR_SEED_AB_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_FILM_RECY_FM_D';
   SET V_ITEM_NAME   = '地膜回收';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_FILM_RECY_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_DT_FM_D';
   SET V_ITEM_NAME   = '田间卫生';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_DT_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_YY_GROW_FM_D';
   SET V_ITEM_NAME   = '田间长势';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_YY_GROW_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_R_PT_CALAMITY_FM_D';
   SET V_ITEM_NAME   = '灾害信息';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_CALAMITY_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_INDEMNIFY_FM_Y';
   SET V_ITEM_NAME   = '定损理赔情况信息';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_INDEMNIFY_FM_Y();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   -----------------------------------------------------
   --XUYL 加工黔西南通过莱易接口加工过来的生产数据
   -----------------------------------------------------
   
   SET V_ITEM_CODE   = 'P_R_PT_SC_QXN';
   SET V_ITEM_NAME   = '黔西南莱易数据加工';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_SC_QXN();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   -----------------------------------------------------
   --LINGM 已合并至P_R_PT_FOR_SEED_FM_Y中
   -----------------------------------------------------
   --SET V_ITEM_CODE   = 'P_R_PT_TR_FOR_SEED_FM_Y';
   --SET V_ITEM_NAME   = '铜仁地区供苗（种植主体）';
   --SET V_TIME_BEGIN  = current timestamp;
   --call P_R_PT_TR_FOR_SEED_FM_Y();
   --SET V_RESULT_TYPE = '1';
   --SET V_RESULT_DESC = '执行成功';
   --SET V_TIME_END    = current timestamp;
   --call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   --
   SET ERR_2 = 1;
   --
   IF ERR_1 = 1 THEN
      SIGNAL  SQLSTATE '22375' SET MESSAGE_TEXT = V_ITEM_NAME;
   END IF;

  END;  
END
@


--PT 重置存储过程加工时间点
  DROP PROCEDURE DCCELL.P_R_PT_RESET_PROC_TIME;
CREATE PROCEDURE DCCELL.P_R_PT_RESET_PROC_TIME
(IN P_TIME_STOP TIMESTAMP)
BEGIN
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_PLOUGH_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_PREPAR_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_GROW_AB_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_FOR_SEED_FM_Y';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_VELUM_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_TRANSPLANT_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_MQGL_NOW_AB_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_FOR_SEED_AB_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_FILM_RECY_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_DT_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_YY_GROW_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_CALAMITY_FM_D';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_INDEMNIFY_FM_Y';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_TR_FOR_SEED_FM_Y';
  UPDATE DC_PROC_TIME_STOP T SET T.TIME_STOP = P_TIME_STOP WHERE PROC_NAME = 'P_R_PT_SC_QXN';

  COMMIT;
END
@



/**
 * 黔南州存储过程加工引用的数据源表
 */
CREATE NICKNAME DCCELL.PT_EXTRA FOR TSOSERVER.TSO.PT_EXTRA;


--黔南州生产数据加工存储过程
/*
--DROP PROCEDURE DCCELL.P_R_PT_SC_QNZ;
--CREATE PROCEDURE DCCELL.P_R_PT_SC_QNZ
BEGIN
  DECLARE V_PT_YEAR INTEGER DEFAULT 2017;

  SELECT BUSI_YEAR INTO V_PT_YEAR
    FROM DC_PROC_BUSI_YEAR A
   WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC'
  ;


  --翻耕
  DELETE FROM R_PT_PLOUGH_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND PLOUGH_CB_D_ID LIKE 'FG%'
  ;
  INSERT INTO R_PT_PLOUGH_CB_D
  (
    PLOUGH_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
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
  SELECT T.ID AS PLOUGH_CB_D_ID,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR AS BUSINESS_YEAR,
         T.N1 AS PLOUGH_AREA,
         T.N2 AS PROPESS_AREA,
         T.ORG_CD,
         T.ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'FG'
  ;


  --起垄
  DELETE FROM R_PT_PREPAR_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND PREPAR_CB_D_ID LIKE 'QL%'
  ;
  INSERT INTO R_PT_PREPAR_CB_D(
    PREPAR_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    PREPAR_AREA,
    PROPESS_AREA,
    PREPAR_TYPE,
    PREPAR_QTY,
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
  SELECT ID AS PREPAR_CB_D_ID,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR AS BUSINESS_YEAR,
         T.N1 AS PREPAR_AREA,
         T.N2 AS PROPESS_AREA,
         T.C1 AS PREPAR_TYPE,
         T.N3 AS PREPAR_QTY,
         T.ORG_CD,
         T.ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'QL'
  ;


  --覆膜
  DELETE FROM R_PT_VELUM_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND VELUM_CB_D_ID LIKE 'FM%'
  ;
  INSERT INTO R_PT_VELUM_CB_D
  (
    VELUM_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    VELUM_AREA,
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
  SELECT T.ID            AS VELUM_CB_D_ID,
         '0'             AS SEND_STATE,
         '1'             AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR       AS BUSINESS_YEAR,
         T.N1            AS PLOUGH_AREA,
         T.N2            AS PROPESS_AREA,
         T.ORG_CD,
         T.ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'FM'
  ;


  --育苗与育苗棚数量
  DELETE FROM R_PT_ARCH_QTY
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND PT_ARCH_QTY_ID LIKE 'QTY%'
  ;
  INSERT INTO R_PT_ARCH_QTY
  (
    PT_ARCH_QTY_ID,
    GROW_POINT_QTY,
    BIG_CANOPY_QTY,
    B_BIG_CANOPY_QTY,
    M_BIG_CANOPY_QTY,
    S_BIG_CANOPY_QTY,
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
    BUSINESS_YEAR
  )
  SELECT T.ID             AS PT_ARCH_QTY_ID,
         T.N1             AS GROW_POINT_QTY,
         T.N2             AS BIG_CANOPY_QTY,
         T.N3             AS B_BIG_CANOPY_QTY,
         T.N4             AS M_BIG_CANOPY_QTY,
         T.N5             AS S_BIG_CANOPY_QTY,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         T.PT_YEAR        AS BUSINESS_YEAR
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'QTY'
  ;

  --育苗信息
  DELETE FROM R_PT_GROW_AB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND GROW_AB_D_ID LIKE 'YM%'
  ;
  INSERT INTO R_PT_GROW_AB_D
  (
    GROW_AB_D_ID,
    BUSINESS_YEAR,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    GROW_PLATE_QTY,
    TRANSPLANT_AREA,
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
  SELECT T.ID              AS GROW_AB_D_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         T.C1              AS LEAF_VARIETY_CD,
         T.C2              AS LEAF_VARIETY_NAME,
         T.N1              AS GROW_PLATE_QTY,
         T.N2              AS TRANSPLANT_AREA,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'YM'
  ;


  --苗期管理
  DELETE FROM R_PT_MQGL_NOW_AB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND MQGL_NOW_AB_D_ID LIKE 'MQ%'
  ;
  INSERT INTO R_PT_MQGL_NOW_AB_D
  (
    MQGL_NOW_AB_D_ID,
    BUSINESS_YEAR,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    EMERGE_AREA,
    S_CROSS_AREA,
    B_CROSS_AREA,
    ONE_CLIP_AREA,
    SEED_AREA,
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
  SELECT T.ID               AS GROW_AB_D_ID,
         T.PT_YEAR          AS BUSINESS_YEAR,
         T.C1               AS LEAF_VARIETY_CD,
         T.C2               AS LEAF_VARIETY_NAME,
         T.N1               AS EMERGE_AREA,
         T.N2               AS S_CROSS_AREA,
         T.N3               AS S_CROSS_AREA,
         T.N4               AS B_CROSS_AREA,
         T.N5               AS ONE_CLIP_AREA,
         T.ORG_CD           AS ORG_CD,
         T.ORG_NAME         AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'                AS SEND_STATE,
         '1'                AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'MQ'
  ;


  --供苗管理
  DELETE FROM R_PT_FOR_SEED_AB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND FOR_SEED_AB_D_ID LIKE 'GM%'
  ;
  INSERT INTO R_PT_FOR_SEED_AB_D
  (
    FOR_SEED_AB_D_ID,
    BUSINESS_YEAR,
    FOR_SEED_PLATE_QTY,
    FOR_SEED_QTY,
    TRANSPLANT_AREA,
    DESTORY_QTY,
    DESTORY_AREA,
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
  SELECT T.ID               AS GROW_AB_D_ID,
         T.PT_YEAR          AS BUSINESS_YEAR,
         T.N1               AS FOR_SEED_PLATE_QTY,
         T.N2               AS FOR_SEED_QTY,
         T.N3               AS TRANSPLANT_AREA,
         T.N4               AS DESTORY_QTY,
         T.N5               AS DESTORY_AREA,
         T.ORG_CD           AS ORG_CD,
         T.ORG_NAME         AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'                AS SEND_STATE,
         '1'                AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'GM'
  ;


  --移栽
  DELETE FROM R_PT_TRANSPLANT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND TRANSPLANT_CB_D_ID LIKE 'YZ%'
  ;
  INSERT INTO R_PT_TRANSPLANT_CB_D
  (
    TRANSPLANT_CB_D_ID,
    SEND_STATE,
    DATA_STATE,
    MODIFY_TIME,
    LAST_TIME,
    BUSINESS_YEAR,
    LEAF_VARIETY_CD,
    LEAF_VARIETY_NAME,
    TRANSPLANT_QTY,
    CENSUS_QTY,
    TRANSPLANT_AREA,
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
  SELECT T.ID AS TRANSPLANT_CB_D_ID,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME,
         T.PT_YEAR AS BUSINESS_YEAR,
         T.C1 AS LEAF_VARIETY_CD,
         T.C2 AS LEAF_VARIETY_NAME,
         T.N1 AS TRANSPLANT_QTY,
         T.N2 AS CENSUS_QTY,
         T.N3 AS TRANSPLANT_AREA,
         T.N4 AS PROPESS_AREA,
         T.ORG_CD AS ORG_CD,
         T.ORG_NAME AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'YZ'
  ;


  --地膜回收
  DELETE FROM R_PT_FILM_RECY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND FILM_RECY_CB_D_ID LIKE 'DM%'
  ;
  INSERT INTO R_PT_FILM_RECY_CB_D
  (
    FILM_RECY_CB_D_ID,
    BUSINESS_YEAR,
    COVER_AREA,
    RECY_ARA,
    PROPESS_AREA,
    SUBSIDE_MONEY,
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
  SELECT T.ID              AS FILM_RECY_CB_D_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         T.N1              AS COVER_AREA,
         T.N2              AS RECY_ARA,
         T.N3              AS PROPESS_AREA,
         T.N4              AS SUBSIDE_MONEY,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'DM'
  ;


  --田间卫生
  DELETE FROM R_PT_DT_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND DT_CB_D_ID LIKE 'TJWS%'
  ;
  INSERT INTO R_PT_DT_CB_D
  (
    DT_CB_D_ID,
    BUSINESS_YEAR,
    UNCOVER_AREA,
    MANURE_AREA,
    PTSX_AREA,
    PREVENT_AREA,
    BUTTON_POLE_AREA,
    DEBRIS_CLEAN_AREA,
    UNCOVER_ROOFED_AREA,
    MANURE_ROOFED_AREA,
    PTSX_ROOFED_AREA,
    PREVENT_ROOFED_AREA,
    BUTTON_POLE_ROOFED_AREA,
    DEBRIS_CLEAN_ROOFED_AREA,
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
  SELECT T.ID AS DT_CB_D_ID,
         T.PT_YEAR AS BUSINESS_YEAR,
         T.N1 AS UNCOVER_AREA,
         T.N2 AS MANURE_AREA,
         T.N3 AS PTSX_AREA,
         T.N4 AS PREVENT_AREA,
         T.N5 AS BUTTON_POLE_AREA,
         T.N6 AS DEBRIS_CLEAN_AREA,
         T.N7 AS UNCOVER_ROOFED_AREA,
         T.N8 AS MANURE_ROOFED_AREA,
         T.N9 AS PTSX_ROOFED_AREA,
         T.N10 AS PREVENT_ROOFED_AREA,
         T.N11 AS BUTTON_POLE_ROOFED_AREA,
         T.N12 AS DEBRIS_CLEAN_ROOFED_AREA,
         T.ORG_CD AS ORG_CD,
         T.ORG_NAME AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'TJWS'
  ;


  --田间管理
  DELETE FROM R_PT_YY_GROW_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND YY_GROW_CB_D_ID LIKE 'TJGL%'
  ;
  INSERT INTO R_PT_YY_GROW_CB_D
  (
    YY_GROW_CB_D_ID,
    BUSINESS_YEAR,
    ROOFED_AREA,
    ROOFED_PROPESS_AREA,
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
  SELECT T.ID AS DT_CB_D_ID,
         T.PT_YEAR AS BUSINESS_YEAR,
         T.N1 AS ROOFED_AREA,
         T.N2 AS ROOFED_PROPESS_AREA,
         T.ORG_CD AS ORG_CD,
         T.ORG_NAME AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0' AS SEND_STATE,
         '1' AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'TJGL'
  ;


  --灾害
  DELETE FROM R_PT_CALAMITY_CB_D
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND CALAMITY_CB_D_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_CALAMITY_CB_D
  (
    CALAMITY_CB_D_ID,
    BUSINESS_YEAR,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_QTY,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    DAMAGE_LOSE_WGHT,
    CALAMITY_LEVEL_EK,
    CALAMITY_FRM_QTY,
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
  SELECT T.ID              AS CALAMITY_CB_D_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         T.C1              AS CALAMITY_TYPE,
         T.C2              AS DISEASE_TYPE,
         T.C3              AS DISASTE_TYPE,
         T.N1              AS CALAMITY_QTY,
         T.N2              AS CALAMITY_AREA,
         T.N3              AS ASSIGN_CALAMITY_AREA,
         T.N4              AS DAMAGE_LOSE_WGHT,
         T.C4              AS CALAMITY_LEVEL_EK,
         T.N6              AS CALAMITY_FRM_QTY,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'ZH'
  ;


  --定损理赔
  DELETE FROM R_PT_INDEMNIFY_CB_Y
   WHERE BUSINESS_YEAR = V_PT_YEAR
     AND CITC = '5227'
     AND INDEMNIFY_CB_Y_ID LIKE 'ZH%'
  ;
  INSERT INTO R_PT_INDEMNIFY_CB_Y
  (
    INDEMNIFY_CB_Y_ID,
    BUSINESS_YEAR,
    CALAMITY_TYPE,
    DISEASE_TYPE,
    DISASTE_TYPE,
    CALAMITY_AREA,
    ASSIGN_CALAMITY_AREA,
    CALAMITY_WGHT,
    LOSE_MONEY,
    CALAMITY_FRM_QTY,
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
  SELECT T.ID              AS INDEMNIFY_CB_Y_ID,
         T.PT_YEAR         AS BUSINESS_YEAR,
         T.C1              AS CALAMITY_TYPE,
         T.C2              AS DISEASE_TYPE,
         T.C3              AS DISASTE_TYPE,
         T.N2              AS CALAMITY_AREA,
         T.N3              AS ASSIGN_CALAMITY_AREA,
         T.N4              AS CALAMITY_WGHT,
         T.N5              AS LOSE_MONEY,
         T.N6              AS CALAMITY_FRM_QTY,
         T.ORG_CD          AS ORG_CD,
         T.ORG_NAME        AS ORG_NAME,
         ORG.PROV,
         ORG.PROV_NAME,
         ORG.CITC,
         ORG.CITC_NAME,
         ORG.COUC,
         ORG.COUC_NAME,
         ORG.STAC,
         ORG.STAC_NAME,
         ORG.SSTC,
         ORG.SSTC_NAME,
         '0'               AS SEND_STATE,
         '1'               AS DATA_STATE,
         T.MODIFY_TIME,
         T.LAST_TIME
    FROM PT_EXTRA T
         LEFT JOIN B_ORG ORG ON T.ORG_CD = ORG.ORG_CD
   WHERE STAGE_TYPE = 'ZH'
  ;
  COMMIT;

END
@
*/

CREATE NICKNAME DCCELL.PT_DC_RECORD_DATA_UNLOCK FOR TSOSERVER.TSO.PT_DC_RECORD_DATA_UNLOCK;

--视图：烟技员修改数据情况表
--DROP VIEW DCCELL.V_R_TECHNICIAN_CHANGE_DATA;
CREATE VIEW DCCELL.V_R_TECHNICIAN_CHANGE_DATA
(
    RECORD_DATA_UNLOCK_ID,
    BUSINESS_TYPE_EK,
    BILL_NO,BILL_NAME,
    CLT_OBJ_ID,
    CLT_OBJ_CD,
    CLT_OBJ_NAME,
    TECHNICIAN_ID,
    SITE_ORG_UNIQUE_CD,
    V_DIVISION_UNIQUE_CD,
    ORG_UNIQUE_CD,
    PT_YEAR,
    DATA_STATE,
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
AS
SELECT M.RECORD_DATA_UNLOCK_ID,
       M.BUSINESS_TYPE_EK,
       M.BILL_NO,
       M.BILL_NAME,
       M.CLT_OBJ_ID,
       M.CLT_OBJ_CD,
       M.CLT_OBJ_NAME,
       M.TLG_ID AS TECHNICIAN_ID,
       M.SITE_ORG_UNIQUE_CD,
       M.V_DIVISION_UNIQUE_CD,
       M.ORG_UNIQUE_CD,
       M.PT_YEAR,
       M.DATA_STATE,
       ORG.ORG_CD,
       ORG.ORG_NAME,
       ORG.PROV,
       ORG.PROV_NAME,
       ORG.CITC,
       ORG.CITC_NAME,
       ORG.COUC,
       ORG.COUC_NAME,
       ORG.STAC,
       ORG.STAC_NAME,
       ORG.SSTC,
       ORG.SSTC_NAME 
  FROM PT_DC_RECORD_DATA_UNLOCK M
       LEFT JOIN B_ORG ORG ON M.ORG_UNIQUE_CD=ORG.ORG_UNIQUE_CD AND ORG.ORG_TYPE='2' AND M.PT_YEAR=ORG.BUSINESS_YEAR
 WHERE M.DATA_STATE='1'
;


---查看执行情况
SELECT * 
  FROM TS_JOB_EXEC_LOG
 ORDER BY EXEC_TIME DESC
;


SELECT JOB_CODE AS 过程名称,
       EXEC_TIME AS 开始时间,
       MODIFY_TIME AS 结束时间,
       MODIFY_TIME-EXEC_TIME AS 用时,
       CASE EXEC_RESULT
         WHEN '1' THEN '成功'
         ELSE '失败'
       END AS 执行结果,
       REMARK
  FROM DCCELL.TS_JOB_EXEC_LOG 
 WHERE CALL_METHOD_NAME = 'P_DC_CALL_ID_02_SC'
 ORDER BY EXEC_TIME DESC
;


--查询存储过程中各个步骤执行情况
SELECT PROC_NAME AS 存储过程名称,
       REMARK AS 执行步骤,
       EXEC_TIME AS 过程执行时间,
       END_TIME - BEGIN_TIME AS 耗时
  FROM DCCELL.PROC_TIME_TOTAL
 ORDER BY EXEC_TIME DESC
;


/*
 * 增加非GPS定位采集操作痕迹
 * 2017-6-13
 */
--增加非GPS定位采集操作痕迹，用于无GPS采集情况统计表使用
CREATE NICKNAME DCCELL.PT_CM_NOTGPS_CLT FOR TSOSERVER.TSO.PT_CM_NOTGPS_CLT;


--增加非GPS定位采集操作痕迹视图
CREATE VIEW V_R_NOTGPS_DATA
(
    NOTGPS_CLT_ID,
    BUSINESS_TYPE_EK,
    BILL_NO,
    BILL_NAME,
    OBJ_ID,
    OBJ_CD,
    OBJ_NAME,
    BIZ_DATE,
    LONGITUDE,
    LATITUDE,
    LONGITUDE_TRUE,
    LATITUDE_TRUE,
    TECHNICIAN_ID,
    ORG_UNIQUE_CD,
    PT_YEAR,
    DATA_STATE,
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
AS
SELECT M.NOTGPS_CLT_ID,
       M.BUSINESS_TYPE_EK,
       M.BILL_NO,
       M.BILL_NAME,
       M.OBJ_ID ,
       M.OBJ_CD,
       M.OBJ_NAME,
       M.BIZ_DATE,
       M.LONGITUDE,
       M.LATITUDE,
       M.LONGITUDE_TRUE,
       M.LATITUDE_TRUE,
       M.TLG_ID AS TECHNICIAN_ID,
       M.ORG_UNIQUE_CD,
       M.PT_YEAR,
       M.DATA_STATE,
       ORG.ORG_CD,
       ORG.ORG_NAME,
       ORG.PROV,
       ORG.PROV_NAME,
       ORG.CITC,
       ORG.CITC_NAME,
       ORG.COUC,
       ORG.COUC_NAME,
       ORG.STAC,
       ORG.STAC_NAME,
       ORG.SSTC,
       ORG.SSTC_NAME
  FROM PT_CM_NOTGPS_CLT M
       LEFT JOIN B_ORG ORG ON M.ORG_UNIQUE_CD=ORG.ORG_UNIQUE_CD AND ORG.ORG_TYPE='2' AND M.PT_YEAR=ORG.BUSINESS_YEAR
 WHERE M.DATA_STATE='1'
;



------------------------------------------------------------
--TSO
------------------------------------------------------------
--DROP PROCEDURE TSO.P_TMP_UPDATE_LEAF_VARIETY_CD;
CREATE PROCEDURE TSO.P_TMP_UPDATE_LEAF_VARIETY_CD
--lingm
-----------------------------------------------------
--临时数据更新加工过程，由于部分手机端未升级照成部分数据无烟叶品种信息
-----------------------------------------------------
BEGIN
  UPDATE TSO.PT_DC_STAT_DATA_F A
     SET A.C7 =
         (
            SELECT B.C7
              FROM TSO.PT_DC_STAT_DATA_E B
             WHERE BILL_NO = 'TJ00000000000056'
               AND B.PT_YEAR = 2018
               AND B.CLT_OBJ_ID = A.C4
               AND EXISTS (
                            SELECT 1
                              FROM (
                                      SELECT CLT_OBJ_ID
                                        FROM TSO.PT_DC_STAT_DATA_E
                                       WHERE BILL_NO = 'TJ00000000000056'
                                         AND PT_YEAR = 2018
                                       GROUP BY CLT_OBJ_ID
                                      HAVING COUNT(1) = 1
                                   ) C
                             WHERE B.CLT_OBJ_ID = C.CLT_OBJ_ID
                          )
         )
         ,A.MODIFY_TIME = CURRENT TIMESTAMP
   WHERE A.BILL_NO = 'TJ00000000000057'
     AND A.PT_YEAR = 2018
     AND EXISTS (
                  SELECT 1
                    FROM (
                            SELECT CLT_OBJ_ID
                              FROM TSO.PT_DC_STAT_DATA_E
                             WHERE BILL_NO = 'TJ00000000000071'
                               AND PT_YEAR = 2018
                             GROUP BY CLT_OBJ_ID
                            HAVING COUNT(1) = 1
                         ) C
                   WHERE A.C4 = C.CLT_OBJ_ID
                )
    AND A.C7 IS NULL
  ;
  COMMIT;

  UPDATE TSO.PT_DC_STAT_DATA_E A
     SET A.C5 =
         (SELECT B.C7
            FROM TSO.PT_DC_STAT_DATA_E B
           WHERE BILL_NO = 'TJ00000000000056'
             AND PT_YEAR = 2018
             AND B.CLT_OBJ_ID = A.CLT_OBJ_ID
             AND EXISTS (SELECT 1
                           FROM (
                                  SELECT CLT_OBJ_ID
                                    FROM TSO.PT_DC_STAT_DATA_E
                                   WHERE BILL_NO = 'TJ00000000000056'
                                     AND PT_YEAR = 2018
                                   GROUP BY CLT_OBJ_ID
                                  HAVING (COUNT(1)) = 1
                                ) C 
                          WHERE B.CLT_OBJ_ID = C.CLT_OBJ_ID
                        )
         )
         ,A.MODIFY_TIME = CURRENT TIMESTAMP
   WHERE A.BILL_NO = 'TJ00000000000070'
     AND A.PT_YEAR = 2018
     AND EXISTS (SELECT 1
                   FROM (
                          SELECT CLT_OBJ_ID
                            FROM TSO.PT_DC_STAT_DATA_E
                           WHERE BILL_NO = 'TJ00000000000070'
                             AND PT_YEAR = 2018
                           GROUP BY CLT_OBJ_ID
                          HAVING(COUNT(1)) = 1
                        ) C
                  WHERE A.CLT_OBJ_ID = C.CLT_OBJ_ID
                )
     AND A.C5 IS NULL
  ;
  COMMIT;
  
  UPDATE TSO.PT_DC_STAT_DATA_E A
     SET A.C5 =
         (SELECT B.C7
            FROM TSO.PT_DC_STAT_DATA_E B
           WHERE BILL_NO = 'TJ00000000000056'
             AND B.PT_YEAR = 2018
             AND B.CLT_OBJ_ID = A.CLT_OBJ_ID
             AND EXISTS (
                          SELECT 1
                            FROM (
                                    SELECT CLT_OBJ_ID
                                      FROM TSO.PT_DC_STAT_DATA_E E
                                     WHERE BILL_NO = 'TJ00000000000056'
                                       AND E.PT_YEAR = 2018
                                     GROUP BY CLT_OBJ_ID
                                    HAVING (COUNT(1)) = 1
                                 ) C
                           WHERE B.CLT_OBJ_ID = C.CLT_OBJ_ID
                        )
         )
         ,A.MODIFY_TIME = CURRENT TIMESTAMP
   WHERE A.BILL_NO = 'TJ00000000000071'
     AND A.PT_YEAR = 2018
     AND EXISTS (
                  SELECT 1
                    FROM (
                            SELECT CLT_OBJ_ID
                              FROM TSO.PT_DC_STAT_DATA_E
                             WHERE BILL_NO = 'TJ00000000000071'
                               AND PT_YEAR = 2018
                             GROUP BY CLT_OBJ_ID
                            HAVING (COUNT(1)) = 1
                         ) C
                   WHERE A.CLT_OBJ_ID = C.CLT_OBJ_ID
                )
     AND A.C5 IS NULL
  ;
  COMMIT;
END
@