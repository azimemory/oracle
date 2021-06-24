--where ��
--��ȸ�� ���̺��� ���ϴ� row�� ��ȸ�ϱ� ���� �ۼ��ϴ� ���ǹ�
--select �÷��� from ���̺�� where ������
-- *** �񱳿�����, ��������
-- �񱳿����� : <, >, <=, >=, = 
--          ���� �ʴ� : !=, ^=, <>
-- �������� : and, or, not
--1. EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE = 'D9';
--2. EMPLOYEE ���̺��� �޿��� 4000000�̻��� �������� �̸��� ������ ��ȸ
select emp_name, salary*12 from employee where salary >= 4000000;
--3. EMPLOYEE ���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ带 ��ȸ
select emp_id, emp_name, dept_code from employee where dept_code != 'D9';
--4. EMPLOYEE ���̺��� ��翩�ΰ� N�� ������ ��ȸ�ϰ�, �ٹ����θ� '������'����
--   ǥ���Ͽ� ���, �̸�, �����, �ٹ����θ� ��ȸ�Ͻÿ�
select emp_id, emp_name, hire_date, '������' �ٹ����� from employee
where ent_yn = 'N';
--5. EMPLOYEE ���̺��� ������ 3000000 �̻��� ����� �̸�, ����, ����� ��ȸ
select emp_name, salary, hire_date from employee where salary >= 3000000;
--6. EMPLOYEE ���̺��� ��������(���Ŀ���, ���� 3%)�� 4500���� �̻���
--  ����� �̸�, ����, �Ǽ��ɾ�, ������� ��ȸ
select emp_name, salary, salary*0.97 as �Ǽ��ɾ�, hire_date
from employee 
where salary*0.97*12 >= 45000000;
-----------------------------------------------------------------
-- *** and, or ***
--1. �μ��ڵ尡 'D6' �̰� �޿��� 200���� ���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿��� ��ȸ
select emp_name, dept_code, salary 
from employee 
where dept_code = 'D6' and salary > 2000000;

--2. EMPLOYEE ���̺��� ������ 400���� �̻��̰� JOB�ڵ尡 J2�� ����� ��� �÷��� ��ȸ
select * from employee where salary >= 4000000 and job_code = 'J2';

--3.EMPLOYEE ���̺��� �μ��ڵ尡 D9�̰ų�  D5�� ��� �� ������� 02/01/01 ���� ����
--  ����� �̸�, �μ��ڵ�, ����� ��ȸ
select emp_name, dept_code, hire_date 
from employee 
where 
(dept_code = 'D9' 
or dept_code = 'D5')
and hire_date < '02/01/01';

--4. EMPLOYEE ���̺��� ������ 350���� �̻��̰� 600���� ������ ������ 
--  ���, �̸�, �޿�, �����ڵ带 ��ȸ
select 
emp_id, emp_name, salary, job_code 
from employee
where salary >= 3500000 and salary <= 6000000;

-- *** BETWEEN AND ***
-- �÷��� BETWEEN ���Ѱ� AND ���Ѱ�
SELECT
EMP_ID, EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
--NOT ������������
--������ 350�� �̻� 600�� ���� ���� ���� ����� ������ ��ȸ
SELECT
EMP_ID, EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

------------------------�ǽ� ����----------------------
--1. EMPLOYEE ���̺��� ������� 90/01/01 ~ 01/01/01 �� �ƴ� ����� ��ü ������ ��ȸ
SELECT * FROM EMPLOYEE WHERE hire_date NOT BETWEEN '90/01/01' AND '01/01/01';

-- *** LIKE ***
--�÷��� ���ڰ��� LIKE���� ������ Ư�� ������ ������Ű�� TRUE�� ��ȯ
--�÷��� LIKE '��������'
-- '%', '_'
-- '%' : '����%' ('����'�� �����ϴ� ���ڿ�)
--       '%����' ('����'�� ������ ���ڿ�)
--       '%����%'('����'�� �����ϴ� ���ڿ�)

--EMPLOYEE ���̺��� ���� ������ ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

--EMPLOYEE ���̺��� ���� �̾��̰� �Ի����� 12/01/01 ������
--����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%' AND hire_date >= '12/01/01';

-- EMPLOYEE ���̺��� �̸��� '��'�� ���� �μ��ڵ尡 'D5'�� ����� ��ȸ
SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND DEPT_CODE = 'D5';

-- EMPLOYEE ���̺��� �̸��� '��'���� ������ ����� ��� ������ ��ȸ
SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--���� �ڸ��� ����: '_'(�� �ڸ�)
--                 '__'(�� �ڸ�)
--EMPLOYEE ���̺��� ��ȭ��ȣ 4��° �ڸ����� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
--WHERE PHONE LIKE '___9%';
WHERE PHONE LIKE '%9___';

--�̸��� �� '_' �� �� ���ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ��� ���� ��ȸ
-- EX) SUN_DI@KH.OR.KR
-- �̹� ���ϵ�ī�� ���ڷ� ��ϵ� Ư�����ڸ� ����ؼ� �˻��ؾ��� ���
-- �ش� Ư������ �տ� ������ Ư�����ڸ� ����ϰ� ESCAPE OPTION���� ���
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-------------�ǽ� ����-------------------
--1. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ ��ȸ
select emp_name, phone from employee where not phone like '010%';
--2. EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4���� �̸鼭
--  DEPT_CODE�� D9 �Ǵ� D6�̰�
--  ������� 90/01/01 ~ 00/12/01 �̸鼭 �޿��� 270���� �̻��� ����� ��ü ������ ��ȸ
select *
from employee
where email like '____$_%' escape '$' 
and (dept_code = 'D9' OR DEPT_CODE = 'D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY >= 2700000;


----------------------�ǽ� ����------------------------
--1. ������ J7�Ǵ� J2�� ���� �� �޿��� 200���� �̻��� ������ �̸�, �޿�, �����ڵ带 ��ȸ
select emp_name, salary, job_code from employee 
where (job_code = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

-------------------------------------------------------------------
-- *** IN ***
-- ���ϴ� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ
-- �÷��� IN(��,��,��....)
-- OR�� ���ϰ� ����� �� �ִ�.

--D6�μ��� D8�μ��� ������� �̸�, �μ��ڵ�, �޿��� ��ȸ
SELECT
DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D8' OR DEPT_CODE = 'D6';

--IN�� Ȱ���� ���
SELECT
DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D8','D9');

-- *** IS NULL
-- �÷����� NULL�� ��� TRUE�� ��ȯ
-- ���ʽ��� ���� �ʴ� (BONUS �÷��� ���� NULL��) ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS IS NULL;
WHERE NOT BONUS IS NULL;


--������ �켱����
--1. ���������
--2. ���Ῥ����
--3. �񱳿�����
--4. IS NULL, LIKE, IN
--5. BETWEEN AND
--6. NOT
--7. AND
--8. OR



























