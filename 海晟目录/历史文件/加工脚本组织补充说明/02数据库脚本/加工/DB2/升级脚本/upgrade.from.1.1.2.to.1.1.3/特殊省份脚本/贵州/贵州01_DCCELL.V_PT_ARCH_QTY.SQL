--DROP VIEW DCCELL.V_PT_ARCH_QTY;
CREATE VIEW DCCELL.V_PT_ARCH_QTY
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