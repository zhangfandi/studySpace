select t.*, t.rowid from BANKINFO t

-- 1.Ŀǰbalance�ֶ�������>0���������Լ��
-- ת��300����300ʧЧ����300�ɹ�����������
update bankinfo set balance=balance-300 where id=1;
update bankinfo set balance=balance+300 where id=2;

-- 2.����ع�
declare 
    v_error exception;
    PRAGMA EXCEPTION_INIT(v_error,-2290);
begin
    update bankInfo set balance=balance+300 where Id=2;
    update bankInfo set balance=balance-300 where Id=1;
    commit;
    dbms_output.put_line('ת�˳ɹ�');
exception
    when v_error then 
    rollback; --����ع�
    dbms_output.put_line('ת��ʧ��');
end;

-- 3.����ع���,�ع���ĳ��λ��
select * from emp;
update emp set sal=2500 where empno=7521;
savepoint m1;
--
select * from emp;
--
delete from emp where empno=7839;
--
select * from emp;
-- 7839ɾ�����󣬸ı乤��û�д���
-- 
rollback to savepoint m1;
--
select * from emp;
-- �ܽ᣺1��������һ����������ִ���˶����cud����������ͨ����ÿһ�β���ǰ���ûع��㣬
-- ȷ�����з��ڲ�����ʱ�򣬿��Իع�����Ӧ����ǰ������״̬

-- 4.����ع��㣬ÿ��Ա����н10%
savepoint m1;
update emp set sal=sal*1.1;
-- 
select * from emp;
-- 
rollback to savepoint m1;
-- 
select * from emp;
-- 
savepoint m2;
update emp set sal=sal*1.1 where sal<=2500;
-- 
savepoint m3;
delete from emp where sal>2500;
-- 
rollback to savepoint m2;

-- �ܽ᣺��������˶���ع��㣨m1,m2,m3���������Ȼص�m3�ٻ�m2,��������Ȼص�m2��
-- ��������m2��ʱ��û������m3���Ͳ����ٻص�m3���൱��m2��������ʧЧ�ˡ�

-- 5.���ﲢ��












