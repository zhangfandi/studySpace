--DROP PROCEDURE P_DC_SWITCH_05_SC;
CREATE PROCEDURE P_DC_SWITCH_05_SC
(
  IN P_YEAR DECIMAL(4) 
)
language sql
modifies sql data
------------------------------------------------------------
-- #  内容：年度切换过程
-- #  作者：zhangfd
-- #  日期：2019-04-26
------------------------------------------------------------
begin
  CALL P_PROC_BUSI_YEAR('P_DC_CALL_ID_02_SC',P_YEAR);
end
@