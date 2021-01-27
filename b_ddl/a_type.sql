CREATE TABLE TB_TYPE(    
    -- CHAR : 고정길이 문자열, 최대 2000BYTE
    -- 입력될 문자열의 자리수가 고정일 경우 속도가 빠르다.
    CHAR_TEST CHAR(100) 
        --> 문자열 데이터를 넣을 수 있는 컬럼을 생성, 크기는 100BYTE
        -- 100BYTE보다 작은 크기의 문자열이 입력되어도 해당 컬럼값의 크기는 100BYTE이다.
    
    -- VARCHAR2 : 가변길이 문자열, 최대 2000BYTE
    ,VARCHAR2_TEST VARCHAR2(100)
    --VARCHAR2_TEST VARCHAR2(100 CHAR) --> 문자로 100자리까지 저장
        --> 최대 100BYTE크기의 문자열을 입력할 수 있는 컬럼 생성
        --  100BYTE보다 작은 크기의 문자열이 입력될 경우 컬럼값의 크기가 문자열의 크기로 줄어든다.
        
    --CLOB (CHARACTER LARGE OBJECT)
    --최대 2GB까지 가변길이 문자데이터 저장 가능
    , CLOB_TEST CLOB
    
    --*** BLOB(BINARY LARGE OBJECT)
    --최대 2GB까지 가변길이 바이너리 데이터를 저장
    , BLOB_TEST BLOB
    
    --NUMBER : 22BYTE 크기의 데이터 타입. 최대 38자리까지 표기가 가능
    --부동소수점 표현방식
    , NUMBER_TEST NUMBER
    
    --고정소수점 표현방식
    --표현할 정수부와 소수점의 자리수를 고정하는 방식
    --NUMBER(PRECISION, SCALE)
    --PRECISION : 소수점을 포함한 전체 자리수를 의미
    --SCALE : 소수점 이하 자리수 지정
    
    --만약 SCALE 생략할 경우 소수점 첫째 자리에서 반올림하여 정수로 만듦
    ,NUMBER_TEST1 NUMBER(7) -- PRECISION 7, SCALE은 생략
    ,NUMBER_TEST2 NUMBER(7,1) 
    ,NUMBER_TEST3 NUMBER(7,3)
    --전체자리수 5자리, SCALE이 음수일 경우 소수점을 기준으로 SCALE의 크기만큼 좌측으로 이동한
    --자리에서 반올림처리
    ,NUMBER_TEST4 NUMBER(5,-2)
    
    --PRECISION이 SCALE보다 작을 경우 PRECISION은 소수점 아래 유효숫자의 자리수를 의미
    --유효숫자 : 0이 아닌 수
    --SCALE이 정밀도 개념이 되어서 SCALE에 지정한 자리수보다 소수점의 자리수가 작은 수를
    --넣으면 에러가 발생
    ,NUMBER_TEST5 NUMBER(4,5)
    ,NUMBER_TEST6 NUMBER(4,5)
    ,NUMBER_TEST7 NUMBER(3,7)
    ,NUMBER_TEST8 NUMBER(3,7)
    
    --DATE : 기본형식 :YY/MM/DD
    ,DATE_TEST DATE
    
    );
    
    
    