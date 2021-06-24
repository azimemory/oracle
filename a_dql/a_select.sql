--Oracle�� Ÿ��
--���ڿ� : char, varchar2
--���� : number
--��¥ : date

--select
--���̺��� ���ϴ� �����͸� ��ȸ�ϴ� ����
--select���� ����� -> result set(��ȯ�� ����� ����)
--�ۼ��� : select �÷� �� from ���̺� �� where ���ǽ�
-- ���̺��� ���ǽĿ� �����ϴ� row���� �÷� ������ ��ȸ

---------------�ǽ�--------------------
--1. JOB���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME FROM JOB;
--2. EMPLOYEE ���̺��� ����� �̸�, �޿��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY FROM employee;
--3. EMPLOYEE ���̺��� ��� ������ ��ȸ
SELECT * FROM EMPLOYEE;
--4. JOB ���̺��� ��� ���� ��ȸ
SELECT * FROM JOB;
--5. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT * FROM DEPARTMENT;
--6. EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;
--7. EMPLOYEE ���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;

-------------------------------------------------------------------
-- **** �÷� �� ��� ���� ****
-- ��������� : +, - , * , /
-- SELECT�� �ۼ��� SELECT��(�÷� �ۼ��ϴ� �κ�)�� ��������� �̿��Ͽ�
--                                           ����� ��ȸ�� �� �ִ�.
-- 1. EMPLOYEE ���̺��� ������ �̸��� ������ ��ȸ(������ �޿� * 12)
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

--*** �÷� ��Ī ***
--���� : �÷��� as ��Ī / �÷��� ��Ī / �÷��� "��Ī" / �÷��� as "��Ī"
-- ���� ��Ī�� ����, Ư������, ���ڰ� ���Ե� ��� "" �ʼ�
select emp_name as ����̸�, salary*12 as ���� from employee;

--�ǽ�--
--1. employee ���̺��� ������ �̸�, ����, ���ʽ��� �߰��� ������ ��ȸ�Ͻÿ�.
select emp_name, salary*12 , salary*(1+bonus)*12 from employee;
--����
select emp_name, salary*12, salary*(1+nvl(bonus,0))*12 from employee;

--*** ���ͷ� ***
--�������� ���� ���Ǵ� ��, select������ ����� ��� ��ġ ���̺� �����ϴ� ������ó�� RESULT SET�� ���Ե� �� �ִ�.
--EMPLOYEE ���̺��� ������ �����, �޿�, ������ ��ȸ
SELECT EMP_NAME, SALARY,'��' FROM EMPLOYEE;

--1. EMPLOYEE ���̺��� ������ ��ȭ��ȣ, �����, �޿�, ����(��) ��ȸ
SELECT PHONE, EMP_NAME, SALARY, '��' AS ���� 
FROM EMPLOYEE;

--*** ���ڿ� ���տ����� ***
-- || ������
-- �÷��� ���ͷ��� �����ؼ� ����ϰų�, ���� �÷��� �ϳ��� �÷� ó�� ��� ����
--1. EMPLOYEE ���̺��� ���, �̸�, �޿��� �����ϴ� ���
SELECT EMP_ID || EMP_NAME || SALARY FROM EMPLOYEE;
--2. EMPLOYEE ���̺��� �÷��� ���ͷ��� �����غ���
SELECT EMP_NAME || '���� ������ ' || SALARY || '�� �Դϴ�.'
FROM EMPLOYEE;

------------------------------�ǽ� ����--------------------------
--1. EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ��� ��ȸ
-- HINT : ��¥(DATE)���ĵ� - ������ ����
-- HINT2 : ���� ��¥�� SYSDATE�� ���� �� �ִ�.

select emp_name, hire_date, sysdate - hire_date as �ٹ��ϼ�
from employee;

-- *** DISTINCT ***
--�÷��� ���Ե� �ߺ��� ROW�� �����ϰ� ǥ���ϰ��� �� �� ���
--EMPLOY ���̺��� ���� �����ڵ带 ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;









