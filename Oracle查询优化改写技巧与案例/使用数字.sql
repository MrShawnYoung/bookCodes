/*���þۺϺ���*/
select deptno,
       avg(sal) as ƽ��ֵ,
       min(sal) as ��Сֵ,
       max(sal) as ���ֵ,
       sum(sal) ���ʺϼ�,
       count(*) ������,
       count(comm) �����ɵ�����,
       avg(comm) ������˾�����㷨,
       avg(coalesce(comm, 0)) ��ȷ���˾���� /*��Ҫ�ѿ�ֵת��Ϊ0*/
  from emp
 group by deptno;

create table emp2 as select * from emp where 1=2;

select count(*) as cnt, sum(sal) as sum_sal from emp2 where deptno = 10;

select count(*) as cnt, sum(sal) as sum_sal
  from emp2
 where deptno = 10
 group by deptno;

declare
  v_sal emp2.sal%type;
begin
  select sum(sal) into v_sal from emp2 where deptno = 10;
  dbms_output.put_line('v_sal=' || v_sal);
end;
/*����*/
declare
  v_sal emp2.sal%type;
begin
  select sum(sal) into v_sal from emp2 where deptno = 10 group by deptno;
  dbms_output.put_line('v_sal=' || v_sal);
end;
/*�����ۼƺ�*/
select empno as ���,
       ename as ����,
       sal as �˹��ɱ�,
       sum(sal) over(order by empno) as �ɱ��ۼ�
  from emp
 where deptno = 30
 order by empno;

select * from table(dbms_xplan.display_cursor(null, 0, 'ALL-NOTE-ALIAS'));

select empno as ���,
       ename as ����,
       sal as �˹��ɱ�,
       sum(sal) over(order by empno) as �ɱ��ۼ�,
       (select listagg(sal, '+') within group(order by empno)
          from emp b
         where b.deptno = 30
           and b.empno <= a.empno) ���㹫ʽ
  from emp a
 where deptno = 30
 order by empno;

select empno,
       sal,
       sum(sal) over(order by empno) as ��д,
       sum(sal) over(order by empno rows between unbounded preceding and current row) as row����,
       sum(sal) over(order by empno range between unbounded preceding and current row) as range����,
       (select sum(sal) from emp b where b.empno <= a.empno) as ����,
       '(select sum(sal) from emp b where b.empno <=)' || a.empno || ')' as ��������
  from emp a
 where deptno = 30
 order by 1;

select empno as ���,
       ename as ����,
       sal as �˹��ɱ�,
       sum(sal) over(order by empno) as �ɱ��ۼ�
  from emp
 where deptno = 30
 order by ename;
/*�����ۼƲ�*/
create table detail as
select 1000 as ���, 'Ԥ������' as ��Ŀ, 30000 as ��� from dual;

insert into detail
  select empno as ���, '֧��' || rownum as ��Ŀ, sal + 1000 as ���
    from emp
   where deptno = 10;

select rownum as seq, a.*
  from (select ���, ��Ŀ, ��� from detail order by ���) a;

with x as
 (select rownum as seq, a.*
    from (select ���, ��Ŀ, ��� from detail order by ���) a)
select ���,
       ��Ŀ,
       ���,
       (case
         when seq = 1 then
          ���
         else
          -���
       end) as ת�����ֵ
  from x;

with x as
 (select rownum as seq, a.*
    from (select ���, ��Ŀ, ��� from detail order by ���) a)
select ���,
       ��Ŀ,
       ���,
       sum(case
             when seq = 1 then
              ���
             else
              -���
           end) over(order by seq) as ת�����ֵ
  from x;
/*�����ۼƺ͵�ֵ*/
create or replace view v(id,amt,trx)
as
select 1, 100, 'PR'
  from dual
union all
select 2, 100, 'PR'
  from dual
union all
select 3, 50, 'PY'
  from dual
union all
select 4, 100, 'PR'
  from dual
union all
select 5, 200, 'PY'
  from dual
union all
select 6, 50, 'PY'
  from dual;

select id,
       case
         when trx = 'PY' then
          'ȡ��'
         else
          '���'
       end ��ȡ����,
       amt ���,
       (case
         when trx = 'PY' then
          -amt
         else
          amt
       end) as ������ֵ
  from v
 order by id;

select id,
       case
         when trx = 'PY' then
          'ȡ��'
         else
          '���'
       end ��ȡ����,
       amt ���,
       sum(case
             when trx = 'PY' then
              -amt
             else
              amt
           end) over(order by id) as ���
  from v
 order by id;
/*���ظ����Ź�������ǰ��λ��Ա��*/
select deptno,
       empno,
       sal,
       row_number() over(partition by deptno order by sal desc) as row_number,
       rank() over(partition by deptno order by sal desc) as rank,
       dense_rank() over(partition by deptno order by sal desc) as dense_rank
  from emp
 where deptno in (20, 30)
 order by 1, 3 desc;

select *
  from (select deptno,
               empno,
               sal,
               dense_rank() over(partition by deptno order by sal desc) as dense_rank
          from emp
         where deptno in (20, 30))
 where dense_rank <= 3;
/*�������������ֵ*/
select sal, count(*) as ���ִ��� from emp where deptno = 20 group by sal;

select sal, dense_rank() over(order by ���ִ��� desc) as ��������
  from (select sal, count(*) as ���ִ���
          from emp
         where deptno = 20
         group by sal) x;

select deptno, sal
  from (select deptno,
               sal,
               dense_rank() over(partition by deptno order by ���ִ��� desc) as ��������
          from (select sal, deptno, count(*) as ���ִ���
                  from emp
                 group by deptno, sal) x) y
 where �������� = 1;
/*������ֵ����������*/
select deptno,
       empno,
       (select max(b.ename) from emp b where b.sal = a.max_sal) as ������ߵ���,
       ename,
       sal
  from (select deptno,
               empno,
               max(sal) over(partition by deptno) as max_sal,
               ename,
               sal
          from emp a
         where deptno = 10) a
 order by 1, 5 desc;

select deptno,
       empno,
       max(ename) keep(dense_rank first order by sal) over(partition by deptno) as ������͵���,
       max(ename) keep(dense_rank last order by sal) over(partition by deptno) as ������ߵ���,
       ename,
       sal
  from emp
 where deptno = 10
 order by 1, 6 desc;

select deptno,
       min(sal) as min_sal,
       max(ename) keep(dense_rank first order by sal) as ������͵���,
       max(sal) as max_sal,
       max(ename) keep(dense_rank last order by sal) as ������ߵ���
  from emp
 where deptno = 10
 group by deptno;

select deptno,
       empno,
       max(sal) over(partition by deptno) as ��߹���,
       ename,
       sal
  from emp
 where deptno = 20
 order by 1, 5 desc;

select deptno,
       empno,
       ename,
       sal,
       to_char(wmsys.wm_concat(ename) keep(dense_rank last order by sal)
               over(partition by deptno)) as ������ߵ���,
       min(ename) keep(dense_rank last order by sal) over(partition by deptno) as ������ߵ���min,
       max(ename) keep(dense_rank last order by sal) over(partition by deptno) as ������ߵ���max
  from emp
 where deptno = 20
 order by 1, 4 desc;
/*fisrt_value*/
select deptno,
       empno,
       first_value(ename) over(partition by deptno order by sal desc) as ������ߵ���,
       ename,
       sal
  from emp
 where deptno = 10
 order by 1, 5 desc;

select deptno,
       empno,
       last_value(ename) over(partition by deptno order by sal desc) as ������ߵ���,
       ename,
       sal
  from emp
 where deptno = 10
 order by 1, 5;

select deptno,
       empno,
       min(sal) over(partition by deptno order by sal desc) as ��߹���,
       ename,
       sal
  from emp
 where deptno = 10
 order by 1, 5;

select deptno,
       empno,
       max(sal) over(partition by deptno order by sal) as ��߹���,
       ename,
       sal
  from emp
 where deptno = 10
 order by 1, 5;

select deptno,
       empno,
       ename,
       sal,
       first_value(ename) over(partition by deptno order by sal desc, ename) as ������ߵ���min,
       first_value(ename) over(partition by deptno order by sal desc, ename) as ������ߵ���max
  from emp
 where deptno = 20
 order by 1, 4 desc;
/*���ܺ͵İٷֱ�*/
select deptno, sum(sal) �����ܼ� from emp group by deptno;

select deptno, �����ܼ�, sum(�����ܼ�) over() as �ܺϼ�
  from (select deptno, sum(sal) �����ܼ� from emp group by deptno) x;

select deptno as ����,
       �����ܼ�,
       round((�����ܼ� / �ܺϼ�) * 100, 2) as ���ʱ���
  from (select deptno, �����ܼ�, sum(�����ܼ�) over() as �ܺϼ�
          from (select deptno, sum(sal) �����ܼ� from emp group by deptno) x) y
 order by 1;

select deptno, round(ratio_to_report(���ʺϼ�) over() * 100, 2) as ���ʱ���
  from (select deptno, sum(sal) ���ʺϼ� from emp group by deptno)
 order by 1;

select deptno,
       empno,
       ename,
       sal,
       round(ratio_to_report(sal) over(partition by deptno) * 100, 2) as ���ʱ���
  from emp
 order by 1, 2;
