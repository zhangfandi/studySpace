-- 触发器
-----------------------
-- 1)、下面的触发器在更新表tb_emp之前触发，目的是不允许在周末修改表：
create or replace trigger auth_secure before insert or update or DELETE
on tb_emp
begin
  IF(to_char(sysdate,'DY')='星期日') THEN
    RAISE_APPLICATION_ERROR(-20600,'不能在周末修改表tb_emp');
  END IF;
END;
-- 2)、使用触发器实现序号自增
-- 1.建测试表
create table tab_user(
  id number(11) primary key,
  username varchar(50),
  password varchar(50)
);
-- 2.建序列
create sequence my_seq increment by 1 start with 1nomaxvalue nocycle cache 20;
-- 3.建触发器
CREATE OR REPLACE TRIGGER MY_TGR
 BEFORE INSERT ON TAB_USER
 FOR EACH ROW--对表的每一行触发器执行一次
DECLARE
 NEXT_ID NUMBER;
BEGIN
 SELECT MY_SEQ.NEXTVAL INTO NEXT_ID FROM DUAL;
 :NEW.ID := NEXT_ID; --:NEW表示新插入的那条记录
END;
-- 插入测试
insert into tab_user(username,password) values('admin','admin');
insert into tab_user(username,password) values('fgz','fgz');
insert into tab_user(username,password) values('test','test');
COMMIT;
--------------------
-- 3)、当用户对test表执行DML语句时，将相关信息记录到日志表
-- 1.创建测试表
CREATE TABLE test(
  t_id  NUMBER(4),
  t_name VARCHAR2(20),
  t_age NUMBER(2),
  t_sex CHAR
);
-- 2.创建记录测试表
CREATE TABLE test_log(
  l_user  VARCHAR2(15),
  l_type  VARCHAR2(15),
  l_date  VARCHAR2(30)
);
-- 3.创建触发器
CREATE OR REPLACE TRIGGER TEST_TRIGGER
 AFTER DELETE OR INSERT OR UPDATE ON TEST
DECLARE
 V_TYPE TEST_LOG.L_TYPE%TYPE;
BEGIN
 IF INSERTING THEN
  --INSERT触发
  V_TYPE := 'INSERT';
  DBMS_OUTPUT.PUT_LINE('记录已经成功插入，并已记录到日志');
 ELSIF UPDATING THEN
V_TYPE := 'UPDATE';
  DBMS_OUTPUT.PUT_LINE('记录已经成功更新，并已记录到日志');
 ELSIF DELETING THEN
  --DELETE触发
  V_TYPE := 'DELETE';
  DBMS_OUTPUT.PUT_LINE('记录已经成功删除，并已记录到日志');
 END IF;
 INSERT INTO TEST_LOG
 VALUES
  (USER, V_TYPE, TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss')); --USER表示当前用户名
END;
-- 4.下面我们来分别执行DML语句
INSERT INTO test VALUES(101,'zhao',22,'M');
UPDATE test SET t_age = 30 WHERE t_id = 101;
DELETE test WHERE t_id = 101;
-- 5.然后查看效果
SELECT * FROM test;
SELECT * FROM test_log;
------------------------------
-- 4)、创建触发器，它将映射emp表中每个部门的总人数和总工资
-- 1.创建映射表
CREATE TABLE dept_sal AS
SELECT deptno, COUNT(empno) total_emp, SUM(sal) total_sal
FROM scott.emp
GROUP BY deptno;
-- 2.创建触发器
CREATE OR REPLACE TRIGGER EMP_INFO
 AFTER INSERT OR UPDATE OR DELETE ON scott.EMP
DECLARE
 CURSOR CUR_EMP IS
  SELECT DEPTNO, COUNT(EMPNO) AS TOTAL_EMP, SUM(SAL) AS TOTAL_SAL FROM scott.EMP GROUP BY DEPTNO;
BEGIN
 DELETE DEPT_SAL; --触发时首先删除映射表信息
 FOR V_EMP IN CUR_EMP LOOP
  DBMS_OUTPUT.PUT_LINE(v_emp.deptno || '  ' || v_emp.total_emp || '  ' || v_emp.total_sal);
  --插入数据
  INSERT INTO DEPT_SAL
  VALUES
   (V_EMP.DEPTNO, V_EMP.TOTAL_EMP, V_EMP.TOTAL_SAL);
 END LOOP;
END;
-- 3.对emp表进行DML操作
INSERT INTO emp(empno,deptno,sal) VALUES('123','10',10000);
SELECT * FROM dept_sal;
DELETE EMP WHERE empno=123;
SELECT * FROM dept_sal;
-----------------------
-- 5)、创建触发器，用来记录表的删除数据
-- 1.创建表
CREATE TABLE employee(
  id  VARCHAR2(4) NOT NULL,
  name VARCHAR2(15) NOT NULL,
  age NUMBER(2)  NOT NULL,
  sex CHAR NOT NULL
);
-- 2.插入数据
INSERT INTO employee VALUES('e101','zhao',23,'M');
INSERT INTO employee VALUES('e102','jian',21,'F');
-- 3.创建记录表(包含数据记录)
CREATE TABLE old_employee AS SELECT * FROM employee;
-- 4.创建触发器
CREATE OR REPLACE TRIGGER TIG_OLD_EMP
 AFTER DELETE ON EMPLOYEE
 FOR EACH ROW --语句级触发，即每一行触发一次
BEGIN
 INSERT INTO OLD_EMPLOYEE VALUES (:OLD.ID, :OLD.NAME, :OLD.AGE, :OLD.SEX); --:old代表旧值
END;
-- 5.下面进行测试
DELETE employee;
SELECT * FROM old_employee;
------------------------
-- 6)、创建触发器，利用视图插入数据
-- 1.创建表
CREATE TABLE tab1 (tid NUMBER(4) PRIMARY KEY,tname VARCHAR2(20),tage NUMBER(2));
CREATE TABLE tab2 (tid NUMBER(4),ttel VARCHAR2(15),tadr VARCHAR2(30));
-- 2.插入数据
INSERT INTO tab1 VALUES(101,'zhao',22);
INSERT INTO tab1 VALUES(102,'yang',20);
INSERT INTO tab2 VALUES(101,'13761512841','AnHuiSuZhou');
INSERT INTO tab2 VALUES(102,'13563258514','AnHuiSuZhou');
-- 3.创建视图连接两张表
CREATE OR REPLACE VIEW tab_view AS SELECT tab1.tid,tname,ttel,tadr FROM tab1,tab2 WHERE tab1.tid = tab2.tid;
-- 4.创建触发器
CREATE OR REPLACE TRIGGER TAB_TRIGGER
 INSTEAD OF INSERT ON TAB_VIEW
BEGIN
 INSERT INTO TAB1 (TID, TNAME) VALUES (:NEW.TID, :NEW.TNAME);
 INSERT INTO TAB2 (TTEL, TADR) VALUES (:NEW.TTEL, :NEW.TADR);
END;
-- 5.现在就可以利用视图插入数据
INSERT INTO tab_view VALUES(106,'ljq','13886681288','beijing');
-- 6.查询
SELECT * FROM tab_view;
SELECT * FROM tab1;
SELECT * FROM tab2;
----------------------------------
-- 7)、创建触发器，比较emp表中更新的工资
-- 1.创建触发器
set serveroutput on; -- 这句要在command window中运行
CREATE OR REPLACE TRIGGER SAL_EMP
 BEFORE UPDATE ON EMP
 FOR EACH ROW
BEGIN
 IF :OLD.SAL > :NEW.SAL THEN
  DBMS_OUTPUT.PUT_LINE('工资减少');
 ELSIF :OLD.SAL < :NEW.SAL THEN
  DBMS_OUTPUT.PUT_LINE('工资增加');
 ELSE
  DBMS_OUTPUT.PUT_LINE('工资未作任何变动');
 END IF;
 DBMS_OUTPUT.PUT_LINE('更新前工资 ：' || :OLD.SAL);
 DBMS_OUTPUT.PUT_LINE('更新后工资 ：' || :NEW.SAL);
END;
-- 2.执行UPDATE查看效果
UPDATE emp SET sal = 3000 WHERE empno = '7788';
--------------------------------
-- 8)、创建触发器，将操作CREATE、DROP存储在log_info表
-- 1.创建表
CREATE TABLE log_info(
  manager_user VARCHAR2(15),
  manager_date VARCHAR2(15),
  manager_type VARCHAR2(15),
  obj_name   VARCHAR2(15),
  obj_type   VARCHAR2(15)
);
-- 2.创建触发器
set serveroutput on;
CREATE OR REPLACE TRIGGER TRIG_LOG_INFO
 AFTER CREATE OR DROP ON SCHEMA
BEGIN
 INSERT INTO LOG_INFO
 VALUES
  (USER,
   SYSDATE,
   SYS.DICTIONARY_OBJ_NAME,
   SYS.DICTIONARY_OBJ_OWNER,
   SYS.DICTIONARY_OBJ_TYPE);
END;
-- 3.测试语句
CREATE TABLE a(id NUMBER);
CREATE TYPE aa AS OBJECT(id NUMBER);
DROP TABLE a;
DROP TYPE aa;
-- 4.查看效果
SELECT * FROM log_info;
-- 5.相关数据字典-----------------------------------------------------
SELECT * FROM USER_TRIGGERS;
-- 6.必须以DBA身份登陆才能使用此数据字典
SELECT * FROM ALL_TRIGGERS;
SELECT * FROM DBA_TRIGGERS;
-- 7.启用和禁用
ALTER TRIGGER trigger_name DISABLE;
ALTER TRIGGER trigger_name ENABLE;

