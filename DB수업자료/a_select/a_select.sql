-- SELECT 
-- Result Set : SELECT �������� �����͸� ��ȸ�� �����. ��ȯ�� ����� ������ �ǹ�.

-- EMPLOYEE ���̺��� ����� �̸�, �޿� ��ȸ
 -- ��ȸ�ϰ��� �ϴ� �÷����� �Է�.
SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��� ���� ��ȸ
 -- ��� �÷����� ���� �ʰ� '*'  ���. (* �� ��� ��� ��)
SELECT * FROM EMPLOYEE;


---------- �ǽ����� -----------
-- 1. JOB ���̺��� ��� ���� ��ȸ
SELECT * FROM JOB;

-- 2. JOB ���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME FROM JOB;

-- 3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE ���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------------------------------------------

-- *** �÷� �� ��� ���� ***
--��������� : + - * /
 -- SELECT �� �÷� �� �Է� �κп� ��꿡 �ʿ��� �÷��� , ����, �����ڸ� �̿��Ͽ� ����� ��ȸ�� �� �ִ�.
 
 -- EMPLOYEE ���̺��� ������ ������, ���� ��ȸ (������ �޿� * 12)
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ ������, ����, ���ʽ��� �߰��� ���� ��ȸ(1)
SELECT EMP_NAME, SALARY*12, (SALARY+(SALARY*BONUS)) * 12
FROM EMPLOYEE; 
-- ���ʽ��� null�� ����� ���ʽ��� �߰��� ���� ��� �� null�� ��µ�.

--��������
SELECT EMP_NAME ����̸�, 
SALARY*12 ����,
(SALARY+(SALARY*NVL(BONUS,0))) * 12 �Ѽ��ɾ�, 
( (SALARY+(SALARY*NVL(BONUS,0))) * 12) - (SALARY*12*3/100) �Ǽ��ɾ�
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������ ������, ����, ���ʽ��� �߰��� ���� ��ȸ(2) (���ĸ� �ٸ�)
SELECT EMP_NAME, SALARY*12, (SALARY*(1+BONUS)) * 12
FROM EMPLOYEE;

 -- *** �÷� ��Ī ***
  -- ���� : �÷��� AS ��Ī   / �÷��� "��Ī" / �÷��� AS "��Ī"
  -- ���� ���ʽ��� �ջ�� ������ ��ȸ�ϸ� �÷����� �ʹ� �������ϰ� ���´�.
  -- �̶� �� �÷��� ��Ī�� �ο��ؼ� ����ϰ� ������ �� �ִ�
  -- AS�� ���� �Ⱦ��� ��Ī�� ���� Ȥ�� Ư������, ���ڰ� ���Ե� ��� ���������̼� ��ߵ�
  
-- EMPLOYEE ���̺��� ������ ������(��Ī : �̸�), ����(��Ī : ����(��)) , ���ʽ��� �߰��� ����(��Ī : �Ѽҵ�(��)) ��ȸ
SELECT EMP_NAME AS �̸�, 
    SALARY*12 "����(��)",  
    SALARY*(1+BONUS)*12  AS "�Ѽҵ�(��)"
FROM EMPLOYEE;
  
 
-----------------------------------------------------------------------------------------------------------------------------------------
 
-- *** ���ͷ� ***
 -- ���Ƿ� ������ ���ڿ��� SELECT���� ����ϸ�, ���̺� �����ϴ� ������ó�� ����� �� �ִ�.
 -- ���ڳ� ��¥ ���ͷ��� ' ' ��ȣ ���
 -- ���ͷ��� Result Set�� ��� �࿡ �ݺ� ǥ�õ�.

-- EMPLOYEE ���̺��� ������ ������ȣ, �����, �޿�, ����(������ �� : ��) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS ����
FROM EMPLOYEE;


-----------------------------------------------------------------------------------------------------------------------------------------
 
 -- *** || ���� ������ ***
 -- ���� �÷��� �ϳ��� �÷��� ��ó�� �����ϰų�, �÷��� ���ͷ��� ������ �� �ִ�.
 
 -- EMPLOYEE ���̺��� ���, �̸�, �޿��� ������ ���
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- �÷��� ���ͷ� ����
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.'
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------------------------------------------

--------------- �ǽ����� --------------
-- 1. EMPLOYEE ���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT EMP_NAME, SALARY*12, (SALARY+(SALARY*BONUS)) * 12, ( (SALARY+(SALARY*BONUS)) * 12) - (SALARY*12*3/100)
FROM EMPLOYEE;

-- 2. EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ�(���� ��¥ - �����) ��ȸ
 -- DATE���� ���� ���굵 ����
 -- SYSDATE : ���� ��¥ 
 SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
 FROM EMPLOYEE;
  -- ��� ���� �� ���� ��µ� ��. 
  -- �������� ������ DATE�� ��/��/��/��/��/�� ������ �ð������� �����ϹǷ�
  -- ��/��/�� �������� �����ϴٺ��� �������ϰ� ����.
 -----------------------------------------------------------------------------------------------------------------------------------------
 
--  WHERE �� 
-- ��ȸ�� ���̺��� ������ �°��ϴ� ���� ���� ���� ���
/*SELECT �÷��� FROM ���̺��  WHERE ����*/
-- ���ǿ��� ���������� �ִ�

-- *** �� ������ ***
-- = ����, > ũ��, < �۳�, >= ũ�ų� ����, <= �۰ų� ����
-- != , ^=, <> ���� �ʳ� 

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺� �޿��� 4000000 �̻��� ������ �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 4000000;
 
-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE ���̺��� ��� ���ΰ� N�� ������ ��ȸ�ϰ� 
-- �ٹ� ���θ� ���������� ǥ���Ͽ�
-- ���, �̸�, �����, �ٹ����θ� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' �ٹ�����
FROM EMPLOYEE
WHERE ENT_YN = 'N';

----------------�ǽ�����-----------------
-- 1. EMPLOYEE ���̺��� ������ 3000000�̻��� ����� �̸�, ����, ����� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2. EMPLOYEE ���̺��� SAL_LEVER�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE ���̺��� �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%))�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*(1+BONUS)*12 - (SALARY*12*0.03), HIRE_DATE
FROM EMPLOYEE
WHERE SALARY*(1+BONUS)*12 - (SALARY*12*0.03) >= 50000000;
 -----------------------------------------------------------------------------------------------------------------------------------------
 
-- *** �� ������ (AND / OR) ***
-- ���� �� ���� �ۼ� �� ���

-- �μ��ڵ尡 ��D6���̰� �޿��� 2�鸸 ���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' 
AND SALARY > 2000000;

-- �μ��ڵ尡 ��D6���̰ų� �޿��� 2�鸸 ���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' 
OR SALARY > 2000000; 

-- EMPLOYEE ���̺��� �޿��� 350���� �̻� 600���� ���ϸ� �޴�
-- ������ ���, �̸�, �޿�, �μ��ڵ�, �����ڵ带 ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE  SALARY >= 3500000
AND SALARY <= 6000000;

--NULL ������ Ȯ�� 
--NULL or true �� true�̴� ����� ���
select * from EMPLOYEE 
where bonus = null or emp_id = 202

--NULL and false �� false�̴� ����� ���
--emp_id 202�� ���� ��� ���
select * from EMPLOYEE 
where not(bonus = null and emp_id = 202)

----------------�ǽ�����-------------------
-- 1. EMPLOYEE ���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE ='J2';

-- 2. EMPLOYEE ���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE='D9' OR DEPT_CODE='D5' AND HIRE_DATE < '02/01/01';
-- ���� ������ ��� ���� �߿� ���� ������ �˻��ؾߵǴ� ��� ��ȣ�� ���� ��

 -----------------------------------------------------------------------------------------------------------------------------------------

-- *** BETWEEN AND ***
-- �񱳴���÷��� BETWEEN ���Ѱ� AND ���Ѱ�
-- >> ���Ѱ� �̻� ���Ѱ� ����

-- �޿��� 3500000�� ���� ���� �ް� 6000000���� ���� �޴� ��� �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �ݴ�� �޿��� 350�� �̸�, �Ǵ� 600���� �ʰ��ϴ� ������ ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT�� �÷��� �տ� �ٿ��� �ǰ� BETWEEN �տ� �ٿ��� ��


----------------�ǽ�����-----------------
-- 1. EMPLOYEE ���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

 -----------------------------------------------------------------------------------------------------------------------------------------
 
-- *** LIKE *** 
-- ���Ϸ��� ���� ������ Ư�� ������ ������Ű���� ��ȸ�� ��
-- �񱳴�� �÷��� LIKE '��������'
-- '%'�� '_'�� ���ϵ� ī��� ����� �� �ִ�.
-- ���� ���� : '����%' (���ڷ� �����ϴ� ��)
--            '%����%'(���ڰ� ���Ե� ��)
--            '%����' (���ڷ� ������ ��)

-- ���� �� : '_' (�ѱ���)
--             '__' (�α���)
--             '___'(������)


-- EMPLOYEE ���̺��� ���� ������ ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺��� '��'�� ���Ե� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- EMPLOYEE ���̺��� ��ȭ��ȣ 4���� �ڸ��� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
-- ���ϵ� ī�� ��� : _(���� ���ڸ�), %(0�� �̻��� ����)
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- �̸��� �� _�ձ��ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸����ּ� ��ȸ
-- EX) sun_di@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- ��ó�� SQL�� ����� ����� ����� ������ �������̴�.( _�տ� ���ڰ� 2~4���� ���׹���)

-- ���ϵ� ī�� ���ڿ�  ������ Ư�����ڰ� ���� �� ��� ( _ ) � ���� �����̰� Ư���������� ������ ����
--> ���ϵ� ī�� ���� ��ü�� �����ͷ� ó���ϱ� ���� 
--> �����ͷ� ó���� ���� ��ȣ �տ� ���Ƿ� Ư�����ڸ� ����ϰ� ESCAPE OPTION���� ���
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';


-- NOT LIKE
-- Ư�� ������ ������Ű�� �ʴ°� ��ȸ

-- EMPLOYEE ���̺��� �达 ���� �ƴ� ������ ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE EMP_NAME NOT LIKE '��%';
WHERE NOT EMP_NAME  LIKE '��%';
-- NOT�� �÷��� ���̳� �ڿ� ���̸��


-----------------�ǽ�����---------------------
-- 1. EMPLOYEE ���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4�� �̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
--    ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$'
    AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
    AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
    AND SALARY >= 2700000;
    
-----------------------------------------------------------------------------------------------------------------------------------------

-- *** IS NULL / IS NOT NULL ***
-- IS NULL : �÷����� NULL�� ���
-- IS NOT NULL : �÷����� NULL�� �ƴѰ��

-- ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME , SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME , SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


-- �����ڵ� ���� �μ� ��ġ�� ���� ���� ������ �̸�, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID , DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL
AND DEPT_CODE IS NULL;

-- �μ� ��ġ�� ���� �ʾ����� ���ʽ��� ���޹޴� ���� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


-----------------------------------------------------------------------------------------------------------------------------------------

-- *** IN ***
-- ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ�ϴ� ������
-- �񱳴���÷��� IN(** , ** ....)

-- D6 �μ��� D8 �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D8');

 -----------------------------------------------------------------------------------------------------------------------------------------
 
-- ������ �켱����
/*
1. ���������
2. ���Ῥ����
3. �񱳿�����
4. IS NULL / IS NOT NULL, LIKE, IN / NOT IN
5. BETWEEN AND / NOT BETWEEN AND
6. NOT(��������)
7. AND(��������)
8. OR(��������)
*/

-- OR���� AND�� ���� ���� 
-- AND �������� ������� OR�� ����ؼ� �ٽ� ��

-- J7 �Ǵ� J2 ������ �޿� 200���� �̻� �޴� ������ ������ �̸�, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7'
      OR JOB_CODE='J2')
      AND SALARY >= 2000000;
-- J7 �Ǵ� J2�� ��ȣ�� ������
-- J7, J2�� ���� �� �޿��� 200���� �̻��� ���� ��ȸ

SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J7'
    OR JOB_CODE = 'J2'
    AND SALARY >= 2000000;
-- �޿��� 200�� �̻��� J2 ������ �Ǵ� J7 ������ ��ȸ


---------������ ��-------------------------------------------------------------------------
 
-- *** DISTINCT ***
 -- �÷��� ���Ե� �ߺ����� �� ������ ǥ���ϰ��� �� �� ���

-- EMPLOYEE ���̺��� ������ ���� �ڵ� ��ȸ
SELECT JOB_CODE 
FROM EMPLOYEE;
 
-- EMPLOYEE ���̺��� ������ �����ڵ�(�ߺ�����) ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- DISTINCT �� SELECT ���� �� �ѹ��� �� �� ����
/*SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;*/

-- ���� ���� �÷��� ��� �ߺ��� ���ܽ�ų �� �ִ�.
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;


-- < ORDER BY�� > --
-- SELECT�� �÷��� ���� ������ �� �� �ۼ��ϴ� ����
-- SELECT�� ���� �������� �ۼ�, ���� ������ ���� ������!  
--> �ؼ� ���� From, Where, Group by, having, Select, Order by;

-- SELECT �÷��� FROM ���̺�� 
[WHERE ������] 
[ORDER BY �÷��� | ��Ī | �÷�����  ���Ĺ�� [NULLS FIRST | LAST]]
-- NULLS FIRST : ���� ������ �÷��� NULL���� ������ �պκп� ���� (LAST�� �ݴ�)

SELECT EMP_NAME
, SALARY*12 AS ����
,sal_level
,salary
,bonus
FROM EMPLOYEE
--�̸����� �������� ����
--ORDER BY EMP_NAME DESC
--�������� �������� ����
--ORDER BY ���� ASC;
--�ι�° �÷����� �������� ����
--ORDER BY 2 DESC;
--���������� ��������, ���������� ������ �������� ��������
--order by sal_level asc, salary desc
--���ʽ��� ������������ null ������ ���� ����
--order by bonus ASC NULLS FIRST
--���ʽ��� �������� ���� null������ �Ʒ��� ����
--order by bonus desc NULLS LAST