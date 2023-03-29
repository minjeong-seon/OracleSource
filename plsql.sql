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

-- ▽  반복문(Cusor FOR LOOP)

