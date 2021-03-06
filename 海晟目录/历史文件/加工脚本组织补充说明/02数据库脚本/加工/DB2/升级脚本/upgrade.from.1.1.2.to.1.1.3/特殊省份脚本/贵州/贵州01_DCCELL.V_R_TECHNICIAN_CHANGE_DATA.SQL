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