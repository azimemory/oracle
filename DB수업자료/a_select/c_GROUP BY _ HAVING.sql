-- ORDER BY �� : SELECT�� �÷��� ������ ������ �� �� �����
-- ORDER BY �÷��� | �÷���Ī | �÷��������� [ASC] | DESC
-- ORDER BY �÷��� ���Ĺ��, �÷��� ���Ĺ��, �÷���, ���Ĺ��, ....
-- ù��° �������� �ϴ� �÷��� ���� �����ϰ� 
-- ���� ���鿡 ���� �ι�° �������� �ϴ� �÷��� ���� �ٽ� ����....
-- SELECT ������ �� �������� ��ġ��
-- ���� ������ �� �������� �����

/*
  5 : SELECT �÷��� AS ��Ī, ����, �Լ���
  1 : FROM ������ ���̺��
  2 : WHERE �÷��� | �Լ��� �񱳿����� �񱳰�
  3 : GROUP BY �׷��� ���� �÷���
  4 : HAVING �׷��Լ��� �񱳿����� �񱳰�
  6 : ORDER BY �÷��� | ��Ī | �÷����� ���Ĺ�� [NULLS FIRST | LAST];
*/

-- �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
-- ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ��
-- => case ���
-- �μ��ڵ� ���� �������� ������.
SELECT EMP_NAME, DEPT_CODE,
CASE
  WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
  WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
  WHEN DEPT_CODE = 'D9' THEN '������'
END
FROM EMPLOYEE  
WHERE DEPT_CODE IN('D5', 'D6', 'D9')
ORDER BY 2;


-- GROUP BY�� : ���� ������ ������ ��ϵ� �÷��� ������ ���� ������
--              �ϳ��� �׷����� ����
-- GROUP BY �÷��� | �Լ���, ....
-- �������� ���� ��� �ϳ��� ó���� �������� �����
-- �׷����� ���� ���� ���ؼ� SELECT������ �׷��Լ��� �����

-- �׷� �Լ��� �� �Ѱ��� ��� ���� �����ϱ� ������ �׷��� ���� ���� ��� ���� �߻�
-- ���� ���� ��� ���� �����ϱ� ���� �׷� �Լ��� ����� �׷��� ������ ORDER BY���� ����Ͽ� ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE; -- ���� �߻�

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE ���̺��� �μ��ڵ�, �׷� �� �޿��� �հ�, �׷� �� �޿��� ���(����ó��), 
-- �ο� ���� ��ȸ�ϰ� �μ� �ڵ� ������ ����
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE ���̺��� �μ��ڵ�� ���ʽ� �޴� ��� �� ��ȸ�ϰ� �μ��ڵ� ������ ����
SELECT DEPT_CODE �μ��ڵ�, COUNT(BONUS) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE ���̺��� �μ� �ڵ庰 �׷��� �����Ͽ� �μ� �ڵ�, �׷캰 �޿��� �հ�, 
-- �׷캰 �޿��� ���(����ó��), �ο����� ��ȸ�ϰ�, �μ� �ڵ� ������ ����
SELECT DEPT_CODE,
       SUM(SALARY) �հ�,
       FLOOR(AVG(SALARY)) ���,
       COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- �������̺��� �����ڵ�, ���ʽ��� �޴� ����� ���� ��ȸ�Ͽ�
-- �����ڵ� ������ �������� �����ϼ���.
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE ���̺��� ������ ���� �� �޿� ���(����ó��), �޿� �հ�, �ο� �� ��ȸ�ϰ�
-- �ο����� �������� ����
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') ����,
    FLOOR(AVG(SALARY)) ���, SUM(SALARY) �հ�, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��')
ORDER BY COUNT(*) DESC;
-- GROUP�� �÷� ���� �� ��Ī X

-- * ���� �÷��� �׷����� ���� �� ����.

-- EMPLOYEE ���̺��� �μ� �ڵ� ���� ���� ������ ����� �޿� �հ踦 ��ȸ�ϰ�
-- �μ� �ڵ� ������ ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--------------------------------------------------------------------------------------------------------------------------

-- HAVING �� : �׷��Լ��� ���� �� �׷쿡 ���� ������ ������ �� ���
-- HAVING �÷��� | �Լ��� �񱳿����� �񱳰�

-- �μ� �ڵ�� �޿� 3000000 �̻��� ������ �׷캰 ��� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) ���
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE
ORDER BY 1;

-- �μ� �ڵ�� �޿� ����� 3000000 �̻��� �׷� ��ȸ
-- �μ� �ڵ� ������ ����
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) ���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY 1;

-- �μ��� �׷��� �޿� �հ� �� 9�鸸���� �ʰ��ϴ� �μ��ڵ�� �޿� �հ� ��ȸ
-- �μ� �ڵ� ������ ����
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY 1;

--  [����]
-- �޿� �հ谡 ���� ���� �μ��� �μ��ڵ�� �μ� �հ踦 ���ϼ���
-- ��������(��������)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
      
                      
--------------------------------------------------------------------------------------------------------------                     

-- �����Լ�(ROLLUP, CUBE)
-- �׷� �� ������ ��� ���� ���踦 ����ϴ� �Լ�

-- EMPLOYEE ���̺��� �� ���� �ڵ� �� �޿� �հ�� 
-- ������ �࿡ ��ü �޿� ���� ��ȸ
-- ���� �ڵ� ������ ����
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;
-- �̷��Ը� �ϸ� �� ���޺� �޿��� �ո� ��µ�

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;
-- ������(8)�࿡ ���޺� �޿����� ��� ���� ������ ��µ�.

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;
-- CUBE�� ����ص� ��������̴�.
-- ROLLUP�� CUBE�� �������� �˾ƺ���.


-- ROLLUP �Լ� : �׷캰�� �߰� ���� ó���� �ϴ� �Լ�
-- GROUP BY �������� ����ϴ� �Լ���
-- �׷캰�� ������ ���� ���� �߰� ����� �� ���踦 ���Ҷ� �����
-- �׷��Լ��� ���� ������鿡 ���� �� ���谡 �ڵ����� �߰���
-- * ���ڷ� ���޹��� �׷��߿��� ���� ���� ������ �׷캰 �հ�� �� �հ踦 ���ϴ� �Լ�

-- EMPLOYEE ���̺��� �� �μ� �ڵ帶�� ���� �ڵ庰 �޿���, �μ��� �޿� ��, ���� ��ȸ
-- �μ� �ڵ� ������ ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;


--�ǽ���Ű��
SELECT decode(JOB_CODE,null,'���հ�',JOB_CODE) 
, decode(SAL_LEVEL,null,decode(JOB_CODE,null,'-','�κ��հ�'), SAL_LEVEL) 
,sum(salary)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE, SAL_LEVEL)


-- CUBE �Լ� : �׷캰 ������ ����� �����ϴ� �Լ��̴�.
-- * �׷����� ������ ��� �׷쿡 ���� ����� �� �հ踦 ���ϴ� �Լ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


-- GROUPING �Լ� : ROLLUP�̳� CUBE�� ���� ���⹰��
-- ���ڷ� ���޹��� �÷��� ������ ���⹰�̸� 0����ȯ�ϰ�,
-- �ƴϸ� 1�� ��ȯ�ϴ� �Լ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
       GROUPING(DEPT_CODE) "�μ����׷칭�λ���",
       GROUPING(JOB_CODE) "���޺��׷칭�λ���"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '�μ����հ�'
            WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '���޺��հ�'
            WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0 THEN '�׷캰�հ�'
            ELSE '���հ�'
    END ����
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


---------------------------------------------------------------------------------------------------------------------------------


-- SET OPERATION
-- ���������� ������ ���� �� �׿� �ش��ϴ� �������� ������� ���ս�Ű�� ������ ���
-- �ʺ��ڵ��� ����ϱ� ����.(���ǵ��� ��� ����� �Ǵ��� �� �����ص� �Ǵϱ�)
-- UNION ���� ���� ������ �ᱹ�� UNION ALL������ ���ȴ�.

-- UNION�� OR ���� ���� (������)
-- INTERSECT�� AND ���� ���� (������)
-- UNION ALL�� OR ��� ���� AND ������� ��������(������ + ������)
--> �ߺ��� �κ��� �ι� ����
-- MINUS�� ������ ���� 


-- UNION : �������� ���� ����� �ϳ��� ��ġ�� ������
-- �ߺ��� ������ �����Ͽ� �ϳ��� ��ģ��.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- �� �������� ����� �Ʒ� ó�� WHERE���� OR�� �� �Ͱ� ����.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY > 3000000;



-- INTERSECT : �������� SELECT�� ������� ���� �κи� ����� ���� (������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- �� �������� ����� �Ʒ� ó�� WHERE���� AND�� �� �Ͱ� ����.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY > 3000000;



-- UNION ALL : �������� ���� ����� �ϳ��� ��ġ�� ������
-- UNION���� �������� �ߺ������� ��� ���Խ�Ų��. (������ +  ������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- MINUS : ���� SELECT ������� ���� SELECT ����� ��ġ�� �κ��� ������ ������ �κи� ����(������)
-- �μ� �ڵ� D5 �� �޿��� 300�� �ʰ��� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- �� �������� ����� ������ ����.
--> �μ� �ڵ� D5 �� 300�� ������ ������ ��ȸ�ϸ� �ȴ�.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;



-- GROUPING SETS : �׷캰�� ó���� �������� SELECT���� �ϳ��� ��ĥ �� ���
--                 SET OPERATION ����� ����� �����ϴ�.
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS(
       (DEPT_CODE, JOB_CODE, MANAGER_ID),
       (DEPT_CODE, MANAGER_ID),
       (JOB_CODE, MANAGER_ID));


