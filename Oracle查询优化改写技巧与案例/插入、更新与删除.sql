/*�����¼�¼*/
create table test(
c1 varchar2(10) default 'Ĭ��1',
c2 varchar2(10) default 'Ĭ��2',
c3 varchar2(10) default 'Ĭ��3',
c4 date default sysdate
);
insert into test (c1, c2, c3) values (default, null, '����ֵ');
select * from test;
/*��ֹ��ĳ���в���*/
create or replace view v_test as select c1, c2, c3 from test;
insert into v_test (c1, c2, c3) values ('����c1', null, '���ܸ�c4');
select * from V_TEST;
/*insert into v_test (c1, c2, c3) values (default, null, '���ܸ�c4');*/
/*���Ʊ�Ķ��弰����*/
create table test2 as select * from test;
create table test2 as select * from test where 1 = 2;
insert into test2 select * from test;
select * from test2;
/*��WITH CHECK OPTION��������¼��*/
alter table emp add constraints ch_sal check(sal > 0);
/*alter table emp add constraints ch_hiredate check(hiredate > sysdate);*/
insert into
  (select empno, ename, hiredate
     from emp
    where hiredate <= sysdate with check option)
values
  (9999, 'test', sysdate + 1);
/*���������*/
create table emp1 as select empno, ename, job from emp where 1 = 2;
create table emp2 as select empno, ename, deptno from emp where 1 = 2;
/*������*/
insert all into emp1
  (empno, ename, job)
values
  (empno, ename, job) into emp2
  (empno, ename, deptno)
values
  (empno, ename, deptno)
  select empno, ename, job, deptno from emp where deptno in (10, 20);
/*������*/
insert all when job in
  ('SALESMAN', 'MANAGER') then into emp1
  (empno, ename, job)
values
  (empno, ename, job) when deptno in
  ('20', '30') then into emp2
  (empno, ename, deptno)
values
  (empno, ename, deptno)
  select empno, ename, job, deptno from emp;
/*��һ�������*/
insert first when job in
  ('SALESMAN', 'MANAGER') then into emp1
  (empno, ename, job)
values
  (empno, ename, job) when deptno in
  ('20', '30') then into emp2
  (empno, ename, deptno)
values
  (empno, ename, deptno)
  select empno, ename, job, deptno from emp;
select * from emp1;
select * from emp2;

create table t2(d varchar2(10),des varchar2(50));
create table t1 as
select '���������񲻼�' as d1,
       'è������ѱ����' as d2,
       '��������������' as d3,
       '��������������' as d4,
       '������Ը�������һ��' as d5
  from dual;

insert all into t2
  (d, des)
values
  ('��һ', d1) into t2
  (d, des)
values
  ('�ܶ�', d2) into t2
  (d, des)
values
  ('����', d3) into t2
  (d, des)
values
  ('����', d4) into t2
  (d, des)
values
  ('����', d5)
  select d1, d2, d3, d4, d5 from t1;
select * from t2;
/*���������е�ֵ����*/
create table emp2 as select * from emp;
alter table emp2 add dname varchar2(50) default 'noname';
/*����ʾ��*/
update emp2
   set emp2.dname =
       (select dept.dname
          from dept
         where dept.deptno = emp2.deptno
           and dept.dname in ('ACCOUNTING', 'RESEARCH'));
select * from emp2;
/*��ȷ�Ĳ�ѯ����*/
select deptno,
       dname as old_name,
       (select dept.dname
          from dept
         where dept.deptno = emp2.deptno
           and dept.dname in ('ACCOUNTING', 'RESEARCH')) as new_dname,
       case
         when emp2.deptno not in (10, 20) then
          '���ñ����µ���'
       end as des
  from emp2
 where exists (select dept.dname
          from dept
         where dept.deptno = emp2.deptno
           and dept.dname in ('ACCOUNTING', 'RESEARCH'));
/*��ȷ�ĸ���*/
update emp2
   set emp2.dname =
       (select dept.dname
          from dept
         where dept.deptno = emp2.deptno
           and dept.dname in ('ACCOUNTING', 'RESEARCH'))
 where exists (select dept.dname
          from dept
         where dept.deptno = emp2.deptno
           and dept.dname in ('ACCOUNTING', 'RESEARCH'));
select * from emp2;
/*��ȷ�ĸ���2*/
update (select emp2.dname, dept.dname as new_dname
          from emp2
         inner join dept
            on dept.deptno = emp2.deptno
         where dept.dname in ('ACCOUNTING', 'RESEARCH'))
   set dname = new_dname;
select * from emp2;
/*��ȷ�ĸ���3*/
merge into emp2
using (select dname, deptno
         from dept
        where dept.dname in ('ACCOUNTING', 'RESEARCH')) dept
on (dept.deptno = emp2.deptno)
when matched then
  update set emp2.dname = dept.dname;
/*�ϲ���¼*/
create table bonuses (employee_id number, bonus number default 100);
insert into bonuses
  (employee_id)
  (select e.employee_id
     from hr.employees e, oe.orders o
    where e.employee_id = o.sales_rep_id
    group by e.employee_id);
select * from bonuses order by employee_id;

merge into bonuses d
using (select employee_id, salary, department_id
         from hr.employees
        where department_id = 80) s
on (d.employee_id = s.employee_id)
/*ƥ������d.employee_id = s.employee_id*/
when matched then/*��d���д�����S��Ӧ����ʱ���и��»�ɾ��*/
  update
     set d.bonus = d.bbonus + s.salary * 0.01 delete
     /*whereֻ�ܳ���һ�Σ�������������where��delete�����where����Ч*/
   where (s.salary > 8000)/*ɾ��ʱ��ֻ����s.salary > 8000ʱ������*/
when not matched then/*��d���в�������S��Ӧ������ʱ��������*/
  insert
    (d.employee_id, d.bonus)
  values
    (s.employee_id, s.salary * 0.01) where
    (s.salary > 8000);/*����ʱ��ֻ����s.salary < 8000ʱ�����ݣ�ע��������ǰ�治ͬ����d���в����ڶ�Ӧ����ʱ������*/
/*ɾ��Υ�����������Եļ�¼*/
insert into emp2
  (empno, ename, job, mgr, hiredate, sal, comm, deptno)
  select 9999 as empno, ename, job, mgr, hiredate, sal, comm, 99 as deptno
    from emp
   where rownum <= 1;
delete from emp2
 where not exists (select null from dept where dept.deptno = emp2.deptno);
select * from emp;
/*ɾ�������ظ��ļ�¼*/
create table dupes (id integer,name varchar2(10));
insert into dupes values(1,'NAPOLEON');
insert into dupes values(2,'DYNAIMTE');
insert into dupes values(3,'DYNAIMTE');
insert into dupes values(4,'SHE SELLS');
insert into dupes values(5,'SEA SHELLS');
insert into dupes values(6,'SEA SHELLS');
insert into dupes values(7,'SEA SHELLS');
/*����1*/
delete from dupes a
 where exists (select null
          from dupes b
         where b.name = a.name
           and b.id > a.id);
select * from dupes;
delete dupes;
/*����2*/
delete from dupes a
 where exists (select /*hash_sj*/
         null
          from dupes b
         where b.name = a.name
           and b.rowid > a.rowid);
select * from dupes;
delete dupes;
/*����3*/
select rowid as rid,
       name,
       row_number() over(partition by name order by id) as seq
  from dupes
 order by 2, 3;
delete from dupes
 where rowid in (select rid
                   from (select rowid as rid,
                                row_number() over(partition by name order by id) as seq
                           from dupes)
                  where seq > 1);
