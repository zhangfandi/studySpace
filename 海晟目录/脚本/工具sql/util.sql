-- 生成随机ID的sql
select * from (SELECT rownumber()over() as r,HEX(rand())||HEX(rand()) as id FROM B_ORG) 
where r <=6;
--生成随机数值的sql
select * from (SELECT rownumber()over() as r,cast(rand()*100 as decimal(8,0)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)) from b_org) 
where r <=6;
--日期
select distinct DATA_STORE_BASE_TBL_ID, feedback_date from PT_DC_STAT_DATA_B where feedback_date>'2019-1-1 00:00:00' and feedback_date <'2019-12-31 00:00:00';
--随机生成01
select cast(rand()*2 as decimal(8,0))
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
from b_org;