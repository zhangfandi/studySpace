-- 1.查询所有工种为CLERK的员工的姓名及其部门名称。
select emp.ename,dept.dname from emp emp inner join dept dept on emp.deptno=dept.deptno
where emp.job='CLERK';
-- 2.查询所有部门及其员工信息，包括那些没有员工的部门.
select * from emp t1 right join dept t2 on t1.deptno=t2.deptno;
-- 3.查询所有员工及其部门信息，包括那些还不属于任何部门的员工。
select * from emp t1 left join dept t2 on t1.deptno=t2.deptno;
-- 4.查询在SALES部门工作的员工的姓名信息。
-- 用子查询实现:
select * from emp where deptno=(select deptno from dept where dname='SALES');
-- 用连接查询实现:
select t1.* from emp t1 inner join dept t2 on t1.deptno=t2.deptno where t2.dname='SALES';
-- 5.查询所有员工的姓名及其直接上级的姓名。
select t1.ename as emp,t2.ename as mgr from emp t1 left join emp t2 on t1.mgr=t2.empno;
select t1.ename as 员工姓名,t2.ename 经理姓名 from scott.emp t1,scott.emp t2 where t1.mgr=t2.empno;
-- 6.查询入职日期早于其上级领导的所有员工的信息。
select * from emp t1 where t1.hiredate < (select hiredate from emp t2 where t2.empno=t1.mgr) ;
select t1.ename as 员工姓名,t2.ename 经理姓名 from scott.emp t1,scott.emp t2
where t1.mgr=t2.empno and t1.hiredate<t2.hiredate;
-- 7.查询从事同一种工作但不属于同一部门的员工信息。▲▲▲笛卡尔连接
select t1.ename,t1.job,t1.deptno,t2.ename,t2.job,t2.deptno from scott.emp t1 cross join scott.emp t2 where t1.job=t2.job and t1.deptno<>t2.deptno;
-- 8.查询10号部门员工及其领导的信息。
select t1.ename as 员工姓名,t2.ename as 经理姓名 from emp t1 inner join emp t2 
on t1.mgr=t2.empno where t1.deptno=10;
select t1.ename as 员工姓名,t2.ename 经理姓名 from scott.emp t1,scott.emp t2
where t1.mgr=t2.empno and t1.deptno=10;
-- 9.使用UNION将工资大于2500的雇员信息与工作为ANALYST的雇员信息合并。
select t2.ename from emp t2 where sal>2500
union 
select t1.ename from emp t1 where t1.job='ANALYST';
-- 10.通过INTERSECT集合运算，查询工资大于2500，并且工作为ANALYST的雇员信息。▲▲▲取两结果的交集
select t2.ename from emp t2 where sal>2500
intersect
select t1.ename from emp t1 where t1.job='ANALYST';
-- 11.使用MINUS集合查询工资大于2500，但工作不是ANALYST的雇员信息。▲▲▲取a结果集中b结果集里没有的记录
select t2.ename from emp t2 where sal>2500
MINUS
select t1.ename from emp t1 where t1.job='ANALYST';
-- 12.查询工资高于公司平均工资的所有员工信息。
select t1.ename from emp t1 where sal>(select avg(sal) from emp);
-- 13.查询与SMITH员工从事相同工作的所有员工信息。
select * from emp where job=(select job from emp where ename='SMITH');
-- 14.查询工资比SMITH员工工资高的所有员工信息。
select * from emp where sal>(select sal from emp where ename='SMITH');
-- 15.查询比所有在30号部门中工作的员工的工资都高的员工姓名和工资。
select * from emp where sal>(select max(sal) from emp where deptno=30);
-- ▲▲▲all()函数与括号里的所有集合项进行比较，如果集合为空比较结果为true。any()函数是比较其中任意一个
select ename,sal from scott.emp where sal>all(select sal from scott.emp where deptno=30);
-- 16.查询部门人数大于5的部门的员工信息。
select * from emp where deptno in
(select deptno from emp having count(1)>5 group by deptno);
-- 17.查询所有员工工资都大于2000的部门的信息。
select * from dept t2 where 2000<all(select t1.sal from emp t1 where t1.deptno=t2.deptno)
and exists(select t3.sal from emp t3 where t3.deptno=t2.deptno);
select * from scott.dept 
where deptno in(select deptno from scott.emp group by deptno having min(sal)>2000);
-- 18.查询人数最多的部门信息。
select * from dept where deptno in(
select deptno from (select deptno,count(1) as cunt from emp group by deptno)
where cunt=(select max(cunt) from (select count(1) as cunt from emp group by deptno)));

select * from scott.dept where deptno in 
(select deptno from (select deptno,count(*) as 人数 from scott.emp group by deptno) 
where 人数=(select max(人数) from(select deptno,count(*) as 人数 from scott.emp group by deptno)));

-- 19.查询至少有一个员工的部门信息。
select * from dept where deptno in
(select deptno as cunt from emp having count(1)>0 group by deptno);
-- 20.查询工资高于本部门平均工资的员工信息。
select * from emp t1 where sal >
(select avg(sal) from emp where deptno=t1.deptno group by deptno);
-- 21.查询工资高于本部门平均工资的员工信息及其部门的平均工资。
select t1.*,(select avg(sal) from emp where deptno=t1.deptno group by deptno) 
from emp t1 where sal >
(select avg(sal) from emp where deptno=t1.deptno group by deptno);
-- 22.查询每个员工的领导所在部门的信息。
select * from dept where deptno in(
select distinct deptno from emp where empno in (select distinct mgr from emp));
-- 23.查询平均工资低于2000的部门及其员工信息。
select * from emp where deptno in
(select deptno from emp having avg(sal)<2000 group by deptno);



