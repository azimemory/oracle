--SUBQUERY
--�ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SQL��
--SUBQUERY �� SELECT��, FROM��, WHERE��, HAVING���� ��� ����

--���������� �ۼ��Ǵ� ��ġ�� ����
--SELECT�� : ��Į�� ��������
--FROM�� : �ζ��κ�
--WHERE, HAVING : ��������

--���������� ��� ��,���� ����
--������
--������
--���߿�



--�μ��ڵ尡 ���ö����� ���� �Ҽ��� ���� ����� ��ȸ�Ͻÿ�.
-- CASE.1 : ���� �ΰ� �ۼ�
select dept_code from employee where emp_name = '���ö';
select 
* 
from employee 
where dept_code = 'D9';

--CASE.2 : SUBQUERY Ȱ��
select 
* 
from employee 
where 
dept_code = (select dept_code from employee where emp_name = '���ö');

--�� ���� ��� �޿����� ���� �޿��� �ް� �ִ� ������
--���, �̸�, �����ڵ�, �޿��� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
--------------------------------------------------------------------
-- *** ������ ��������
-- ������ �������� : ���������� ��ȸ ��� ���� 1���� ��������
-- �񱳿����� ��� (<, >, <=, >=, = , !=, ^=, <>)

--1. ���ö ����� �޿����� ���� �޴� ������
-- ���, �̸�, �μ�, ����, �޿��� ��ȸ
SELECT EMP_ID, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMP WHERE EMP_NAME = '���ö');

--2. ���� ���� �޿��� �޴� ������
-- ���, �̸�, �޿�, �μ�, ����, �Ի����� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--3. �μ��� �޿��� �հ谡 ���� ū �μ��� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 
(SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);


-- *** ������ ��������
-- ���������� ��ȸ ��� ���� �������� ��
-- IN, ANY, ALL, EXISTS ������ ���
--IN : ���������� ��� ���� �߿��� �ϳ��� ��ġ�ϴ� ���� ������ TRUE
-- �ְ�޿��� 4999999�� ���� ���� �޿������ ������ �ִ� �������� ��ȸ�Ͻÿ�.
SELECT *
FROM EMPLOYEE
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM SAL_GRADE WHERE MAX_SAL < 4999999);

-- �񱳿����� ANY : ���������� ��� ���� �߿��� �ϳ��� �񱳿���� TRUE�� ������ TRUE 
--               WHERE 1 > ANY(SUBQUERY) -> SUBQUERY�� ������� 0,3,5 --> TRUE

-- �ڳ��� ���� �μ��� ���� ���� �޿��� �޴� ������� ������ ���� �ް�
-- �ڳ��� ���� �μ����� ���� ���� �޿��� �޴� ������ٴ� ���� �޿��� �޴� ������� ����� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY < ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE =
                    (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME= '�ڳ���'))
AND SALARY > ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE =
                    (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME= '�ڳ���'));

select *
from employee
where dept_code in (select dept_code from employee where email like '%n%');


-- �񱳿����� ALL : ���������� ��� ������ ��� �񱳿���� TRUE�� ���;� TRUE
--               WHERE 1 > ALL(SUBQUERY) -> SUBQUERY�� ������� 0,0.5,0.7 --> TRUE
--               ���������� ����� �߿��� ���� ū ������ ũ��.
--�ڳ��� ���� �μ��� ����� �� ���� ���� �޿��� �޴� ������� �� ���� �޿��� �޴� ������ ���
--�� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE SALARY > ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE =
                    (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME= '�ڳ���'));




-- EXISTS : SUBQUERY�� ����� �����ϸ� TRUE ������ FLASE
SELECT * FROM 
EMPLOYEE E
WHERE NOT EXISTS(SELECT EMP_ID FROM EMPLOYEE WHERE EMP_ID = e.manager_id);

-- *** ���߿� ��������
-- ���������� ����� �÷��� �������� ��� 
--����� ������ ���� �μ�, ���� ���޿� �ش��ϴ� ����� �̸�, ����, �μ�, �Ի����� ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y')
AND JOB_CODE IN(SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y');

--���߿�,(������) ��������
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 
(DEPT_CODE, JOB_CODE) IN(SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE 
WHERE ENT_YN = 'Y');

SELECT * 
FROM EMPLOYEE
WHERE
(DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE
WHERE EMP_ID = '200');

-------------------------------------------------------------------------
-- *** ��[ȣ��]�� ����
-- ��������� ���������� ����ϴ� �÷����� ���������� �̿��ϴ� ����
-- ���������� �÷����� �ٲ�� ���������� ������� �ٲ��.

--�������� ������ ���, �̸�, �μ��ڵ�, ������ ��� ��ȸ.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE E
WHERE EXISTS(SELECT EMP_ID FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);
---------------------------------------------------------------------
-- *** ��Į��(���ϰ�) ��������
-- SELECT ������ ���Ǵ� ��������
-- ��Į�� ���������� �ݵ�� ����� ���ϰ��� ��ȯ�Ǿ�� �Ѵ�.
-- ��� ����� ���, �̸�, �����ڻ��, �����ڸ��� ��ȸ
SELECT ROWNUM, EMP_ID, EMP_NAME, MANAGER_ID,
(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID)
FROM EMPLOYEE E 
ORDER BY EMP_NAME DESC;

-- *** ROWNUM : �ٹ�ȣ
-- * SELECT���� ����Ǵ� �ñ⿡ ���� ����ȴ�.
-- SELECT�� ���Ŀ� ����Ǵ� ORDER BY���� ����� ��� ROWNUM�� ���׹��� �ȴ�.

-- *** �ζ��� ��
-- FROM���� �������� ���
-- ���������� RESULTSET�� ���̺� ������� ���

-- �� ���� �� �޿��� ���� ���� ���� 5���� ����, �̸�, �޿��� ��ȸ�Ͻÿ�
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT * FROM EMPLOYEE ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- �� ���� �� �Ի����� ���� ���� ��� 5���� ����, �̸�, �Ի����� ��ȸ�Ͻÿ�
SELECT ROWNUM, EMP_NAME, HIRE_DATE
FROM (SELECT * FROM EMPLOYEE ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

-- *** WITH
-- ������ �̸��� �ٿ� �̸����� �ش� ������ ����� ȣ��
-- ���� ������ �ݺ������� ��� �� �� �ߺ��ۼ� ���� �� �ִ�.
-- ������ ����� �޸𸮿� ������ �ξ��ٰ�, �̸����� ȣ�� �� �� �Ҿ���� ����̱�
-- ������, ����ӵ��� ������.

WITH TOPN_SAL AS(SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE
    ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;






























































