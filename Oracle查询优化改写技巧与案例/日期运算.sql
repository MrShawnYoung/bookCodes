/*�Ӽ��ա��¡���*/
select hiredate as Ƹ������,
       hiredate - 5 as ��5��,
       hiredate + 5 as ��5��,
       add_months(hiredate, -5) as ��5����,
       add_months(hiredate, 5) as ��5����,
       add_months(hiredate, -5 * 12) as ��5��,
       add_months(hiredate, 5 * 12) as ��5��
  from emp
 where rownum <= 1;
/*�Ӽ�ʱ���֡���*/
select hiredate as Ƹ������,
       hiredate - 5 / 24 / 60 / 60 as ��5��,
       hiredate + 5 / 24 / 60 / 60 as ��5��,
       hiredate - 5 / 24 / 60 as ��5����,
       hiredate + 5 / 24 / 60 as ��5����,
       hiredate - 5 / 24 as ��5Сʱ,
       hiredate + 5 / 24 as ��5Сʱ
  from emp
 where rownum <= 1;
/*���ڼ��֮ʱ���֡���*/
select �������,
       ������� * 24 as ���Сʱ,
       ������� * 24 * 60 as �����,
       ������� * 24 * 60 * 60 as �����
  from (select max(hiredate) - min(hiredate) as �������
          from emp
         where ename in ('WARD', 'ALLEN')) x;
/*���ڼ��֮�ա��¡���*/
select max_hd - min_hd �����,
       months_between(max_hd, min_hd) �����,
       months_between(max_hd, min_hd) / 12 �����
  from (select min(hiredate) min_hd, max(hiredate) max_hd from emp) x;
/*ȷ����������֮��Ĺ�������*/
create table t500 as select level as id from dual connect by level <=500;

select sum(case
             when to_char(min_hd + t500.id - 1,
                          'DY',
                          'NLS_DATE_LANGUAGE= American') in ('SAT', 'SUN') then
              0
             else
              1
           end) as��������
  from (select min(hiredate) as min_hd, max(hiredate) as max_hd
          from emp
         where ename in ('BLAKE', 'JONES')) x,
       t500
 where t500.id <= max_hd - min_hd + 1;

select ename, hiredate from emp where ename in ('BLAKE', 'JONES');

select min(hiredate) as min_hd, max(hiredate) as max_hd
  from emp
 where ename in ('BLAKE', 'JONES');

select (max_hd - min_hd) + 1 as ����
  from (select min(hiredate) as min_hd, max(hiredate) as max_hd
          from emp
         where ename in ('BLAKE', 'JONES')) x;

select min_hd + (t500.id - 1) as ����
  from (select min(hiredate) as min_hd, max(hiredate) as max_hd
          from emp
         where ename in ('BLAKE', 'JONES')) x,
       t500
 where t500.id <= ((max_hd - min_hd) + 1);

select ����, to_char(����, 'DY', 'NLS_DATE_LANGUAGE = American') as dy
  from (select min_hd + (t500.id - 1) as ����
          from (select min(hiredate) as min_hd, max(hiredate) as max_hd
                  from emp
                 where ename in ('BLAKE', 'JONES')) x,
               t500
         where t500.id <= ((max_hd - min_hd) + 1));

select count(*)
  from (select ����,
               to_char(����, 'DY', 'NLS_DATE_LANGUAGE = American') as dy
          from (select min_hd + (t500.id - 1) as ����
                  from (select min(hiredate) as min_hd,
                               max(hiredate) as max_hd
                          from emp
                         where ename in ('BLAKE', 'JONES')) x,
                       t500
                 where t500.id <= ((max_hd - min_hd) + 1)))
 where dy not in ('SAT', 'SUN');
/*����һ�������ڸ����ڵĴ���*/
with x0 as
 (select to_date('2013-01-01', 'yyyy-mm-dd') as ��� from dual),
x1 as
 (select ���, add_months(���, 12) as ����� from x0),
x2 as
 (select ���, �����, ����� - ��� as ���� from x1),
x3 as /*�����б�*/
 (select ��� + (level + 1) as ���� from x2 connect by level <= ����),
x4 as /*�����ݽ���ת��*/
 (select ����, to_char(����, 'DY') as ���� from x3)
/*����������*/
select ����, count(*) as ���� from x4 group by ����;

with x0 as
 (select to_date('2013-01-01', 'yyyy-mm-dd') as ��� from dual),
x1 as
 (select ���, add_months(���, 12) as ��� from x0),
x2 as
 (select next_day(��� - 1, level) as d1, next_day(��� - 8, level) as d2
    from x1
  connect by level <= 7)
select to_char(d1, 'dy') as ����, d1, d2 from x2;

with x0 as
 (select to_date('2013-01-01', 'yyyy-mm-dd') as ��� from dual),
x1 as
 (select ���, add_months(���, 12) as ��� from x0),
x2 as
 (select next_day(��� - 1, level) as d1, next_day(��� - 8, level) as d2
    from x1
  connect by level <= 7)
select to_char(d1, 'dy') as ����, ((d2 - d1) / 7 + 1) as ����
  from x2
 order by 1;
/*ȷ����ǰ��¼����һ����¼֮����������*/
select deptno,
       ename,
       hiredate,
       lead(hiredate) over(order by hiredate) next_hd
  from emp
 where deptno = 10;

select ename, hiredate, next_hd, next_hd - hiredate diff
  from (select deptno,
               ename,
               hiredate,
               lead(hiredate) over(order by hiredate) next_hd
          from emp
         where deptno = 10);

select ename, hiredate, next_hd, next_hd - hiredate diff
  from (select deptno,
               ename,
               hiredate,
               lead(hiredate) over(order by hiredate) next_hd
          from emp
         where deptno = 10);

select deptno,
       ename,
       hiredate,
       lead(hiredate) over(order by hiredate) next_hd,
       hiredate,
       lag(hiredate) over(order by hiredate) lag_hd
  from emp
 where deptno = 10;
