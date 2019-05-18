SELECT
    fb.FIELD_BLOCK_CD,
    fb.FIELD_BLOCK_NAME,
    fb.FIELD_BLOCK_AREA,
    f.VARIETY_NAME,
    b.sumNotProcessArea,
    b.sumProcessArea,
    b.sumTransplant,
    CASE
        WHEN b.sumTransplant>0
        AND b.area>0
        THEN CAST(ROUND(CAST(b.sumTransplant*100 AS FLOAT)/b.area,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--
        WHEN b.DIFF>0
        AND b.area>0
        THEN CAST(ROUND(CAST(b.DIFF*100 AS FLOAT)/1,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--
        WHEN b.DEEP>0
        AND b.area>0
        THEN CAST(ROUND(CAST(b.DEEP*100 AS FLOAT)/1,2) AS DECIMAL(10,2))
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
        AND b.area>0
        THEN CAST(ROUND(CAST(e.sumAll AS FLOAT)/b.area,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    c.d1,
    c.d3,
    CASE
        WHEN c.d3>0
        AND b.area>0
        THEN CAST(ROUND(CAST(c.d3*100 AS FLOAT)/b.area,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--
        WHEN c.d4>0
        AND 1>0
        THEN CAST(ROUND(CAST(c.d4*100 AS FLOAT)/1,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    100-
    CASE--
        WHEN c.d4>0
        AND 1>0
        THEN CAST(ROUND(CAST(c.d4*100 AS FLOAT)/1,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CASE--
        WHEN c.d5>0
        AND 1>0
        THEN CAST(ROUND(CAST(c.d5*100 AS FLOAT)/1,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    100-
    CASE--
        WHEN c.d5>0
        AND 1>0
        THEN CAST(ROUND(CAST(c.d5*100 AS FLOAT)/1,2) AS DECIMAL(10,2))
        ELSE 0
    END,
    CAST(ROUND(CAST(f.n1 AS DECIMAL(11,4)) ,2) AS DECIMAL(11,2))
FROM
    (
        SELECT
            cd,
            SUM(FIELD_BLOCK_AREA) AS area,
            SUM(PROPESS_AREA)     AS sumProcessArea,
            SUM(RE1)              AS sumNotProcessArea ,
            SUM(TRANSPLANT_AREA)  AS sumTransplant,--,
            -- SUM(DIFF)             AS DIFF,
            -- SUM(DEEP)             AS DEEP
            DIFF,
            DEEP
        FROM
            (
                SELECT DISTINCT
                    B.DATA_STORE_BASE_TBL_ID,
                    bl.FIELD_BLOCK_AREA,
                    B.CLT_OBJ_CD AS cd,
                    b.CLT_OBJ_NAME,
                    x.PROPESS_AREA,
                    x.TRANSPLANT_AREA - x.PROPESS_AREA AS RE1,
                    x.TRANSPLANT_AREA,
                    -- x.DIFF_TRANSPLANT_AREA AS DIFF,
                    -- x.DEEP_TRANSPLANT_AREA AS DEEP
                    CASE WHEN B.C1='1' THEN 1 ELSE 0 END AS DIFF,--NEW
                    CASE WHEN B.C2='1' THEN 1 ELSE 0 END AS DEEP--NEW
                FROM
                    R_PT_TRANSPLANT_FM_D x,
                    R_FIELD_BLOCK_Y18 bl,
                    PT_DC_STAT_DATA_B B
                WHERE
                    b.DATA_STATE='1'
                AND b.FEEDBACK_DATE>='2018-01-01 00:00:00'
                AND b.FEEDBACK_DATE<='2019-05-11 00:00:00'
                AND B.DATA_STORE_BASE_TBL_ID = x.TRANSPLANT_FM_D_ID
                AND bl.FIELD_BLOCK_ID=b.CLT_OBJ_ID
                AND B.RELA_OBJECT_CD='4110230165000015')
        GROUP BY
            cd,
            CLT_OBJ_NAME,
            DIFF,--
            DEEP) b
LEFT JOIN
    (
        SELECT
            cd,
            SUM(LAND_MEMBRANE_WGHT/1000) AS d1,
            SUM(VELUM_AREA)              AS d3,
            -- SUM(TOP_MEMBRANE_AREA)       AS d4,
            -- SUM(BOTH_SIDE_AREA)          AS d5
            D4,
            D5
        FROM
            (
                SELECT DISTINCT
                    B.DATA_STORE_BASE_TBL_ID,
                    B.CLT_OBJ_CD AS cd,
                    x.LAND_MEMBRANE_WGHT,
                    x.VELUM_AREA,
                    -- x.TOP_MEMBRANE_AREA,
                    -- x.BOTH_SIDE_AREA
                    CASE WHEN B.C3='1' THEN 1 ELSE 0 END AS D4,
                    CASE WHEN B.C4='1' THEN 1 ELSE 0 END AS D5
                FROM
                    R_PT_VELUM_FM_D x,
                    R_FIELD_BLOCK_Y18 bl,
                    PT_DC_STAT_DATA_B B
                WHERE
                    b.DATA_STATE='1'
                AND b.FEEDBACK_DATE>='2018-01-01 00:00:00'
                AND b.FEEDBACK_DATE<='2019-05-11 00:00:00'
                AND B.DATA_STORE_BASE_TBL_ID = x.VELUM_FM_D_ID
                AND bl.FIELD_BLOCK_ID=b.CLT_OBJ_ID
                AND B.RELA_OBJECT_CD='4110230165000015')
        GROUP BY
            cd,--
            D4,--
            D5--
            ) c ON b.cd = c.cd
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
                    B.FIELD_BLOCK_CD AS cd,
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
                AND b.farmer_cd ='4110230165000015'
                AND b.BUSINESS_DATE>='2018-01-01 00:00:00'
                AND b.BUSINESS_DATE<='2019-05-11 00:00:00' )
        GROUP BY
            cd) d ON b.cd = d.cd
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
                    B.FIELD_BLOCK_CD AS cd,
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
                AND b.farmer_cd ='4110230165000015'
                AND b.BUSINESS_DATE>='2018-01-01 00:00:00'
                AND b.BUSINESS_DATE<='2019-05-11 00:00:00' )
        GROUP BY
            cd) e ON b.cd = e.cd
LEFT JOIN
    (
        SELECT
            cd,
            VARIETY_NAME,
            AVG(ILLUMINATE_LEN) AS n1
        FROM
            (
                SELECT
                    B.FIELD_BLOCK_CD AS cd,
                    B.VARIETY_NAME,
                    B.ILLUMINATE_LEN
                FROM
                    V_PT_TRANSPLANT_BASIC_FM_D B
                WHERE
                    b.DATA_STATE='1'
                AND b.farmer_cd ='4110230165000015'
                AND b.TRANSPLANT_DATE>='2018-01-01 00:00:00'
                AND b.TRANSPLANT_DATE<='2019-05-11 00:00:00' )
        GROUP BY
            cd,
            VARIETY_NAME) f ON b.cd = f.cd
LEFT JOIN
    R_FIELD_BLOCK_Y18 fb ON b.cd=fb.FIELD_BLOCK_CD WITH ur