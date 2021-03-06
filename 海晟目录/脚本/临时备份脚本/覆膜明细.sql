--覆膜明细
SELECT
  A.TOWN_NAME,
  A.VAGE_NAME,
  A.FARMER_CD,
  A.FARMER_NAME,
  B.CNTRCT_PLNT_AREA,
  A.VELUM_AREA,
  CASE
  WHEN A.VELUM_AREA > 0
       AND B.CNTRCT_PLNT_AREA > 0
    THEN CAST(ROUND(CAST(A.VELUM_AREA * 100 AS FLOAT) / B.CNTRCT_PLNT_AREA, 2) AS DECIMAL(10, 2))
  ELSE 0
  END,
  A.IS_VELUM,
  A.VELUM_EFFTET,
  A.EVAL,
  A.BEGIN_DATE,
  A.END_DATE,
  C.TECHNICIAN_NAME
FROM
  (
    SELECT
      TOWN_NAME,
      VAGE_NAME,
      FARMER_CD,
      FARMER_NAME,
      CASE
      WHEN VELUM_EFFTET = '1' OR VELUM_EFFTET = '2'
        THEN VELUM_AREA
      ELSE 0 END     AS VELUM_AREA,
      CASE
      WHEN VELUM_EFFTET = '1' OR VELUM_EFFTET = '2'
        THEN '是'
      ELSE '否' END   AS IS_VELUM,
      CASE
      WHEN VELUM_EFFTET = '1'
        THEN '严实'
      ELSE '不严实' END AS VELUM_EFFTET,
      CASE WORK_EFFECT_EVAL
      WHEN '01'
        THEN '好'
      WHEN '02'
        THEN '较好'
      WHEN '03'
        THEN '一般'
      WHEN '04'
        THEN '差' END AS EVAL,
      BEGIN_DATE,
      END_DATE,
      TECHNICIAN_ID
    FROM
      R_PT_VELUM_FM_D
    WHERE
      DATA_STATE = '1'
      AND PROV = '52'
      AND BEGIN_DATE >= TIMESTAMP('2018-01-01 00:00:00')
      AND END_DATE <= TIMESTAMP('2019-05-09 00:00:00')
      AND BUSINESS_YEAR = 2019
  ) A
  LEFT JOIN
  (
    SELECT
      FARMER_CD,
      SUM(CNTRCT_PLNT_AREA) AS CNTRCT_PLNT_AREA
    FROM
      R_PC_CTRT_PC_Y_Y19
    WHERE DATA_STATE = '1'
    GROUP BY FARMER_CD
  ) B ON A.FARMER_CD = B.FARMER_CD
  LEFT JOIN
  R_TECHNICIAN_Y19 C
    ON A.TECHNICIAN_ID = C.TECHNICIAN_ID