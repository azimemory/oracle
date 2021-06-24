-- DML(Data Manipulation Language) : ������ ���� ���

-- ���̺� ���� �����ϰų�(INSERT), �����ϰų�(UPDATE), ����(DELETE)�ϴ� ����
--------------------------------------------------------------------------------------------------------------------

-- 1. INSERT

-- ���ο� ���� �߰��ϴ� ����
-- ���̺��� �� ������ ����

-- [ǥ����]
-- INSERT INTO ���̺��(�÷���, �÷���, �÷���,...)
-- VALUES (������1, ������2, ������3, ...);
-- ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
-- ���þȵ� �÷��� ���� NULL�� ��

insert into location
(local_code,national_code,local_name) 
values('L6','ID','ASIA4')


-- INSERT INTO ���̺�� VALUES(������, ������, ...)
-- ���̺� ��� �÷��� ���� ���� INSERT�� �� ���
-- INSERT�ϰ��� �ϴ� �÷��� ��� �÷��� ��� �÷��� ���� ����. ��, �÷��� ������ ���Ѽ� VALUES�� ���� �����ؾ� ��


insert into location
values('L7','TK','ASIA5')
        
COMMIT;
SELECT * FROM location


-- INSERT�� VALUES ��� �������� ��� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01 (
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
); -- ��ȣ ���� ����


--------------------------------------------------------------------------------------------------------------------

-- 2. INSERT ALL
-- INSERT�� ���������� ����ϴ� ���̺��� ���� ���,
-- �� �� �̻��� ���̺� INSERT ALL�� �̿��Ͽ� �ѹ��� ���� ����
-- ��, �� ���������� �������� ���ƾ� ��

-- INSERT ALL ����1
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
-- WHERE���� 1 = 0�� ��� ��� �࿡ ���ؼ� FALSE�� ����
-- �ƹ� ���ǵ� �������� �����Ƿ� ���� ���Ե��� �ʰ� ���̺� �÷��� �����ȴ�.
SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1 = 0;
   
SELECT * FROM EMP_MANAGER;

-- EMP_DEPT_D1���̺� EMPLOYEE���̺� �ִ� �μ��ڵ尡 D1�� ������
-- ��ȸ�ؼ� ���, �̸�, �ҼӺμ�, �Ի����� �����ϰ�,
-- EMP_MANAGER ���̺� EMPLOYEE���̺� �ִ� �μ��ڵ尡 D1�� ������
-- ��ȸ�ؼ� ���, �̸�, ������ ����� ��ȸ�ؼ� ����

SELECT * FROM EMP_MANAGER;

-- ���� ������ �������� DEPT_CODE = 'D1'���� ����
ROLLBACK;

INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT_D1;
SELECT * FROM EMP_MANAGER;


--------------------------------------------------------------------------------------------------------------------

-- 3. UPDATE

-- ���̺� ��ϵ� �÷��� ���� �����ϴ� ����
-- ���̺��� ��ü �� �������� ��ȭ�� ����

-- [ǥ����]
-- UPDATE ���̺�� SET �÷��� = �ٲܰ� [WHERE �÷��� �񱳿����� �񱳰�];


--�μ����̺� �����ϱ�, select������ ���̺��� ���� �� �ִ�.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;


-- update������ �ۼ��ϱ� ������ 
-- ������ select���� ���ϴ� �������� �´��� ���� �����Ϻ��� ���� ����.
SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺��� DEPT_ID �� 'D9'�� ���� DEPT_TITLE�� '������ȹ��' ���� ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_COPY;

COMMIT;

-- �������� �������� �ʰ� UPDATE ���� ���� �� ��� ���� �÷� �� ����.
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��';

SELECT * FROM DEPT_COPY;
ROLLBACK;


-- UPDATE�ÿ��� ���������� ��� ����

-- [ǥ����]
-- UPDATE ���̺��
-- SET �÷��� = (��������)

--  ���� ����� �޿��� ���ʽ����� ����� ����� �����ϰ� ������ �ֱ�� �ߴ�.
--  �̸� �ݿ��ϴ� UPDATE���� �ۼ��Ͻÿ�.

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;
   
SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('�����', '����');

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '�����'),
     BONUS = (SELECT BONUS
              FROM EMPLOYEE
              WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('�����', '����');


-- ������, ���߿� ���������� �̿��� UPDATE

-- EMP_SALARY���̺��� �ƽþ������� �ٹ��ϴ� ������ ���ʽ��� 0.3���� ����
-- �ƽþ� ������ �ٹ��ϴ� ����
SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME 
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';


-- �ƽþ� ���� �ٹ� ���� ���ʽ� 0.3���� ����
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                 FROM EMPLOYEE
                 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                 JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME 
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';


-- *** UPDATE�� ������ ���� �ش� �÷��� ���� �������ǿ� ������� �ʾƾ� ��



------------------------------------------------------------------------------------------------------------------
-- 5. DELETE

-- ���̺��� ���� �����ϴ� ����
-- ���̺��� ���� ������ �پ��
-- DELTE FROM ���̺�� WHERE ���Ǽ���
-- ���� WHERE ������ �������� ������ ��� ���� �� ������

COMMIT;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '��ä��';
SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';   -- FOREIGN KEY ���������� ������ �Ǿ� �ִ� ���
                        -- �����ǰ� �ִ� ���� ���ؼ��� ������ �� ����.

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';   -- FORIGN KEY ���������� ������ �Ǿ� �־
                        -- �����ǰ� ���� �ʴ� ���� ���ؼ��� ���� ����

ROLLBACK;

-- ���� �� FOREIGN KEY ������������ �÷� ������ �Ұ��� �� ���
-- ���������� ��Ȱ��ȭ �� �� �ִ�.
ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT SYS_C007093 CASCADE;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

ROLLBACK;

INSERT INTO DEPARTMENT
VALUES ('D1', '�λ������', 'L1');

-- ��Ȱ��ȭ �� ���������� �ٽ� Ȱ��ȭ
ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT SYS_C007093; 

-- TRUNCATE : ���̺��� ��ü ���� ������ �� ����Ѵ�.
--            DELETE���� ����ӵ��� �� ������.
--            ROLLBACK�� ���� ������ �� ����.

SELECT * FROM EMP_SALARY;
COMMIT;

DELETE FROM EMP_SALARY;

delete from employee
where emp_id = (select emp_id from employee where emp_id = '200')

SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY emp_id = (select emp_id from employee where emp_id = '200');

SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;
