select t.*, t.rowid from BANKINFO t

-- 1.目前balance字段设置了>0的这个数据约束
-- 转账300，减300失效，加300成功，操作错误
update bankinfo set balance=balance-300 where id=1;
update bankinfo set balance=balance+300 where id=2;

-- 2.事物回滚
declare 
    v_error exception;
    PRAGMA EXCEPTION_INIT(v_error,-2290);
begin
    update bankInfo set balance=balance+300 where Id=2;
    update bankInfo set balance=balance-300 where Id=1;
    commit;
    dbms_output.put_line('转账成功');
exception
    when v_error then 
    rollback; --事物回滚
    dbms_output.put_line('转账失败');
end;

-- 3.事物回滚点,回滚到某个位置
select * from emp;
update emp set sal=2500 where empno=7521;
savepoint m1;
--
select * from emp;
--
delete from emp where empno=7839;
--
select * from emp;
-- 7839删除错误，改变工资没有错误
-- 
rollback to savepoint m1;
--
select * from emp;
-- 总结：1、场景：一个事物里面执行了多个的cud操作，可以通过对每一次操作前设置回滚点，
-- 确保了有反悔操作的时候，可以回滚到对应操作前的数据状态

-- 4.多个回滚点，每个员工加薪10%
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

-- 总结：如果设置了多个回滚点（m1,m2,m3），可以先回到m3再回m2,但是如果先回到m2，
-- 由于设置m2的时候还没有设置m3，就不能再回到m3，相当于m2后面的语句失效了。

-- 5.事物并发












