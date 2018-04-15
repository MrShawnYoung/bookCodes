/*��λ����ֵ�ķ�Χ*/
create or replace view v(proj_id,proj_start,proj_end) as
select 1, date '2005-01-01', date '2005-01-02'
  from dual
union all
select 2, date '2005-01-02', date '2005-01-03'
  from dual
union all
select 3, date '2005-01-03', date '2005-01-04'
  from dual
union all
select 4, date '2005-01-04', date '2005-01-05'
  from dual
union all
select 5, date '2005-01-06', date '2005-01-07'
  from dual
union all
select 6, date '2005-01-16', date '2005-01-17'
  from dual
union all
select 7, date '2005-01-17', date '2005-01-18'
  from dual
union all
select 8, date '2005-01-18', date '2005-01-19'
  from dual
union all
select 9, date '2005-01-19', date '2005-01-20'
  from dual
union all
select 10, date '2005-01-21', date '2005-01-22'
  from dual
union all
select 11, date '2005-01-26', date '2005-01-27'
  from dual
union all
select 12, date '2005-01-27', date '2005-01-28'
  from dual
union all
select 13, date '2005-01-28', date '2005-01-29'
  from dual
union all
select 14, date '2005-01-29', date '2005-01-30'
  from dual;

select v1.proj_id as ���̺�, v1.proj_start ��ʼ����, v1.proj_end ��������
  from v v1, v v2
 where v2.proj_start = v1.proj_end;

select proj_id as ���̺�,
       proj_start ��ʼ����,
       proj_end ��������,
       lead(proj_start) over(order by proj_id) ��һ�����̿�ʼ����
  from v;

select ���̺�, ��ʼ����, ��������
  from (select proj_id as ���̺�,
               proj_start ��ʼ����,
               proj_end ��������,
               lead(proj_start) over(order by proj_id) ��һ�����̿�ʼ����
          from v)
 where ��һ�����̿�ʼ���� = ��������;
/*����ͬһ����������֮��Ĳ�*/
select * from log;

with x0 as
 (select rownum as seq, ��¼��, ��¼ʱ��
    from (select ��¼��, ��¼ʱ�� from log order by ��¼��, ��¼ʱ��) e)
select * from x0;

with x0 as
 (select rownum as seq, ��¼��, ��¼ʱ��
    from (select ��¼��, ��¼ʱ�� from log order by ��¼��, ��¼ʱ��) e)
select e1.��¼��, e1.��¼ʱ��, e2.��¼ʱ�� as ��һ��¼ʱ��
  from x0 e1
  left join x0 e2
    on (e2.��¼�� = e1.��¼�� and e2.seq = e1.seq + 1)
 order by 1, 2;

select ��¼��,
       ��¼ʱ��,
       lead(��¼ʱ��) over(partition by ��¼�� order by ��¼ʱ��) as ��һ��¼ʱ��
  from log;

select ��¼��, ��¼ʱ��, (��һ��¼ʱ�� - ��¼ʱ��) * 24 * 60 as ��¼���
  from (select ��¼��,
               ��¼ʱ��,
               lead(��¼ʱ��) over(partition by ��¼�� order by ��¼ʱ��) as ��һ��¼ʱ��
          from log);
/*��λ����ֵ��Χ�Ŀ�ʼ��ͽ�����*/
select min(proj_start) as ��ʼ, max(proj_end) as ���� from v;

create or replace view x0 as
select proj_id as ���,
       proj_start as ��ʼ����,
       proj_end as ��������,
       lag(proj_end) over(order by proj_id) as ��һ���̽�������
  from v;
select * from x0;

create or replace view x1 as
select ���,
       ��ʼ����,
       ��������,
       ��һ���̽�������,
       case
         when ��ʼ���� = ��һ���̽������� then
          0
         else
          1
       end as ����״̬
  from x0;
select * from x1;

create or replace view x2 as
select ���,
       ��ʼ����,
       ��������,
       ��һ���̽�������,
       ����״̬,
       sum(����״̬) over(order by ���) as ��������
  from x1;
select * from x2;

select ��������, min(��ʼ����) as ��ʼ����, max(��������) as ��������
  from (select ���,
               ��ʼ����,
               ��������,
               sum(����״̬) over(order by ���) as ��������
          from (select proj_id as ���,
                       proj_start as ��ʼ����,
                       proj_end as ��������,
                       case
                         when lag(proj_end)
                          over(order by proj_id) = proj_start then
                          0
                         else
                          1
                       end as ����״̬
                  from v))
 group by ��������
 order by 1;
/*�ϲ�ʱ���*/
create or replace view timesheets(task_id,start_date,end_date) as
select 1, date '1997-01-01', date '1997-01-03'
  from dual
union all
select 2, date '1997-01-02', date '1997-01-04'
  from dual
union all
select 3, date '1997-01-04', date '1997-01-05'
  from dual
union all
select 4, date '1997-01-06', date '1997-01-09'
  from dual
union all
select 5, date '1997-01-09', date '1997-01-09'
  from dual
union all
select 6, date '1997-01-09', date '1997-01-09'
  from dual
union all
select 7, date '1997-01-12', date '1997-01-15'
  from dual
union all
select 8, date '1997-01-13', date '1997-01-13'
  from dual
union all
select 9, date '1997-01-15', date '1997-01-15'
  from dual
union all
select 10, date '1997-01-17', date '1997-01-17'
  from dual;

select ��������, min(��ʼ����) as ��ʼ����, max(��������) as ��������
  from (select ���,
               ��ʼ����,
               ��������,
               sum(����״̬) over(order by ���) as ��������
          from (select task_id as ���,
                       start_date as ��ʼ����,
                       end_date as ��������,
                       case
                         when lag(end_date)
                          over(order by task_id) >= start_date then
                          0
                         else
                          1
                       end as ����״̬
                  from timesheets))
 group by ��������
 order by 1;

select start_date,
       end_date,
       max(end_date) over(order by start_date rows between unbounded preceding and 1 preceding) as max_end_date
  from timesheets b;

with x0 as
 (select task_id,
         start_date,
         end_date,
         max(end_date) over(order by start_date rows between unbounded preceding and 1 preceding) as max_end_date
    from timesheets b),
x1 as
 (select start_date as ��ʼʱ��,
         end_date as ����ʱ��,
         max_end_date,
         case
           when max_end_date >= start_date then
            0
           else
            1
         end as ����״̬
    from x0)
select * from x1;

with x0 as
 (select task_id,
         start_date,
         end_date,
         max(end_date) over(order by start_date rows between unbounded preceding and 1 preceding) as max_end_date
    from timesheets b),
x1 as
 (select start_date as ��ʼʱ��,
         end_date as ����ʱ��,
         max_end_date,
         case
           when max_end_date >= start_date then
            0
           else
            1
         end as ����״̬
    from x0),
x2 as
 (select ��ʼʱ��,
         ����ʱ��,
         sum(����״̬) over(order by ��ʼʱ��) as ��������
    from x1)
select ��������, min(��ʼʱ��) as ��ʼʱ��, max(����ʱ��) as ����ʱ��
  from x2
 group by ��������
 order by ��������;
