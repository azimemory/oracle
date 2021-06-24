-- SUBQUERY(��������)
/*
- �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SQL��.
- ���� ����(���� ����)�� ���� ���� ������ �ϴ� ������.
*/


-- �μ��ڵ尡 ���ö����� ���� �Ҽ��� ���� ��� ��ȸ

-- 1) ������� ���ö�� ����� �μ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 D9�� ������ ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) �μ��ڵ尡 ���ö����� ���� �Ҽ��� ���� ��� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');                
                    
                    
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ 
-- ���, �̸�, �����ڵ� ,�޿� ��ȸ

-- 1) �� ������ ��� �޿�
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) ��� �޿����� ���� �޴� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
----------------------------------------------------------------------------------------------------------------------------------

-- ���������� ����
-- ������ �������� : ���������� ��ȸ ������� ������ 1���� ��
-- ������ �������� : ���������� ��ȸ ��� ���� ������ �������� ��
-- ���߿� �������� : �������� SELECT���� ������ �׸� ���� ������ �� ��
-- ������ ���߿� �������� : ��ȸ ��� �� ���� �� �� �� ������ �� ��
-- ��� �������� : �������� ������ ���������� �÷����� �����ϴ� ����
-- ��Į�� �������� : SELECT���� ��� �Ǵ� ���� ����, ����� 1�ุ ��ȯ


-- * ���������� ������ ���� �������� �տ� �ٴ� �����ڰ� �ٸ�

----------------------------------------------------------------------------------------------------------------------------------

-- 1. ������ �������� (SINGLE ROW SUBQUERY)

-- ���������� ��ȸ ������� ������ 1���� ��
-- ������ �������� �տ��� �Ϲ� ������ ���
-- < , >, <=, >=, =, !=/<>/^= (��������)


-- ���ö ����� �޿����� ���� �޴� ������
-- ���, �̸�, �μ�, ����, �޿��� ��ȸ
SELECT EMP_ID, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');
                    
-- ���� ���� �޿��� �޴� ������
-- ���, �̸�, ����, �μ�, �޿�, �Ի����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                    FROM EMPLOYEE);

-- �� ������ �޿� ��պ��� ���� �޿��� �޴� ������ �̸�, ����, �μ�, �޿� ��ȸ
-- ���� ������ ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE)
ORDER BY 2;


-- * ���������� SELECT, WHERE, HAVING, FROM�������� ����� �� �ִ�.
-- �μ��� �޿��� �հ� �� ���� ū �μ���
-- �μ���, �޿� �հ踦 ��ȸ 

-- 1) �μ��� �޿� �հ�
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

-- 2) �޿�  �հ谡 ���� ū �μ��� �޿� �հ�
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 3) �μ��� �޿��� �հ� �� ���� ū �μ�
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);


----------------------------------------------------------------------------------------------------------------------------------


-- 2. ������ ��������(MULTI ROW SUBQUERY)

--  ���������� ��ȸ ��� ���� ������ �������� ��

-- ������ �������� �տ��� �Ϲ� �񱳿����� ��� ����
-- IN / NOT IN : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ�
--               Ȥ�� ���ٸ� �̶�� �ǹ�
-- > ANY, < ANY : ���� ���� ����� �߿��� �� ���� ū / ���� ���
--                ���� ���� ������ ũ��? / ���� ū ������ �۳�?
-- > ALL, < ALL : ��� ������ ū / ���� ���
--                ���� ū ������ ũ��? / ���� ���� ������ �۳�?
-- EXISTS / NOT EXISTS : ���� �����ϳ�? / �������� �ʴ���?


-- �μ��� �ְ� �޿��� �޴� ������ �̸�, ����, �μ�, �޿� ��ȸ
-- �μ� ������ ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                    FROM EMPLOYEE
                    GROUP BY DEPT_CODE)
ORDER BY 3;


-- �����ڿ� �ش��ϴ� ������ ���� ���� ���� ��ȸ
-- ���, �̸�, �μ���, ����,  ����(������ / ����)

-- 1)  �����ڿ� �ش��ϴ� ��� ��ȣ ��ȸ
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2)  ������ ���, �̸�, �μ���, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE);

-- 3) �����ڿ� �ش��ϴ� ������ ���� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' AS ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);


-- 4) �����ڿ� �ش����� �ʴ� ������ ���� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' AS ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);
                        
-- 5) 3, 4�� ��ȸ ����� �ϳ��� ��ħ -> UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' AS ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' AS ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);


-- * SELECT ������ �������� ����� �� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
    CASE WHEN EMP_ID IN (SELECT DISTINCT(MANAGER_ID)
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL)
                            THEN '������'
        ELSE '����'
    END AS ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);



-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, > ANY Ȥ�� < ANY �����ڸ� ����ϼ���

-- > ANY : ���� ���� ������ ũ��? / ���� ���� ����� �߿��� �� ���� ū ���
-- < ANY : ���� ū ������ �۳�?  / ���� ���� ����� �߿��� �� ���� ���� ���

-- 1) �޿��� 200���� �̻��� �븮 ���� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY >= 2000000;

-- 2) ���� ���� ������ �޿�
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 3) �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING(JOB_CODE)
                WHERE JOB_NAME = '����');



-- ���� ������ �޿��� ���� ū ������ ���� �޴� ���� ������ ���� ��ȸ
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, > ALL Ȥ�� < ALL �����ڸ� ����ϼ���

-- > ALL, : ��� ������ ū  ��� / ���� ū ������ ũ��?
-- < ALL :  ��� ������ ���� ��� / ���� ���� ������ �۳�?

-- 1)  �޿��� 200���� �̻��� ���� ���� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY >= 2000000;

-- 2) ���� ���� ������ �޿�
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 3) ���� ������ �޿��� ���� ū ������ ���� �޴� ���� ������ ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL (SELECT SALARY
                              FROM EMPLOYEE
                              JOIN JOB USING (JOB_CODE)
                              WHERE JOB_NAME = '����');
                              
             
             
----------------------------------------------------------------------------------------------------------------------------------

-- 3.  ���߿� ��������
-- �������� SELECT���� ������ �׸� ���� ������ �� ��

-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ�
-- ����� �̸�, ����, �μ�, �Ի����� ��ȸ        

-- 1) ����� ������
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
AND ENT_YN = 'Y';

-- 2) ����� �������� ���� �μ�, ���� ���� (���Ͽ� ǥ�� �� -> �ϳ��� �÷��� ��)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
-- ���� �μ�
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y')
-- ���� ����
AND JOB_CODE = (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y')
-- �ߺ� �̸� ����                  
AND EMP_NAME != (SELECT EMP_NAME
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y');
  
             
-- 3) ����� �������� ���� �μ�, ���� ���� (���� �� ��������)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y')
AND EMP_NAME != (SELECT EMP_NAME
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO, 8, 1) = 2
                   AND ENT_YN = 'Y');
             
             
   
---------------------------------------------------------------------------------------------------------------------------------- 
           
           
-- 4. ������ ���߿� ��������

--��ȸ ��� �� ���� �� �� �� ������ �� ��


-- �ڱ� ������ ��� �޿��� �ް� �ִ� ������
-- ���, �̸�, ����, �޿��� ��ȸ�ϼ���
-- ��, �޿��� �޿� ����� ���������� ����ϼ��� TRUNC(�÷���, -5)      

-- 1) �޿��� 200, 600�� �޴� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2000000, 6000000);

-- 2) ���޺� ��� �޿�
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 3) �ڱ� ������ ��� �޿��� �ް� �ִ� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                        FROM EMPLOYEE
                        GROUP BY JOB_CODE);


---------------------------------------------------------------------------------------------------------------------------------- 


-- 5. ��[ȣ��]�� ��������

-- ��������� ���������� ����ϴ� ���̺��� ���������� �̿��ؼ� ����� ����
-- ���������� ���̺� ���� ����Ǹ� ���������� ������� �ٲ�� �Ǵ� ������

-- ������ ����� EMPLOYEE���̺� �����ϴ� ������
-- ���, �̸�, �μ���, �����ڻ�� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE E
WHERE EXISTS (SELECT EMP_ID
              FROM EMPLOYEE M
              WHERE E.MANAGER_ID = M.EMP_ID);            
-- EXISTS : ���������� �ش��ϴ� ���� ��� �� �� �̻� ������ ��찡 �����Ǵ� ��� SELECT�� ����


-- ���޺� �޿� ��� �̻� �޿��� �޴� ������
-- �̸�, ����, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT TRUNC(AVG(SALARY), -5)
                FROM EMPLOYEE M
                WHERE E.JOB_CODE = M.JOB_CODE);
                
                

---------------------------------------------------------------------------------------------------------------------------------- 


-- 6. ��Į�� ��������

-- * SELECT���� ��� �Ǵ� ���� ����, ����� 1�ุ ��ȯ
-- SQL���� ���ϰ��� ������ '��Į��' ��� ��

-- ������ �������� + �������
-- SELECT��,WHERE��, ORDER BY�� ��� ����

-- 1) ��Į�� �������� SELECT�� ���

-- ��� ����� ���, �̸�, �����ڻ��, �����ڸ��� ��ȸ
-- �� �����ڰ� ���� ��� '����'���� ǥ��
SELECT E.EMP_ID, E.EMP_NAME, E.MANAGER_ID, 
    NVL((SELECT M.EMP_NAME
            FROM EMPLOYEE M
            WHERE E.MANAGER_ID = M.EMP_ID), '����') AS �����ڸ�
FROM EMPLOYEE E
ORDER BY 1;


-- 2) ��Į�� �������� WHERE�� ���

-- �ڽ��� ���� ������ ��� �޿����� ���� �޴� ������
-- �̸�, ����, �޿��� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE M
                    WHERE M.JOB_CODE = E.JOB_CODE)
ORDER BY 2;


-- 3) ORDER BY ������ ��Į�� �������� ���

-- ��� ������ ���, �̸�, �ҼӺμ��� ��ȸ
-- ��, �μ��� �������� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
ORDER BY (SELECT DEPT_TITLE
            FROM DEPARTMENT
            WHERE DEPT_CODE = DEPT_ID)
            DESC NULLS LAST;
-- NULLS LAST : NULL���� ���� �������� ����

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
ORDER BY DEPT_TITLE DESC;



---------------------------------------------------------------------------------------------------------------------------------- 

-- [������� & ��Į�󼭺����� ��������]

-- 1) �μ��� �Ի����� ���� ���� �����
-- ���, �̸�, �μ���(NULL�̸� '�ҼӾ���'), ���޸�, �Ի����� ��ȸ�ϰ�
-- �Ի����� ���� ������ ��ȸ�ϼ���
-- ��, ����� ������ �����ϰ� ��ȸ�ϼ���

SELECT EMP_ID, EMP_NAME, 
        NVL(DEPT_TITLE, '�ҼӾ���'),
        JOB_NAME, HIRE_DATE
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE)
                    FROM EMPLOYEE M
                    WHERE E.DEPT_CODE = M.DEPT_CODE
                    AND ENT_YN = 'N')
ORDER BY HIRE_DATE;



-- 2. ���޺� ���̰� ���� � ������
-- ���, �̸�, ���޸�, ����, ���ʽ� ���� ������ ��ȸ�ϰ�
-- ���̼����� �������� �����ϼ���
-- �� ������ \124,800,000 ���� ��µǰ� �ϼ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, 
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) + 1 ����,
    TO_CHAR(SALARY + SALARY * NVL(BONUS, 0) * 12, 'L999,999,999') ���ʽ����Կ���
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE 
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) + 1 =  
        (SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) + 1)
            FROM EMPLOYEE M
            WHERE E.JOB_CODE = M.JOB_CODE);


---------------------------------------------------------------------------------------------------------------------------------- 


-- 7. �ζ��� ��(INLINE-VIEW)

-- FROM������ ���������� ���
--  ���������� ���� �������(RESULT SET)�� ���̺� ��ſ� �����.


-- 1) �ζ��κ並 Ȱ���� TOP-N�м�

-- * ROWNUM : ��ȸ�� ������� 1���� ��ȣ�� �ű�

-- ORDER BY �� ����� ROWNUM�� ����
-- ROWNUM�� �� ��ȣ�� �ǹ���
-- FROM������ �ٿ���
-- ORDER BY �� ������ ROWNUM�� �������� ��������(�ζ��κ�)�� �̿��ؾ� ��

-- �� ���� �� �޿��� ���� ���� 5����
-- ����, �̸�, �޿� ��ȸ

-- ��� 1
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- �������� ����� �޿� ������������ �����ϰ� �� �� ���� 5�� ���.
-- *ROWNUM�� FROM���� �����ϸ鼭 �ٿ����� ������ top-N�м� �� SELECT���� ����� ROWNUM�� �ǹ� ���� ��

-- ��� 2
SELECT  ROWNUM, EMP_NAME, SALARY
FROM (SELECT * FROM EMPLOYEE
            ORDER BY SALARY DESC)
WHERE ROWNUM <=5;
-- ���� �������� ������ ������������ �����ص�
-- ������������ �������� ��� �� ���� 5���� ��ȸ��.
-- * FROM���� �̹� ���ĵ� ��������(�ζ��� ��) ���� �� ROWNUM�� top-N�м��� ��� ����


-- �޿� ��� 3�� �ȿ� ��� �μ��� �μ��ڵ�� �μ���, ��ձ޿��� ��ȸ�ϼ���
SELECT DEPT_CODE, DEPT_TITLE, ��ձ޿�
FROM (SELECT DEPT_CODE, DEPT_TITLE, FLOOR(AVG(SALARY)) ��ձ޿�
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    GROUP BY DEPT_CODE, DEPT_TITLE
    ORDER BY FLOOR(AVG(SALARY)) DESC)
WHERE ROWNUM <= 3;


-- [�� ���̻����ؾߵǴ� ����]
-- ���޺� �޿� ��հ� ���� ����, �޿��� ���� ���� ��ȸ
SELECT EMP_NAME, JOB_NAME, SALARY
FROM (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5) AS JOBAVG
      FROM EMPLOYEE
      GROUP BY JOB_CODE) V
          
JOIN EMPLOYEE E ON (JOBAVG = SALARY 
                    AND E.JOB_CODE = V.JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY JOB_NAME;




---------------------------------------------------------------------------------------------------------------------------------- 

-- 8. WITH

-- ���������� �̸��� �ٿ��ְ� ���� �̸��� ����ϰ� ��
-- �ζ��κ�� ���� ���������� �ַ� �̿��
-- ���� ���������� ������ ���� ��� �ߺ� �ۼ��� ���� �� �ִ�.
-- ���� �ӵ��� �������ٴ� ������ ����

WITH TOPN_SAL AS (SELECT EMP_ID,
                         EMP_NAME,
                         SALARY
                  FROM   EMPLOYEE
                  ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;



---------------------------------------------------------------------------------------------------------------------------------- 

-- 9. RANK() OVER / DENSE_RANK() OVER

--  RANK() OVER : ������ ���� ������ ����� ������ �ο� ����ŭ �ǳ� �ٰ� ���� ���
--> EX) ���� 1���� 2���̸� ���� �����ڴ� 2���� �ƴ϶� 3��
SELECT ����, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY,
                RANK() OVER(ORDER BY SALARY DESC) AS ����
            FROM EMPLOYEE
            ORDER BY SALARY DESC);


-- DENSE_RANK() OVER : �ߺ��Ǵ� ���� ������ ����� ������ ����� ó��
--> EX) ���� 1���� 2���̾ ���� �����ڴ� 2��
SELECT ����, EMP_NAME, SALARY
FROM (SELECT EMP_NAME,
             SALARY,
             DENSE_RANK() OVER(ORDER BY SALARY DESC) AS ����
      FROM   EMPLOYEE
      ORDER BY SALARY DESC);
      
      
--------------------------------------------------------------------------------------------------------------------------

-- [�ǽ�����]

-- ���� ���̺��� ���ʽ� ������ ������ ���� 5����
-- ���, �̸�, �μ���, ���޸�, �Ի����� ��ȸ�ϼ���
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, ����
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, SALARY,(SALARY + (SALARY * NVL(BONUS,0))) * 12,
      RANK() OVER(ORDER BY ((SALARY + (SALARY * NVL(BONUS, 0))) * 12) DESC) ����
      FROM EMPLOYEE E
      JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
      JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE))
WHERE ���� <= 5;



-- �μ��� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ����
-- �μ��� �μ����, �μ��� �޿� �հ� ��ȸ
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                      FROM EMPLOYEE);





--------------------------------------------------------------------------------------------------------------------------

-- ���� �κ��ε�.. �־ �־��

-- �ζ��κ� ���
SELECT DEPT_TITLE, SUM(SALARY) SSAL
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

SELECT DEPT_TITLE, SSAL
FROM (SELECT DEPT_TITLE, SUM(SALARY) SSAL
      FROM EMPLOYEE
      LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_TITLE)
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
              FROM EMPLOYEE);

-- WITH ���
WITH TOTAL_SAL AS (SELECT DEPT_TITLE, SUM(SALARY) SSAL
                   FROM EMPLOYEE
                   LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                   GROUP BY DEPT_TITLE)
SELECT DEPT_TITLE, SSAL
FROM TOTAL_SAL
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
              FROM EMPLOYEE);


WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT *
FROM SUM_SAL
UNION
SELECT * FROM AVG_SAL;


WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * 
FROM SUM_SAL, AVG_SAL;