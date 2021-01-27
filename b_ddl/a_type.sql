CREATE TABLE TB_TYPE(    
    -- CHAR : �������� ���ڿ�, �ִ� 2000BYTE
    -- �Էµ� ���ڿ��� �ڸ����� ������ ��� �ӵ��� ������.
    CHAR_TEST CHAR(100) 
        --> ���ڿ� �����͸� ���� �� �ִ� �÷��� ����, ũ��� 100BYTE
        -- 100BYTE���� ���� ũ���� ���ڿ��� �ԷµǾ �ش� �÷����� ũ��� 100BYTE�̴�.
    
    -- VARCHAR2 : �������� ���ڿ�, �ִ� 2000BYTE
    ,VARCHAR2_TEST VARCHAR2(100)
    --VARCHAR2_TEST VARCHAR2(100 CHAR) --> ���ڷ� 100�ڸ����� ����
        --> �ִ� 100BYTEũ���� ���ڿ��� �Է��� �� �ִ� �÷� ����
        --  100BYTE���� ���� ũ���� ���ڿ��� �Էµ� ��� �÷����� ũ�Ⱑ ���ڿ��� ũ��� �پ���.
        
    --CLOB (CHARACTER LARGE OBJECT)
    --�ִ� 2GB���� �������� ���ڵ����� ���� ����
    , CLOB_TEST CLOB
    
    --*** BLOB(BINARY LARGE OBJECT)
    --�ִ� 2GB���� �������� ���̳ʸ� �����͸� ����
    , BLOB_TEST BLOB
    
    --NUMBER : 22BYTE ũ���� ������ Ÿ��. �ִ� 38�ڸ����� ǥ�Ⱑ ����
    --�ε��Ҽ��� ǥ�����
    , NUMBER_TEST NUMBER
    
    --�����Ҽ��� ǥ�����
    --ǥ���� �����ο� �Ҽ����� �ڸ����� �����ϴ� ���
    --NUMBER(PRECISION, SCALE)
    --PRECISION : �Ҽ����� ������ ��ü �ڸ����� �ǹ�
    --SCALE : �Ҽ��� ���� �ڸ��� ����
    
    --���� SCALE ������ ��� �Ҽ��� ù° �ڸ����� �ݿø��Ͽ� ������ ����
    ,NUMBER_TEST1 NUMBER(7) -- PRECISION 7, SCALE�� ����
    ,NUMBER_TEST2 NUMBER(7,1) 
    ,NUMBER_TEST3 NUMBER(7,3)
    --��ü�ڸ��� 5�ڸ�, SCALE�� ������ ��� �Ҽ����� �������� SCALE�� ũ�⸸ŭ �������� �̵���
    --�ڸ����� �ݿø�ó��
    ,NUMBER_TEST4 NUMBER(5,-2)
    
    --PRECISION�� SCALE���� ���� ��� PRECISION�� �Ҽ��� �Ʒ� ��ȿ������ �ڸ����� �ǹ�
    --��ȿ���� : 0�� �ƴ� ��
    --SCALE�� ���е� ������ �Ǿ SCALE�� ������ �ڸ������� �Ҽ����� �ڸ����� ���� ����
    --������ ������ �߻�
    ,NUMBER_TEST5 NUMBER(4,5)
    ,NUMBER_TEST6 NUMBER(4,5)
    ,NUMBER_TEST7 NUMBER(3,7)
    ,NUMBER_TEST8 NUMBER(3,7)
    
    --DATE : �⺻���� :YY/MM/DD
    ,DATE_TEST DATE
    
    );
    
    
    