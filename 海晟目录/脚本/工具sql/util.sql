-- �������ID��sql
select * from (SELECT rownumber()over() as r,HEX(rand())||HEX(rand()) as id FROM B_ORG) 
where r <=6;
--���������ֵ��sql
select * from (SELECT rownumber()over() as r,cast(rand()*100 as decimal(8,0)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)),cast(rand()*100 as decimal(8,3)) from b_org) 
where r <=6;
--����
select distinct DATA_STORE_BASE_TBL_ID, feedback_date from PT_DC_STAT_DATA_B where feedback_date>'2019-1-1 00:00:00' and feedback_date <'2019-12-31 00:00:00';
--�������01
select cast(rand()*2 as decimal(8,0))
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
,cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)),cast(rand()*2 as decimal(8,0)) 
from b_org;