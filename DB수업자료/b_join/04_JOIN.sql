------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOIN
-- �ϳ� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ���.
-- ���� ����� �ϳ��� Result Set���� ����.

/* 
- ������ �����ͺ��̽����� SQL�� �̿��� ���̺� '����'�� �δ� ���.

- ������ �����ͺ��̽��� �ּ����� �����͸� ���̺� ��� �־�
  ���ϴ� ������ ���̺��� ��ȸ�Ϸ��� �� �� �̻��� ���̺��� �����͸� �о�;� �Ǵ� ��찡 ����.
  �̶�, ������ �����͸� �������� ���� �ƴ� ���̺� ������� ���谡 �ξ��� �����͸� �����ؾ� �Ѵ�.
 --> 'JOIN'�� ���� �̸� ���� ����.
*/

--------------------------------------------------------------------------------------------------------------------------------------------------

-- ������ ���� �ٸ� ���̺��� �����͸� ��ȸ �� ��� �Ʒ��� ���� ���� ��ȸ��.

-- ������ȣ, ������, �μ��ڵ�, �μ����� ��ȸ �ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
-- ������ȣ, ������, �μ��ڵ�� EMPLOYEE���̺� ��ȸ����

-- �μ������� DEPARTMENT���̺��� ��ȸ ����
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--0. ���� ����(CROSS JOIN == īƼ���� ��(CARTESAIN PRODUCT))
--�� �� ���̺��� ��� ���� �ٸ� ���̺��� ��� ���� ����
--3������ ��ǰ���̺�� 5������ �ֹ����̺��� �����ϸ� 15�ﰳ��...
select 
* 
from 
employee cross join department;


-- 1. ���� ����(INNER JOIN) ( == � ����(EQUAL JOIN))
--> ����Ǵ� �÷��� ���� ��ġ�ϴ� ��鸸 ���ε�.  (== ��ġ�ϴ� ���� ���� ���� ���ο��� ���ܵ�. )

-- �ۼ� ��� : ����Ŭ ����, ANSI����

-- ����Ŭ ���� ����
-- FROM���� ','�� �����Ͽ� ��ġ�� �� ���̺���� ����ϰ�
-- WHERE���� ��ġ�⿡ ����� �÷����� ����Ѵ�

-- 1) ���ῡ ����� �� �÷����� �ٸ� ���

-- EMPLOYEE ���̺� DEPT_CODE�÷��� DEPARTMENT ���̺� DEPT_ID �÷��� 
-- ���� ���� �μ� �ڵ带 ��Ÿ����.
--> �̸� ���� �� ���̺��� ���谡 ������ �˰� ������ ���� ������ ������ ����.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- 2) ���ῡ ����� �� �÷����� ���� ���
-- employee���� �ְ� job���� �ִ� �÷��� ���
-- ��Ȯ�ϰ� ��� ���̺� ���ϴ� �÷����� ����ؾ��Ѵ�.
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

--  3) ��Ī ���
-- employee���� �ְ� job���� �ִ� �÷��� ���
-- ��Ȯ�ϰ� ��� ���̺� ���ϴ� �÷����� ����ؾ��ϴµ� �̶� ��Ī�� ����� ���� �ִ�.
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- 4) �������� join���� ���� �� �ִ�.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE e, DEPARTMENT d, LOCATION l
WHERE e.DEPT_CODE = d.DEPT_ID
AND d.LOCATION_ID = l.LOCAL_CODE;


--------------------------------------------------------------------------------------------------------------
-- Oracle�� ��� where ���� ��ġ�⿡ ����� �÷����� ���� ������
-- where�� ������ ������ ��� �бⰡ �����ϴ�.

-- ANSI ǥ�� ����
-- ANSI�� �̱� ���� ǥ�� ��ȸ�� ����, �̱��� ���ǥ���� �����ϴ� �ΰ���ü�� ����ǥ��ȭ�ⱸ ISO�� ���ԵǾ��ִ�.
-- ANSI���� ������ ǥ���� ANSI��� �ϰ� ���⼭ ������ ǥ�� �� ���� ������ ���� ASCII�ڵ��̴�.

--INNER JOIN���νᵵ �ǰ� JOIN���� �ᵵ �ȴ�.
-- 1) ���ῡ ����� �÷����� ���� ��� USING(�÷���)�� �����

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
INNER JOIN JOB USING(JOB_CODE);

-- on�� ����ص� ������ ���� �÷��� �ߺ��Ǿ ���´�.
-- on�� ����� ��� employee�� job�� ����
--������ �ִ� job_code�� ���̺��� ��Ȯ��
--��������� �Ѵ�.
--�׷��� ������ �Ҹ�Ȯ�ϴٴ� ������ �߻�
select emp_name,e.job_code,job_name
from 
employee e inner join job j on(e.job_code = j.job_code);

-- 2) ���ῡ ����� �÷����� �ٸ���� ON()�� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 3) �������� join�� �� �ִ�.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE e
JOIN DEPARTMENT d ON (e.DEPT_CODE = d.DEPT_ID)
JOIN LOCATION l ON (d.LOCATION_ID = l.LOCAL_CODE);

-- �μ� ���̺��� �μ��� �������� ��ȸ�ϼ���
-- ����Ŭ
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT d, LOCATION l
WHERE d.LOCATION_ID = l.LOCAL_CODE;

-- ANSI
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT d
JOIN LOCATION l ON(d.LOCATION_ID = l.LOCAL_CODE);

---------------------------------------------------------------------------------------------------------------
-- 2. �ܺ� ����(OUTER JOIN)
-- �� ���̺��� �����ϴ� �÷����� ��ġ���� �ʴ� �൵ ���ο� ������ ��Ŵ
-->  *�ݵ�� OUTER JOIN���� ����ؾ� �Ѵ�.

-- OUTER JOIN�� ���� INNER JOIN ������
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--job���̺� ��ü ������ ����
select * from job;
--���ο� ���� �Է�      
insert into job(job_code,job_name) values('J8','����')


-- 1) LEFT [OUTER] JOIN  : ��ġ�⿡ ����� �� ���̺� �� ���� ����� ���̺��� �÷� ���� �������� JOIN

select emp_name,job_code,job_name
from 
employee e left join job j using(job_code);


--������ �Ǵ� ���̺��� �÷��� �׳ɵΰ�, �߰� �� ���̺��� �÷��� (+) �߰�
select emp_name,j.job_code,job_name
from 
employee e, job j
where e.job_code(+) = j.job_code

-- ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+);

-- ANSI ǥ��
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
--LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- OUTER ���� ����

-- ���ʿ� ����� EMPLOYEE���̺��� �÷���: 23
-->DEPT_CODE�� ���� ���(�̿���, �ϵ���)�� �ܺ� ���� �� ǥ�ð� �ȴ�.


-- 2) RIGHT [OUTER] JOIN : ��ġ�⿡ ����� �� ���̺� �� ������ ����� ���̺���  �÷� ���� �������� JOIN

-- ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID;

-- ANSI ǥ��
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 3) FULL [OUTER] JOIN   : ��ġ�⿡ ����� �� ���̺��� ���� ��� ���� ����� ����
-- ANSI ǥ��
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ����Ŭ ������ FULL OUTER JOIN�� ��� ����
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID(+);


---------------------------------------------------------------------------------------------------------------

-- 4. �� ����(NON EQUAL JOIN)

-- '='(��ȣ)�� ������� �ʴ� ���ι�
--  ������ �÷� ���� ��ġ�ϴ� ��찡 �ƴ�, ���� ������ ���ԵǴ� ����� �����ϴ� ���

--SAL_GRADE ���� �޿��� �ּҰ����� �ִ밪�� ������ ����ִ�.
--�ش� ������ ���� ��� join�� �߻����Ѻ���
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON(SALARY BETWEEN 1 AND 100000000)

SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL  AND MAX_SAL)

--�ִ밪 ������ �ٿ�����.
SELECT *
FROM EMPLOYEE E
left JOIN SAL_GRADE S on(SALARY BETWEEN MIN_SAL AND MAX_SAL*0.8);

--����Ŭ �������ε� ����
select *
from employee e, sal_grade s
where SALARY BETWEEN MIN_SAL AND MAX_SAL*0.8

--outer join ����
SELECT *
FROM EMPLOYEE E
left JOIN SAL_GRADE S on(SALARY BETWEEN MIN_SAL AND MAX_SAL*0.8);


---------------------------------------------------------------------------------------------------------------

-- 5. ��ü ����(SELF JOIN)

-- ���� ���̺��� ����.
-- �ڱ� �ڽŰ� ������ ����

--employee ���̺��� ����̸�, �μ��ڵ�, ����� ������ ���, �����ڻ��, �������̸���
-- ����ϼ���

--self join ������� �ʰ� ���������� Ǯ���

SELECT 
E.EMP_ID
, E.EMP_NAME ����̸�
, E.DEPT_CODE
, E.MANAGER_ID ��������ڻ��
, (select emp_id from EMPLOYEE m where e.manager_id = m.emp_id) �����ڻ��
, (select emp_name from EMPLOYEE m where e.manager_id = m.emp_id) �������̸�
FROM EMPLOYEE E
where exists(select emp_id from EMPLOYEE m where e.manager_id = m.emp_id)

-- ����Ŭ ����
SELECT 
E.EMP_ID
, E.EMP_NAME ����̸�
, E.DEPT_CODE
, E.MANAGER_ID ��������ڻ��
, M.EMP_ID �����ڻ��
, M.EMP_NAME �������̸�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-- ANSI ǥ��
SELECT 
E.EMP_ID
, E.EMP_NAME ����̸�
, E.DEPT_CODE
, E.MANAGER_ID ��������ڻ��
, M.EMP_ID �����ڻ��
, M.EMP_NAME �������̸�
FROM EMPLOYEE E
JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

--------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------

-- [�ǽ�����] 

-- 1
--70��� ���̸鼭 ������ �����̰� ���� ������ �����
--�̸�, �ֹε�Ϲ�ȣ, �μ���, �������� ����ϼ���.
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(EMP_NO, 1,2) >= 70 AND SUBSTR(EMP_NO, 1,2) <80
      AND SUBSTR(EMP_NO, 8,1) = 2
      AND EMP_NAME LIKE '��%';

-- 2
--
update 
employee 
set emp_no = 
substr(emp_no,1,2) ||
case 
    when substr(emp_no,3,2) > 12 and substr(emp_no,5,2) > 30 then '1231'
    when substr(emp_no,3,2) > 12 then '12' || substr(emp_no,5,2)
    else substr(emp_no,3,2) || '30'
end
|| substr(emp_no,7,10)
where SUBSTR(EMP_NO,3,2) > 12 or SUBSTR(EMP_NO,5,2) > 30;
commit;

--�μ����� ���̰� ���� � ����� ���ID, �̸�, ����, �μ���, �������� ����ϼ���

SELECT 
EMP_ID
, EMP_NAME
, EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO,1,6)))) + 1 AS ����
, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE 
EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO,1,6)))) =
(SELECT 
MIN(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO,1,6))))) 
FROM 
EMPLOYEE);

--3
--�̸��� '��'�� ���� ����� ���ID, ����̸�, �������� ����ϼ��� 
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

--4
--�μ����� D5, D6 �� ����� �̸�, ������, �μ��ڵ�, �μ����� ����ϼ���
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_ID IN('D5', 'D6');

--5
--���ʽ��� ���� ����� �����, ���ʽ�, �μ���, �������� ����ϼ���
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--6
--����� �̸� ���޸� �μ��� �������� ����Ͻÿ�
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


--7
--�μ��� ��ġ�� ������ �ѱ��̳� �Ϻ��� �����
--�̸�, �μ���, ������, �������� ����Ͻÿ�
-- employee, department, location, national 
SELECT EMP_NAME, D.DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE NATIONAL_NAME IN('�ѱ�', '�Ϻ�');


--8
--job_code�� 'J4', 'J7'�̸鼭 ���ʽ��� ���� ���� ����� 
--�̸�, ���޸�, �޿�, ���ʽ��ݾ�(0������) ����ϼ���
SELECT EMP_NAME, JOB_NAME, SALARY, nvl(bonus,0)
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE bonus is null AND J.JOB_CODE IN('J4', 'J7');

--9
--����� ����� ������� ���� ����� ���ڸ� ����ϼ���
SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY ENT_YN;


621235
