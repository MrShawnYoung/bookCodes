/*��ѯ��������������*/
select * from emp;
/*�ӱ��м���������*/
select * from emp where job = 'SALESMAN';
/*���ҿ�ֵ*/
select * from emp where comm is null;
/*����ֵת��Ϊʵ��ֵ��coalesce֧�ֶ������*/
select coalesce(comm, 0) from emp;
/*������������������*/
select *
  from emp
 where (deptno = 10 or comm is not null or (sal <= 2000 and deptno = 20));
/*�ӱ��м���������*/
select empno, ename, hiredate, sal from emp where deptno = 10;
/*Ϊ��ȡ�����������*/
select ename as ����, deptno as ���ű��, sal as ����, comm as ���
  from emp;
/*��where�Ӿ�������ȡ��������*/
select *
  from (select sal as ����, comm as ��� from emp) x
 where ���� < 1000;
/*ƴ����*/
select ename || '�Ĺ�����' || job as msg from emp where deptno = 10;
/*��select�����ʹ�������߼�*/
select ename,
       sal,
       case
         when sal <= 2000 then
          '����'
         when sal >= 4000 then
          '����'
         else
          'OK'
       end as status
  from emp
 where deptno = 10;
/*���Ʒ��ص�����*/
select * from emp where rownum <= 2;
/*�ӱ����������n����¼*/
select empno, ename
  from (select empno, ename from emp order by dbms_random.value())
 where rownum <= 3;
/*ģ����ѯ*/
create or replace view v as
  select 'ABCEDF' as vname
    from dual
  union all
  select '_BCEFG' as vname
    from dual
  union all
  select '_BCEDF' as vname
    from dual
  union all
  select '_\BCEDF' as vname
    from dual
  union all
  select 'XYCEG' as vname
    from dual;
/*escape��'\'��ʶΪת���ַ�*/
select * from v where vname like '%CED%';
select * from v where vname like '\_BCE%' escape '\';
select * from v where vname like '_\\BCE%' escape '\';
