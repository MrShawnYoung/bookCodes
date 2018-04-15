/*SYSDATE�ܵõ�����Ϣ*/
select hiredate as ��Ӷ����,
       to_date(to_char(hiredate, 'yyyy-mm') || '-1', 'yyyy-mm-dd') as �³�
  from emp
 where rownum <= 1;

select hiredate as ��Ӷ����, trunc(hiredate, 'mm') as �³�
  from emp
 where rownum <= 1;

select hiredate,
       to_number(to_char(hiredate, 'hh24')) ʱ,
       to_number(to_char(hiredate, 'mi')) ��,
       to_number(to_char(hiredate, 'ss')) ��,
       to_number(to_char(hiredate, 'dd')) ��,
       to_number(to_char(hiredate, 'mm')) ��,
       to_number(to_char(hiredate, 'yyyy')) ��,
       to_number(to_char(hiredate, 'ddd')) ���ڵڼ���,
       trunc(hiredate, 'dd') һ�쿪ʼ,
       trunc(hiredate, 'day') �ܳ�,
       trunc(hiredate, 'mm') �³�,
       last_day(hiredate) ��δ,
       add_months(trunc(hiredate, 'mm'), 1) ���³�,
       trunc(hiredate, 'yy') ���,
       to_char(hiredate, 'day') �ܼ�,
       to_char(hiredate, 'month') �·�
  from (select hiredate + 30 / 24 / 60 / 60 + 20 / 24 / 60 + 5 / 24 as hiredate
          from emp
         where rownum <= 1);

with t as
 (select to_date('1980-12-31 15:20:30', 'yyyy-mm-dd hh24:mi:ss') as d1,
         to_date('1980-12-31 05:20:30', 'yyyy-mm-dd hh24:mi:ss') as d2
    from dual)
select d1, d2 from t;

with t as
 (select to_date('1980-12-31 15:20:30', 'yyyy-mm-dd hh24:mi:ss') as d1,
         to_date('1980-12-31 05:20:30', 'yyyy-mm-dd hh24:mi:ss') as d2
    from dual)
select d1, d2 from t where d1 between trunc(d2, 'mm') and last_day(d2);

with t as
 (select to_date('1980-12-31 15:20:30', 'yyyy-mm-dd hh24:mi:ss') as d1,
         to_date('1980-12-31 05:20:30', 'yyyy-mm-dd hh24:mi:ss') as d2
    from dual)
select d1, d2
  from t
 where d1 >= trunc(d2, 'mm')
   and d1 < add_months(trunc(d2, 'mm'), 1);
/*INTERVAL*/
select interval '2' year as "year",
       interval '50' month as "month",
       interval '99' day as "day", /*���ֻ����99*/
       interval '80' hour as "hour",
       interval '90' minute as "minute",
       interval '3.15' second as "second",
       interval '2 12:30:59' day to second as "day to second",
       interval '13-3' year to month as "year to month"
  from dual;
/*EXTRACT*/
create table test as
  select extract(year from systimestamp) as "year",
         extract(month from systimestamp) as "month",
         extract(day from systimestamp) as "day",
         extract(hour from systimestamp) as "hour",
         extract(minute from systimestamp) as "minute",
         extract(second from systimestamp) as "second"
    from dual;
select * from test;

select created, extract(day from created) as d
  from dba_objects
 where object_id = 2;

select extract(hour from created) as h
  from dba_objects
 where object_id = 2;

select created, to_char(created, 'dd') as d, to_char(created, 'hh24') as h
  from dba_objects
 where object_id = 2;

select extract(hour from it) as "hour"
  from (select interval '2 12:30:59' day to second as it from dual);

select to_char(it, 'hh24') as "hour"
  from (select interval '2 12:30:59' day to second as it from dual);
/*ȷ��һ���Ƿ���Ϊ����*/
select trunc(hiredate, 'y') ��� from emp where empno = 7788;

select add_months(trunc(hiredate, 'y'), 1) ���³�
  from emp
 where empno = 7788;

select last_day(add_months(trunc(hiredate, 'y'), 1)) as ���µ�
  from emp
 where empno = 7788;

select to_char(last_day(add_months(trunc(hiredate, 'y'), 1)), 'DD') as ��
  from emp
 where empno = 7788;
/*�ܵļ���*/
with x as
 (select trunc(sysdate, 'YY') + (level - 1) as ����
    from dual
  connect by level <= 8)
select ����,
       /*����ֵ1��������,2������һ....*/
       to_char(����, 'd') as d,
       to_char(����, 'day') as day,
       /*����2��1��������,2������һ....*/
       next_day(����, 1) as �¸�����,
       /*ww���㷨Ϊÿ��1��1��Ϊ��һ��ʼ,date+6Ϊÿ��һ����*/
       to_char(����, 'ww') as ww,
       /*iw���㷨Ϊ��һ����������һ��,��ÿ��ĵ�һ������һΪ��һ��*/
       to_char(����, 'iw') as iw
  from x;
/*ȷ��һ������������ĳһ�����������*/
with x as
 (select trunc(sysdate, 'y') + (level - 1) dy
    from dual
  connect by level <=
             add_months(trunc(sysdate, 'y'), 12) - trunc(sysdate, 'y'))
select dy, to_char(dy, 'day') as ���� from x where to_char(dy, 'd') = 6;

select to_char(hiredate, 'day') as day, to_char(hiredate, 'd') as d
  from emp
 where rownum <= 1;
/*ȷ��ĳ���ڵ�һ�������һ��������ĳ�족������*/
select next_day(trunc(hiredate, 'mm') - 1, 2) ��һ����һ,
       next_day(last_day(trunc(hiredate, 'mm')) - 7, 2) ���һ����һ
  from emp
 where empno = 7788;

with x as
 (select to_date('2013-03-24', 'yyyy-mm-dd') + (level - 1) as dy
    from dual
  connect by level <= 10)
select dy, to_char(dy, 'day') as day, next_day(dy, 2) as d1 from x;

with x as
 (select to_date('2013-09-23', 'yyyy-mm-dd') + (level - 1) as dy
    from dual
  connect by level <= 15)
select dy, to_char(dy, 'day') as day, next_day(dy, 2) as d1 from x;
/*������������*/
with x1 as
/*1������һ������*/
 (select to_date('2013-03-01', 'yyyy-mm-dd') as cur_date from dual),
x2 as
/*2��ȡ�³�*/
 (select trunc(cur_date, 'mm') as �³�,
         add_months(trunc(cur_date, 'mm'), 1) as ���³�
    from x1),
x3 as
/*3��ö�ٵ������е���*/
 (select �³� + (level - 1) as ��
    from x2
  connect by level <= (���³� - �³�)),
x4 as
/*4����ȡ����Ϣ*/
 (select to_char(��, 'iw') ������,
         to_char(��, 'dd') ����,
         to_number(to_char(��, 'd')) �ܼ�
    from x3)
select max(case �ܼ�
             when 2 then
              ����
           end) ��һ,
       max(case �ܼ�
             when 3 then
              ����
           end) �ܶ�,
       max(case �ܼ�
             when 4 then
              ����
           end) ����,
       max(case �ܼ�
             when 5 then
              ����
           end) ����,
       max(case �ܼ�
             when 6 then
              ����
           end) ����,
       max(case �ܼ�
             when 7 then
              ����
           end) ����,
       max(case �ܼ�
             when 1 then
              ����
           end) ����
  from x4
 group by ������
 order by ������;
/*ȫ������*/
with x as
 (select to_date('2013-12-27', 'yyyy-mm-dd') + (level - 1) as d
    from dual
  connect by level <= 5)
select d, to_char(d, 'day') as day, to_char(d, 'iw') as iw from x;

with x0 as
 (select to_date('2013-12-27', 'yyyy-mm-dd') + (level - 1) as d
    from dual
  connect by level <= 5),
x1 as
 (select d,
         to_char(d, 'day') as day,
         to_char(d, 'mm') as mm,
         to_char(d, 'iw') as iw
    from x0)
select d,
       day,
       case
         when mm = '12' and iw = '01' then
          '53'
         else
          iw
       end as iw
  from x1;

with x0 as
 (select 2013 as ��� from dual),
x1 as
 (select trunc(to_date(���, 'yyyy'), 'YYYY') as �����,
         add_months(trunc(to_date(���, 'yyyy'), 'YYYY'), 12) as �����
    from x0),
x2 as
/*ö������*/
 (select ����� + (level - 1) as ����
    from x1
  connect by level <= ����� - �����),
x3 as
 (
  /*ȡ�·ݣ�������Ϣ*/
  select ����,
          to_char(����, 'mm') �����·�,
          to_char(����, 'iw') ������,
          to_number(to_char(����, 'd')) �ܼ�
    from x2),
x4 as
/*������,12�µġ���һ�ܡ���Ϊ����ʮ���ܡ�*/
 (select ����,
         �����·�,
         case
           when �����·� = '12' and ������ = '01' then
            '53'
           else
            ������
         end as ������,
         �ܼ�
    from x3)
select case
         when lag(�����·�) over(order by ������) = �����·� then
          null
         else
          �����·�
       end as �·�,
       ������,
       max(case �ܼ�
             when 2 then
              ����
           end) ��һ,
       max(case �ܼ�
             when 3 then
              ����
           end) �ܶ�,
       max(case �ܼ�
             when 4 then
              ����
           end) ����,
       max(case �ܼ�
             when 5 then
              ����
           end) ����,
       max(case �ܼ�
             when 6 then
              ����
           end) ����,
       max(case �ܼ�
             when 7 then
              ����
           end) ����,
       max(case �ܼ�
             when 1 then
              ����
           end) ����
  from x4
 group by �����·�, ������
 order by 2;
/*ȷ��ָ����ݼ��ȵĿ�ʼ���ںͽ�������*/
select sn as ����,
       (sn - 1) * 3 + 1 as ��ʼ�·�,
       add_months(to_date(��, 'yyyy'), (sn - 1) * 3) as ��ʼ����,
       add_months(to_date(��, 'yyyy'), sn * 3) - 1 as ��������
  from (select '2013' as ��, level as sn from dual connect by level <= 4);
/*���䷶Χ�ڶ�ʧ��ֵ*/
select empno, hiredate from scott.emp order by 2;

select to_char(hiredate, 'yyyy') as year, count(*) as cnt
  from scott.emp
 group by to_char(hiredate, 'yyyy')
 order by 1;

with x as
 (select ��ʼ��� + (level - 1) as ���
    from (select extract(year from min(hiredate)) as ��ʼ���,
                 extract(year from max(hiredate)) as �������
            from scott.emp)
  connect by level <= ������� - ��ʼ��� + 1)
select * from x;

with x as
 (select ��ʼ��� + (level - 1) as ���
    from (select extract(year from min(hiredate)) as ��ʼ���,
                 extract(year from max(hiredate)) as �������
            from scott.emp)
  connect by level <= ������� - ��ʼ��� + 1)
select x.���, count(e.empno) Ƹ������
  from x
  left join scott.emp e
    on (extract(year from e.hiredate) = x.���)
 group by x.���
 order by 1;
/*���ո�����ʱ�䵥λ���в���*/
select ename ����, hiredate Ƹ������, to_char(hiredate, 'day') as ����
  from emp
 where to_char(hiredate, 'mm') in ('02', '12')
    or to_char(hiredate, 'd') = '3';
/*ʹ�����ڵ����ⲿ�ֱȽϼ�¼*/
select ename as ����,
       hiredate as Ƹ������,
       to_char(hiredate, 'mon day') as ����
  from (select ename,
               hiredate,
               count(*) over(partition by to_char(hiredate, 'mon day')) as ct
          from emp)
 where ct > 1;
/*ʶ���ص������ڷ�Χ*/
create or replace view emp_project(empno, ename, proj_id, proj_start, proj_end) as
  select 7782, 'CLARK', 1, date '2005-06-16', date '2005-06-18'
    from dual
  union all
  select 7782, 'CLARK', 4, date '2005-06-19', date '2005-06-24'
    from dual
  union all
  select 7782, 'CLARK', 7, date '2005-06-22', date '2005-06-25'
    from dual
  union all
  select 7782, 'CLARK', 10, date '2005-06-25', date '2005-06-28'
    from dual
  union all
  select 7782, 'CLARK', 13, date '2005-06-28', date '2005-07-02'
    from dual
  union all
  select 7839, 'KING', 2, date '2005-06-17', date '2005-06-21'
    from dual
  union all
  select 7839, 'KING', 2, date '2005-06-17', date '2005-06-21'
    from dual
  union all
  select 7839, 'KING', 8, date '2005-06-23', date '2005-06-25'
    from dual
  union all
  select 7839, 'KING', 14, date '2005-06-29', date '2005-06-30'
    from dual
  union all
  select 7839, 'KING', 11, date '2005-06-26', date '2005-06-27'
    from dual
  union all
  select 7839, 'KING', 5, date '2005-06-20', date '2005-06-24'
    from dual
  union all
  select 7934, 'MILLER', 3, date '2005-06-18', date '2005-06-22'
    from dual
  union all
  select 7934, 'MILLER', 12, date '2005-06-27', date '2005-06-28 '
    from dual
  union all
  select 7934, 'MILLER', 15, date '2005-06-30', date '2005-07-03'
    from dual
  union all
  select 7934, 'MILLER', 9, date '2005-06-24', date '2005-06-27'
    from dual
  union all
  select 7934, 'MILLER', 6, date '2005-06-21', date '2005-06-23'
    from dual;

select empno as Ա������,
       ename as ����,
       proj_id as ���̺�,
       proj_start as ��ʼ����,
       lag(proj_end) over(partition by empno order by proj_start) as ��һ���̽�������,
       proj_end as ��������,
       lag(proj_id) over(partition by empno order by proj_start) as ��һ���̺�
  from emp_project;

select a.Ա������,
       a.����,
       a.���̺�,
       a.��ʼ����,
       a.��������,
       case
         when ��һ���̽������� >= ��ʼ���� /*ɸѡʱ���ظ�������*/
          then
          '(����' || lpad(a.���̺�, 2, '0') || ')�빤��(' ||
          lpad(a.��һ���̺�, 2, '0') || ')�ظ�'
       end as ����
  from (select empno as Ա������,
               ename as ����,
               proj_id as ���̺�,
               proj_start as ��ʼ����,
               proj_end as ��������,
               lag(proj_end) over(partition by empno order by proj_start) as ��һ���̽�������,
               lag(proj_id) over(partition by empno order by proj_start) as ��һ���̺�
          from emp_project) a
--where ��һ���̽������� >= ��ʼ����
 order by 1, 4;
/*��ָ�������������(�л���system�û�)*/
select timestamp, action, action_name from dba_audit_trail;

select trunc(sysdate, 'mi') as mi, trunc(sysdate, 'hh') as hh from dual;

with x0 as
 (select to_date('2013-12-18 16:15:15', 'yyyy-mm-dd hh24:mi:ss') as c1
    from dual)
select trunc(c1, 'mi') as c1, to_char(c1, 'mi') as mi from x0;

select mod(15, 10) as m from dual;

with x0 as
 (select to_date('2013-12-18 16:15:15', 'yyyy-mm-dd hh24:mi:ss') as c1
    from dual)
select trunc(c1, 'mi') - 5 / 24 / 60 from x0;

select gp, count(*) as cnt
  from (select timestamp,
               trunc(timestamp, 'mi') -
               mod(to_char(timestamp, 'mi'), 10) / 24 / 60 as gp,
               action,
               action_name
          from t_trail)
 group by gp;
