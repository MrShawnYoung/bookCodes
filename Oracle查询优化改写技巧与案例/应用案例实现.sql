/*�Ӳ��̶�λ����ȡ�ַ�����Ԫ��*/
create or replace view v as
select 'xxxxxabc[867]xxx[-]xxxx[5309]xxxxx' msg
  from dual
union all
select 'xxxxxtime:[11271978]favnum:[4]id:[Joe]xxxxx' msg
  from dual
union all
select 'call:[F_GET_ROWS()]b1:[ROSEWOOD��SIR]b2:[44400002]77.90xxxxx' msg
  from dual
union all
select 'film:[non_marked]qq:[unit]tailpipe[withabanana?]80sxxxxx' msg
  from dual;

select regexp_substr(v.msg, '[^][]+', 1, 2) ��һ����,
       regexp_substr(v.msg, '[^][]+', 1, 4) �ڶ�����,
       regexp_substr(v.msg, '[^][]+', 1, 6) ��������,
       msg
  from v;

create or replace view v as
select 'xxxxxabc[867]xxx[-]xxxx[5309]xxxxx' msg
  from dual
union all
select 'xxxxxtime:[11271978]favnum:[4]id:[Joe]xxxxx' msg
  from dual
union all
select 'call:[F_GET_ROWS()]b1:[ROSEWOOD��SIR]b2:[44400002]77.90xxxxx' msg
  from dual
union all
select 'film:[non_marked]qq:[unit]tailpipe[withabanana?]80sxxxxx' msg
  from dual
union all
select '[һ][��][��]' msg
  from dual;

select regexp_substr(v.msg, '(\[)([^]]+)', 1, 1) ��һ����,
       regexp_substr(v.msg, '(\[)([^]]+)', 1, 2) �ڶ�����,
       regexp_substr(v.msg, '(\[)([^]]+)', 1, 3) ��������,
       msg
  from v;

select ltrim(regexp_substr(v.msg, '(\[)([^]]+)', 1, 1), '[') ��һ����,
       ltrim(regexp_substr(v.msg, '(\[)([^]]+)', 1, 2), '[') �ڶ�����,
       ltrim(regexp_substr(v.msg, '(\[)([^]]+)', 1, 3), '[') ��������,
       msg
  from v;
/*������ĸ���ֻ�ϵ��ַ���*/
create or replace view v as
select 'ClassSummary' strings
  from dual
union all
select '3453430278'
  from dual
union all
select 'findRow 55'
  from dual
union all
select '1010 switch'
  from dual
union all
select '333'
  from dual
union all
select 'threes'
  from dual;

select strings
  from v
 where regexp_like(v.strings, '([a-zA-Z].*[0-9]|[0-9].*[a-zA-Z])');
/*�ѽ���ּ���תΪ��*/
with x as
 (select ename as ����,
         sal as ����,
         dense_rank() over(order by sal desc) as ����
    from emp)
select * from x;

with x as
 (select ename as ����,
         sal as ����,
         dense_rank() over(order by sal desc) as ����
    from emp),
y as
 (select ����,
         ����,
         ����,
         case
           when ���� <= 3 then
            1
           when ���� <= 6 then
            2
           else
            3
         end ��
    from x)
select * from y;

with x as
 (select ename as ����,
         sal as ����,
         dense_rank() over(order by sal desc) as ����
    from emp),
y as
 (select ����,
         ����,
         ����,
         case
           when ���� <= 3 then
            1
           when ���� <= 6 then
            2
           else
            3
         end ��
    from x),
z as
 (select ����,
         ����,
         ����,
         ��,
         row_number() over(partition by �� order by ����, ����) as ��������
    from y)
select * from z;

/*1.�����ݷֵ�*/
with x as
 (select ename as ����,
         sal as ����,
         dense_rank() over(order by sal desc) as ����
    from emp),
/*2.���ݵ��ΰ����ݷ�Ϊ����*/
y as
 (select ����,
         ����,
         ����,
         case
           when ���� <= 3 then
            1
           when ���� <= 6 then
            2
           else
            3
         end ��
    from x),
/*3.�ֱ�����е���������ȡ��ţ�������ͬ��ŵĿ��Ի��ܺ����ͬһ��*/
z as
 (select ����,
         ����,
         ����,
         ��,
         row_number() over(partition by �� order by ����, ����) as ��������
    from y)
/*4.��ת��*/
select max(case ��
             when 1 then
              rpad(����, 6) || '(' || ���� || ')'
           end) �������,
       max(case ��
             when 2 then
              rpad(����, 6) || '(' || ���� || ')'
           end) �μ�����,
       max(case ��
             when 3 then
              rpad(����, 6) || '(' || ���� || ')'
           end) ���൵��
  from z
 group by ��������
/*ע��Ҫ���򣬷�����ʾ���������ҵ�*/
 order by ��������;
/*�����������ݵ���Ҫ��*/
create table j1 as
select 1 as col1 from dual;

create table j2 as
select 1 as col1 from dual union all select 2 as col1 from dual;

create table j3 as
select 3 as col1 from dual union all select 4 as col1 from dual;

create table j4 as
select 3 as col1 from dual union all select 4 as col1 from dual;

select j1.col1, j2.col1, j3.col1, j4.col1
  from j1
  full join j2
    on j2.col1 = j1.col1
  full join j3
    on j3.col1 = j1.col1
  full join j4
    on j4.col1 = j1.col1;

create table j0 as
select 1 as col0
  from dual
union all
select 2 as col0
  from dual
union all
select 3 as col0
  from dual
union all
select 4 as col0
  from dual;

select j1.col1, j2.col1, j3.col1, j4.col1
  from j0
  left join j1
    on j1.col1 = j0.col0
  left join j2
    on j2.col1 = j0.col0
  left join j3
    on j3.col1 = j0.col0
  left join j4
    on j4.col1 = j0.col0
 order by j0.col0;
/*���ݴ����������ز�ͬ���е�����*/
create table area as
select '����' as ��, 'ɳƺ��' as ��, 'С����' as ��
  from dual
union all
select '����' as ��, 'ɳƺ��' as ��, '������' as ��
  from dual
union all
select '����' as ��, '������' as ��, '���ƺ' as ��
  from dual
union all
select '����' as ��, '������' as ��, 'л����' as ��
  from dual;

var v_�� varchar2(50);
var v_�� varchar2(50);
exec :v_��:='';
exec :v_��:='������';
select distinct case
                  when :v_�� is not null then
                   ��
                  when :v_�� is not null then
                   ��
                end as ��������
  from area
 where �� = nvl(:v_��, ��)
   and �� = nvl(:v_��, ��);

exec :v_��:='����';
exec :v_��:='';
select distinct case
                  when :v_�� is not null then
                   ��
                  when :v_�� is not null then
                   ��
                end as ��������
  from area
 where �� = nvl(:v_��, ��)
   and �� = nvl(:v_��, ��);
/*����ַ�����������*/
create table d_objects as select * from dba_objects;

create table test1 as
select to_char(wmsys.wm_concat(object_id)) as id_lst, owner, object_type
  from d_objects
 where owner in ('SCOTT', 'TEST')
 group by owner, object_type;

with a as
 (select id_lst, regexp_substr(id_lst, '[^,]+', 1, level) as object_id
    from test1
  connect by nocycle(prior rowid) = rowid
         and level <= length(regexp + replace(id_lst, '[^,]', ''))
         and (prior dbms_random.value) is not null)
select a.id_lst, to_char(wmsys.wm_concat(b.object_name)) as name_lst
  from a
 inner join d_objects b
    on b.object_id = a.object_id
 group by a.id_lst;
/*������������*/
create or replace view x0(��Ա���,��ʼʱ��,����ʱ��,����,��ֵid) as
select 11, to_date('201305', 'yyyymm'), to_date('201308', 'yyyymm'), 1, 1
  from dual
union all
select 11, to_date('201307', 'yyyymm'), null, 1, 2
  from dual
union all
select 11, to_date('201301', 'yyyymm'), null, -1, 3
  from dual
union all
select 11, to_date('201312', 'yyyymm'), null, 1, 4
  from dual
union all
select 22, to_date('201305', 'yyyymm'), to_date('201306', 'yyyymm'), 1, 1
  from dual
union all
select 22, to_date('201308', 'yyyymm'), to_date('201309', 'yyyymm'), 1, 2
  from dual
union all
select 22, to_date('201312', 'yyyymm'), to_date('201312', 'yyyymm'), -1, 3
  from dual
union all
select 22, to_date('201403', 'yyyymm'), null, 1, 4
  from dual
union all
select 22, to_date('201405', 'yyyymm'), null, -1, 4
  from dual
union all
select 33, to_date('201305', 'yyyymm'), to_date('201305', 'yyyymm'), 1, 1
  from dual
union all
select 33, to_date('201307', 'yyyymm'), to_date('201307', 'yyyymm'), 1, 2
  from dual
union all
select 33, to_date('201310', 'yyyymm'), null, -1, 3
  from dual
union all
select 33, to_date('201312', 'yyyymm'), null, 1, 4
  from dual;

create or replace view x01 as
select ��Ա���,
       ��ʼʱ��,
       /*��ǰ��Ա����С���ڣ�������*/
       coalesce(min(case
                      when ���� = -1 then
                       add_months(��ʼʱ��, -1)
                      else
                       ��ʼʱ��
                    end)
                over(partition by ��Ա��� order by ��ֵid rows between 1
                     following and unbounded following),
                ��ʼʱ�� + 1) as min_��ʼʱ��,
       ����ʱ�� as ����ǰ,
       /*��������ʱ��*/
       case
         when ����ʱ�� is null and
              (lead(����) over(partition by ��Ա��� order by ��ֵid)) = -1 then
          add_months((lead(��ʼʱ��) over(partition by ��Ա��� order by ��ֵid)),
                     -1)
         else
          ����ʱ��
       end as ����ʱ��,
       ����,
       ��ֵid,
       max(��ֵid) over(partition by ��Ա���) as max_id
  from x0;
select * from x01;

create or replace view x02 as
select ��Ա���,
       ��ʼʱ��,
       min_��ʼʱ��,
       ����ʱ��,
       ����,
       ��ֵid,
       max_id,
       /*���������Ƿ��ص��ı�ʶ���ϲ�ʱ��ʱ��*/
       case
         when (lag(����ʱ��) over(partition by ��Ա��� order by ��ֵid)) <
              add_months(��ʼʱ��, -1) then
          1
         when (lag(����) over(partition by ��Ա��� order by ��ֵid)) = 1 then
          null
         else
          1
       end as so
  from x01;
select * from x02;

create or replace view x03 as
select ��Ա���,
       ��ֵid,
       max_id,
       ����,
       /*�ۼӱ�ʶ�����ɷ���ϲ�����*/
       sum(so) over(partition by ��Ա��� order by ��ֵid) as so,
       ��ʼʱ��,
       min_��ʼʱ��,
       /*������ǰ���ɵ�ʱ�串�Ƕ�Ӧ��ʱ��*/
       case
         when min_��ʼʱ�� < ����ʱ�� and min_��ʼʱ�� >= ��ʼʱ�� then
          min_��ʼʱ��
         else
          ����ʱ��
       end as ����ʱ��
  from x02
 where ���� = 1
      /*�����ʼʱ����⻹С���Ͷ�����*/
   and ��ʼʱ�� <= min_��ʼʱ��;
select * from x03;

create or replace view x04 as
select ��Ա���,
       max_id,
       max(��ֵid) as max_id2,
       sum(����) as ����,
       min(��ʼʱ��) keep(dense_rank first order by ��ֵid) as ��ʼʱ��,
       max(����ʱ��) keep(dense_rank last order by ��ֵid) as ����ʱ��
  from x03
 group by ��Ա���, so, max_id;
select * from x04;

create or replace view x05 as
select ��Ա���,
       to_char(��ʼʱ��, 'yyyymm') || '--' ||
       coalesce(to_char(����ʱ��, 'yyyymm'), 'NULL') as ����
  from x04
 where (max_id = max_id2 or ��ʼʱ�� <= ����ʱ��)
   and ���� > -1;
select * from x05;
/*�á���ת�С����õ�������Ϣ*/
create table cte as
(select 'A' as shop, '2013' as nyear, 123 as amount
  from dual
union all
select 'A' as shop, '2012' as nyear, 200 as amount
  from dual);
select * from cte;

select shop,
       max(decode(nyear, '2012', amount)),
       max(decode(nyear, '2013', amount))
  from cte
 group by shop;

select shop,
       nyear,
       max(nyear) over() as max_year,
       min(nyear) over() as min_year,
       sum(amount) as amount
  from cte
 group by shop, nyear;

with t0 as
 (select shop,
         nyear,
         /*���÷�����������ת�У����������������*/
         max(nyear) over() as max_year,
         min(nyear) over() as min_year,
         sum(amount) as amount
    from cte
   group by shop, nyear)
select shop,
       max(decode(nyear, min_year /*����2012*/, amount)) as ȥ��,
       min(decode(nyear, max_year /*����2012*/, amount)) as ����
  from t0
 group by shop;
/*���������ݽ�����ת��*/
select job, ename, row_number() over(partition by job order by empno) sn
  from emp;

select job,
       max(case
             when sn = 1 then
              ename
           end) as n1,
       max(case
             when sn = 2 then
              ename
           end) as n2,
       max(case
             when sn = 3 then
              ename
           end) as n3,
       max(case
             when sn = 4 then
              ename
           end) as n4
  from (select job,
               ename,
               row_number() over(partition by job order by empno) as sn
          from emp)
 group by job;

select *
  from (select job,
               ename,
               row_number() over(partition by job order by empno) as sn
          from emp)
pivot(max(ename)
   for sn in(1 as n1, 2 as n2, 3 as n3, 4 as n4));

declare
  v_max_seq number;
  v_sql     varchar2(4000);
begin
  select max(count(*)) into v_max_seq from emp group by job;
  v_sql := 'select' || chr(10);
  for i in 1 .. v_max_seq loop
    v_sql := v_sql || 'max(case when seq =' || to_char(i) ||
             'then ename end) as n' || to_char(i) || ',' || chr(10);
  end loop;
  v_sql := v_sql || 'job from(select ename,job,row_number() over(partition by job order by empno) as seq from emp)
    group by job';
  dbms_output.put_line(v_sql);
end;
/*��������ʽ��ȡclob����ı���ʽ��¼��*/
select c1,
       regexp_substr(c1, '[^|#]+', 1, 1) as d1,
       regexp_substr(c1, '[^|#]+', 1, 1) as d1,
       regexp_substr(c1, '[^|#]+', 1, 2) as d2,
       regexp_substr(c1, '[^|#]+', 1, 3) as d3,
       regexp_substr(c1, '[^|#]+', 1, 4) as d4,
       regexp_substr(c1, '[^|#]+', 1, 5) as d5,
  from (select to_char(regexp_substr(c1,
                                     '[^' || chr(10) || ']+',
                                     1,
                                     level + 1)) as c1
          from test
        connect by level <= regexp_count(c1, chr(10)));
