-- ������(SEQUENCE)
-- �ڵ� ��ȣ �߻��� ������ �ϴ� ��ü
-- ���������� ���� ���� �ڵ����� ��������


--------------------------------------------------------------------------------------------------------------------

-- 1. SEQUENCE ����

--  [ǥ����]
/*
  CREATE SQUENCE �������̸�
  [INCREMENT BY ����] -- ���� ���� ���� ����ġ, �����ϸ� �ڵ� 1�� �⺻
  [STRAT WITH ����] -- ó�� �߻���ų ���۰� ����, �����ϸ� �ڵ� 1�� �⺻
  [MAXVALUE ���� | NOMAXVALUE] -- �߻���ų �ִ밪 ���� (10�� 27��, -1)
  [MINVALUE ���� | NOMINVALUE] -- �ּҰ� ���� (-10�� 26��)
  [CYCLE | NOCYCLE] -- �� ��ȯ ���� ����
  [CACHE ����Ʈũ�� | NOCACHE] -- ĳ���޸� �⺻���� 20����Ʈ, �ּҰ��� 2����Ʈ
*/
-- �������� ĳ�� �޸𸮴� �Ҵ�� ũ�⸸ŭ �̸� ���� ������ ������ �����ص�
-- --> ������ ȣ�� �� �̸� ����Ǿ��� ������ ������ ��ȯ�ϹǷ� 
--     �Ź� �������� �����ؼ� ��ȯ�ϴ� �ͺ��� DB�ӵ��� ����.


CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;


-- ����ڰ� ������ ������ Ȯ���ϱ�.
SELECT * FROM USER_SEQUENCES;

--------------------------------------------------------------------------------------------------------------------

-- 2. SEQUENCE ���
/*
��������.CURRVAL : ���� ������ �������� ��

��������.NEXTVAL : - �������� ������Ŵ
                 - ���� ������ ������ ����ġ��ŭ ������ ��
                  ->  ��������.NEXTVAL = ��������.CURRVAL + INCREMENT�� ������ ��

*/

-- NEXTVAL�� �������� �ʰ� ��� ������ �������� CURRVAL ȣ�� ��
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- ���� �߻�!
-- ���� �߻� ����
/*
��������.CURRVAL�� ���������� ȣ��� ��������.NEXTVAL�� ���� �����Ͽ� �����ִ� �ӽð�.
������ ���� ���� �ѹ��� NEXTVAL�� ȣ������ �ʾ����Ƿ� ������ �߻��Ѵ�.

[�󼼼���]
sequence.currval���� �� session������ �����ϴ� �ӽð��Դϴ�.
currval���� ���ǿ��� ���������� call�� nextval�� ���� ���ϵ� ���� ���� ���� �˴ϴ�.
���� ���ǿ��� nextval���� ���� call���� �ʾҴٸ� currval ���� ���� ���� �ʽ��ϴ�.
�� ���ǿ��� nextval�� �����ؾ� currval�� �Ҽ� �����ϴ�.
������ ù��° nextval function�� �ش� seq �� �ʱ�ȭ��Ű�� �����Դϴ�
*/

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- ERROR
-- ������ MAXVALUE ���� �ʰ��Ͽ��� ������ ���� �߻�

-- ����ڰ� ������ ������ Ȯ��
SELECT * FROM USER_SEQUENCES; 
-- MAX_VALUE�� 310������ LAST_NUMBER�� 315�� ������


SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- CURRVAL�� ���������� ȣ��� ������ NEXTVAL�� ���� �����ϰ� �����


/*
    * CURRVAL / NEXTVAL ��� ���� ����
    
    1) ��� ����
        - ���������� �ƴ� SELECT��
        - INSERT���� SELECT��
        - INSERT���� VALUES��
        - UPDATE���� SET��
    
    2) ��� �Ұ�
        - VIEW�� SELECT��
        - DISTINCE Ű���尡 �ִ� SELECT��
        - GROUP BY, HAVING, ORDER BY���� SLEECT��
        - SELECT, DELETE, UPDATE���� ��������
        - CREATE TABLE, ALTER TABLE ����� DEFAULT��
*/

CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

COMMIT;

-- ��� ���� ����
INSERT INTO EMPLOYEE 
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '666666-3666666', 'hong_gd@kh.or.kr'
       ,'01012344444', 'D2', 'J7', 'S1', 5000000, 0.1, 200, SYSDATE,
       NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE;


-- ��� �Ұ� ����
CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.CURRVAL,
    E_NAME VARCHAR2(30)
);

--DROP TABLE TMP_EMPLOYEE;

ROLLBACK;


--------------------------------------------------------------------------------------------------------------------


-- 3. SEQUENCE ����

-- [ǥ����]
/*
    ALTER SEQUENCE �������̸�
    [INCREMENT BY ����]
    [MAXVALUE ���� | NOMAXVALUE]
    [MINVALUE ���� | NOMINVALUE] 
    [CYCLE | NOCYCLE]
    [CACHE ����Ʈũ�� | NOCACHE];
*/
-- START WITH�� ���� �Ұ� 
-- --> �缳�� �ʿ� �� ���� ������ DROP�� �����

ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

-- ������ ���� Ȯ��
SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.CURRVAL FROM DUAL;









