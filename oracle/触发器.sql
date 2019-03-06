-- ������
-----------------------
-- 1)������Ĵ������ڸ��±�tb_emp֮ǰ������Ŀ���ǲ���������ĩ�޸ı�
create or replace trigger auth_secure before insert or update or DELETE
on tb_emp
begin
  IF(to_char(sysdate,'DY')='������') THEN
    RAISE_APPLICATION_ERROR(-20600,'��������ĩ�޸ı�tb_emp');
  END IF;
END;
-- 2)��ʹ�ô�����ʵ���������
-- 1.�����Ա�
create table tab_user(
  id number(11) primary key,
  username varchar(50),
  password varchar(50)
);
-- 2.������
create sequence my_seq increment by 1 start with 1nomaxvalue nocycle cache 20;
-- 3.��������
CREATE OR REPLACE TRIGGER MY_TGR
 BEFORE INSERT ON TAB_USER
 FOR EACH ROW--�Ա��ÿһ�д�����ִ��һ��
DECLARE
 NEXT_ID NUMBER;
BEGIN
 SELECT MY_SEQ.NEXTVAL INTO NEXT_ID FROM DUAL;
 :NEW.ID := NEXT_ID; --:NEW��ʾ�²����������¼
END;
-- �������
insert into tab_user(username,password) values('admin','admin');
insert into tab_user(username,password) values('fgz','fgz');
insert into tab_user(username,password) values('test','test');
COMMIT;
--------------------
-- 3)�����û���test��ִ��DML���ʱ���������Ϣ��¼����־��
-- 1.�������Ա�
CREATE TABLE test(
  t_id  NUMBER(4),
  t_name VARCHAR2(20),
  t_age NUMBER(2),
  t_sex CHAR
);
-- 2.������¼���Ա�
CREATE TABLE test_log(
  l_user  VARCHAR2(15),
  l_type  VARCHAR2(15),
  l_date  VARCHAR2(30)
);
-- 3.����������
CREATE OR REPLACE TRIGGER TEST_TRIGGER
 AFTER DELETE OR INSERT OR UPDATE ON TEST
DECLARE
 V_TYPE TEST_LOG.L_TYPE%TYPE;
BEGIN
 IF INSERTING THEN
  --INSERT����
  V_TYPE := 'INSERT';
  DBMS_OUTPUT.PUT_LINE('��¼�Ѿ��ɹ����룬���Ѽ�¼����־');
 ELSIF UPDATING THEN
V_TYPE := 'UPDATE';
  DBMS_OUTPUT.PUT_LINE('��¼�Ѿ��ɹ����£����Ѽ�¼����־');
 ELSIF DELETING THEN
  --DELETE����
  V_TYPE := 'DELETE';
  DBMS_OUTPUT.PUT_LINE('��¼�Ѿ��ɹ�ɾ�������Ѽ�¼����־');
 END IF;
 INSERT INTO TEST_LOG
 VALUES
  (USER, V_TYPE, TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss')); --USER��ʾ��ǰ�û���
END;
-- 4.�����������ֱ�ִ��DML���
INSERT INTO test VALUES(101,'zhao',22,'M');
UPDATE test SET t_age = 30 WHERE t_id = 101;
DELETE test WHERE t_id = 101;
-- 5.Ȼ��鿴Ч��
SELECT * FROM test;
SELECT * FROM test_log;
------------------------------
-- 4)������������������ӳ��emp����ÿ�����ŵ����������ܹ���
-- 1.����ӳ���
CREATE TABLE dept_sal AS
SELECT deptno, COUNT(empno) total_emp, SUM(sal) total_sal
FROM scott.emp
GROUP BY deptno;
-- 2.����������
CREATE OR REPLACE TRIGGER EMP_INFO
 AFTER INSERT OR UPDATE OR DELETE ON scott.EMP
DECLARE
 CURSOR CUR_EMP IS
  SELECT DEPTNO, COUNT(EMPNO) AS TOTAL_EMP, SUM(SAL) AS TOTAL_SAL FROM scott.EMP GROUP BY DEPTNO;
BEGIN
 DELETE DEPT_SAL; --����ʱ����ɾ��ӳ�����Ϣ
 FOR V_EMP IN CUR_EMP LOOP
  DBMS_OUTPUT.PUT_LINE(v_emp.deptno || '  ' || v_emp.total_emp || '  ' || v_emp.total_sal);
  --��������
  INSERT INTO DEPT_SAL
  VALUES
   (V_EMP.DEPTNO, V_EMP.TOTAL_EMP, V_EMP.TOTAL_SAL);
 END LOOP;
END;
-- 3.��emp�����DML����
INSERT INTO emp(empno,deptno,sal) VALUES('123','10',10000);
SELECT * FROM dept_sal;
DELETE EMP WHERE empno=123;
SELECT * FROM dept_sal;
-----------------------
-- 5)��������������������¼���ɾ������
-- 1.������
CREATE TABLE employee(
  id  VARCHAR2(4) NOT NULL,
  name VARCHAR2(15) NOT NULL,
  age NUMBER(2)  NOT NULL,
  sex CHAR NOT NULL
);
-- 2.��������
INSERT INTO employee VALUES('e101','zhao',23,'M');
INSERT INTO employee VALUES('e102','jian',21,'F');
-- 3.������¼��(�������ݼ�¼)
CREATE TABLE old_employee AS SELECT * FROM employee;
-- 4.����������
CREATE OR REPLACE TRIGGER TIG_OLD_EMP
 AFTER DELETE ON EMPLOYEE
 FOR EACH ROW --��伶��������ÿһ�д���һ��
BEGIN
 INSERT INTO OLD_EMPLOYEE VALUES (:OLD.ID, :OLD.NAME, :OLD.AGE, :OLD.SEX); --:old�����ֵ
END;
-- 5.������в���
DELETE employee;
SELECT * FROM old_employee;
------------------------
-- 6)��������������������ͼ��������
-- 1.������
CREATE TABLE tab1 (tid NUMBER(4) PRIMARY KEY,tname VARCHAR2(20),tage NUMBER(2));
CREATE TABLE tab2 (tid NUMBER(4),ttel VARCHAR2(15),tadr VARCHAR2(30));
-- 2.��������
INSERT INTO tab1 VALUES(101,'zhao',22);
INSERT INTO tab1 VALUES(102,'yang',20);
INSERT INTO tab2 VALUES(101,'13761512841','AnHuiSuZhou');
INSERT INTO tab2 VALUES(102,'13563258514','AnHuiSuZhou');
-- 3.������ͼ�������ű�
CREATE OR REPLACE VIEW tab_view AS SELECT tab1.tid,tname,ttel,tadr FROM tab1,tab2 WHERE tab1.tid = tab2.tid;
-- 4.����������
CREATE OR REPLACE TRIGGER TAB_TRIGGER
 INSTEAD OF INSERT ON TAB_VIEW
BEGIN
 INSERT INTO TAB1 (TID, TNAME) VALUES (:NEW.TID, :NEW.TNAME);
 INSERT INTO TAB2 (TTEL, TADR) VALUES (:NEW.TTEL, :NEW.TADR);
END;
-- 5.���ھͿ���������ͼ��������
INSERT INTO tab_view VALUES(106,'ljq','13886681288','beijing');
-- 6.��ѯ
SELECT * FROM tab_view;
SELECT * FROM tab1;
SELECT * FROM tab2;
----------------------------------
-- 7)���������������Ƚ�emp���и��µĹ���
-- 1.����������
set serveroutput on; -- ���Ҫ��command window������
CREATE OR REPLACE TRIGGER SAL_EMP
 BEFORE UPDATE ON EMP
 FOR EACH ROW
BEGIN
 IF :OLD.SAL > :NEW.SAL THEN
  DBMS_OUTPUT.PUT_LINE('���ʼ���');
 ELSIF :OLD.SAL < :NEW.SAL THEN
  DBMS_OUTPUT.PUT_LINE('��������');
 ELSE
  DBMS_OUTPUT.PUT_LINE('����δ���κα䶯');
 END IF;
 DBMS_OUTPUT.PUT_LINE('����ǰ���� ��' || :OLD.SAL);
 DBMS_OUTPUT.PUT_LINE('���º��� ��' || :NEW.SAL);
END;
-- 2.ִ��UPDATE�鿴Ч��
UPDATE emp SET sal = 3000 WHERE empno = '7788';
--------------------------------
-- 8)��������������������CREATE��DROP�洢��log_info��
-- 1.������
CREATE TABLE log_info(
  manager_user VARCHAR2(15),
  manager_date VARCHAR2(15),
  manager_type VARCHAR2(15),
  obj_name   VARCHAR2(15),
  obj_type   VARCHAR2(15)
);
-- 2.����������
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
-- 3.�������
CREATE TABLE a(id NUMBER);
CREATE TYPE aa AS OBJECT(id NUMBER);
DROP TABLE a;
DROP TYPE aa;
-- 4.�鿴Ч��
SELECT * FROM log_info;
-- 5.��������ֵ�-----------------------------------------------------
SELECT * FROM USER_TRIGGERS;
-- 6.������DBA��ݵ�½����ʹ�ô������ֵ�
SELECT * FROM ALL_TRIGGERS;
SELECT * FROM DBA_TRIGGERS;
-- 7.���úͽ���
ALTER TRIGGER trigger_name DISABLE;
ALTER TRIGGER trigger_name ENABLE;

