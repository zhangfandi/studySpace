--DROP PROCEDURE DCCELL.P_R_PT_GROW_IMPLANT_AB_D_HLJ;
CREATE PROCEDURE DCCELL.P_R_PT_GROW_IMPLANT_AB_D_HLJ
  BEGIN
    DECLARE V_PROC_NAME VARCHAR(1000) DEFAULT 'P_R_PT_GROW_IMPLANT_AB_D_HLJ';
    DECLARE V_STEP VARCHAR(500);
    DECLARE V_PT_YEAR INTEGER DEFAULT 2019;
    DECLARE V_BILL_NO VARCHAR(64) DEFAULT 'TJ23000000000020'; --���ݱ��


    DECLARE V_CURRENTTIMESTAMP TIMESTAMP;

    DECLARE V_LOG_GROUP VARCHAR(32);
    DECLARE V_LAST_STEP VARCHAR(32);
    DECLARE V_LOG VARCHAR(32);


    SET V_CURRENTTIMESTAMP = CURRENT TIMESTAMP;
    SET V_LOG = ' ';
    SET V_LOG_GROUP = TO_CHAR(V_CURRENTTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS');

    SELECT BUSI_YEAR
    INTO V_PT_YEAR
    FROM DC_PROC_BUSI_YEAR A
    WHERE A.PROC_NAME = 'P_DC_CALL_ID_02_SC';

    SET V_STEP = '1��R_PT_GROW_IMPLANT_AB_D_HLJ-D';
    CALL P_DEBUG_LOG(V_LOG_GROUP, V_PROC_NAME, V_PROC_NAME, V_STEP, TO_CHAR(CURRENT TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
                                                                    || V_LOG);
    DELETE FROM R_PT_GROW_IMPLANT_AB_D_HLJ T
    WHERE BUSINESS_YEAR >= V_PT_YEAR;

    SET V_STEP = '2��R_PT_GROW_IMPLANT_AB_D_HLJ-I';
    CALL P_DEBUG_LOG(V_LOG_GROUP, V_PROC_NAME, V_PROC_NAME, V_STEP, TO_CHAR(CURRENT TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
                                                                    || V_LOG);
    INSERT INTO R_PT_GROW_IMPLANT_AB_D_HLJ
    (
      GROW_IMPLANT_AB_D_ID,
      BUSINESS_YEAR,
      BUSINESS_DATE,
      IMPLANT_TYPE_NAME,
      IMPLANT_TYPE,
      IMPLANT_DATE,
      LEAF_VARIETY_CD,
      LEAF_VARIETY_NAME,
      MAIN_BED_CANOPY_ID,
      MAIN_BED_CANOPY_CD,
      MAIN_BED_CANOPY_NAME,
      MAIN_BED_POINT_NAME,
      MAIN_BED_COUC_NAME,
      IMPLANT_QTY,
      GROW_POINT_ID,
      GROW_POINT_CD,
      GROW_POINT_NAME,
      GROW_TYPE_NAME,
      SERVER_ORG_NAME,
      POINT_BUILD_YEAR,
      BIG_CANOPY_ID,
      BIG_CANOPY_CD,
      BIG_CANOPY_NAME,
      CANOPY_TYPE_NAME,
      LAND_AREA,
      LONGITUDE,
      LATITUDE,
      MAIN_BED_AREA,
      SUB_BED_AREA,
      TECHNICIAN_ID,
      TECHNICIAN_NAME,
      SEND_STATE,
      DATA_STATE,
      MODIFY_TIME,
      LAST_TIME,
      ORG_CD,
      IS_COUNTRY_SUBSIDY
    )
      SELECT
        ID,
        BUSINESS_YEAR,
        BUSINESS_DATE,
        IMPLANT_TYPE_NAME,
        IMPLANT_TYPE,
        IMPLANT_DATE,
        LEAF_VARIETY_CD,
        LEAF_VARIETY_NAME,
        MAIN_BED_CANOPY_ID,
        MAIN_BED_CANOPY_CD,
        MAIN_BED_CANOPY_NAME,
        MAIN_BED_POINT_NAME,
        MAIN_BED_COUC_NAME,
        IMPLANT_QTY,
        GROW_POINT_ID,
        GROW_POINT_CD,
        GROW_POINT_NAME,
        GROW_POINT_TYPE_NAME,
        SERVER_ORG_NAME,
        POINT_BUILD_YEAR,
        BIG_CANOPY_ID,
        BIG_CANOPY_CD,
        BIG_CANOPY_NAME,
        CANOPY_TYPE_NAME,
        LAND_AREA,
        LONGITUDE,
        LATITUDE,
        MAIN_BED_AREA,
        SUB_BED_AREA,
        TECHNICAN_ID,
        TECHNICAN_NAME,
        SEND_STATE,
        DATA_STATE,
        MODIFY_TIME,
        CURRENT TIMESTAMP,
        ORG_CD,
        IS_COUNTRY_SUBSIDY
      FROM V_PT_GROW_IMPLANT_HLJ
      WHERE BUSINESS_YEAR >= V_PT_YEAR
            AND DATA_STATE = '1';
    COMMIT;

    SET V_STEP = '3��R_PT_GROW_IMPLANT_AB_D_HLJ-U';
    CALL P_DEBUG_LOG(V_LOG_GROUP, V_PROC_NAME, V_PROC_NAME, V_STEP, TO_CHAR(CURRENT TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
                                                                    || V_LOG);
    UPDATE R_PT_GROW_IMPLANT_AB_D_HLJ A
    SET TECHNICIAN_NAME = (SELECT TECHNICIAN_NAME
                           FROM R_TECHNICIAN B
                           WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
    WHERE EXISTS
          (SELECT 1
           FROM R_TECHNICIAN B
           WHERE A.TECHNICIAN_ID = B.TECHNICIAN_ID)
          AND A.BUSINESS_YEAR >= V_PT_YEAR;
    COMMIT;
    UPDATE R_PT_GROW_IMPLANT_AB_D_HLJ A
    SET A.LEAF_VARIETY_NAME = (SELECT LEAF_VARIETY_NAME
                               FROM R_LEAF_VARIETY B
                               WHERE B.LEAF_VARIETY_CD = A.LEAF_VARIETY_CD)
    WHERE A.BUSINESS_YEAR >= V_PT_YEAR
          AND A.LEAF_VARIETY_NAME IS NULL;
    COMMIT;

    CALL P_DEBUG_LOG(V_LOG_GROUP, V_PROC_NAME, V_PROC_NAME, 'ORG', TO_CHAR(CURRENT TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
                                                                   || V_LOG);
    MERGE INTO R_PT_GROW_IMPLANT_AB_D_HLJ A
    USING
      (
        SELECT
          CASE WHEN B.PROV = '0'
            THEN NULL
          ELSE B.PROV END AS PROV,
          CASE WHEN B.CITC = '0'
            THEN NULL
          ELSE B.CITC END AS CITC,
          CASE WHEN B.COUC = '0'
            THEN NULL
          ELSE B.COUC END AS COUC,
          CASE WHEN B.STAC = '0'
            THEN NULL
          ELSE B.STAC END AS STAC,
          CASE WHEN B.SSTC = '0'
            THEN NULL
          ELSE B.SSTC END AS SSTC,
          CASE WHEN B.SLIN = '0'
            THEN NULL
          ELSE B.SLIN END AS SLIN,
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
    ON (B.ORG_UNIQUE_CD = A.ORG_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND
        (A.PROV IS NULL OR A.PROV_NAME IS NULL))
    WHEN MATCHED THEN
    UPDATE SET
      A.PROV      = B.PROV,
      A.CITC      = B.CITC,
      A.COUC      = B.COUC,
      A.STAC      = B.STAC,
      A.SSTC      = B.SSTC,
      A.SLIN      = B.SLIN,
      A.PROV_NAME = B.PROV_NAME,
      A.CITC_NAME = B.CITC_NAME,
      A.COUC_NAME = B.COUC_NAME,
      A.STAC_NAME = B.STAC_NAME,
      A.SSTC_NAME = B.SSTC_NAME,
      A.SLIN_NAME = B.SLIN_NAME,
      A.ORG_NAME  = B.ORG_NAME;
    COMMIT;
    CALL P_DEBUG_LOG(V_LOG_GROUP, V_PROC_NAME, V_PROC_NAME, 'DIV', TO_CHAR(CURRENT TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
                                                                   || V_LOG);
    MERGE INTO R_PT_GROW_IMPLANT_AB_D_HLJ A
    USING
      (
        SELECT
          CASE WHEN B.AREA_PROV = '0'
            THEN NULL
          ELSE B.AREA_PROV END AS AREA_PROV,
          CASE WHEN B.AREA_CITC = '0'
            THEN NULL
          ELSE B.AREA_CITC END AS AREA_CITC,
          CASE WHEN B.AREA_COUC = '0'
            THEN NULL
          ELSE B.AREA_COUC END AS AREA_COUC,
          CASE WHEN B.AREA_TOWN = '0'
            THEN NULL
          ELSE B.AREA_TOWN END AS AREA_TOWN,
          CASE WHEN B.AREA_VAGE = '0'
            THEN NULL
          ELSE B.AREA_VAGE END AS AREA_VAGE,
          CASE WHEN B.AREA_GRUP = '0'
            THEN NULL
          ELSE B.AREA_GRUP END AS AREA_GRUP,
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
    ON (B.DIVISION_UNIQUE_CD = A.AREA_CD AND A.DATA_STATE = '1' AND A.BUSINESS_YEAR >= V_PT_YEAR AND
        (A.AREA_PROV IS NULL OR A.AREA_PROV_NAME IS NULL))
    WHEN MATCHED THEN
    UPDATE SET
      A.AREA_PROV      = B.AREA_PROV,
      A.AREA_CITC      = B.AREA_CITC,
      A.AREA_COUC      = B.AREA_COUC,
      A.AREA_TOWN      = B.AREA_TOWN,
      A.AREA_VAGE      = B.AREA_VAGE,
      A.AREA_GRUP      = B.AREA_GRUP,
      A.AREA_PROV_NAME = B.AREA_PROV_NAME,
      A.AREA_CITC_NAME = B.AREA_CITC_NAME,
      A.AREA_COUC_NAME = B.AREA_COUC_NAME,
      A.TOWN_NAME      = B.TOWN_NAME,
      A.VAGE_NAME      = B.VAGE_NAME,
      A.GRUP_NAME      = B.GRUP_NAME,
      A.AREA_NAME      = B.ORG_NAME;
    COMMIT;

  END