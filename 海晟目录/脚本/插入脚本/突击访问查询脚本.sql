--1
SELECT * FROM pt_wc_task_assign_mas where data_state='1' and TASK_ASSIGN_MAS_ID like 'zhangfd0%';
SELECT * FROM pt_wc_bill_set_mas where data_state='1' and BILL_SET_MAS_ID like 'zhangfd0%';
SELECT * FROM pt_ds_bill_set_mas where data_state='1' and BILL_SET_MAS_ID like 'zhangfd0%';
SELECT IDX_ID FROM Pt_Ix_Idx WHERE PARENT_ID='8a3c3453692934c601692f11d0aa0064' AND DATA_STATE='1' AND ISSUE_STATE='1';
SELECT * FROM pt_dc_stat_data_z where data_state='1' and DATA_STORE_BASE_TBL_ID like 'zhangfd0%';
SELECT * FROM pt_wc_stat_data_a where data_state='1' and DATA_STORE_BASE_TBL_ID like 'zhangfd0%';
SELECT * FROM VIEW_PT_AS_TLG_FARMER where FRM_FUND_UNIQUE_ID in ('4203230265000209','4203230265000210','4203230265000211');

--2
SELECT * FROM pt_wc_task_assign_mas where data_state='1' and TASK_ASSIGN_MAS_ID like 'zhangfd0%';
SELECT * FROM pt_wc_bill_set_mas where data_state='1' and BILL_SET_MAS_ID like 'zhangfd0%';
SELECT IDX_ID FROM Pt_Ix_Idx WHERE PARENT_ID='8a3c3453692934c601692f11d0aa0064' AND DATA_STATE='1' AND ISSUE_STATE='1';
SELECT * FROM pt_wc_stat_data_a where data_state='1' and DATA_STORE_BASE_TBL_ID like 'zhangfd0%';
SELECT * FROM PT_AS_PUBLISH_OBJ_RELA WHERE DATA_STATE='1' AND PUBLISH_OBJ_TYPE_EK='ORG' AND PUBLISH_OBJ_RELA_ID like 'zhangfd0%';

--3
SELECT * FROM pt_wc_task_assign_mas where data_state='1' and TASK_ASSIGN_MAS_ID like 'zhangfd0%';
SELECT * FROM pt_wc_bill_set_mas where data_state='1' and BILL_SET_MAS_ID like 'zhangfd0%';
SELECT * FROM pt_ds_bill_set_mas where data_state='1' and BILL_SET_MAS_ID like 'zhangfd0%';
SELECT * FROM PT_WC_BILL_TBL_BODY_SET where data_state='1' and BILL_TBL_BODY_SET_ID like 'zhangfd0%';
SELECT * FROM PT_DS_BILL_TBL_BODY_SET where data_state='1' and BILL_TBL_BODY_SET_ID like 'zhangfd0%';

SELECT * FROM CM_OM_DIVISION WHERE DIVISION_NAME='Á¬³ÇÏØ';
SELECT * FROM CM_OM_ORG_MAIN WHERE ORG_CD='352627';


SELECT * FROM pt_dc_stat_data_z WHERE X_DIVISION_UNIQUE_CD='3508000000000006'


