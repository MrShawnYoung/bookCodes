/*��ָ���Ĵ��򷵻ز�ѯ���*/
select empno, ename, hiredate
  from emp
 where deptno = 10
 order by hiredate asc;
/*������������*/
select empno, ename, hiredate from emp where deptno = 10 order by 3 asc;
/*������ֶ�����*/
select empno, deptno, sal, ename, job from emp order by 2 asc, 3 desc;
/*���Ӵ�����(�����ڣ�ֻչʾ���)*/
select last_name as ����,
       phone_number as ����,
       salary as ����,
       substr(phone_number, -4) as β��
  from hr.employees
 where rownum <= 5
 order by 4;
/*TRANSLATE*/
select translate('ab ��� bcadefg', 'abcdefg', '1234567') as NEW_STR
  from dual;
/*�����ֺ���ĸ����ַ����е���ĸ����*/
create or replace view V as
  select empno || ' ' || ename as data from emp;
select * from v;
select data, translate(data, '- 0123456789', '-') as ename
  from v
 order by 2;
/*���������ֵ*/
select ename, sal, comm, nvl(comm, -1) order_col from emp order by 4;
/*��ǰ*/
select ename, sal, comm from emp order by 3 nulls first;
/*�ں�*/
select ename, sal, comm from emp order by 3 nulls last;
/*��������ȡ��ͬ���е�ֵ������*/
select empno as ����,
       ename as ����,
       case
         when sal >= 1000 and sal < 2000 then
          1
         else
          2
       end as ����,
       sal as ����
  from emp
 where deptno = 30
 order by 3, 4;

select empno as ����, ename as ����, sal as ����
  from emp
 where deptno = 30
 order by case
            when sal >= 1000 and sal < 2000 then
             1
            else
             2
          end,
          3;
