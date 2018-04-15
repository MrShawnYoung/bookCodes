/*�����ַ���*/
create or replace view v as
select '��������' as ����, 'TTXS' as ��ƴ from dual;

select level from dual connect by level <= 4;

select v.����, v.��ƴ, level from v connect by level <= length(v.����);

select v.����,
       v.��ƴ,
       level,
       substr(v.����, level, 1) as ���ֲ��,
       substr(v.��ƴ, level, 1) as ��ƴ���,
       'substr(''' || v.���� || ''',' || level || ',1)' as fun
  from v
connect by level <= length(v.����);
/*�ַ��������а�������*/
select 'g''day mate' qmarks
  from dual
union all
select 'beavers'' teeth'
  from dual
union all
select ''''
  from dual;

select q'[g'day mate]' qmarks
  from dual
union all
select q'[beavers' teeth]'
  from dual
union all
select q'[']'
  from dual;
/*�����ַ����ַ����г��ֵĴ���*/
create or replace view v as
select 'CLARK,KING,MILLER' as str from dual;

select regexp_count(str, ',') + 1 as cnt from v;

select length(regexp_replace(str, '[^,]')) + 1as cnt from v;

select length(translate(str, ',' || str, ',')) + 1 as cnt from v;

create or replace view v as
select '10$#CLARK$#MANAGER' as str from dual;
/*����д��*/
select length(translate(str, '$#' || str, '$#')) + 1 as cnt from v;
/*��ȷд��*/
select length(translate(str, '$#' || str, '$#')) / length('$#') + 1 as cnt
  from v;

select regexp_count(str, '\$#') + 1 as cnt from v;
/*���ַ�����ɾ������Ҫ���ַ�*/
select ename,
       replace(translate(ename, 'AEIOU', 'aaaaa'), 'a', '') strippedl
  from emp
 where deptno = 10;

select ename, translate(ename, '1AEIOU', '1') strippedl
  from emp
 where deptno = 10;

select ename, regexp_replace(ename, '[AEIOU]', '1')
  from emp
 where deptno = 10;
/*���ַ����������ݷ���*/
create table dept2 as select dname || deptno as data from dept;

select regexp_replace(data, '[0-9]', '') dname,
       regexp_replace(data, '[^0-9]', '') deptno
  from dept2;

select translate(data, 'a0123456789', 'a') dname,
       translate(data, '0123456789' || data, '0123456789') deptno
  from dept2;
/*��ѯֻ������ĸ�������͵�����*/
create or replace view v as
select '123' as data
  from dual
union all
select 'abc'
  from dual
union all
select '123abc'
  from dual
union all
select 'abc123'
  from dual
union all
select 'a1b2c3'
  from dual
union all
select 'a1b2c3#'
  from dual
union all
select '3$'
  from dual
union all
select 'a 2'
  from dual;

select data from v where regexp_like(data, '^[0-9a-zA-z]+$');

create or replace view v as
select 'A' as data
  from dual
union all
select 'AB'
  from dual
union all
select 'BA'
  from dual
union all
select 'BAC'
  from dual;

select * from v where regexp_like(data, 'A');

select * from v where regexp_like(data, '^A');

select * from v where regexp_like(data, 'A$');

select * from v where regexp_like(data, '^A$');

create or replace view v as
select '167' as str from dual union all select '1234567' as str from dual;

select * from v where regexp_like(str, '16+');

select * from v where regexp_like(str, '16*');

create table test as
select *
  from (with x0 as (select level as lv from dual connect by level <= 3)
         select replace(sys_connect_by_path(lv, ','), ',') as s
           from x0
         connect by nocycle prior lv <> lv)
          where length(s) <= 2;
insert into test values (null);

select * from test where regexp_like(s, '^[12]+$');

select * from test where regexp_like(s, '^[12]*$');
/*��ȡ�����Ĵ�д����ĸ��д*/
create or replace view v as
select 'Michael Hartstein' as a1 from dual;

select regexp_replace(v.a1, '([[:upper:]])(.*)([[:upper:]])(.*)', '\1.\3') as sx
  from v;

select a1, lower(a1) as a2 from v;

select translate(a1, ' ' || a2, '.') as a3
  from (select a1, lower(a1) as a2 from v);
/*���ַ����е���ֵ����*/
create or replace view v as
select dname || ' ' || deptno || ' ' || loc as data
  from dept
 order by dname;

select data, to_number(regexp_replace(data, '[^0-9]', '')) as deptno
  from v
 order by 2;

select data,
       to_number(translate(data, '0123456789' || data, '0123456789')) as deptno
  from v
 order by 2;
/*���ݱ��е��д���һ���ָ��б�*/
select deptno,
       sum(sal) as total_sal,
       listagg(ename, ',') within group(order by ename) as totoal_ename
  from emp
 group by deptno;
/*��ȡ��n���ָ����Ӵ�*/
create or replace view v as
select listagg(ename, ',') within group(order by ename) as name
  from emp
 where deptno in (10, 20)
 group by deptno;

select name,
       �ڶ������ź��λ��,
       ���������ŵ�λ��,
       ����,
       substr(name, �ڶ������ź��λ��, ����) as �Ӵ�
  from (select name,
               instr(src.name, ',', 1, 2) + 1 as �ڶ������ź��λ��,
               instr(src.name, ',', 1, (2 + 1)) as ���������ŵ�λ��,
               instr(src.name, ',', 1, (2 + 1)) - instr(src.name, ',', 1, 2) - 1 as ����
          from (select ',' || name || ',' as name from v) src) x;

select regexp_substr(v.name, '[^,]+', 1, 2) as �Ӵ� from v;
/*�ֽ�IP��ַ*/
select regexp_substr(v.ip, '[^.]+', 1, 1) a,
       regexp_substr(v.ip, '[^.]+', 1, 2) b,
       regexp_substr(v.ip, '[^.]+', 1, 3) c,
       regexp_substr(v.ip, '[^.]+', 1, 4) d
  from (select '192.168.1.118' as ip from dual) v;
/*���ָ�����ת��Ϊ��ֵIN�б�*/
create or replace view v as select 'CLARK,KING,MILLER' as emps from dual;

select regexp_substr(v.emps, '[^,]+', 1, level) as ename,
       level,
       'regexp_substr(''' || v.emps || ''',''[^,]+'',1,' || to_char(level) || ')' as reg
  from v
connect by level <= (length(translate(v.emps, ',' || v.emps, ',')) + 1);
/*�����л�������ڲ���*/
var v_emps varchar2;
exec :v_emps := 'CLARK,KING,MILLER';
select *
  from emp
 where ename in
       (select regexp_substr(:v_emps, '[^,]+', 1, level) as ename
          from dual
        connect by level <=
                   (length(translate(:v_emps, ',' || :v_emps, ',')) + 1));
/*����ĸ˳�������ַ���*/
var v_ename varchar2(50);
exec :v_ename := 'ADAMS';
select :v_ename as ename, substr(:v_ename, level, 1) as c
  from dual
connect by level <= length(:v_ename);

var v_ename varchar2(50);
exec :v_ename := 'ADAMS';
select :v_ename as ename,
       listagg(substr(:v_ename, level, 1)) within group(order by substr(:v_ename, level, 1)) as new_name
  from dual
connect by level <= length(:v_ename)
 group by :v_ename;

select ename,
       (select listagg(substr(ename, level, 1)) within group(order by substr(ename, level, 1))
          from dual
        connect by level <= length(ename)) as new_name
  from emp;

select ename,
       (select listagg(min(substr(ename, level, 1))) within group(order by min(substr(ename, level, 1)))
          from dual
        connect by level <= length(ename)
         group by substr(ename, level, 1)) as new_name
  from emp;
/*�б����Ϊ��ֵ���ַ���*/
create or replace view v as
select replace(mixed, ' ', '') as mixed
  from (select substr(ename, 1, 2) || cast(deptno as char(4)) ||
               substr(ename, 3, 2) as mixed
          from emp
         where deptno = 10
        union all
        select cast(empno as char(4)) as mixed
          from emp
         where deptno = 20
        union all
        select ename as mixed
          from emp
         where deptno = 30) x;

select to_number(case
                   when replace(translate(mixed, '0123456789', '9999999999'), '9') is not null then
                    replace(translate(mixed,
                                      replace(translate(mixed,
                                                        '0123456789',
                                                        '9999999999'),
                                              '9'),
                                      rpad('#', length(mixed), '#')),
                            '#')
                   else
                    mixed
                 end) mixed
  from v
 where instr(translate(mixed, '0123456789', '9999999999'), '9') > 0;

select translate('CL10AR', '0123456789', '9999999999') as mixed1 from dual;

select replace('CL99AR', '9') as mixed2 from dual;

select rpad('#', length('CL10AR'), '#') from dual;

select translate('CL10AR', 'CLAR', '######') as mixed2 from dual;

select replace('##10##', '#') as mixed2 from dual;

select replace(translate('7369', '0123456789', '9999999999'), '9') as mixed2
  from dual;

select mixed,
       /*select translate('CL10AR', '0123456789', '9999999999') as mixed1 from dual;
       ��һ�����滻����Ϊ9�����ΪCL99AR*/
       translate(mixed, '0123456789', '9999999999') as mixed1,
       /*select replace('CL99AR', '9') as mixed2 from dual;
       �ڶ�����ȥ��mixed1�е����֣����ΪCLAR*/
       replace(translate(mixed, '0123456789', '9999999999'), '9') as mixed2,
       /*select rpad('#', length('CL10AR'), '#') from dual ���ɴ�######
       select translate('CL10AR', 'CLAR', '######') as mixed2 from dual;
       ���������滻mixed�е��ַ�Ϊ#�����Ϊ##10##*/
       translate(mixed,
                 replace(translate(mixed, '0123456789', '9999999999'), '9'),
                 rpad('#', length(mixed), '#')) as mixed3,
       /*select replace('##10##', '#') as mixed2 from dual;
       ���Ĳ����滻��#�����Ϊ10*/
       replace(translate(mixed,
                         replace(translate(mixed, '0123456789', '9999999999'),
                                 '9'),
                         rpad('#', length(mixed), '#')),
               '#') as mixed4,
       /*���岽����case when����ֵ�жϣ���Ϊ�����滻��ʽ��������滻Ϊ��*/
       to_number(case
                   when replace(translate(mixed, '0123456789', '9999999999'), '9') is not null then
                    replace(translate(mixed,
                                      replace(translate(mixed,
                                                        '0123456789',
                                                        '9999999999'),
                                              '9'),
                                      rpad('#', length(mixed), '#')),
                            '#')
                   else
                    mixed
                 end) mixed5
  from v
 where instr(translate(mixed, '0123456789', '9999999999'), '9') > 0;

select mixed,
       translate(mixed, '0123456789' || mixed, '0123456789') as mixed1
  from v;

select to_number(mixed) as mixed
  from (select translate(mixed, '0123456789' || mixed, '0123456789') as mixed
          from v)
 where mixed is not null;

select to_number(mixed) as mixed
  from (select regexp_replace(mixed, '[^0-9]', '') as mixed from v)
 where mixed is not null;
