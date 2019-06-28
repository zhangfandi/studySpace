SELECT
  ORG.ORG_NAME,
  BC.TOTLE_FRM_QTY,
  BC.COMP_FRM_QTY,
  CASE
  WHEN BC.COMP_FRM_QTY > 0
       AND BC.TOTLE_FRM_QTY > 0
    THEN CAST(ROUND(CAST(BC.COMP_FRM_QTY * 100 AS FLOAT) / BC.TOTLE_FRM_QTY, 2) AS DECIMAL(10, 2))
  ELSE 0
  END,
  BC.APPROVE_AREA,
  A.PLOUGH_AREA,
  CASE
  WHEN A.PLOUGH_AREA > 0
       AND BC.APPROVE_AREA > 0
    THEN CAST(ROUND(CAST(A.PLOUGH_AREA * 100 AS FLOAT) / BC.APPROVE_AREA, 2) AS DECIMAL(10, 2))
  ELSE 0
  END,
  DEPTH_T,
  DEPTH_F,
  OPEN_T,
  OPEN_F,
  EVAL_1,
  EVAL_2,
  EVAL_3,
  EVAL_4,
  BEGIN_DATE,
  END_DATE,
  A.ORG_CD
FROM
  (
    SELECT
      CITC                                           AS ORG_CD,
      SUM(PLOUGH_AREA)                               AS PLOUGH_AREA,
      SUM(
          CASE
          WHEN IS_DEPTH_STAND = '1'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS DEPTH_T,
      SUM(
          CASE
          WHEN IS_DEPTH_STAND = '0'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS DEPTH_F,
      SUM(
          CASE
          WHEN IS_OPEN_TRENCH = '1'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS OPEN_T,
      SUM(
          CASE
          WHEN IS_OPEN_TRENCH = '0'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS OPEN_F,
      SUM(
          CASE
          WHEN WORK_EFFECT_EVAL = '01'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS EVAL_1,
      SUM(
          CASE
          WHEN WORK_EFFECT_EVAL = '02'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS EVAL_2,
      SUM(
          CASE
          WHEN WORK_EFFECT_EVAL = '03'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS EVAL_3,
      SUM(
          CASE
          WHEN WORK_EFFECT_EVAL = '04'
            THEN PLOUGH_AREA
          ELSE 0
          END)                                       AS EVAL_4,
      CAST(CHAR(DATE(MIN(END_DATE))) AS VARCHAR(10)) AS BEGIN_DATE,
      CAST(CHAR(DATE(MAX(END_DATE))) AS VARCHAR(10)) AS END_DATE
    FROM
      R_PT_PLOUGH_FM_D
    WHERE
      DATA_STATE = '1'
      AND PROV = '52'
      AND END_DATE >= TIMESTAMP('2018-01-01 00:00:00')
      AND END_DATE <= TIMESTAMP('2019-05-25 00:00:00')
      AND BUSINESS_YEAR = 2019
    GROUP BY
      CITC) A
  LEFT JOIN
  (
    SELECT
      B.ORG_CD,
      D.TOTLE_FRM_QTY,
      COUNT(DISTINCT B.FARMER_CD) AS COMP_FRM_QTY,
      SUM(B.PLOUGH_AREA)          AS PLOUGH_AREA,
      SUM(C.APPROVE_AREA)         AS APPROVE_AREA
    FROM
      (
        SELECT
          CITC             AS ORG_CD,
          FARMER_CD,
          SUM(PLOUGH_AREA) AS PLOUGH_AREA
        FROM
          R_PT_PLOUGH_FM_D
        WHERE
          DATA_STATE = '1'
          AND PROV = '52'
          AND END_DATE >= TIMESTAMP('2018-01-01 00:00:00')
          AND END_DATE <= TIMESTAMP('2019-05-25 00:00:00')
        GROUP BY
          CITC,
          FARMER_CD) B
      LEFT JOIN
      (
        SELECT DISTINCT
          FRM_CD            AS FARMER_CD,
          SUM(APPROVE_AREA) AS APPROVE_AREA
        FROM
          PC_AI_PLANT_APPLY A
        WHERE
          DATA_STATE = '1'
          AND AUDIT_STATE = '3'
          AND IS_INVALID_FLAG = '0'
          AND BIZ_YEAR = 2019
        GROUP BY
          FRM_CD) C ON B.FARMER_CD = C.FARMER_CD
      LEFT JOIN
      (
        SELECT
          CITC                      AS ORG_CD,
          COUNT(DISTINCT FARMER_CD) AS TOTLE_FRM_QTY
        FROM
          R_FRMR_TECH_REL_Y19
        WHERE
          DATA_STATE = '1'
          AND PROV = '52'
        GROUP BY CITC
      )
      D ON B.ORG_CD = D.ORG_CD
    GROUP BY
      B.ORG_CD, D.TOTLE_FRM_QTY) BC ON A.ORG_CD = BC.ORG_CD
  LEFT JOIN
  b_org ORG ON A.ORG_CD = ORG.ORG_CD WITH UR