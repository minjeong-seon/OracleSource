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
SELECT
    empno,
    ename,
    sal,
    comm,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno,
    ename           사원명, --as는 생략가능
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp;


--9. 정렬 : order by
--  내림차순 정렬 : desc, 오름차순 정렬: asc

-- ename, sal 열 추출하고, sal 내림차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;

 -- ename, sal 열 추출하고, sal 오름차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal ASC; --asc는 생략 가능
    
--전체 내용 출력, 사원번호 오름차순으로 정렬
SELECT
    *
FROM
    emp empno;
    
--전체 내용 출력하고, 결과가 부서번호의 오름차순 & 급여 내림차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    deptno,
    sal DESC;
    
    -----------------------------------------------------------
--[실습]emp table의 모든 열 출력
--empno => employee_no
--ename => employee_name
--mgr => manager
--sal => salary
--comm => commision
--deptno => department_name
--부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면 사원 이름을 기준으로 오름차순 정렬
SELECT
    empno  AS employee_no,
    ename  AS employee_name,
    mgr    AS manager,
    sal    AS salary,
    comm   AS commision,
    deptno AS department_name
FROM
    emp
ORDER BY
    deptno DESC,
    ename ASC;
    
    
    -----------------------------------------------------------
--10. WHERE : 특정 조건을 기준으로 원하는 행을 조회(select 데이터명 from 테이블명 where 데이터명=기준)
--부서번호가 30인 데이터만 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30;


--사원번호가 7782인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;
    
    
--[동시조건부여: and = '';] 부서번호가 30이며, 사원직책이  salesman 인 행 조회
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';   --query문은 대소문자 구별 x, 내용은 구분해야 함
    
    
--사원번호가 7499이고, 부서번호가 30인 사원 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;
    
    
--[동시조건부여: or = '';]부서번호가 30이거나, 사원직책이 clerk인 행 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';
    
    -----------------------------------------------------------
--11. 산술연산자 : +, -, *, /, mod(나머지-오라클에서만)
    --비교연산자 : >, >=, <, <=
    --등가비교연산자 : =, !=, <>, ^= (!=. <>, ^= : A값과 B값이 다를 경우 TRUE, 같은 경우 FALSE)
    --논리부정연산자: NOT (비교연산자 대신 붙여서 쓸 수도 있음)
    --IN 연산자 (IN 조건 부여 --> 해당 조건만 조회)
    --BETWEEN A AND B 연산자
    --LIKE 연산자와 와일드 카드(_, %)
    --IS NULL 연산자
    --집합연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)
    
  ---------------------------------------------------  
--EMP테이블에서 급여 열에 12를 곱한 값이 36000인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;
    
    
--[산술연산자] ENAME이 F 이후의 문자로 시작하는 사원 조회
--**문자 표현 시 '홑따옴표'만 사용함**
SELECT
    *
FROM
    emp
WHERE
    ename > 'F'
ORDER BY
    ename;
    
    
--[비교연산자] JOB이 MNG, SALESMAN, CLERK 인 사원 조회 (이런 건 사실 IN연산자가 더 편함)
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';
    

--[등가비교연산자] SAL이 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000;  --sal <> 3000 나 sal ^= 3000도 가능
    
    
--[IN연산자] JOB이 MNG, SALESMAN, CLERK 인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    

----[NOT + IN연산자] JOB이 MNG, SALESMAN, CLERK 이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
    
--부서번호가 10번, 20번인 사원 조회(IN 연산자 사용)
SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );


--[BETWEEN A AND B 연산자] 급여가 2000이상 3000이하인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;


--[BETWEEN A AND B 연산자] 급여가 2000이상 3000이하가 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;
    
    
--[LIKE 연산자와 와일드 카드(_, %)]
--사원이름이 S로 시작하는 사원 정보를 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%';


--사원이름의 두번째 글자가 L인 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_L%';


--사원이름에 AM이 포함된 사원만 조회**
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%AM%';



--사원이름에 AM 이 포함되지 않은 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename NOT LIKE '%AM%';


--[IS NULL 연산자] 
--COMM이 NULL인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;

--MGR이 NULL인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NULL;

--MGR이 NULL이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NOT NULL;


--[집합연산자]
--[UNION] : 합집합 (동일한 결과값인 경우 중복 제거)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
    --[UNION ALL] : 합집합 (동일한 결과값도 포함)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
    --[MINUS] : 차집합 (A에서 B 빼기)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
    --[INTERSECT] : 교집합 (A와 B의 교집합만 조회)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
    
    
-- EMP 테이블에서 사원이름이 s로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';


-- EMP 테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의 사원번호, 이름, 급여 조회(SAL 내림차순 정렬)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
    deptno IN ( 30 )
    AND job = 'SALESMAN'
ORDER BY
    sal DESC;


-- EMP 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원 조회(사원번호, 이름, 급여, 부서번호 조회)
--집합 연산자를 사용하는 방식과 사용하지 않는 방식 두 가지를 활용하기
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

--교집합 사용 시 [INTERSECT 버전]
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

--교집합 사용 시 [MINUS 버전]
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    sal > 2000;
MINUS 
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO =10;


--사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000-2000사이가 아닌 사원의 이름
--사원번호, 급여, 부서번호 조회
SELECT EMPNO, ENAME, SAL, DEPTNO FROM, EMP
WHERE ENAME LIKE '%E%' AND DEPTNO=30
AND SAL NOT BETWEEN 1000 AND 2000;


--추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MNG. CLERK 인 사원 중에서
--사원이름의 두 번째 글자가 L이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
        AND job IN ( 'MANAGER', 'CLERK' )
            AND ename NOT LIKE '_L%';





--오라클 함수
--오라클에서 기본으로 제공하는 [내장 함수]와 사용자가 필요에 의해 직접 정의한 [사용자정의 함수]
-- [1] 문자열 함수
--  1) UPPER, LOWER, INITCAP 
--  UPPER(모두 대문자), LOWER(모두 소문자), INITCAP(첫글자만 대문자)
--  EX) 1.을 사용하지 않을 시, LIKE '%ORACLE%' OR LIKE '%oracle%' OR LIKE '%ORACLE%'로 각각 입력해야 하지만
--          1.을 사용하면 데이터값을 단순하게 조회 가능
SELECT
    ename,
    upper(ename),
    lower(ename),
    inItcap(ename)
FROM
    emp;

-- 1. UPPER, LOWER, INITCAP 사용 예시
 SELECT * FROM EMP
WHERE UPPER(ENAME)='FORD';

SELECT * FROM EMP WHERE UPPER(ENAME) LIKE UPPER('%ford');


-- 2) LENGTH : 문자열 길이
SELECT ENAME, length(ENAME) 
FROM EMP;

--사원 이름의 길이가 5 이상인 사원 조회
SELECT ENAME, length(ENAME) 
FROM EMP WHERE LENGTH(ENAME)>=5;

--한글일 때
--DUAL : SYS가 소유하는 테이블
--LENGTHB : 실제 사용하는 바이트 수 (인코딩 UTF-8 기준: 영어는 문자 1개 = 1 BYTE, 한글은 문자 1개 = 3 BYTE)
SELECT LENGTH('한글'), LENGTHB('한글'), LENGTHB('AB')
FROM DUAL;


-- 3) SUBSTR(문자열데이터, 시작위치, 추출길이) : 지정한 범위에 해당하는 문자열 추출(추출길이는 생략 가능)
SELECT JOB, SUBSTR(JOB, 1,2), SUBSTR(JOB,3,2), SUBSTR(JOB, 5), SUBSTR(JOB, -3) FROM EMP;

--ENAME, 세 번째 글자부터 출력
SELECT ENAME, SUBSTR(ENAME, 3) FROM EMP;



-- 4) INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
--INSTR(대상 문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택), 시작위치에서 찾으려는 문자가 몇 번째로 나오는 문자인지 지정(선택))
--EX) HELLO, ORACLE! 문자열에서 L 문자열 찾기
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, 
INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2, 
INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3 
FROM DUAL; 


-- 5) REPLACE : 특정 문자를 다른 문자로 변경
--REPLACE(문자열 데이터, 찾는 문자, 바꿀 문자)
-- 010-1234-5678 에서 -를 빈 문자열로 변경/ -를 없애기
SELECT REPLACE('010-1234-5678','-',' ') AS 공백, 
REPLACE('010-1234-5678','-') AS 없애기
FROM DUAL;

--'이것이 Oracle이다', '이것이' => This is로 변경
SELECT REPLACE('이것이 Oracle이다', '이것이', 'This is') FROM DUAL;


-- 6) CONCAT : 두 문자열 데이터 합치기 (두 개 초과 시 사용 불가)
SELECT CONCAT(EMPNO, ENAME) FROM EMP;
-- 3개 합치기
SELECT CONCAT(EMPNO, CONCAT (' : ', ENAME)) FROM EMP;
-- || : 문자열 연결 연산자(함수 사용X)
SELECT EMPNO || ' : ' || ENAME  FROM EMP;


-- 7) TRIM, LTRIM, RTRIM : 공백 포함 특정 문자 제거
SELECT '     이것이 ORACLE이다.   ', TRIM('     이것이 ORACLE이다.   ') FROM DUAL;