--DROP TABLE R_PT_GROW_IMPLANT_AB_D_HLJ;
CREATE TABLE
    R_PT_GROW_IMPLANT_AB_D_HLJ
    (
        GROW_IMPLANT_AB_D_ID VARCHAR(32) NOT NULL,      --ID
        SEND_STATE CHARACTER(1) DEFAULT '0',
        DATA_STATE CHARACTER(1) DEFAULT '1',
        MODIFY_TIME TIMESTAMP,
        SEND_TIME TIMESTAMP,
        PACKAGE_TIME TIMESTAMP,
        LAST_TIME TIMESTAMP DEFAULT CURRENT TIMESTAMP,
        BUSINESS_YEAR DECIMAL(4,0),
        BUSINESS_DATE TIMESTAMP,                        --采集日期
        IMPLANT_DATE TIMESTAMP,                         --假植日期
        IMPLANT_TYPE VARCHAR(32),                       --统一假植类型代码
        IMPLANT_TYPE_NAME VARCHAR(64),                  --统一假植类型名称
        CANOPY_TYPE VARCHAR(32),
        CANOPY_TYPE_NAME VARCHAR(64),                   --育苗棚设施类型名称
        GROW_TYPE VARCHAR(32),
        GROW_TYPE_NAME VARCHAR(64),                     --育苗点设施类型名称
        SERVER_ORG_NAME VARCHAR(64),                    --育苗点设施所属单位名称
        GROW_PLATE_TYPE VARCHAR(32),
        SUPPLY_STANDARD_EK VARCHAR(32),
        LEAF_VARIETY_CD VARCHAR(32),                    --烟叶品种代码
        LEAF_VARIETY_NAME VARCHAR(64),                  --烟叶品种名称
        GROW_PLATE_QTY DECIMAL(12,0),
        GROW_QTY DECIMAL(12,0),
        MACHINE_GROW_QTY DECIMAL(12,0),
        TRANSPLANT_AREA DECIMAL(24,6) DEFAULT 0,
        ORG_CD VARCHAR(32) DEFAULT '0',
        ORG_NAME VARCHAR(128),
        PROV VARCHAR(32) DEFAULT '0',
        PROV_NAME VARCHAR(128),
        CITC VARCHAR(32) DEFAULT '0',
        CITC_NAME VARCHAR(128),
        COUC VARCHAR(32) DEFAULT '0',
        COUC_NAME VARCHAR(128),
        STAC VARCHAR(32) DEFAULT '0',
        STAC_NAME VARCHAR(128),
        SSTC VARCHAR(32) DEFAULT '0',
        SSTC_NAME VARCHAR(128),
        SLIN VARCHAR(32) DEFAULT '0',
        SLIN_NAME VARCHAR(128),
        AREA_CD VARCHAR(32),
        AREA_NAME VARCHAR(128),
        AREA_PROV VARCHAR(32),
        AREA_PROV_NAME VARCHAR(128),
        AREA_CITC VARCHAR(32),
        AREA_CITC_NAME VARCHAR(128),
        AREA_COUC VARCHAR(32),
        AREA_COUC_NAME VARCHAR(128),
        AREA_TOWN VARCHAR(32),
        TOWN_NAME VARCHAR(128),
        AREA_VAGE VARCHAR(32),
        VAGE_NAME VARCHAR(128),
        AREA_GRUP VARCHAR(32),
        GRUP_NAME VARCHAR(128),
        GROW_POINT_ID VARCHAR(32),                      --育苗点ID
        GROW_POINT_CD VARCHAR(32),                      --育苗点编号
        GROW_POINT_NAME VARCHAR(64),                    --育苗点名称
        GROW_CANOPY_ID VARCHAR(32),
        GROW_CANOPY_CD VARCHAR(32),
        GROW_CANOPY_NAME VARCHAR(64),
        BIG_CANOPY_ID VARCHAR(32),                      --育苗棚ID
        BIG_CANOPY_CD VARCHAR(32),                      --育苗棚编号
        BIG_CANOPY_NAME VARCHAR(64),                    --育苗棚名称
        TECHNICIAN_ID VARCHAR(32),                      --烟技员ID
        TECHNICIAN_NAME VARCHAR(64),                    --烟技员名称
        LEAF_GUIDER_ID VARCHAR(32),
        CNTY VARCHAR(32) DEFAULT '0',
        CNTY_NAME VARCHAR(128),
        CNTY_UNIQUE VARCHAR(32) DEFAULT '0',
        PROV_UNIQUE VARCHAR(32) DEFAULT '0',
        CITC_UNIQUE VARCHAR(32) DEFAULT '0',
        COUC_UNIQUE VARCHAR(32) DEFAULT '0',
        STAC_UNIQUE VARCHAR(32) DEFAULT '0',
        SSTC_UNIQUE VARCHAR(32) DEFAULT '0',
        SLIN_UNIQUE VARCHAR(32) DEFAULT '0',
        AREA_CNTY VARCHAR(32) DEFAULT '0',
        AREA_CNTY_NAME VARCHAR(128),
        POINT_BUILD_YEAR VARCHAR(4),                    --育苗点建设年度
        MAIN_BED_AREA DECIMAL(24,6),                    --育苗棚 母床面积
        SUB_BED_AREA DECIMAL(24,6),                     --育苗棚 子床面积
        IMPLANT_QTY DECIMAL(24,6),                      --假植株数
        MAIN_BED_CANOPY_ID VARCHAR(32),                 --母床大棚ID
        MAIN_BED_CANOPY_CD VARCHAR(32),                 --母床大棚编号
        MAIN_BED_CANOPY_NAME VARCHAR(64),               --母床大棚名称
        MAIN_BED_POINT_NAME VARCHAR(32),                --母床育苗点名称
        MAIN_BED_COUC_NAME VARCHAR(32),                 --母床分公司名称
        IS_COUNTRY_SUBSIDY VARCHAR(4),                  --育苗棚 是否国补
        LAND_AREA DECIMAL(24,6),                        --育苗棚 占地面积
        LONGITUDE DECIMAL(24,6),                        --育苗棚经度
        LATITUDE DECIMAL(24,6),                         --育苗棚纬度
        CONSTRAINT PK_R_PT_GROW_IMPLANT_AB_D PRIMARY KEY (GROW_IMPLANT_AB_D_ID)
    );