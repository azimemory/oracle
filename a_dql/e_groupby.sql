--GROUP BY ��
--Ư�� �÷��� �������� �׷��� ����� �׷� �Լ��� Ȱ���� �������� ���
--GROUP �Լ� : SUM(COLUMN), COUNT(COLUMN), AVG(COLUMN), MAX(COLUMN), MIN(COLUMN)

-- �μ��� �޿� �Ѿװ�, ��� �޿��� ���غ���
SELECT DEPT_CODE, SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ���� �÷����� �׷� �����
-- �μ� �� ���� �� �޿� �հ�� ����� ���غ���
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE ASC NULLS LAST;

--GROUP BY ���� ����� ��� GROUP BY������ �׷����� ������ �÷���
--SELECT���� ����� �� �ִ�.
--�� �׷��Լ� �ȿ��� ���ϴ� �÷��� ����� �� �ִ�.

--1. �޿��� 300���� �̻��� ������� �μ��� �޿� �Ѿ��� ���Ͻÿ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

--2. �޿��� 300���� �̻��� ������� ���޺� �޿� ����� ���Ͻÿ�
SELECT JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY JOB_CODE;

--3. �μ� �� ���� �� ���� ���� �� �޿��� �ְ� ������ �ּ� ������ ���Ͻÿ�
--  ���� �� �μ��� �������� �������� �����ϰ� NULL���� �Ʒ��� �����Ͻÿ�
SELECT DEPT_CODE, JOB_CODE, SAL_LEVEL, MAX(SALARY*12), MIN(SALARY*12)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, SAL_LEVEL
ORDER BY DEPT_CODE ASC NULLS LAST;

---------------------------------------------------------------
-- *** HAVING �� : GROUP BY�� ���� �׷쿡 ���� ������ ����
-- �޿��� 3000000 �̻��� �������� �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

-- �޿� ����� 3000000 �̻��� �μ��� �޿� ��� ��ȸ
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 30000;

--1.�μ��� �׷��� �޿��հ谡 9�鸸���� �ʰ��ϴ� �μ��ڵ�� �޿��հ踦 ��ȸ�ϰ�
-- �μ��ڵ� ������ �����Ͻÿ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY DEPT_CODE ASC;

---------------------------------------------------------------------------
--�����Լ�(ROLLUP, CUBE)
--�׷� �� ������ ��� ���� ���踦 ����ϴ� �Լ�
--�����Լ��� ������� ���� ����
SELECT DEPT_CODE, JOB_CODE, SAL_LEVEL, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, SAL_LEVEL
ORDER BY DEPT_CODE ASC NULLS LAST;

--ROLLUP, CUBE ���
--�׷캰 �߰� ���踦 ���
SELECT DEPT_CODE, JOB_CODE, SAL_LEVEL, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE, SAL_LEVEL)
ORDER BY DEPT_CODE ASC NULLS LAST;

--CUBE
--�׷����� ������ ��� �׷��� ��� ���տ� ���� �߰����踦 ���Ѵ�.
SELECT DEPT_CODE, JOB_CODE, SAL_LEVEL, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE, SAL_LEVEL)
ORDER BY DEPT_CODE ASC NULLS LAST;

--GROUPING �Լ�
-- ���ڷ� ���޹��� �÷� ������ ���⹰�̸� 0�� ��ȯ�ϰ�
-- �ƴϸ� 1�� ��ȯ�ϴ� �Լ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
,GROUPING(DEPT_CODE) �μ���, GROUPING(JOB_CODE) ���޺�
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE NULLS LAST;



















