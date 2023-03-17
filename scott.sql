--scott

--DESC(;describe) emp; : emp(employee) 테이블 구성 보기
--열: 필드명(열 이름) > 제약조건 > 데이터타입 순으로 나옴
--    EMPNO(사원번호)   NOT NULL    NUMBER(4)
--    ENAME(사원명), JOB(직책), MGR(직속상관 번호), HIREDATE(입사일), SAL(급여), COMM(수당), DEPTNO(부서번호)
--    NUMBER : 소숫점 자릿수를 포함하여 지정 가능 (ex- NUMBER(4) : 4자리 숫자까지 허용, NUMBER(8,2): 전체 자릿수는 8자리에 소숫점 2자리 포함)
--    VARCHAR2 : 가변형 문자열 저장 (ex- VARCHAR2(10): 10byte 문자까지 저장 가능)
--    DATE : 날짜 데이터

DESC emp;

-- DNAME(부서명), LOC(부서위치)
DESC dept;

--GRADE(급여등급). LOWSAL(최소 급여액), HISAL(최대 급여액) 
DESC salgrade;

--select : 데이터 조회**
--셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두 개 이상의 테이블을 사용하여 조회) : (selection, projection, join)
--SELECT 열이름1, 열이름2....(조회할 열이 전체라면 *로 처리 -ex) SELECT *)
--FROM 테이블명;

--1. EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

--2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;

--3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;

--4. DEPT 테이블 안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;
    
--5. EMP 테이블 안에 부서번호 조회
SELECT
    deptno
FROM
    emp;
    
    --6. EMP 테이블 안에 부서번호 조회(단, 중복된 부서번호는 제외)
SELECT DISTINCT
    deptno
FROM
    emp;
    
--7. 6.에 JOB 추가/ 열이 여러 개인 경우 묶어서 중복인지 여부 판단 
SELECT DISTINCT
    job,
    deptno
FROM
    emp;
    
--8. 연산
-- 사원들의 1년 연봉 구하기 (SAL*12+COMM)
-- 필드에 별칭을 임의로 부여(as 별칭 / 한 칸 띄고 별칭 / 별칭에 공백이 있으면 한 칸 띄고 "별칭")
SELECT EMPNO, ENAME, SAL*12+COMM AS ANNSAL FROM EMP;
SELECT EMPNO, ENAME 사원명, JOB "직 책", SAL*12+COMM ANNSAL FROM EMP;
