-- *** JOIN
--�ϳ� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ���
--�������� �ϳ��� RESULT SET ���� ���´�.
--������ �����ͺ��̽������� �������� �ߺ��� �ּ�ȭ �ϱ� ���� �ּ����� �����͸�
--���̺� �����صΰ�, �ʿ��� �� ���̺� ���踦 ���� �����͸� �����ؼ� �����Ѵ�.

--������ȣ, ������, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E JOIN DEPARTMENT D
ON(E.DEPT_CODE = D.DEPT_ID);

-- 0.CROSS JOIN(�Ⱦ�)
-- Cartesan ���� �߻��ϱ� ������ ������� �ʴ´�.
-- �� �� ���̺��� ��� ��� �ٸ� ���̺��� ��� ���� JOIN
-- EMPLOYEE ���̺��� ROW�� * DEPARTMENT ���̺��� ROW�� ��ŭ�� ROW�� ����
-- 3���� ��ǰ�����Ϳ� 5������ �ֹ������͸� CROSS JOIN �ϸ� 15�ﰳ�� ROW�� ��ȯ
SELECT *
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY EMP_ID DESC, DEPT_ID ASC;

--JOIN�� ����
-- CROSS JOIN, INNER JOIN, OUTER JOIN(LEFT JOIN, RIGHT JOIN)
-- 1. INNER JOIN (� ���� (EQUALS JOIN))
-- JOIN ���ǹ��� �ۼ��Ͽ� ���ǹ��� �����ϴ� ROW�鸸 JOIN�� ����
-- ON() �ȿ� JOIN �������� �ۼ�
-- ���࿡ ���������� ����� �� ���̺��� �÷����� ���ٸ� USING(�÷���)�������ε� ����
SELECT *
FROM EMPLOYEE E 
INNER JOIN JOB J 
ON(E.JOB_CODE = J.JOB_CODE);

--ANSI ǥ�ر���
--ANSI(�̱� ���� ǥ�� ��ȸ)���� ������ ǥ�� ����
--ON ���
SELECT EMP_ID, EMP_NAME,E.JOB_CODE, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E 
INNER JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

--USING ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE JOIN JOB USING(JOB_CODE);

--���� ���̺� JOIN �غ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E 
INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

--ORACLE ����
--JOIN�� ���̺��� ,���� �����ϰ�
--JOIN �������� WHERE ���� �ۼ�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JFROOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

--���� ���̺� JOIN
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE
E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE;

--�μ� ���̺��� �μ��� �������� ��ȸ�ϼ���
--ANSI
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
INNER JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
--ORACLE
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
--------------------------------------------------------
-- *** OUTER JOIN
-- JOIN �������� ��ġ���� �ʴ� ROW�� JOIN�� ���� ��Ų��.
-- LEFT [OUTER] JOIN, RIGHT [OUTER] JOIN, FULL OUTER JOIN

--OUTER JOIN�� ���� INNER JOIN ������ �ۼ�
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--���ο� ���� �Է�
INSERT INTO JOB(JOB_CODE, JOB_NAME) VALUES('J8','����');
COMMIT;
SELECT * FROM JOB;

--1) LEFT [OUTER] JOIN : FROM������ LEFT JOIN ���� ���� ���̺��� �������� JOIN �߻�
SELECT *
FROM JOB LEFT JOIN EMPLOYEE USING(JOB_CODE) ORDER BY JOB_CODE;
--2) RIGHT [OUTER] JOIN : FROM������ RIGHT JOIN ���� ������ ���̺��� �������� JOIN �߻�
SELECT * 
FROM EMPLOYEE RIGHT JOIN JOB USING(JOB_CODE) ORDER BY JOB_CODE;
--ORACLE
--JOIN ���������� JOIN�� ������ ���� �ʴ� ���̺��� �÷��� (+) �� ǥ��
SELECT *
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE(+) = J.JOB_CODE;
--3. FULL OUTER JOIN : ���� �������� ��ġ���� �ʴ� ROW�� �� ���̺� ��� ����� ���Խ�Ŵ
SELECT EMP_NAME, DEPT_TITLE, DEPT_ID
FROM EMPLOYEE 
FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

--4. �� ����(NON EQUAL JOIN)
-- ���� �������� '=' ��� �ٸ� �����ڸ� ����ϴ� JOIN��
-- �������� ������ ���ԵǴ� ����� ������ �� ����Ѵ�.
SELECT 
EMP_NAME, SALARY, E.SAL_LEVEL, S.MIN_SAL, S.MAX_SAL
FROM EMPLOYEE E JOIN SAL_GRADE S
ON(E.SALARY < 2500000 AND S.MAX_SAL < 2999999);

--5.��ü ����(SELF JOIN)
-- �ڱ� �ڽŰ� JOIN
-- EMPLOYEE ���̺��� ����� �̸�, �μ��ڵ�, ������ ���, ������ �̸��� ����Ͻÿ�
--SUB QUERY
SELECT EMP_NAME, DEPT_CODE, MANAGER_ID
, (SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) �����ڸ�
FROM EMPLOYEE E;

--SELF JOIN
SELECT E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME
FROM EMPLOYEE E JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);







































