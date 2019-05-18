SELECT
    org.groupCd,
    org.groupName,
    f.FRMNO,
    f.AREA,
    d.rg,
    d.d4,
    d.d5,
    CASE
        WHEN d.d5>0
        AND f.area>0
        THEN CAST(ROUND(CAST(d.d5*100 AS FLOAT)/f.area,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--NEW
        WHEN d.d7>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(d.d7*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--NEW
        WHEN d.d8>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(d.d8*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    a.a1,
    a.a2,
    a.a3,
    a.a4,
    a.a5,
    a.a6,
    a.a7,
    a.a8,
    a.a9,
    b.b1,
    b.b2,
    b.b3,
    b.b4,
    b.b5,
    b.b6,
    b.b7,
    b.b8,
    b.b_sum,
    CASE
        WHEN b.b_sum>0
        AND f.area>0
        THEN CAST(ROUND(CAST(b.b_sum AS FLOAT)/f.area,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    c.c1,
    c.c3,
    CASE
        WHEN c.c3>0
        AND f.area>0
        THEN CAST(ROUND(CAST(c.c3*100 AS FLOAT)/f.area,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--UPDATE
        WHEN c.c4>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.c4*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    100-
    CASE--UPDATE
        WHEN c.c4>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.c4*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--UPDATE
        WHEN c.c5>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.c5*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    100-
    CASE--UPDATE
        WHEN c.c5>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.c5*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CAST(ROUND(CAST(e.e1 AS DECIMAL(11,4)) ,2) AS DECIMAL(11,2))
FROM
    (
        SELECT
            org_unique_cd,
            citc      AS groupCd,
            citc_name AS groupName
        FROM
            b_org
        WHERE
            org_type='2'
        AND org_level = 2
        AND prov='41') org
INNER JOIN
    (
        SELECT
            groupCd,
            SUM(NotProcessArea)  AS rg,
            SUM(PROCESS_AREA)    AS d4,
            SUM(TRANSPLANT_AREA) AS d5,
            COUNT(DISTINCT(CASE WHEN IS_DIFF='1' THEN FIELD_BLOCK_CD END))            AS d7,--SUM(DIFF)            AS d7,
            COUNT(DISTINCT(CASE WHEN IS_DEEP='1' THEN FIELD_BLOCK_CD END))            AS d8--SUM(DEEP)            AS d8
        FROM
            (
                SELECT DISTINCT
                    a.DATA_STORE_BASE_TBL_ID,
                    org.org_unique_cd,
                    org.groupCd,
                    a.TRANSPLANT_AREA,
                    A.FIELD_BLOCK_CD,--NEW
                    a.IS_DIFF,--DIFF
                    a.IS_DEEP,--DEEP
                    A.NotProcessArea,
                    a.PROCESS_AREA
                FROM
                    (
                        SELECT
                            org_unique_cd,
                            citc      AS groupCd,
                            citc_name AS groupName
                        FROM
                            b_org
                        WHERE
                            org_type='2'
                        AND org_level = 2
                        AND prov='41') org
                LEFT JOIN
                    (
                        SELECT
                            da.FEEDBACK_DATE,
                            da.CITY_ORG_UNIQUE_CD AS org_unique_cd,
                            DATA_STORE_BASE_TBL_ID,
                            wt.TRANSPLANT_AREA,
                            wt.TRANSPLANT_AREA-wt.PROPESS_AREA AS NotProcessArea,
                            wt.PROPESS_AREA                    AS PROCESS_AREA,
                            -- CASE
                            --     WHEN wt.DIFF_TRANSPLANT_AREA>0
                            --     AND wt.TRANSPLANT_AREA>0
                            --     THEN CAST(ROUND(CAST(wt.DIFF_TRANSPLANT_AREA*100 AS FLOAT)/wt.TRANSPLANT_AREA,2) AS DECIMAL(10,2))
                            --     ELSE 0
                            -- END AS DIFF,
                            -- CASE
                            --     WHEN wt.DEEP_TRANSPLANT_AREA>0
                            --     AND wt.TRANSPLANT_AREA>0
                            --     THEN CAST(ROUND(CAST(wt.DEEP_TRANSPLANT_AREA*100 AS FLOAT)/wt.TRANSPLANT_AREA,2) AS DECIMAL(10,2))
                            --     ELSE 0
                            -- END AS DEEP
                            WT.FIELD_BLOCK_CD,--NEW
                            DA.C1 AS IS_DIFF,--NEW
                            DA.C2 AS IS_DEEP--NEW
                        FROM
                            PT_DC_STAT_DATA_B da,
                            V_PT_TRANSPLANT_FM_D wt
                        WHERE
                            da.DATA_STORE_BASE_TBL_ID = wt.TRANSPLANT_FM_D_ID
                        AND pt_year =2018
                        AND da.data_state='1'
                        AND da.check_state='1'
                        AND da.FEEDBACK_DATE>='2018-01-01 00:00:00'
                        AND da.FEEDBACK_DATE<='2019-05-09 00:00:00') a ON a.org_unique_cd = org.org_unique_cd 
                    )
        GROUP BY
            groupCd) d ON org.groupCd=d.groupCd
LEFT JOIN
    (
        SELECT
            org_cd,
            SUM(b21) AS a1,
            SUM(b22) AS a2,
            SUM(b23) AS a3,
            SUM(b24) AS a4,
            SUM(b25) AS a5,
            SUM(b26) AS a6,
            SUM(b27) AS a7,
            SUM(b28) AS a8,
            SUM(b29) AS a9
        FROM
            (
                SELECT
                    citc      AS org_cd,
                    citc_NAME AS org_name,
                    CASE
                        WHEN MEDICAL_TYPE='001'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b21,
                    CASE
                        WHEN MEDICAL_TYPE='002'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b22,
                    CASE
                        WHEN MEDICAL_TYPE='003'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b23,
                    CASE
                        WHEN MEDICAL_TYPE='004'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b24,
                    CASE
                        WHEN MEDICAL_TYPE='005'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b25,
                    CASE
                        WHEN MEDICAL_TYPE='006'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b26,
                    CASE
                        WHEN MEDICAL_TYPE='007'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b27,
                    CASE
                        WHEN MEDICAL_TYPE='008'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b28,
                    CASE
                        WHEN MEDICAL_TYPE='009'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b29
                FROM
                    V_PT_TRANSPLANT_MEDICAL_FM_D
                WHERE
                    prov='41'
                AND BUSINESS_YEAR =2018
                AND data_state='1'
                AND BUSINESS_DATE>='2018-01-01 00:00:00'
                AND BUSINESS_DATE<='2019-05-09 00:00:00' )
        GROUP BY
            org_cd) a ON a.org_cd=org.groupCd
LEFT JOIN
    (
        SELECT
            org_cd,
            SUM(b31)                             AS b1,
            SUM(b32)                             AS b2,
            SUM(b33)                             AS b3,
            SUM(b34)                             AS b4,
            SUM(b35)                             AS b5,
            SUM(b36)                             AS b6,
            SUM(b37)                             AS b7,
            SUM(b38)                             AS b8,
            SUM(b31+b32+b33+b34+b35+b36+b37+b38) AS b_sum
        FROM
            (
                SELECT
                    citc      AS org_cd,
                    citc_NAME AS org_name,
                    CASE
                        WHEN MEDICAL_TYPE='001'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b31,
                    CASE
                        WHEN MEDICAL_TYPE='002'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b32,
                    CASE
                        WHEN MEDICAL_TYPE='003'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b33,
                    CASE
                        WHEN MEDICAL_TYPE='004'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b34,
                    CASE
                        WHEN MEDICAL_TYPE='005'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b35,
                    CASE
                        WHEN MEDICAL_TYPE='006'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b36,
                    CASE
                        WHEN MEDICAL_TYPE='007'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b37,
                    CASE
                        WHEN MEDICAL_TYPE='008'
                        THEN MEDICAL_WGHT
                        ELSE 0
                    END AS b38
                FROM
                    V_PT_TRANSPLANT_MEDICAL_FM_D
                WHERE
                    prov='41'
                AND BUSINESS_YEAR =2018
                AND data_state='1'
                AND BUSINESS_DATE>='2018-01-01 00:00:00'
                AND BUSINESS_DATE<='2019-05-09 00:00:00' )
        GROUP BY
            org_cd) b ON org.groupCd=b.org_cd
LEFT JOIN
    (
        SELECT
            groupCd,
            SUM(LAND_MEMBRANE_WGHT)/1000 AS c1,
            SUM(VELUM_AREA)              AS c3,
            COUNT(DISTINCT(CASE WHEN IS_TOP='1' THEN FIELD_BLOCK_CD END))       AS c4,--SUM(TOP_MEMBRANE_AREA)       AS c4,
            COUNT(DISTINCT(CASE WHEN IS_BOTH='1' THEN FIELD_BLOCK_CD END))          AS c5--SUM(BOTH_SIDE_AREA)          AS c5
        FROM
            (
                SELECT DISTINCT
                    a.DATA_STORE_BASE_TBL_ID,
                    org.org_unique_cd,
                    org.groupCd,
                    a.LAND_MEMBRANE_WGHT,
                    a.VELUM_AREA,
                    -- a.TOP_MEMBRANE_AREA,
                    -- a.BOTH_SIDE_AREA
                    A.FIELD_BLOCK_CD,--NEW
                    A.IS_TOP,--NEW
                    A.IS_BOTH--NEW
                FROM
                    (
                        SELECT
                            org_unique_cd,
                            citc      AS groupCd,
                            citc_name AS groupName
                        FROM
                            b_org
                        WHERE
                            org_type='2'
                        AND org_level = 2
                        AND prov='41') org
                LEFT JOIN
                    (
                        SELECT
                            da.FEEDBACK_DATE,
                            da.CITY_ORG_UNIQUE_CD AS org_unique_cd,
                            DATA_STORE_BASE_TBL_ID,
                            wt.LAND_MEMBRANE_WGHT,
                            wt.VELUM_AREA,
                            -- wt.TOP_MEMBRANE_AREA,
                            -- wt.BOTH_SIDE_AREA
                            WT.FIELD_BLOCK_CD,--NEW
                            da.C3 AS IS_TOP,--NEW
                            da.C4 AS IS_BOTH--NEW
                        FROM
                            PT_DC_STAT_DATA_B da,
                            V_PT_VELUM_FM_D wt
                        WHERE
                            da.DATA_STORE_BASE_TBL_ID = wt.VELUM_FM_D_ID
                        AND pt_year =2018
                        AND da.data_state='1'
                        AND da.check_state='1'
                        AND da.FEEDBACK_DATE>='2018-01-01 00:00:00'
                        AND da.FEEDBACK_DATE<='2019-05-09 00:00:00') a ON a.org_unique_cd = org.org_unique_cd )
        GROUP BY
            groupCd) c ON org.groupCd=c.groupCd
LEFT JOIN
    (
        SELECT
            org_cd,
            AVG(ILLUMINATE_LEN) AS e1
        FROM
            (
                SELECT
                    citc      AS org_cd,
                    citc_NAME AS org_name,
                    ILLUMINATE_LEN
                FROM
                    V_PT_TRANSPLANT_BASIC_FM_D
                WHERE
                    prov='41'
                AND BUSINESS_YEAR =2018
                AND data_state='1'
                AND TRANSPLANT_DATE>='2018-01-01 00:00:00'
                AND TRANSPLANT_DATE<='2019-05-09 00:00:00' )
        GROUP BY
            org_cd) e ON org.groupCd=e.org_cd
LEFT JOIN
    (
        SELECT
            citc                      AS cd,
            COUNT(DISTINCT FARMER_CD) AS frmNo,
            SUM(CNTRCT_PLNT_AREA)     AS area
        FROM
            R_PC_CTRT_PC_D_Y18
        WHERE
            CNTRCT_TYPE='NOR_CONT'
        AND LEAF_TYPE_CD='10'
        AND DATA_STATE='1'
        GROUP BY
            citc) f ON f.cd = org.groupCd
LEFT JOIN --NEW 
(
  SELECT
    citc                      AS cd,
    COUNT(DISTINCT FIELD_BLOCK_CD) AS TOTLE_BLOCK_QTY
    FROM
    R_FIELD_BLOCK_Y18
    WHERE
    DATA_STATE='1'
    AND prov='41'
    GROUP BY citc
) G ON G.CD = org.groupCd

ORDER BY
    org.groupCd WITH ur