-- ♣ PL/SQL : SQL만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해 오라클에서 제공하는 프로그래밍 언어 > 코딩하고 비슷함


-- ▽ 실행 결과를 화면에 출력
SET SERVEROUTPUT ON;

-- ▽ 블록 : DECLEAR ~ BDGIN ~ END
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello PL/SQL');
END;
/


-- ♣ 변수 선언
DECLARE
    V_EMPNO NUMBER(4) := 7788;      --[java] int vEnpno = 7788; 이랑 동일함
    V_ENAME VARCHAR2(10);           --[java] String ename;
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_ENMAE: ' || V_ENAME);       -- DBMS_OUTPUT.PUT_LINE = SYSTEM.OUT.PRINTLN();
    DBMS_OUTPUT.PUT_LINE('V_EMPNO: ' || V_EMPNO);
END;
/


-- ▽ 상수 선언
DECLARE
    V_TAX CONSTANT NUMBER(4) := 7788;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX: ' || V_TAX);
END;
/


-- ▽ 변수+DEFAULT 선언
DECLARE
    V_TAX NUMBER(4) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX: ' || V_TAX);
END;
/


-- ▽ 변수+NOT NULL
DECLARE
    V_TAX NUMBER(4) NOT NULL := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX: ' || V_TAX);
END;
/


-- ▽ 변수+NOT NULL+DEFAULT
DECLARE
    V_TAX NUMBER(4) NOT NULL DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX: ' || V_TAX);
END;
/


-- ♣ 변수와 상수의 자료형
--      1) 스칼라 : 오라클이 사용하는 타입(ex- NUMBER, CHAR, DATE,....)
--      2) 참조형 : 오라클 데이터베이스에 존재하는 특정 테이블 내 열의 자료형이나 하나의 행 구조를 참조하는 자료형
--            > 변수이름 테이블명.열이름%TYPE : 특정 테이블에 속한 열과 같은 크기의 자료형을 사용
--            > 변수이름 테이블명%ROWTYPE : 특정 테이블에 속한 행구조 전체 참조

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO: ' || V_DEPTNO);
END;
/

-- ▽ V_DEPT_ROW 변수가 DEPT 테이블 내 한 행의 구조를 참조
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
    FROM DEPT
    WHERE DEPTNO=40;
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME: ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC: ' || V_DEPT_ROW.LOC);
END;
/


-- ▽ 조건문 : IF, IF ~ THEN ~ END IF,
DECLARE
    V_NUMBER NUMBER :=15;
BEGIN
    --V_NUMBER가 홀수인지 짝수인지 구별하기
    --MOD() : 나머지 구하는 오라클 함수
    IF MOD(V_NUMBER, 2) = 1 THEN
    DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수');
    ELSE
    DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수');
    END IF;
END;
/


-- ▽ 학점 출력하기(IF문)
DECLARE
    SCORE NUMBER :=95;
BEGIN

    IF SCORE >= 90 THEN
    DBMS_OUTPUT.PUT_LINE('학점: A');
    ELSIF SCORE >= 80 THEN
    DBMS_OUTPUT.PUT_LINE('학점: B');
    ELSIF SCORE >= 70 THEN
    DBMS_OUTPUT.PUT_LINE('학점: C');
    ELSIF SCORE >= 60 THEN
    DBMS_OUTPUT.PUT_LINE('학점: D');
    ELSE
    DBMS_OUTPUT.PUT_LINE('학점: F');
    END IF;
END;
/


-- ▽ 학점 출력하기(CASE문)
DECLARE
    SCORE NUMBER :=95;
BEGIN
    CASE TRUNC (SCORE/10)
    WHEN 10 THEN
    DBMS_OUTPUT.PUT_LINE('학점: S');
    WHEN 9 THEN
    DBMS_OUTPUT.PUT_LINE('학점: A');
    WHEN 8 THEN
    DBMS_OUTPUT.PUT_LINE('학점: B');
    WHEN 7 THEN
    DBMS_OUTPUT.PUT_LINE('학점: C');
    WHEN 6 THEN
    DBMS_OUTPUT.PUT_LINE('학점: D');
    ELSE DBMS_OUTPUT.PUT_LINE('학점: F');
    END CASE;
END;
/



-- ▽ 학점 출력하기(CASE문2)
DECLARE
    SCORE NUMBER :=95;
BEGIN
    CASE
    WHEN SCORE>=90 THEN
    DBMS_OUTPUT.PUT_LINE('학점: A');
    WHEN SCORE>=80 THEN
    DBMS_OUTPUT.PUT_LINE('학점: B');
    WHEN SCORE>=70 THEN
    DBMS_OUTPUT.PUT_LINE('학점: C');
    WHEN SCORE>=60 THEN
    DBMS_OUTPUT.PUT_LINE('학점: D');
    ELSE DBMS_OUTPUT.PUT_LINE('학점: F');
    END CASE;
END;
/


-- ▽ 반복문(LOOP ~ EXIT WHEN ~ END LOOP)
DECLARE
    V_NO NUMBER :=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('V_NO : ' || V_NO);
        V_NO := V_NO+1;
        EXIT WHEN V_NO>4;
    END LOOP;
END;
/


-- ▽  반복문(WHILE LOOP) : WHILE 조건 LOOP 실행문 END LOOP;
DECLARE
    V_NO NUMBER :=0;
BEGIN
    WHILE V_NO>4 LOOP
        DBMS_OUTPUT.PUT_LINE('V_NO : ' || V_NO);
        V_NO := V_NO+1;
    END LOOP;
END;
/


-- ▽  반복문(FOR LOOP) : FOR i IN 시작값..종료값 LOOP 실행문 END LOOP;
BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
    END LOOP;
END;
/

-- (거꾸로)
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
    END LOOP;
END;
/

-- (CONTINUE) : WHEN 다음에 오는 실행문(조건에 맞는) 건너뛰기
BEGIN
    FOR i IN 0..4 LOOP
    CONTINUE WHEN MOD(I,2) = 1;
        DBMS_OUTPUT.PUT_LINE('i : ' || I);
    END LOOP;
END;
/


--[연습]1~10까지의 수 홀수만 거꾸로 출력하기
BEGIN
    FOR i IN REVERSE 1..10 LOOP
     IF MOD(I,2)=1 THEN
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
     END IF;
    END LOOP;
END;
/

BEGIN
    FOR i IN REVERSE 1..10 LOOP
     CONTINUE WHEN MOD(I, 2) = 0;
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
    END LOOP;
END;
/


-- ♣ 커서(; Cursor) : SELECT문 또는 데이터 조작어 같은 SQL문을 실행했을 때 해당 SQL문을 처리하는 정보를 저장한 메모리 공간(포인터)
--      >>출력할 데이터의 양이 많을 때 유용함

-- ▼ 명시적 커서
--  1)커서 선언 -> 2) 커서 열기 -> 3) 커서에서 가져온 데이터 사용 -> 4) 커서 닫기

-- ▽ 결과가 단일행일 때
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    -- 1) 커서 선언
    CURSOR c1 IS
         SELECT DEPTNO, DNAME, LOC
         FROM DEPT
         WHERE DEPTNO=40;
BEGIN
    -- 2) 커서 열기
    OPEN c1;
    -- 3) 커서에서 데이터 가져와 사용하기
        FETCH c1 INTO V_DEPT_ROW    ;
        DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME: ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC: ' || V_DEPT_ROW.LOC);
    -- 4) 커서 닫기
    CLOSE c1;
END;
/


-- ▽ 반복문(Cursor + LOOP) : CURSOR 커서이름 IS ~ OPEN 커서이름; FETCH ~; CLOSE; / 결과가 여러 행일 때 사용
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    CURSOR c1 IS
         SELECT DEPTNO, DNAME, LOC
         FROM DEPT;
BEGIN
    OPEN c1; 
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
    -- LOOP 탈출 조건 부여(조건이 없으면 루프를 빠져나오지 못해서 에러 발생)
            EXIT WHEN c1%NOTFOUND;      -- 커서이름%NOTFOUND : 수행된 FETCH문을 통해 추출된 행이 있으면 FALSE, 없으면 TRUE 리턴
            DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || V_DEPT_ROW.DEPTNO);
            DBMS_OUTPUT.PUT_LINE('DNAME: ' || V_DEPT_ROW.DNAME);
            DBMS_OUTPUT.PUT_LINE('LOC: ' || V_DEPT_ROW.LOC);
        END LOOP;
    CLOSE c1;
END;
/


-- ▽ 반복문(Cursor + FOR LOOP) : OPEN, FETCH, CLOSE 가 자동으로 수행됨
DECLARE
    CURSOR c1 IS
         SELECT DEPTNO, DNAME, LOC
         FROM DEPT;
BEGIN
    FOR C1_REC IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || C1_REC.DEPTNO || ' DNAME: ' || C1_REC.DNAME || ' LOC: ' || C1_REC.LOC);
    END LOOP;
END;
/


-- ▽ 커서 + 파라미터 : 
DECLARE
        V_DEPTNO DEPT%ROWTYPE;
        CURSOR C1(P_DEPTNO DEPT.DEPTNO%TYPE) IS
         SELECT DEPTNO, DNAME, LOC
         FROM DEPT
         WHERE DEPTNO = P_DEPTNO;
BEGIN
    OPEN C1(10);
        LOOP
            FETCH C1 INTO V_DEPTNO;
            EXIT WHEN C1%NOTFOUND;
                 DBMS_OUTPUT.PUT_LINE('10번 부서 DEPTNO: ' || V_DEPTNO.DEPTNO || ' DNAME: ' || V_DEPTNO.DNAME || ' LOC: ' || V_DEPTNO.LOC);
        END LOOP;
    CLOSE c1;
END;
/    


-- ▽ 커서 + 파라미터 입력받기 : 사용자 입력을 받아 반복문 출력
DECLARE    
    -- 사용자가 입력한 부서 번호를 저장하는 변수
    V_DEPTNO DEPT.DEPTNO%TYPE;
    -- 커서 선언
    CURSOR C1(P_DEPTNO DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC 
        FROM DEPT
        WHERE DEPTNO = P_DEPTNO;          
BEGIN    
    -- 사용자 입력 : &변수
    V_DEPTNO := &INPUT_DEPTNO;
    FOR C1_REC IN c1(V_DEPTNO) LOOP        -- V_DEPTNO에 입력받은 C1 값 넘기기
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || C1_REC.DEPTNO || ' DNAME : ' || C1_REC.DNAME || ' LOC : ' || C1_REC.LOC);      
    END LOOP;    
END;
/


-- ▼ 묵시적 커서 : 별다른 선언 없이 SQL문 사용
        -- 여러 행의 결과를 가지는 커서는 명시적 커서로만 사용함

-- SQL%NOTFOUND : 묵시적 커서 안에 추출된 행이 있으면 FALSE, 없으면 TRUE 반환
        -- DML 명령어로 영향을 받는 행이 없을 경우에도 TRUE

-- SQL%FOUND : 묵시적 커서 안에 추출된 행이 있으면 TRUE, 없으면 FALSE 반환
        -- 영향을 받는 행이 있다면 TRUE

-- SQL%ROWCOUNT : 묵시적 커서에 현재까지 추출한 행의 수 또는 DML 명령어로 영향받는 행의 수 반환

-- SQL%ISOPEN : 묵시적 커서는 자동으로 SQL문을 실행한 후 CLOSE되므로 이 속성은 항상 FALSE 반환

BEGIN
    UPDATE DEPT_TEMP SET DNAME = 'DATABASE'
    WHERE DEPTNO = 50;
        DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);
    IF (SQL%FOUND) THEN
         DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : FALSE');
    END IF;
    
    IF (SQL%NOTFOUND) THEN
         DBMS_OUTPUT.PUT_LINE('커서 OPEN 여부 : TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('커서 OPEN 여부 : FALSE');
    END IF;
END;
/


-- ▼ 예외 처리 : EXCEPTION WHEN 오류코드 THEN 실행문
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG   --ERROR : NUMBER로 선언한 변수에 VARCHAR2 데이터를 불러오기 함
    FROM DEPT
    WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('예외 발생 시 이 문장은 실행되지 않음');      --정상적으로 실행 시 출력될 구문
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');   --에러 발생 시 출력될 구문
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 요구보다 많은 행 추출 오류 발생');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류 발생');
END;
/


-- ▽ 예외처리 OTHERS : 어떤 에러가 발생할 지 모를 때
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME INTO V_WRONG 
    FROM DEPT
    WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('예외 발생 시 이 문장은 실행되지 않음');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류 발생');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/



-- 예제) 명시적 커서를 사용하여 EMP 테이블의 전체 데이터를 조회한 후 데이터 출력(FOR LOOP 사용)
DECLARE
    CURSOR c1 IS
         SELECT *
         FROM EMP;
BEGIN
    FOR C1_REC IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE('EMPNO: ' || C1_REC.EMPNO || ' ENAME: ' || C1_REC.ENAME || ' JOB: ' || C1_REC.JOB
                || ' SAL : ' || C1_REC.SAL || ' DEPTNO : ' || C1_REC.DEPTNO);
    END LOOP;
END;
/



-- ♣ (저장)프로시저 : 특정 처리 작업을 수행하는데 사용 (=다른 응용 프로그램에서 호출 가능)
-- (컴파일 =저장(메소드 같은 거))
--CREATE [OR REPLACE] PROCEDURE 프로시저명
--IS | AS 선언부
--BEGIN
--    실행부
--EXCEPTION
--    예외부
--END;/
--EXECUTE 프로시저명; (실행)

CREATE OR REPLACE PROCEDURE PRO_NOPARAM
IS
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_ENMAE: ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_EMPNO: ' || V_EMPNO);
END;
/

-- 실행
EXECUTE PRO_NOPARAM;

--블록 안에서 실행
BEGIN
    PRO_NOPARAM;
END;
/

-- 프로시저 삭제
DROP PROCEDURE PRO_NOPARAM;


-- ▽ 파라미터 + 프로시저
-- IN(DEFAULT) : 프로시저 호출 시 값을 입력받음
-- OUT : 프로시저를 호출할 때 값 반환
-- IN OUT : 호출할 때 값을 입력 받은 후 실행결과 값 반환

CREATE OR REPLACE PROCEDURE PRO_PARAM(PARAM1 IN NUMBER, PARAM2 NUMBER, PARAM3 NUMBER :=3, PARAM4 NUMBER DEFAULT 4)
IS
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('PARAM1: ' || PARAM1);
    DBMS_OUTPUT.PUT_LINE('PARAM2: ' || PARAM2);
    DBMS_OUTPUT.PUT_LINE('PARAM3: ' || PARAM3);
    DBMS_OUTPUT.PUT_LINE('PARAM4: ' || PARAM4);
END;
/

EXECUTE PRO_PARAM(1,2,8,9);

EXECUTE PRO_PARAM(1,2);


-- ▽ 프로시저 + OUT
CREATE OR REPLACE PROCEDURE PRO_PARAM_OUT(IN_EMPNO IN EMP.EMPNO%TYPE, OUT_ENAME OUT EMP.ENAME%TYPE, OUT_SAL OUT EMP.SAL%TYPE)
IS
-- IN_EMPNO로 받은 값에 대한 데이터를 OUT_ENAME, OUT_SAL에 담아 내보내기
BEGIN
    SELECT ENAME, SAL INTO OUT_ENAME, OUT_SAL
    FROM EMP
    WHERE EMPNO=IN_EMPNO;
END;
/

DECLARE
    V_ENAME EMP.ENAME%TYPE;
    V_SAL EMP.SAL%TYPE;
BEGIN
    PRO_PARAM_OUT(7839, V_ENAME, V_SAL);
    DBMS_OUTPUT.PUT_LINE('V_ENMAE: ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_SAL: ' || V_SAL);
END;
/


-- ♣ 트리거(; TRIGGER) : 데이터베이스 안의 특정 상황이나 동작=이벤트가 발생할 경우, 자동으로 실행되는 기능 정의
        --> 테이블에 저장됨
-- 작업 EX) 회원 테이블에서 회원이 삭제되면(이벤트 발생) > 해당 회원을 다른 테이블로 이동(자동 실행 기능 정의)

--CREATE [OR REPLACE] TRIGGER 트리거명
--BEFORE | AFTER (<-트리거 동작 시점: 이벤트 발생 전|후)
--INSERT | UPDATE | DELETE ON 테이블명 (<-이벤트 발생 상황)
--[FOR EACH ROW WHEN 조건식] (<-각 행마다 WHEN 이후 내용 실행)
--[ENABLE | DISABLE]
--(자동실행기능 정의)
--DECLARE
--    선언부
--BEGIN
--    실행부
--EXCEPTION
--    예외부
--END;
--/

CREATE TABLE EMP_TRG AS SELECT * FROM EMP;

-- EMP_TRG 테이블에 DML 명령 사용 시, 주말일 경우 DML 명령 실행 취소
CREATE OR REPLACE TRIGGER TRG_EMP_NODML_WEEKEND
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF TO_CHAR(SYSDATE, 'DY') IN ('토', '일') THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20000, '주말은 사원정보 추가 불가');
        ELSIF UPDATING THEN
            RAISE_APPLICATION_ERROR(-20001, '주말은 사원정보 수정 불가');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002, '주말은 사원정보 삭제 불가');
        ELSE
            RAISE_APPLICATION_ERROR(-20003, '주말은 사원정보 변경 불가');
        END IF;
    END IF;
END;
/

-- 트리거 기능 작동 여부 확인해보기
UPDATE EMP_TRG SET SAL=8000 WHERE EMPNO=7369;
SELECT EMPNO, ENAME, SAL FROM EMP_TRG WHERE EMPNO=7369;
COMMIT;

-- ▽ LOG 기록 트리거
CREATE TABLE EMP_TRG_LOG(
    TABLENAME VARCHAR2(10),
    DML_TYPE VARCHAR2(10),
    EMPNO NUMBER(4),
    USER_NAME VARCHAR2(30),
    CHANGE_DATE DATE);


CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
INSERT OR UPDATE OR DELETE ON emp_trg
FOR EACH ROW

BEGIN
    IF INSERTING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'INSERT', :new.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
    ELSIF UPDATING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'UPDATE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
    ELSIF DELETING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'DELETE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);    
    END IF;
   
END;
/



