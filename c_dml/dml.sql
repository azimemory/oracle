--DML(DATA MANIPULATION LANGUAGE) : ������ ���۾��
--���̺� ���� �����ϰų�(INSERT), �����ϰų�(UPDATE), ����(DELETE)

--TCL(TRANSACTION CONTROLL LANGUAGE)
-- TRANSACTION : ���� �ּ� �۾� ����
-- COMMIT/ROLLBACK
-- COMMIT : DML�� ���ؼ� ����� ������ ���̺� �ݿ�
-- ROLLBACK : DML�� ���ؼ� ����� ������ ������ COMMIT�� �������� �ǵ��� ���� ��
-- ����! : DDL�� �ڵ� COMMIT�̴�.
--       DML�� �ۼ��ϰ� DDL�� ���޾� �ۼ��� ��� DDL�� �ڵ����� COMMIT �Ǹ鼭
--       DML�� ���� COMMIT �Ǿ������.

--INSERT 
--���ο� ���� �߰��ϴ� ����
--ǥ����
--INSERT INTO ���̺��(�÷���,�÷���...) VALUES(������1, ������2...)
--�������� ���� �÷����� NULL�� ����.
--INSERT INTO ���̺�� VALUES(������1, ������2...) -> ��� �÷��� �����͸� �־�� �Ѵ�.

--JOB_CODE�� 'J10'�̰� ���޸��� �̻��� �����͸� JOB ���̺� �߰��Ͻÿ�.
INSERT INTO JOB(JOB_CODE, JOB_NAME) VALUES('J0','�̻�');
SELECT * FROM JOB;
--COMMIT�� ���� �ʾƼ� '�̻�' ������ ����
ROLLBACK;
--COMMIT���Ŀ��� ROLLBACK�� �ص� �����Ͱ� ������� ����
COMMIT;

--LOCATION���̺� LOCAL_CODE�� 'L6', NATIONAL_CODE�� 'ID', LOCAL_NAME�� 'ASIA4'��
--�����͸� �߰��ϰ� COMMIT �Ͻÿ�
INSERT INTO LOCATION(LOCAL_CODE,NATIONAL_CODE,LOCAL_NAME)
VALUES('L6','ID','ASIA4');
COMMIT;
SELECT * FROM LOCATION;

--���������� ������ �Է��ϱ�
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_DEPT(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_DEPT;
COMMIT;

--------------------------------------------------------------------------
--2. INSERT ALL
-- �� �� �̻��� ���̺� �ѹ��� �����͸� �߰��ϴ� ����
-- 1. ���������� ����ؼ� INSERT�� �ۼ��ϰ�
-- 2. ���������� �������� �����ؾ� �Ѵ�.

--INSERT ALL�� ���Ӱ� �����͸� �߰��ϱ� ���� EMP_DEPT ���̺��� �����͸� ����
DELETE FROM EMP_DEPT;
COMMIT;

--���ο� ���̺� ����
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE WHERE 1 = 0;

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_DEPT_D1;

--EMP_DEPT ���̺� �μ��ڵ尡 D1�� ������ ��ȸ�ؼ�
-- ���, �̸�, �ҼӺμ����� ���� ROW�� �߰��ϰ�
--EMP_DEPT_D1 ���̺� �μ��ڵ尡 D1�� ������ ��ȸ�ؼ�
-- ���, �̸�, �ҼӺμ��ڵ�, �Ի����� ���� ROW�� �߰�
INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
    INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE E
    LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE DEPT_CODE = 'D1';
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_DEPT_D1;

---------------------------------------------------------------------------
--3. UPDATE
-- ���̺� ��ϵ� �÷� ���� �����ϴ� ����
-- ǥ����
-- UPDATE ���̺�� SET �÷��� = ������ �� [WHERE ��]
-- EMP_DEPT ���̺��� �̸��� �������� ����� �μ����� '�λ��λ��'�� ����
UPDATE EMP_DEPT SET DEPT_TITLE = '�λ��λ��' WHERE EMP_NAME = '������';
SELECT * FROM EMP_DEPT;
COMMIT;
ROLLBACK;

-- UPDATE�� ���� ����!
-- 1. ���� WHERE���� �ۼ����� �ʰ� UPDATE���� �ۼ��� ��� �ش� ���̺��� ��� ���� �����Ǳ� ������
--  �ݵ�� WHERE���� �ۼ��� ��
-- 2. UPDATE���� �ۼ��ϰ� �����ϱ� ���� �ݵ�� ���� WHERE���� ���� SELECT���� ����
--  ������ �����ϰ��� �ϴ� �����Ͱ� �´� �� Ȯ���ϰ� UPDATE���� ������ ��

--���������� �̿��� UPDATE ��
-- ǥ����
-- UPDATE ���̺�� SET �÷��� = (��������)
--���� ����� �޿��� ���ʽ����� ����� ����� �����ϰ� �������ִ� UPDATE���� �ۼ��Ͻÿ�
UPDATE EMPLOYEE
SET SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';
SELECT * FROM EMPLOYEE WHERE EMP_NAME IN('����','�����');
ROLLBACK;

--�ƽþ� �������� �ٹ��ϴ� ������ ���ʽ��� 0.3���� �����Ͻÿ�
--�ݵ�� ROLLBACK �� ��
UPDATE EMPLOYEE
SET BONUS = 0.3
WHERE EMP_ID IN(SELECT EMP_ID
    FROM EMPLOYEE E
    INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
    WHERE LOCAL_NAME LIKE 'ASIA%');
    
SELECT *
    FROM EMPLOYEE E
    INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
    WHERE LOCAL_NAME LIKE 'ASIA%';    
ROLLBACK;

--5 DELETE
-- ���̺��� ���� �����ϴ� ����
-- WHERE ������ �������� ������ ��� ���� �� ������
--ǥ����
--DELETE FROM ���̺�� WHERE ���ǽ�

--�̸��� �������� ����� EMPLOYEE ���̺��� �����Ͻÿ�
DELETE FROM EMPLOYEE WHERE EMP_NAME = '������';
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '������';
ROLLBACK;

-- TRUNCATE : ���̺��� ��ü ���� ������ �� ���
--          DELETE�� ��ü ���� ������ �� ���� ������.
--          ROLLBACK�� �ȵ�
TRUNCATE TABLE EMP_DEPT;
SELECT * FROM EMP_DEPT;
ROLLBACK;

























