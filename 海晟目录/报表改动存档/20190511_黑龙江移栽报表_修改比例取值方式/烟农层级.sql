SELECT
    a.cd,
    a.org_name,
    a.frmNo,
    a.arear,
    b.sumNotProcessArea,
    b.sumProcessArea,
    b.sumTransplant,
    CASE
        WHEN b.sumTransplant>0
        AND a.arear>0
        THEN CAST(ROUND(CAST(b.sumTransplant*100 AS FLOAT)/a.arear,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--UPDATE
        WHEN b.DIFF>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(b.DIFF*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--UPDATE
        WHEN b.DEEP>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(b.DEEP*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    d.s1,
    d.s2,
    d.s3,
    d.s4,
    d.s5,
    d.s6,
    d.s7,
    d.s8,
    d.s9,
    e.e1,
    e.e2,
    e.e3,
    e.e4,
    e.e5,
    e.e6,
    e.e7,
    e.e8,
    e.sumAll,
    CASE
        WHEN e.sumAll>0
        AND a.arear>0
        THEN CAST(ROUND(CAST(e.sumAll AS FLOAT)/a.arear,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    c.d1,
    c.d3,
    CASE
        WHEN c.d3>0
        AND a.arear>0
        THEN CAST(ROUND(CAST(c.d3*100 AS FLOAT)/a.arear,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--UPDATE
        WHEN c.d4>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.d4*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    100-
    CASE--UPDATE
        WHEN c.d4>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.d4*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--UPDATE
        WHEN c.d5>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.d5*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    100-
    CASE--UPDATE
        WHEN c.d5>0
        AND G.TOTLE_BLOCK_QTY>0
        THEN CAST(ROUND(CAST(c.d5*100 AS FLOAT)/G.TOTLE_BLOCK_QTY,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CAST(ROUND(CAST(f.n1 AS DECIMAL(11,4)) ,2) AS DECIMAL(11,2))
FROM
    (
        SELECT
            farmer_cd             AS cd,
            farmer_name           AS org_name,
            PROV_CNTRCT_NO        AS frmNo,
            SUM(cntrct_plnt_area) AS arear
        FROM
            R_PC_CTRT_PC_D_Y18
        WHERE
            CNTRCT_TYPE='NOR_CONT'
        AND LEAF_TYPE_CD='10'
        AND TECHNICIAN_NAME = '许昌烟点'
        AND data_state = '1'
        GROUP BY
            farmer_cd,
            farmer_name,
            PROV_CNTRCT_NO) a
INNER JOIN
    (
        SELECT
            cd,
            SUM(PROPESS_AREA)    AS sumProcessArea,
            SUM(RE1)             AS sumNotProcessArea ,
            SUM(TRANSPLANT_AREA) AS sumTransplant,
            COUNT(DISTINCT(CASE WHEN IS_DIFF='1' THEN FIELD_BLOCK_CD END)) AS DIFF,--SUM(DIFF)            AS DIFF
            COUNT(DISTINCT(CASE WHEN IS_DEEP='1' THEN FIELD_BLOCK_CD END)) AS DEEP--SUM(DEEP)            AS DEEP
        FROM
            (
                SELECT DISTINCT
                    B.DATA_STORE_BASE_TBL_ID,
                    B.RELA_OBJECT_CD AS cd,
                    x.PROPESS_AREA,
                    x.TRANSPLANT_AREA - x.PROPESS_AREA AS RE1,
                    x.TRANSPLANT_AREA,
                    -- x.DIFF_TRANSPLANT_AREA AS DIFF,
                    -- x.DEEP_TRANSPLANT_AREA AS DEEP
                    x.FIELD_BLOCK_CD,--NEW
                    B.C1 AS IS_DIFF,--NEW
                    B.C2 AS IS_DEEP--NEW
                FROM
                    R_PT_TRANSPLANT_FM_D x,
                    PT_DC_STAT_DATA_B b
                WHERE
                    b.DATA_STATE='1'
                AND b.FEEDBACK_DATE>='2018-01-01 00:00:00'
                AND b.FEEDBACK_DATE<='2019-05-11 00:00:00'
                AND B.DATA_STORE_BASE_TBL_ID = x.TRANSPLANT_FM_D_ID)
        GROUP BY
            cd) b ON a.cd = b.cd
LEFT JOIN
    (
        SELECT
            cd,
            SUM(n1) AS s1,
            SUM(n2) AS s2,
            SUM(n3) AS s3,
            SUM(n4) AS s4,
            SUM(n5) AS s5,
            SUM(n6) AS s6,
            SUM(n7) AS s7,
            SUM(n8) AS s8,
            SUM(n9) AS s9
        FROM
            (
                SELECT
                    B.FARMER_CD AS cd,
                    CASE
                        WHEN b.MEDICAL_TYPE = '001'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n1,
                    CASE
                        WHEN b.MEDICAL_TYPE = '002'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n2,
                    CASE
                        WHEN b.MEDICAL_TYPE = '003'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n3,
                    CASE
                        WHEN b.MEDICAL_TYPE = '004'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n4,
                    CASE
                        WHEN b.MEDICAL_TYPE = '005'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n5,
                    CASE
                        WHEN b.MEDICAL_TYPE = '006'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n6,
                    CASE
                        WHEN b.MEDICAL_TYPE = '007'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n7,
                    CASE
                        WHEN b.MEDICAL_TYPE = '008'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n8,
                    CASE
                        WHEN b.MEDICAL_TYPE = '009'
                        THEN b.MEDICAL_WGHT
                        ELSE 0
                    END AS n9
                FROM
                    V_PT_TRANSPLANT_MEDICAL_FM_D B
                WHERE
                    b.DATA_STATE='1'
                AND b.TECHNICAN_NAME ='许昌烟点'
                AND b.BUSINESS_DATE>='2018-01-01 00:00:00'
                AND b.BUSINESS_DATE<='2019-05-11 00:00:00' )
        GROUP BY
            cd) d ON a.cd = d.cd
LEFT JOIN
    (
        SELECT
            cd,
            SUM(LAND_MEMBRANE_WGHT/1000) AS d1,
            SUM(VELUM_AREA)              AS d3 ,
            COUNT(DISTINCT(CASE WHEN IS_TOP='1' THEN FIELD_BLOCK_CD END)) AS d4,--SUM(TOP_MEMBRANE_AREA)       AS d4,
            COUNT(DISTINCT(CASE WHEN IS_BOTH='1' THEN FIELD_BLOCK_CD END)) AS d5--SUM(BOTH_SIDE_AREA)          AS d5
        FROM
            (
                SELECT DISTINCT
                    B.DATA_STORE_BASE_TBL_ID,
                    B.RELA_OBJECT_CD AS cd,
                    x.LAND_MEMBRANE_WGHT,
                    x.VELUM_AREA,
                    -- x.TOP_MEMBRANE_AREA,
                    -- x.BOTH_SIDE_AREA
                    X.FIELD_BLOCK_CD,--NEW
                    B.C3 AS IS_TOP,--NEW
                    B.C4 AS IS_BOTH--NEW
                FROM
                    R_PT_VELUM_FM_D x,
                    PT_DC_STAT_DATA_B b
                WHERE
                    b.DATA_STATE='1'
                AND b.FEEDBACK_DATE>='2018-01-01 00:00:00'
                AND b.FEEDBACK_DATE<='2019-05-11 00:00:00'
                AND B.DATA_STORE_BASE_TBL_ID = x.VELUM_FM_D_ID )
        GROUP BY
            cd) c ON a.cd = c.cd
LEFT JOIN
    (
        SELECT
            cd,
            AVG(ILLUMINATE_LEN) AS n1
        FROM
            (
                SELECT
                    B.FARMER_CD AS cd,
                    B.ILLUMINATE_LEN
                FROM
                    V_PT_TRANSPLANT_BASIC_FM_D B
                WHERE
                    b.DATA_STATE='1'
                AND b.TECHNICAN_NAME ='许昌烟点'
                AND b.TRANSPLANT_DATE>='2018-01-01 00:00:00'
                AND b.TRANSPLANT_DATE<='2019-05-11 00:00:00' )
        GROUP BY
            cd) f ON a.cd = f.cd
LEFT JOIN
    (
        SELECT
            cd,
            SUM(n1)                      AS e1,
            SUM(n2)                      AS e2,
            SUM(n3)                      AS e3,
            SUM(n4)                      AS e4,
            SUM(n5)                      AS e5,
            SUM(n6)                      AS e6,
            SUM(n7)                      AS e7,
            SUM(n8)                      AS e8,
            SUM(n1+n2+n3+n4+n5+n6+n7+n8) AS sumAll
        FROM
            (
                SELECT
                    B.FARMER_CD AS cd,
                    CASE
                        WHEN b.MANURE_TYPE = '001'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n1,
                    CASE
                        WHEN b.MANURE_TYPE = '002'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n2,
                    CASE
                        WHEN b.MANURE_TYPE = '003'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n3,
                    CASE
                        WHEN b.MANURE_TYPE = '004'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n4,
                    CASE
                        WHEN b.MANURE_TYPE = '005'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n5,
                    CASE
                        WHEN b.MANURE_TYPE = '006'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n6,
                    CASE
                        WHEN b.MANURE_TYPE = '007'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n7,
                    CASE
                        WHEN b.MANURE_TYPE = '008'
                        THEN b.MANURE_WGHT
                        ELSE 0
                    END AS n8
                FROM
                    V_PT_TRANSPLANT_MANURE_FM_D B
                WHERE
                    b.DATA_STATE='1'
                AND b.TECHNICAN_NAME ='许昌烟点'
                AND b.BUSINESS_DATE>='2018-01-01 00:00:00'
                AND b.BUSINESS_DATE<='2019-05-11 00:00:00' )
        GROUP BY
            cd) e ON a.cd = e.cd
LEFT JOIN --NEW 
(
  SELECT
    FARMER_CD                      AS cd,
    COUNT(DISTINCT FIELD_BLOCK_CD) AS TOTLE_BLOCK_QTY
    FROM
    R_FIELD_BLOCK_Y18
    WHERE
    DATA_STATE='1'
    AND prov='41'
    GROUP BY FARMER_CD
) G ON G.CD = A.cd
ORDER BY
    a.cd WITH ur