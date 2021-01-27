--CREATE TABLE ���̺��(
--   �÷���(�Ӽ�) ��������
--)
CREATE TABLE CONSTRAINT_EMP(
    --�������� ���� �÷��� �߰�
    PHONE VARCHAR2(13),
    
    --DEFAULT : �⺻ �� ����, ���� ROW�� �߰��� �� �ش� �÷������� ������ ���� ������
    --NULL�� �Է��ϴ� ��� �⺻������ ������ ���� �Է��Ѵ�.
    HIRE_DATE DATE DEFAULT SYSDATE,
    
    --���� ���Ἲ(UNIQUE) : ���̺��� Ư�� �÷����� ���ؼ� �� ROW�� ������ ������ ���� �޶���Ѵٴ� ����
    --                     �ߺ��Ǵ� �� ���� �� ����
    ENO CHAR(14) UNIQUE,
    
    --NULL ���Ἲ(NOT NULL) : ���̺��� Ư�� �÷����� NULL�� �� �� ������ �ϴ� ����
    ENAME VARCHAR2(20) NOT NULL,
    
    --DOMAIN ���Ἲ(CHECK) : Ư�� �÷����� �� �÷��� ���ǵ� �����ο� ���� ���̾�� �Ѵٴ� ����
    --                       �÷��� ���ǵ� ���� ���� ���� �÷������� ���� �� �ִ�.
    MARRIAGE CHAR(1) DEFAULT 'N' CHECK(MARRIAGE IN ('Y','N')),
    
    --DOMAIN ���Ἲ(CHECK) : Ư�� �÷����� �� �÷��� ���ǵ� �����ο� ���� ���̾�� �Ѵٴ� ����
    --                       �÷��� ���ǵ� ���� ���� ���� �÷������� ���� �� �ִ�.
    AGE NUMBER CHECK(AGE > 20),
    
    --�⺻Ű(primary key) ����
    --�⺻Ű�� ���̺��� �� ���� �����ϰ� �ĺ��ϴ� ������ ����Ѵ�.
    --���̺� �� �ϳ��� ���� �����ϴ�.
    --�⺻Ű�� �ּҼ�(NOT NULL), ���ϼ�(UNIQUE)�� �����Ǿ�� �Ѵ�.
    --���� �ּҼ��� ���ϼ��� �����Ǵ� �÷��� ���� ���
    --��ǥ���� ���ϴ� �÷��� �⺻Ű�� �����ϰ� �̶� �������� ���� ���������� �ĺ�Ű�� �θ���.
    --�⺻Ű�� �����ϸ� ���� �ε����� �ڵ����� ������ �ȴ�.
    --�ε��� : �����ͺ��̽����� �˻������� ������ �ϱ� ���� ����ϴ� �÷������� �����ϴ� �����ͱ���
    --  �ε����� ����ؼ� ���ϴ� ������ ������ �˻��� �� �� �ִ�.
    EID CHAR(3) PRIMARY KEY --���ϼ��� �ּҼ��� �����ϰ� �Ǿ���. NOT NULL + UNIQUE
    
    --���� ���Ἲ : �⺻Ű�� ����Ű ���� ���谡 �׻� ���� ��
    --�θ����̺��� �ڽ��� �����ϰ� �ִ� �ڽ����̺��� ���� ���� �ʴ� �� ������ �� ����
    --�ڽ����̺��� �θ����̺��� �⺻Ű �÷��� �������� �ʴ� ���� �ܷ�Ű �÷��� �÷������� ���� �� ����.
    --CONSTRAINT �������� �� FOREIGN KEY(�÷���) REFERENCES �θ����̺��(�θ����̺��÷�)
    --ON UPDATE CASCADE : �θ����̺��� ���� �����Ǹ� �ڽ� ���̺��� �൵ ���� ����(����Ŭ ���� X)
    --ON DELETE CASCADE : �θ����̺��� ���� �����Ǹ� �ڽ� ���̺��� �൵ ���� ����
    --ON DELETE SET NULL : �θ����̺��� ���� �����Ǹ� �ڽ� ���̺��� ���� NULL   
);

--�������� ��ܺ���
--1. AGE�� 20���� ���� ���� �ְ�, MARRIAGE�� 'Z'�� �־ �����ι��Ἲ�� ��ܺ���!
--2. NOT NULL �� ������ �÷��� NULL�� �־ NULL���Ἲ�� ��ܺ���!
--3. PROMARY KEY�� ������ E_ID�� NULL���� �־ �⺻Ű�� �ּҼ��� Ȯ���ϰ�
--  �ߺ��� ���� �־ �⺻Ű�� ���ϼ��� Ȯ��
--4. HIRE_DATE�� NULL�� �־ DEFAULT�� ������ ���� �� �ԷµǴ��� Ȯ��

--1. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE) VALUES(19,'Z');
--       NULL���Ἲ, ������ ���Ἲ ����
--2. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID) VALUES(19,'Z','�ϸ�','AAA');
--       ������ ���Ἲ ����
--3. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID) VALUES(21,'N','�ϸ�','AAA');
--       ������ ���� �Է�, DEFAULT ���� Ȯ��
--4. INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID) VALUES(21,'N','�ϸ�','AAA');
--       �⺻Ű�� ���ϼ� ���� ���� ����

--SELECT���� Ȱ���ؼ� ���̺� ����
CREATE TABLE COPY_EMPLOYEE
AS SELECT * FROM EMPLOYEE WHERE ENT_YN = 'Y';
SELECT * FROM COPY_EMPLOYEE;

DROP TABLE COPY_EMPLOYEE;

--���̺� �÷��� �����ؿ���, ������(X)
CREATE TABLE COPY_EMPLOYEE
AS SELECT * FROM EMPLOYEE WHERE 1=0;

----------------------------------------------------------------------
--���̺� ����
--1. �÷�
--ALTER TABLE ���̺�� ADD|MODIFY|DROP(�÷��� Ÿ�� [DEFAULT] [��������])
--�÷� �߰�(ADD)
ALTER TABLE MY_EMPLOYEE ADD(JOB_CODE CHAR(2));
SELECT * FROM MY_EMPLOYEE;

--�÷� ����(MODIFY)
--1. �÷��� Ÿ���� ���� �Ұ�, �� ���̺� �����Ͱ� �ϳ��� ������ Ÿ�Ժ��� ����
--2. �÷��� ũ��� ���ݺ��� ū ũ��θ� ���� ����
--3. NOT NULL ���������� ������ �� �ִ�, �� �̹� NULL�� ���� �����ϸ� ���� �Ұ�
--4. UNIQUE ���������� ������ �� �ִ�, �� �̹� �ߺ��� �����Ͱ� ������ ���� �Ұ�
-- * ���������� ����� �����Ͱ� �̹� ���� ��� ���������� �÷��� �߰��� �� ����

ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE NOT NULL);
--NOT NULL�� �÷��� NULL�� ������ ���� NULL�� ��������� ���
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE NULL);
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE CHAR(10));

--JOB_CODE�÷��� ���� ������ �߰�
INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID, JOB_CODE) 
VALUES(21,'N','�ϸ�','AAA','J10'); 
INSERT INTO MY_EMPLOYEE(AGE, MARRIAGE, ENAME, EID, JOB_CODE) 
VALUES(21,'N','�踻��','BBB','J10'); 
SELECT * FROM MY_EMPLOYEE;

--UNIQUE �������� �߰��ϱ� ����, �̹� �ߺ��� �����Ͱ� ����
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE UNIQUE);
--CHECK �������� �߰��ϱ� ����, �̹� ������ ��� �����Ͱ� ����
ALTER TABLE MY_EMPLOYEE MODIFY(JOB_CODE CHECK(JOB_CODE IN('J100')));

--�÷� ����(DROP)
ALTER TABLE MY_EMPLOYEE DROP COLUMN JOB_CODE;
SELECT * FROM MY_EMPLOYEE;

--�⺻Ű �߰��ϱ�, �⺻Ű �����ϱ�
ALTER TABLE MY_EMPLOYEE ADD PRIMARY KEY(ENAME);
--���� �⺻Ű ����
ALTER TABLE MY_EMPLOYEE DROP PRIMARY KEY;

--�ܷ�Ű �߰�
--ALTER TABLE ���̺�� 
--ADD CONSTRAINT �������Ǹ� FOREIGN KEY(�÷���) REFERENCES �θ����̺��(�÷���)
ALTER TABLE TB_BOARD ADD CONSTRAINT FK_BOARD_MEMBER
FOREIGN KEY(USER_ID) REFERENCES TB_MEMBER(USER_ID);

--�ܷ�Ű ����
--ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
ALTER TABLE TB_BOARD DROP CONSTRAINT FK_BOARD_MEMBER;

--[����]
--DATA DICTIONARY : ������ ����
--�б� �������� �����Ǵ� ���̺� �Ǵ� VIEW�� ����, �����ͺ��̽� ���ݿ� ���� ������ ����
--����� ����, ���� ����, ���� ����, ��ü����....
--�������ǿ� ���� ������ ��� �ִ� DICTIONARY ��ȸ
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'TB_BOARD';

--�������� �߰��ϱ�, �������� �����ϱ�
--MY_EMPLOYEE ���̺��� ENO �÷��� NOT NULL �������� �߰�
--ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ���� ���� ����(�÷���)
ALTER TABLE MY_EMPLOYEE ADD CONSTRAINT ENO_UNIQUE CHECK(AGE IS NOT NULL);

--�������� �����ϱ�
--ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
ALTER TABLE MY_EMPLOYEE DROP CONSTRAINT SYS_C007347;
-----------------------------------------------------------------------------------
--���̺� ����
--DROP TABLE ���̺��
--�����Ǿ����� �ִ� ���̺��� ������ �Ұ���
DROP TABLE MY_EMPLOYEE;
--DROP TABLE ���̺�� CASCADE CONSTRAINTS;
--���̺�� ���������� ���̺��� ���� �������ǵ� �Բ� ����



























