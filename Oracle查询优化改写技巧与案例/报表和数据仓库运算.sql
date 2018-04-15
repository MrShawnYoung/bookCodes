/*��ת��*/
select job as ����,
       case deptno
         when 10 then
          sal
       end as ����10����,
       case deptno
         when 20 then
          sal
       end as ����20����,
       case deptno
         when 30 then
          sal
       end as ����30����,
       sal as �ϼƹ���
  from emp
 order by 1;

select job as ����,
       sum(case deptno
             when 10 then
              sal
           end) as ����10����,
       sum(case deptno
             when 20 then
              sal
           end) as ����20����,
       sum(case deptno
             when 30 then
              sal
           end) as ����30����,
       sum(sal) as �ϼƹ���
  from emp
 group by job
 order by 1;

select *
  from (select job, /*����δ��pivot�У����Ա�������������*/ sal, deptno
          from emp)
pivot(sum(sal) as s /*SUM��MAX�Ⱦۼ�����+�б������������ã���Ĭ��ֻʹ�ú���in����ı��������������������*/
   for deptno in(10 as d10, /*�൱��sum(case when deptno = 10 then sal end) as
                 d10������ǰ��ı����ϲ���ΪD10_s*/
                 20, /*�൱��sum(case when deptno = 20 then sal end) as 20
                 ���б��������ã���Ĭ��ʹ��ֵ��Ϊ�������˴�Ϊ20����ǰ��ĺϲ���Ϊ20_s*/
                 30 as d30 /*�൱��sum(case when deptno = 30 then sal end) as d30
                 ������ǰ��ı����ϲ���ΪD30_S*/))
 order by 1;

select *
  from (select job, sal, comm, deptno from emp)
pivot(sum(sal) as s, sum(comm) as c
   for deptno in(10 as d10, 20 as d20, 30 as d30))
 order by 1;

select job,
       sum(case
             when deptno = 10 then
              sal
           end) as d10_s,
       sum(case
             when deptno = 20 then
              sal
           end) as d20_s,
       sum(case
             when deptno = 30 then
              sal
           end) as d30_s,
       sum(case
             when deptno = 10 then
              comm
           end) as d10_c,
       sum(case
             when deptno = 20 then
              comm
           end) as d20_c,
       sum(case
             when deptno = 30 then
              comm
           end) as d30_c
  from emp
 group by job
 order by 1;

select count(case
               when deptno = 10 then
                ename
             end) as deptno_10,
       count(case
               when deptno = 20 then
                ename
             end) as deptno_10,
       count(case
               when deptno = 30 then
                ename
             end) as deptno_10,
       count(case
               when job = 'CLERK' then
                comm
             end) as clerks,
       count(case
               when job = 'MANAGER' then
                comm
             end) as mgrs,
       count(case
               when job = 'PRESIDENT' then
                comm
             end) as prez,
       count(case
               when job = 'ANALYST' then
                comm
             end) as anals,
       count(case
               when job = 'SALESMAN' then
                comm
             end) as sales
  from emp;
/*��ת��*/
create table test as
select *
  from (select deptno, sal from emp)
pivot(count(*) as ct, sum(sal) as s
   for deptno in(10 as deptno_10, 20 as deptno_20, 30 as deptno_30));

select '10' as ���ű���, deptno_10_ct as �˴�
  from test
union all
select '20' as ���ű���, deptno_20_ct as �˴�
  from test
union all
select '30' as ���ű���, deptno_30_ct as �˴�
  from test;

select *
  from test unpivot(�˴� for deptno in(deptno_10_ct,
                                     deptno_20_ct,
                                     deptno_30_ct));

select deptno as ����, substr(deptno, -5, 2) as ���ű���, �˴�
  from test unpivot(�˴� for deptno in(deptno_10_ct,
                                     deptno_20_ct,
                                     deptno_30_ct));

select a.����, a.���ű���, a.�˴�, b.����
  from (select substr(deptno, 1, 9) as ����,
               substr(deptno, -5, 2) as ���ű���,
               �˴�
          from test unpivot include nulls(�˴� for deptno in(deptno_10_ct,
                                                           deptno_20_ct,
                                                           deptno_30_ct))) a
 inner join (select substr(deptno, 1, 9) as ����, ����
               from test unpivot include nulls(���� for deptno in(deptno_10_s,
                                                                deptno_20_s,
                                                                deptno_30_s))) b
    on (b.���� = a.����);

select deptno, �˴�, deptno2, ����
  from test unpivot include nulls(�˴� for deptno in(deptno_10_ct as 10,
                                                   deptno_20_ct as 20,
                                                   deptno_30_ct as 30)) unpivot include nulls(���� for deptno2 in(deptno_10_s as 10,
                                                                                                                deptno_20_s as 20,
                                                                                                                deptno_30_s as 30))
 order by 1, 3;

with x0 as
 (select deptno, �˴�, deptno_10_s, deptno_20_s, deptno_30_s
    from test unpivot include nulls(�˴� for deptno in(deptno_10_ct as 10,
                                                     deptno_20_ct as 20,
                                                     deptno_30_ct as 30)))
select deptno, �˴�, deptno2, ����
  from x0 unpivot include nulls(���� for deptno2 in(deptno_10_s as 10,
                                                  deptno_20_s as 20,
                                                  deptno_30_s as 30))
 order by 1, 3;

select deptno as ���ű���, �˴�, ����
  from test unpivot include nulls(�˴� for deptno in(deptno_10_ct as 10,
                                                   deptno_20_ct as 20,
                                                   deptno_30_ct as 30)) unpivot include nulls(���� for deptno2 in(deptno_10_s as 10,
                                                                                                                deptno_20_s as 20,
                                                                                                                deptno_30_s as 30))
 where deptno = deptno2;
/*�����������ת��Ϊһ��*/
select emps
  from (select ename, job, to_char(sal) as sal, null as t_col /*������һ������ʾ����*/
          from emp
         where deptno = 10) unpivot include nulls(emps for col in(ename,
                                                                  job,
                                                                  sal,
                                                                  t_col));

select emps
  from (select ename, job, sal, null as t_col /*������һ������ʾ����*/
          from emp
         where deptno = 10) unpivot include nulls(emps for col in(ename,
                                                                  job,
                                                                  sal,
                                                                  t_col));

select emps
  from (select ename, job, to_char(sal) as sal, null as t_col
          from emp
         where deptno = 10) unpivot(emps for col in(ename, job, sal, t_col));
/*���ƽ�����е��ظ�ֵ*/
select case
       /*�����ŷ��ఴ�������������һ��������ͬʱ����ʾ*/
         when lag(job) over(order by job, ename) = job then
          null
         else
          job
       end as ְλ,
       ename as ����
  from emp
 where deptno = 20
 order by emp.job, ename;

select case
         when lag(job) over(order by job, ename) = job then
          null
         else
          job
       end as job,
       ename as ����
  from emp
 where deptno = 20
 order by job, ename;
/*���á���ת�С����м���*/
select d10_sal,
       d20_sal,
       d30_sal,
       d20_sal - d10_sal as d20_10_diff,
       d20_sal - d30_sal as d20_30_diff
  from (select sum(case
                     when deptno = 10 then
                      sal
                   end) as d10_sal,
               sum(case
                     when deptno = 20 then
                      sal
                   end) as d20_sal,
               sum(case
                     when deptno = 30 then
                      sal
                   end) as d30_sal
          from emp) totals_by_dept;
/*�����ݷ���*/
with x1 as
 (select ename from emp order by ename),
x2 as
 (select rownum as rn, ename from x1)
select * from x2;

with x1 as
 (select ename from emp order by ename),
x2 as
 (select rownum as rn, ename from x1),
x3 as
 (select ceil(rn / 5) as gp, ename from x2)
select * from x3;

with x1 as
 (select ename from emp order by ename),
x2 as
 (select rownum as rn, ename from x1),
x3 as
 (select ceil(rn / 5) as gp, ename from x2),
x4 as
 (select gp, ename, row_number() over(partition by gp order by ename) as rn
    from x3)
select * from x4;

with x1 as
/*1.����*/
 (select ename from emp order by ename),
x2 as
/*2.�������*/
 (select rownum as rn, ename from x1),
x3 as
/*3.����*/
 (select ceil(rn / 5) as gp, ename from x2),
/*4.�����������*/
x4 as
 (select gp, ename, row_number() over(partition by gp order by ename) as rn
    from x3)
/*5.��ת��*/
select *
  from x4
pivot (max(ename) for rn in(1 as n1, 2 as n2, 3 as n3, 4 as n4, 5 as n5));
/*�����ݷ���*/
select ntile(3) over(order by empno) as ��, empno as ����, ename as ����
  from emp
 where job in ('CLERK', 'MANAGER');
/*����򵥵�С��*/
select deptno, sum(sal) as s_sal from emp group by rollup(deptno);

select deptno as ���ű���, job as ����, mgr as ����, sum(sal) as s_sal
  from emp
 group by rollup(deptno, job, mgr);

select deptno as ���ű���, job as ����, mgr as ����, sum(sal) as s_sal
  from emp
 group by deptno, job, mgr
union all
select deptno as ���ű���,
       job as ����,
       null /*����С��*/ as ����,
       sum(sal) as s_sal
  from emp
 group by deptno, job
union all
select deptno as ���ű���,
       null /*����С��*/ as ����,
       null as ����,
       sum(sal) as s_sal
  from emp
 group by deptno
union all
select null /*�ܺϼ�*/, null as ����, null as ����, sum(sal) as s_sal
  from emp;

select deptno as ���ű���, job ����, sum(sal) as ����С��
  from emp
 group by rollup((deptno, job));
/*�б��С�Ƶ���(����ԭ����һ�ű����)*/
create table temp_emp as select * from emp;

update temp_emp set job = null where empno = 7788;

update temp_emp set deptno = null where empno in (7654, 7902);

select nvl(to_char(deptno), '�ܼ�') as ���ű���,
       nvl(job, 'С��') as ����,
       deptno,
       job,
       mgr as ����,
       max(case
             when empno in (7788, 7654, 7902) then
              empno
           end) as max_empno,
       sum(sal) sal,
       grouping(deptno) deptno_grouping,
       grouping(job) job_grouping
  from temp_emp
 group by rollup(deptno, job, mgr);

select case grouping(deptno)
         when 1 then
          '�ܼ�'
         else
          to_char(deptno)
       end as ���ű���,
       case
         when grouping(deptno) = 1 then
          null
         when grouping(job) = 1 then
          'С��'
         else
          job
       end as ����,
       case
         when grouping(job) = 1 then
          null
         when grouping(mgr) = 1 then
          'С��'
         else
          to_char(mgr)
       end as ����,
       max(case
             when empno in (7788, 7654, 7902) then
              empno
           end) as max_empno,
       sum(sal) as ���ʺϼ�
  from temp_emp
 group by rollup(deptno, job, mgr);
/*�������б��ʽ��ϵ�С��*/
select case grouping(deptno) || grouping(job)
         when '00' then
          '�������빤������'
         when '10' then
          '����������'
         when '01' then
          '�����ŷ���'
         when '11' then
          '�ܺϼ�'
       end as grouping,
       /*��grouping(deptno)||grouping(job)�Ľ������������
       ��תΪʮ����
       ����grouping_id(deptno,job)��ֵ*/
       case grouping_id(deptno, job)
         when 0 then
          '�������빤������'
         when 2 then
          '����������'
         when 1 then
          '�����ŷ���'
         when 3 then
          '�ܺϼ�'
       end grouping_id,
       deptno as ����,
       job as ����,
       sum(sal) as ����
  from emp
 group by cube(deptno, job)
 order by grouping(job), grouping(deptno);
/*��Ա�ڹ�����ķֲ�*/
select *
  from (select ename, job from emp)
pivot(sum(1)
   for job in('CLERK' as is_clerk,
              'SALESMAN' as is_sales,
              'MANAGER' as is_mgr,
              'ANALYST' as is_analyst,
              'PRESIDENT' as is_prez))
 order by 2, 3, 4, 5, 6;
/*����ϡ�����*/
select *
  from (select empno, ename, ename as ename2, deptno, job from emp)
pivot(max(ename)
   for deptno in(10 as deptno_10, 20 as deptno_20, 30 as deptno_30))
pivot(max(ename2)
   for job in('CLERK' as clerks,
              'MANAGER' as mgrs,
              'PRESIDENT' as prez,
              'ANALYST' as anals,
              'SALESMAN' as sales))
 order by 1;

select *
  from (select ename, ename as ename2, deptno, job from emp)
pivot(count(ename)
   for deptno in(10 as deptno_10, 20 as deptno_20, 30 as deptno_30))
pivot(count(ename2)
   for job in('CLERK' as clerks,
              'MANAGER' as mgrs,
              'PRESIDENT' as prez,
              'ANALYST' as anals,
              'SALESMAN' as sales))
 order by 1;

with x0 as
 (select *
    from (select ename, ename as ename2, deptno, job from emp)
  pivot(count(ename)
     for deptno in(10 as deptno_10, 20 as deptno_20, 30 as deptno_30)))
select * from x0;

with x0 as
 (select *
    from (select ename, ename as ename2, deptno, job from emp)
  pivot(count(ename)
     for deptno in(10 as deptno_10, 20 as deptno_20, 30 as deptno_30)))
select *
  from x0
pivot (count(ename2) for job in('CLERK' as clerks,
                           'MANAGER' as mgrs,
                           'PRESIDENT' as prez,
                           'ANALYST' as anals,
                           'SALESMAN' as sales))
 order by 1;
/*�Բ�ͬ��/����ͬʱʵ�־ۼ�*/
select e.ename ����,
       e.deptno ����,
       s_d.cnt as ��������,
       e.job as ְλ,
       s_j.cnt as ְλ����,
       (select count(*) as cnt from emp where deptno in (10, 20)) as ������
  from emp e
 inner join (select deptno, count(*) as cnt
               from emp
              where deptno in (10, 20)
              group by deptno) s_d
    on (s_d.deptno = e.deptno)
 inner join (select job, count(*) as cnt
               from emp
              where deptno in (10, 20)
              group by job) s_j
    on (s_j.job = e.job)
 where e.deptno in (10, 20);

select ename ����,
       deptno ����,
       count(*) over(partition by deptno) as ��������,
       job as ְλ,
       count(*) over(partition by job) as ְλ����,
       count(*) over() as ������
  from emp
 where deptno in (10, 20);
/*���ƶ���Χ��ֵ���оۼ�*/
select hiredate as Ƹ������,
       sal as ����,
       (select sum(b.sal)
          from emp b
         where b.deptno = 30
           and b.hiredate <= e.hiredate
           and b.hiredate >= e.hiredate - 90) as ������ֵ,
       '(' || to_char(hiredate - 90, 'yy-mm-dd') || '��' ||
       to_char(hiredate, 'yy-mm-dd') || ')Ƹ����Ա���ʺ�' as ����,
       sum(sal) over(order by hiredate range between 90 preceding and current row) as ����������ֵ,
       (select listagg(b.sal, '+') within group(order by b.hiredate)
          from emp b
         where b.deptno = 30
           and b.hiredate <= e.hiredate
           and b.hiredate >= e.hiredate - 90) as ģ�⹫ʽ
  from emp e
 where deptno = 30
 order by 1;

select hiredate as Ƹ������,
       sal as ����,
       sum(sal) over(order by hiredate range between interval '3' month preceding and current row) as ���ºϼ�
  from emp e
 where deptno = 30
 order by 1;

create table test as
select 1 as c1, trunc(sysdate) + level / 24 / 60 as d1
  from dual
connect by level <= 5;

select * from test;

select c1,
       d1,
       sum(c1) over(order by d1 range between 2 / 24 / 60 preceding and current row) as s1,
       sum(c1) over(order by d1 range between(interval '2' minute) preceding and current row) as s2
  from test;
/*���÷���������������*/
select ename,
       sal,
       /*���ǰ�������������������Ľ�����������е���Сֵ*/
       min(sal) over(order by sal) as min_11,
       /*�������Ĭ�ϲ������£�plan�п��Կ���*/
       min(sal) over(order by sal range between unbounded preceding and current row) as min_12,
       /*��������£�rows��range��������һ��*/
       min(sal) over(order by sal rows between unbounded preceding and current row) as min_13,
       /*ȡ����������Сֵ��������ǰ�淵�ص�ֵ�ԱȲ鿴*/
       min(sal) over() as min_14,
       /*�����ȷд������min_14�ķ�Χ����*/
       min(sal) over(order by sal range between unbounded preceding and unbounded following) as min_15,
       /*��������£�rows��range��������һ��*/
       min(sal) over(order by sal rows between unbounded preceding and unbounded following) as min_16
  from emp
 where deptno = 30;

select ename,
       sal,
       /*�򰴹�����������������������sal���ص�ֵһ��*/
       max(sal) over(order by sal) as max_11,
       /*�������Ĭ�ϲ������£�plan�п��Կ���*/
       max(sal) over(order by sal range between unbounded preceding and current row) as max_12,
       /*��������£�rows��range��������һ��*/
       max(sal) over(order by sal rows between unbounded preceding and current row) as max_13,
       /*ȡ�����������ֵ��������ǰ�淵�ص�ֵ�ԱȲ鿴*/
       max(sal) over() as max_14,
       /*�����ȷд������min_14�ķ�Χ����*/
       max(sal) over(order by sal range between unbounded preceding and unbounded following) as max_15,
       /*��������£�rows��range��������һ��*/
       max(sal) over(order by sal rows between unbounded preceding and unbounded following) as max_16
  from emp
 where deptno = 30;

select ename,
       sal,
       /*�ۼӹ��ʣ�Ҫע�⹤���ظ�ʱ������*/
       sum(sal) over(order by sal) as max_11,
       /*�������Ĭ�ϲ������£�plan�п��Կ���*/
       sum(sal) over(order by sal range between unbounded preceding and current row) as sum_12,
       /*��������£�rows��range�������ݲ�һ�������ڶ���*/
       sum(sal) over(order by sal rows between unbounded preceding and current row) as sum_13,
       /*���ʺϼ�*/
       sum(sal) over() as sum_14,
       /*�����ȷд������sum_14�ķ�Χ����*/
       sum(sal) over(order by sal range between unbounded preceding and unbounded following) as sum_15,
       /*��������£�rows��range��������һ��*/
       sum(sal) over(order by sal rows between unbounded preceding and unbounded following) as sum_16
  from emp
 where deptno = 30;

select ename,
       sal,
       /*��ǰ�У�+-1500����Χ�ڵ����ֵ*/
       max(sal) over(order by sal range between 500 preceding and 500 following) as max_11,
       /*ǰ��һ�У��������е����ֵ*/
       max(sal) over(order by sal rows between 1 preceding and 1 following) as max_12
  from emp
 where deptno = 30;
/*listagg��С�ž�*/
with l as
 (select level as lv from dual connect by level <= 9)
select a.lv as lv_a,
       b.lv as lv_b,
       to_char(b.lv) || ' �� ' || to_char(a.lv) || ' = ' ||
       rpad(to_char(a.lv * b.lv), 2, ' ') as text
  from l a, l b
 where b.lv <= a.lv

with l as
 (select level as lv from dual connect by level <= 9),
m as
 (select a.lv as lv_a,
         b.lv as lv_b,
         to_char(b.lv) || ' �� ' || to_char(a.lv) || ' = ' ||
         rpad(to_char(a.lv * b.lv), 2, ' ') as text
    from l a, l b
   where b.lv <= a.lv)
select listagg(m.text, '   ') within group(order by m.lv_b) as С�ž�
  from m
 group by m.lv_a;
