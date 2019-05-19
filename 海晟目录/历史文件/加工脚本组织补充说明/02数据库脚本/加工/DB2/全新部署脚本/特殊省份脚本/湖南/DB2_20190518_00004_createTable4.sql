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
        BUSINESS_DATE TIMESTAMP,                        --�ɼ�����
        IMPLANT_DATE TIMESTAMP,                         --��ֲ����
        IMPLANT_TYPE VARCHAR(32),                       --ͳһ��ֲ���ʹ���
        IMPLANT_TYPE_NAME VARCHAR(64),                  --ͳһ��ֲ��������
        CANOPY_TYPE VARCHAR(32),
        CANOPY_TYPE_NAME VARCHAR(64),                   --��������ʩ��������
        GROW_TYPE VARCHAR(32),
        GROW_TYPE_NAME VARCHAR(64),                     --�������ʩ��������
        SERVER_ORG_NAME VARCHAR(64),                    --�������ʩ������λ����
        GROW_PLATE_TYPE VARCHAR(32),
        SUPPLY_STANDARD_EK VARCHAR(32),
        LEAF_VARIETY_CD VARCHAR(32),                    --��ҶƷ�ִ���
        LEAF_VARIETY_NAME VARCHAR(64),                  --��ҶƷ������
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
        GROW_POINT_ID VARCHAR(32),                      --�����ID
        GROW_POINT_CD VARCHAR(32),                      --�������
        GROW_POINT_NAME VARCHAR(64),                    --���������
        GROW_CANOPY_ID VARCHAR(32),
        GROW_CANOPY_CD VARCHAR(32),
        GROW_CANOPY_NAME VARCHAR(64),
        BIG_CANOPY_ID VARCHAR(32),                      --������ID
        BIG_CANOPY_CD VARCHAR(32),                      --��������
        BIG_CANOPY_NAME VARCHAR(64),                    --����������
        TECHNICIAN_ID VARCHAR(32),                      --�̼�ԱID
        TECHNICIAN_NAME VARCHAR(64),                    --�̼�Ա����
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
        POINT_BUILD_YEAR VARCHAR(4),                    --����㽨�����
        MAIN_BED_AREA DECIMAL(24,6),                    --������ ĸ�����
        SUB_BED_AREA DECIMAL(24,6),                     --������ �Ӵ����
        IMPLANT_QTY DECIMAL(24,6),                      --��ֲ����
        MAIN_BED_CANOPY_ID VARCHAR(32),                 --ĸ������ID
        MAIN_BED_CANOPY_CD VARCHAR(32),                 --ĸ��������
        MAIN_BED_CANOPY_NAME VARCHAR(64),               --ĸ����������
        MAIN_BED_POINT_NAME VARCHAR(32),                --ĸ�����������
        MAIN_BED_COUC_NAME VARCHAR(32),                 --ĸ���ֹ�˾����
        IS_COUNTRY_SUBSIDY VARCHAR(4),                  --������ �Ƿ����
        LAND_AREA DECIMAL(24,6),                        --������ ռ�����
        LONGITUDE DECIMAL(24,6),                        --�����ﾭ��
        LATITUDE DECIMAL(24,6),                         --������γ��
        CONSTRAINT PK_R_PT_GROW_IMPLANT_AB_D PRIMARY KEY (GROW_IMPLANT_AB_D_ID)
    );