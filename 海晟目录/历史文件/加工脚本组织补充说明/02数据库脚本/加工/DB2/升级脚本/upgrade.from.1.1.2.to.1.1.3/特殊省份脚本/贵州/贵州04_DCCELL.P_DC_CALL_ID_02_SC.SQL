--DROP PROCEDURE DCCELL.P_DC_CALL_ID_02_SC;
CREATE PROCEDURE DCCELL.P_DC_CALL_ID_02_SC
------------------------------------------------------------
-- #  内容：调用汇总
-- #  作者：郑瑞坤
--          linds  增异常处理 
-- #  日期：2016-12-1
------------------------------------------------------------
BEGIN
  DECLARE V_JOB_CODE    VARCHAR(32);
  DECLARE V_ITEM_CODE   VARCHAR(32);
  DECLARE V_ITEM_NAME   VARCHAR(32);
  DECLARE V_RESULT_TYPE CHAR(1);
  DECLARE V_RESULT_DESC VARCHAR(1024);
  DECLARE V_TIME_BEGIN  TIMESTAMP;
  DECLARE V_TIME_END    TIMESTAMP;

  DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
  DECLARE L_SQLSTATE CHAR(5) DEFAULT '00000';
  DECLARE SQLCODE INTEGER DEFAULT 0;
  DECLARE L_SQLCODE INTEGER DEFAULT 0; 

  DECLARE ERR_1 INTEGER DEFAULT 0; 
  DECLARE ERR_2 INTEGER DEFAULT 0; 


  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
   VALUES (SQLSTATE, SQLCODE) INTO L_SQLSTATE, L_SQLCODE;
   SET V_RESULT_TYPE = '0';
   SET V_RESULT_DESC = '执行失败,'||'停止在过程：'||V_ITEM_CODE||',错误代码'|| L_SQLSTATE;
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   COMMIT;
   IF ERR_2 = 1 AND ERR_1 = 1 THEN
     RESIGNAL;
   ELSE 
     IF ERR_2 = 0 THEN
       SET ERR_1 = 1;
     END IF;
   END IF;
  END;

  BEGIN

   SET V_JOB_CODE    = 'P_DC_CALL_ID_02_SC';

   SET V_ITEM_CODE   = 'P_GROW_POINT';
   SET V_ITEM_NAME   = '育苗点加工过程';
   SET V_TIME_BEGIN  = current timestamp;
   call P_GROW_POINT();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_BIG_CANOPY';
   SET V_ITEM_NAME   = '育苗棚';
   SET V_TIME_BEGIN  = current timestamp;
   call P_BIG_CANOPY();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_TECHNICIAN';
   SET V_ITEM_NAME   = '烟技员加工过程';
   SET V_TIME_BEGIN  = current timestamp;
   call P_TECHNICIAN();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_R_PT_PLOUGH_FM_D';
   SET V_ITEM_NAME   = '翻耕过程';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_PLOUGH_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_PREPAR_FM_D';
   SET V_ITEM_NAME   = '起垄';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_PREPAR_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_VELUM_FM_D';
   SET V_ITEM_NAME   = '盖膜';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_VELUM_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_GROW_AB_D';
   SET V_ITEM_NAME   = '育苗';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_GROW_AB_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_FOR_SEED_FM_Y';
   SET V_ITEM_NAME   = '供苗（种植主体）';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_FOR_SEED_FM_Y();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_TRANSPLANT_FM_D';
   SET V_ITEM_NAME   = '移栽';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_TRANSPLANT_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_MQGL_NOW_AB_D';
   SET V_ITEM_NAME   = '苗期管理';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_MQGL_NOW_AB_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_FOR_SEED_AB_D';
   SET V_ITEM_NAME   = '供苗(育苗点)';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_FOR_SEED_AB_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_FILM_RECY_FM_D';
   SET V_ITEM_NAME   = '地膜回收';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_FILM_RECY_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_DT_FM_D';
   SET V_ITEM_NAME   = '田间卫生';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_DT_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_YY_GROW_FM_D';
   SET V_ITEM_NAME   = '田间长势';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_YY_GROW_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   SET V_ITEM_CODE   = 'P_R_PT_CALAMITY_FM_D';
   SET V_ITEM_NAME   = '灾害信息';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_CALAMITY_FM_D();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   SET V_ITEM_CODE   = 'P_R_PT_INDEMNIFY_FM_Y';
   SET V_ITEM_NAME   = '定损理赔情况信息';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_INDEMNIFY_FM_Y();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   -----------------------------------------------------
   --XUYL 加工黔西南通过莱易接口加工过来的生产数据
   -----------------------------------------------------
   
   SET V_ITEM_CODE   = 'P_R_PT_SC_QXN';
   SET V_ITEM_NAME   = '黔西南莱易数据加工';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_SC_QXN();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);
   
   
   SET V_ITEM_CODE   = 'P_PT_STP_SURVEY_STAT';
   SET V_ITEM_NAME   = 'STP调查指标数据加工';
   SET V_TIME_BEGIN  = current timestamp;
   call P_R_PT_SC_QXN();
   SET V_RESULT_TYPE = '1';
   SET V_RESULT_DESC = '执行成功';
   SET V_TIME_END    = current timestamp;
   call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);   

   -----------------------------------------------------
   --LINGM 已合并至P_R_PT_FOR_SEED_FM_Y中
   -----------------------------------------------------
   --SET V_ITEM_CODE   = 'P_R_PT_TR_FOR_SEED_FM_Y';
   --SET V_ITEM_NAME   = '铜仁地区供苗（种植主体）';
   --SET V_TIME_BEGIN  = current timestamp;
   --call P_R_PT_TR_FOR_SEED_FM_Y();
   --SET V_RESULT_TYPE = '1';
   --SET V_RESULT_DESC = '执行成功';
   --SET V_TIME_END    = current timestamp;
   --call P_DC_LOG(V_JOB_CODE,V_ITEM_CODE,V_ITEM_NAME,V_RESULT_TYPE,V_RESULT_DESC,V_TIME_BEGIN,V_TIME_END);

   --
   SET ERR_2 = 1;
   --
   IF ERR_1 = 1 THEN
      SIGNAL  SQLSTATE '22375' SET MESSAGE_TEXT = V_ITEM_NAME;
   END IF;

  END;  
END
@