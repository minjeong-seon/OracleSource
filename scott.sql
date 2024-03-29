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


----------------------------------------(2023.03.21)-------------------------------------------------


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



-- [2] 숫자함수
-- 1) ROUND(반올림), TRUNC(버림), CEIL(큰 정수), FLOOR(작은 정수), MOD(나머지)

-- ROUND(숫자, 올림위치(선택))
SELECT ROUND(1234.5678) AS ROUND,  --소숫점 첫째 자리에서 반올림
ROUND(1234.5678, 0) AS ROUND0,    --소숫점 첫째 자리에서 반올림
ROUND(1234.5678, 1) AS ROUND1,    --소숫점 둘째 자리에서 반올림
ROUND(1234.5678, 2) AS ROUND2,    --소숫점 셋째 자리에서 반올림
ROUND(1234.5678, -1) AS ROUND_MINUS1,  --자연수 첫째 자리에서 반올림
ROUND(1234.5678, -2) AS ROUND_MINUS2  --자연수 둘째 자리에서 반올림
FROM DUAL;


--TRUNC : 특정 위치에서 버리는 함수
--TRUC(숫자, 버림위치(선택))
SELECT TRUNC(1234.5678) AS TRUNC,
TRUNC(1234.5678, 0) AS TRUNC0,  --
TRUNC(1234.5678, 1) AS TRUNC1,
TRUNC(1234.5678, 2) AS TRUNC2,
TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM DUAL;


--CEIL(숫자) FLOOR(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수
SELECT CEIL(3.14),
FLOOR(3.14),
CEIL(-3.14),
FLOOR(-3.14)
FROM DUAL;


--MOD(숫자, 나눌 수) : 나머지 값
SELECT MOD(15,6), MOD(10, 2), MOD(11, 2) FROM DUAL;



-- [3] 날짜함수
-- 날짜 데이터+/-숫자 : 날짜 데이터보다 숫자만큼 추가된/이전의 날짜
-- 날짜 데이터-날짜데이터 : 두 날짜 데이터 간의 일수 차이
-- 날짜 데이터+날짜데이터 : 연산 불가

-- 1) SYSDATE 함수 : 오라클DB 서버가 설치된 OS의 현재 날짜와 시간을 가져옴
SELECT SYSDATE AS TODAY, 
SYSDATE-1 AS YESTERDAY, 
SYSDATE+1 AS TOMORROW
FROM DUAL;


-- 2) add_month(날짜, 추가할 개월 수) : 몇 개월 이후의 날짜 데이터
SELECT SYSDATE AS "오늘날짜", ADD_MONTHS(SYSDATE, 3) AS "3개월후날짜"
FROM DUAL;


-- EX) 입사 50주년이 되는 날짜 구하기
--EMPNO, ENAME, HIREDATE, 입사 50주년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 600) AS "입사 50주년"
FROM EMP;

--3 ) MONTHS_BETWEEN (날짜 데이터, 날짜 데이터): 두 날짜 데이터 간의 날짜 차이를 개월수로 계산하여 출력 
-- EX2) 입사 45년 미만인 사원 데이터 조회
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE)< 540;  --현재 날짜-입사일<45년(540개월)


-- EX2) 현재 날짜와 5개월 후 날짜 출력
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 5) FROM DUAL;

SELECT EMPNO, ENAME, HIREDATE, SYSDATE, 
MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
trunc(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
FROM emp;


-- 4) next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--    last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
select sysdate, next_day(sysdate, '금요일'), last_day(sysdate)
from dual;

--날짜의 반올림, 버림: round, trunc
-- CC : 네 자리 연도의 끝 두 자리를 기준으로 사용 ex) 2023년 -> 2050 이하이므로 = 2001년 
-- HH : 시간 기준 반올림
-- DD : 오늘 날짜를 기준으로 반올림
select sysdate, round(sysdate, 'CC') as foramt_cc,
round(sysdate, 'YYYY') as foramt_yyyy,
round(sysdate, 'DDD') as foramt_ddd,
round(sysdate, 'HH') as foramt_hh
from dual;


-- [4] 형변환 함수 : 자료형을 형변환
-- number, varchar2, date

--FORD 사원의 사원번호에 500 더하기
select empno, ename, empno+'500'
from emp
where ename = 'FORD';

--ORA-01722: 수치가 부적합합니다
--select empno, ename, empno+'ABCD'
--from emp
--where ename = 'FORD';

--1) TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
--   TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
--   TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- ex) to_char(숫자/날짜 데이터 , 문자데이터) : 원하는 형태로 날짜를 출력할 때 주로 사용됨
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') as 현재날짜시간,
to_char(sysdate, 'yyyy') as 현재날짜시간,
to_char(sysdate, 'mm') as 현재월,
to_char(sysdate, 'MON') as 현재월1,
to_char(sysdate, 'DD') as 현재일자,
to_char(sysdate, 'DDD') as 현재일자1,
to_char(sysdate, 'HH12:MI:SS AM') as 현재날짜시간
FROM dual;

--sal 필드에 ',' 혹은 통화 표시를 추가할 때
--원화 표시는 L(;local)을 붙이면 됨
select sal, to_char(sal, '$999,999') as sal_$, to_char(sal, 'L999,999') as sal_L 
from emp;




--TO_NUMBER(문자열데이터, 인식될 숫자형태)
-- '999,999' => 숫자 세 자리마다 콤마 삽입
SELECT 
to_number('1,300', '999,999')-to_number('1,500','999,999')
FROM DUAL;


--to_date(문자 데이터, '인식될' 날짜 데이터)
select to_date(sysdate, 'YYYY-MM-DD') as todate1,
to_date('20230321', 'YYYY-MM-DD') as todate2
from dual;

--날짜에서 날짜 차감
select to_date('2023-03-21')-to_date('2023-02-01')
from dual;


-- [5] null 처리함수
-- NULL+300=NULL 으로 연산이 안 됨.
-- 1) NVL(데이터, NULL일 경우 리턴 데이터)
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM, NVL(COMM, 0)
FROM EMP;

-- 2) NVL2(데이터, NULL이 아닐 경우 리턴 데이터, NULL일 경우 리턴 데이터)
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, 'O', 'X'), 
NVL2(COMM, SAL*12+COMM,SAL*12) AS ANNSAL
FROM EMP; 


-- [6] decode 함수 / case 문
-- 1) decode(검사 대상이 될 데이터, 조건1, 조건1이 일치할 때 실행할 구문, ...)

-- ex) emp테이블에서 직책이 manager 인 사람은 급여의 10% 인상,
--      salesman은 5%, analyst는 그대로, 그 외 3% 인상된 급여 출력
select empno, ename, job, sal,
decode(job, 'MANAGER', SAL*1.1, 'SALESMAN', SAL*1.05, 'ANALYST', SAL, SAL*1.03)
FROM EMP;

--CASE문
SELECT EMPNO, ENAME, JOB, SAL,
CASE JOB
WHEN 'MANAGER' THEN sal * 1.1
    WHEN 'SLAESMAN' THEN
        sal * 1.05
    WHEN 'ANALYST' THEN
        sal
ELSE SAL*1.03
END AS UPSAL
FROM
emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항없음'
        WHEN comm = 0 THEN
            '수당없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;







--------------------------------------------------
--[실습1] 사원들의 월 평균 근무일수가 21.5일일 때, 하루 급여(셋째자리 반올림), 시급(둘째자리 반올림) 조회
SELECT
    empno,
    ename,
    sal,
    round(sal / 21.5, 2)     AS day_pay,
    round(sal / 21.5 / 8, 1) AS time_pay
FROM
    emp;


--[실습2] emp테이블에서 입사일 기준 3개월 후 정직원이 되는 날짜(R_job)을 YYYY-MM-DD 형식으로 출력
--          단, COMM이 없는 사원의 추가 수당은 N/A로 출력하기 
SELECT
    empno,
    ename,
    hiredate,
    TO_DATE(add_months(hiredate, 3),
            'YYYY-MM-DD') AS r_job,
    nvl(to_char(comm),
        'N/A')
FROM
    emp;

-- 정직원이 되는 시기의 월요일
SELECT
    empno,
    ename,
    hiredate,
    next_day(add_months(hiredate, 3),
             '월요일') AS r_job,
    nvl(to_char(comm),
        'N/A')      AS comm
FROM
    emp;
    

--[실습3] emp테이블에서 모든 사원을 대상으로 직속상관의 번호를 아래 조건을 기준으로 변환하여 출력 
--직속상관이 없으면 0000 | 앞 두자리가 75: 5555 | 76: 6666 | 77: 7777 | 78: 8888
--그 외 75-18에 해당하지 않으면 원래 번호 그대로 출력
SELECT
    empno,
    ename,
    mgr,
    decode(substr(to_char(mgr),1,2), NULL, '0000',
    '75', '5555', 
    '76', '6666', 
    '77', '7777', 
    '78', '8888', 
    substr(to_char(mgr), 1)) AS chg_mgr
FROM
    emp;

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            '0000'
        WHEN substr(to_char(mgr), 1, 2) = '75' THEN
            '5555'
        WHEN substr(to_char(mgr), 1, 2) = '76' THEN
            '6666'
        WHEN substr(to_char(mgr), 1, 2) = '77' THEN
            '7777'
        WHEN substr(to_char(mgr), 1, 2) = '78' THEN
            '8888'
        ELSE
            to_char(mgr)
    END AS chg_mgr
FROM
    emp;


-- [7] 다중행 함수
-- SUM, COUNT, MAX, MIN, AVG
-- 주로 발생하는 오류 : ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
-- SUM( ) : null 값은 제외하고 합산함
SELECT
    SUM(sal)
FROM
    emp;
    
SELECT
    SUM(distinct sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;
    
SELECT
    SUM(comm)
FROM
    emp;
    
-- 2)count() : null 값을 제외한 테이블 내 행의 개수
select count(sal)
from emp;

select count(comm)
from emp;

-- 3) max(), min() : null 값은 0으로 리턴
select max(sal)
from emp;

select min(hiredate), max(hiredate)
from emp;

select min(comm) from emp;

-- 4) avg() : null 값은 제외하고 평균값 리턴
select round(avg(sal),2) from emp where deptno=30;
select avg(comm) from emp;


-- [8] group by : 결과 값을 원하는 열로 묶어 출력
-- group by 데이터명(열 이름)과 일치하는 데이터만 조회할 수 있다.
select avg(sal) from emp where deptno=10;
select avg(sal) from emp where deptno=20;
select avg(sal) from emp where deptno=30;
--위를 한 줄로 줄일 때 사용
SELECT
    AVG(sal),
    deptno
FROM
    emp
GROUP BY
    deptno;

--부서별 추가 수당 평균 구하기
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;

-- group by + having : group by절에 조건을 부여할 때 사용 (group by 데이터 명 having 조건절)
-- having :  그룹화된 대상을 출력 제한 걸 때
--각 부서의 직급별 평균 급여 출력(단, 평균 급여가 2000이상인 그룹만)
--deptno, job, 평균 조회

SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;


--ORA-00934: 그룹 함수는 허가되지 않습니다
--select deptno, job, avg(sal)
--from emp
--where avg(sal) >=2000   <<-그룹함수에 담은 데이터는 where절에 삽입할 수 없음
--group by deptno, job  
--order by deptno, job;

--where절과 having 을 같이 쓰는 경우 실행 순서
-- 1) from 문 -> 2) where 절 -> 3) group by -> 4) having -> 5) select 문
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;
    
    
--[실습5] emp 테이블에서 부서번호, 평균급여(소수점 제외), 최고급여, 최저급여를 부서번호별로 출력
SELECT
    deptno,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)
FROM
    emp
GROUP BY
    deptno;

--[실습6] 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력
SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(job) >= 3;

--substr(to_char(mgr), 1, 2)
--[실습7] 사원들의 입사연도(HIRE_YEAR)를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT
    to_char(hiredate, 'YYYY') AS hire_year,
    deptno,
    COUNT(*)                  AS cnt
FROM
    emp
GROUP BY
    to_char(hiredate, 'YYYY'),
    deptno;






----------------------------------------(2023.03.22)-------------------------------------------------

-- 조인 : 여러 테이블을 하나의 테이블처럼 사용

-- 1) 내부조인(inner join) : 여러 개의 테이블에서 공통된 부분만 추출
--      ⓐ 등가조인 : 서로 다른 테이블의 열이 일치할 때 값 추출
--      ⓑ 비등가조인 : 어느 테이블의 열이 다른 테이블의 열 범위에 해당할 때 값 추출

-- 2) 외부조인(outer join) : 
--      ⓐ left outer joi
--      ⓑ right outer join
--      ⓒ full outer join

SELECT
    *
FROM
    emp,
    dept
ORDER BY
    empno;
-- => dept table : 4행 * emp table : 12행 = 48행이 나와버림


-- inner join : 별칭과 조건 부여
-- 중복된 열이 있는 경우, select 문에서 ORA-00918: column ambiguously defined 에러 발생하므로 주의
SELECT
    empno,
    ename,
    e.deptno,
    dname,
    loc  -->deptno는 중복 열이므로 어느 테이블에 있는 deptno열을 추출할 건지 확실히 기재해야 한다.
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno;  -- = 'emp테이블의 deptno와 dept테이블의 deptno가 일치한다면'

-- SQL-99 표준 방식
-- JOIN ~ ON
SELECT
    e.empno,
    e.ename,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno;

SELECT
    e.empno,
    e.ename,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    sal >= 3000;


--EMP, DEPT INNER JOIN, 급여가 2500 이하이고, 사원번호가 9999 이하인 사원 정보 조회
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal <= 2500
        AND e.empno <= 9999;

-- SQL-99 VER
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.sal <= 2500
    AND e.empno <= 9999;


-- EMP와 SALGRADE 조인 ; 일치하는 정보가 없는 테이블 간 INNER JOIN
-- EMP테이블의 SAL 데이터는 SALGRADE의 LOSAL, HISAL 데이터 범위에 포함된다. => BETWEEN A AND B 사용
SELECT
    *
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal;

--SQL-99
SELECT
    *
FROM
         emp e
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;


-- SELF JOIN : 자기 자신 테이블과 조인
-- EMP테이블 내 사원들의 직속상관 번호와 사원명 추출하기 
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno;



-- OUTER JOIN : 일치하는 정보가 없는 테이블의 정보를 추가
-- LEFT OUTER JOIN : 데이터명 오른쪽에 (+)를 붙임 
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno (+);

-- SQL-99 VER
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1 LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno (+);
    
    
-- RIGHT OUTER JOIN : 데이터 명 왼쪽에 (+)를 붙임
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr (+) = e2.empno;

-- SQL-99 VER
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1 RIGHT OUTER JOIN emp e2 ON e1.mgr (+) = e2.empno;


-- FULL OUTER JOIN : SQL-99 표준으로만 구현 가능
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1 FULL OUTER JOIN emp e2 ON e1.mgr = e2.empno;


-- 연결해야 할 테이블이 3개 이상일 때
SELECT *
FROM TABLE T1, TABLE T2, TABLE T3
WHERE T1.EMPNO = T2.EMPNO AND T2.DEPTNO = T3.DEPTNO;

-- SQL-99 VER
SELECT *
FROM TABLE T1 JOIN ON T1.EMPNO = T2.EMPNO JOIN TABLE T3 ON T2.DEPTNO = T3.DEPTNO;


--[실습1] 급여가 2000초과인 사원들의 부서 정보, 사원 정보를 출력
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
WHERE E.SAL >2000;


--[실습2] 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력
SELECT E.DEPTNO, D.DNAME, 
FLOOR(AVG(SAL)) AS AVG_SAL, 
MAX(SAL) AS MAX_SAL, 
MIN(SAL) AS MIN_SAL, 
COUNT(*) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, D.DNAME;

-- SQL-99 표준
SELECT E.DEPTNO, D.DNAME, 
FLOOR(AVG(SAL)) AS AVG_SAL, 
MAX(SAL) AS MAX_SAL, 
MIN(SAL) AS MIN_SAL, 
COUNT(*) AS CNT
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, D.DNAME;


--[실습3] 모든 부서정보와 사원 정보를 부서번호, 사원이름 순으로 정렬하여 출력하기
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO (+)= D.DEPTNO
ORDER BY D.DEPTNO, E.ENAME;

-- SQL-99 표준
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT OUTER JOIN DEPT D ON E.DEPTNO (+)= D.DEPTNO
ORDER BY D.DEPTNO, E.ENAME;



-----------
-- 서브쿼리 (SELECT 안에 또 SELECT)
-- SQL문을 실행하는데 필요한 데이터를 추가로 조회하기 위해 SQL문 내부에 사용하는 SELECT문
-- 1) 단일행 서브쿼리 : 서브쿼리 결과로 하나의 행 리턴
--      ▶ =, >, <, >=, <=, <>, ^=, != 연산자 허용

-- 2) 다중행 서브쿼리 : 서브쿼리 결과로 여러 개의 행 리턴
--      ▶ IN, ANY(SOME), ALL, EXISTS 연산자 허용 (*단, 단일행에서 사용하는 연산자는 사용 불가)
--      ▷ IN : 메인쿼리 결과가 서브쿼리 결과 중 하나라도 일치하면 TRUE 
--      ▷ SOME(ANY) : 메인쿼리 결과가 서브쿼리 결과와 하나라도 일치하면 TRUE
--      ▷ ALL : 서브쿼리의 모든 결과가 조건식에 맞아 떨어져야 메인쿼리 조건식이 TRUE
--      ▷ EXISTS : 서브 쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE


-- 3) 다중열 서브쿼리

-- 단일행 서브쿼리 예제 풀이
-- JONES의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 > JONES 급여로 조건식 걸기
SELECT SAL
FROM EMP
WHERE ENAME='JONES';    --2975

SELECT *
FROM EMP
WHERE SAL>2975;

--위의 두 쿼리를 서브쿼리를 사용해 아래와 같이 나타낼 수 있음
SELECT *
FROM EMP
WHERE SAL>(SELECT SAL
FROM EMP
WHERE ENAME='JONES');

-- 예제) 사원 이름이 ALLEN 인 사원의 추가수당 보다 많은 추가수당을 받는 사원 조회
SELECT *
FROM EMP
WHERE COMM>(SELECT COMM
FROM EMP
WHERE ENAME='ALLEN');

--예제) 사원 이름이 WARD인 사원의 입사일보다 빨리 입사한 사원 조회
SELECT *
FROM EMP
WHERE HIREDATE< (SELECT HIREDATE
FROM EMP
WHERE ENAME='WARD');


-- 예제) 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및 부서정보 조회
--사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO=20 AND E.SAL > (SELECT AVG(SAL) FROM EMP);

-- 예제) 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및 부서정보 조회
--사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO=20 AND E.SAL <= (SELECT AVG(SAL) FROM EMP);


-- 다중행 서브쿼리 예제

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회

--ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다. = "single-row subquery returns more than one row"
--다중행 서브쿼리에서는 비교(등가)연산자 사용 불가
--SELECT *
--FROM EMP
--WHERE SAL = (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);


-- 예제) 30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 조회

SELECT *
FROM EMP
WHERE SAL < SOME (SELECT SAL FROM EMP WHERE DEPTNO=30);

--▲위 결과는 단일행 쿼리로 작성이 가능함
SELECT *
FROM EMP
WHERE SAL < (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30);

-- 30번 부서 사원들의 최소 급여보다 많이 받는 사원 조회(단일행 쿼리)
SELECT *
FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);
-- 30번 부서 사원들의 최소 급여보다 많이 받는 사원 조회(다중행 쿼리)
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );


--▷ ALL : 서브쿼리의 모든 결과가 조건식에 맞아 떨어져야 메인쿼리 조건식이 TRUE
SELECT
    *
FROM
    emp
WHERE
    sal > ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

--▷ EXISTS : 서브 쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 10
    );


--[실습] 전체 사원 중 ALLEN 과 같은 직책인 사원들의 사원정보, 부서정보를 출력
--조회 열 : 직책, 사원번호, 사원명, 급여, 부서번호, 부서명
SELECT
    e.job,
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND job = (
        SELECT
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );


--[실습] 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보 출력
--단, 급여가 높은 순, 급여가 같다면 이름 오름차순으로 정렬
--사원번호, 사원명, 부서명, 입사일, 부서위치, 급여, 등급
SELECT
    empno,
    ename,
    d.dname,
    e.hiredate,
    d.loc,
    e.sal,
    s.grade
FROM
    emp      e,
    dept     d,
    salgrade s
WHERE
        e.deptno = d.deptno
    AND sal BETWEEN s.losal AND hisal
        AND sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    )
ORDER BY
    sal DESC,
    ename;

-- 3) 다중열 서브쿼리 : 서브쿼리의 SELECT절에 비교할 데이터를 여러 개 지정

SELECT
    *
FROM
    emp
WHERE
    ( deptno, sal ) IN (
        SELECT
            deptno, MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );


-- 4) INLINE VIEW : FROM 절에 사용하는 서브쿼리
--      >>FROM절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 크거나 불필요한 열이 많을 때 사용

--부서번호가 10번인 사원들의 사원정보와 부서정보 조회
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO=10) E10,
(SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

--JOIN 과 비슷함
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO=10;


-- 5) 스칼라 서브쿼리 : SELECT 절에 사용하는 서브쿼리
--SELECT 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야 함

SELECT EMPNO, ENAME, JOB, SAL, (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
DEPTNO, (SELECT DNAME FROM DEPT WHERE E.DEPTNO=DEPT.DEPTNO) AS DNAME
FROM EMP E;


--[실습] 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원 정보 출력
SELECT EMPNO, ENAME, JOB, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO=10 AND JOB NOT IN (SELECT JOB FROM EMP WHERE DEPTNO=30);


--[실습] 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여등급 정보를 출력
--단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원번호를 기준으로 오름차순 정렬
--단일행 서브쿼리 사용 시
SELECT EMPNO, ENAME, S.GRADE
FROM EMP, SALGRADE S
WHERE EMP.SAL BETWEEN S.LOSAL AND S.HISAL
AND SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN')
ORDER BY EMPNO DESC;

--다중행 서브쿼리 사용 시
SELECT EMPNO, ENAME, S.GRADE
FROM EMP, SALGRADE S
WHERE EMP.SAL BETWEEN S.LOSAL AND S.HISAL
AND SAL > ALL (SELECT SAL FROM EMP WHERE JOB='SALESMAN')
ORDER BY EMPNO DESC;

--다중행+스칼라 서브쿼리 사용 시
SELECT EMPNO, ENAME, (SELECT GRADE FROM SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL) AS GRADE
FROM EMP
WHERE SAL > ALL (SELECT SAL FROM EMP WHERE JOB='SALESMAN')
ORDER BY EMPNO DESC;



----------------------------------------(2023.03.23)-------------------------------------------------

-- DML (Data Manipulation Language): 데이터를 추가, 수정, 삭제하는 데이터 조작어
-- select + DML ==> 자주 사용하는 sql

-- 연습용 테이블 생성
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;


-- 열이름은 선택사항이다.
-- insert into 테이블이름(열이름1. 열이름2, ...etc)
-- values(데이터1, 데이터2,...etc)

-- DEPT_TEMP 테이블에 새로운 부서 추가하기
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(50, 'DATABASE', 'SEOUL');

-- 열 이름 사용하지 않는 경우
INSERT INTO DEPT_TEMP
VALUES(60, 'NETWORK', 'BUSAN');

-- insert 시 발생할 수 있는 오류

-- 1) ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
INSERT INTO DEPT_TEMP
VALUES(600, 'NETWORK', 'BUSAN'); -->deptno 열은 NUMBER(2,0)로 숫자 2자리만 가능한데 600으로 초과됨


-- 2) ORA-01722: 수치가 부적합합니다
INSERT INTO DEPT_TEMP
VALUES('NO', 'NETWORK', 'BUSAN'); -->숫자 영역에 문자를 추가하여 오류 발생('숫자' 는 자동형변환으로 허용 가능)


-- 3) ORA-00947: 값의 수가 충분하지 않습니다. ("not enough values")
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(50, 'DATABASE'); -->열의 수와 데이터 수가 맞지 않음


-- 4) NULL 값을 삽입하는 방법
-- (1)NULL을 직접 입력
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(50, 'WEB', NULL);

-- (2)빈문자열을 입력
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(90, 'MOBILE', '');

-- (3)NULL을 삽입할 칼럼명을 지정하지 않음(필드(열)명은 필수)
INSERT INTO DEPT_TEMP(DEPTNO, LOC)
VALUES(90, 'INCHEON');

SELECT * FROM DEPT_TEMP;

-- 테이블 복사(데이터 제외)
-- emp_temp 생성(emp 테이블 복사 - 단, 데이터는 복사를 하지 않을 때)
create table emp_temp as select * from emp where 1<>1;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(9999, '강백호', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(1111, '김도일', 'MANAGER', 9999, '2001/01/05', 4000, NULL, 20);

--[날짜오류]ORA-01830: 날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2222, '도레미', 'MANAGER', 9999, '07/01/2001', 4000, NULL, 20);

--solution) 데이터를 인식할 수 있도록 코드 입력
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2222, '도레미', 'MANAGER', 9999, TO_DATE('07/01/2001', 'DD/MM/YYYY'), 4000, NULL, 20);


insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(3333, '루피', 'MANAGER', 3333, SYSDATE, 3000, NULL, 30);



-- 서브쿼리로 INSERT 구현
-- emp, salgrade 테이블을 조인 후 급여등급이 1인 사원만 emp_temp에 추가
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select empno, ename, job, mgr, hiredate, sal, comm, deptno 
from emp join salgrade on sal between losal and hisal where grade=1;

SELECT * FROM EMP_TEMP;

COMMIT;     --현재까지 실행한 작업 저장


-- UPDATE : 테이블에 있는 데이터 수정
--update 테이블명
--set 변경할 열 이름 = 데이터, 변경할 열 이름 = 데이터, ....etc
--where 변경을 위한 대상 행을 선별하기 위한 조건

--dept_temp 테이블 loc 열의 모든 값을 seoul로 변경
update dept_temp
set loc='SEOUL';

rollback;   --commit 전에는 실행한 내용을 되돌릴 수 있음

--dept_temp 테이블 부서번호가 40번인 loc열의 데이터를 seoul로 변경
update dept_temp
set loc='SEOUL'
where deptno = 40;


update emp_temp
set comm = 50
where sal<=2500;



-- 서브쿼리를 사용하여 데이터 수정 가능
-- DEPT 테이블: 40번 부서의 DNAME, LOC를 > DEPT_TEMP 테이블: 40번 부서의 DNAME, LOC로 업데이트

update dept_temp
set (dname, loc) = (select dname, loc from dept where deptno=40)
where deptno=40;

commit;



-- delete : 테이블에 있는 데이터 삭제
-- delete  from(선택) 테이블명
-- where 삭제 데이터를 선별하기 위한 조건식

create table emp_temp2 as select * from emp; 

delete from emp_temp2 where job='MANAGER';
delete emp_temp2 where job='SALESMAN';

--전체 데이터 삭제
DELETE EMP_TEMP2;

ROLLBACK; 

-- 서브쿼리를 사용하여 삭제
-- 급여등급이 3, 30번 부서인 사원 삭제
DELETE FROM emp_temp2
WHERE empno in (SELECT e.empno from emp_temp2 e, salgrade s where e.sal between s.losal and s.hisal 
and s.grade=3 and deptno=30);

commit;

SELECT * FROM dept_temp;
SELECT * FROM EMP_TEMP;
SELECT * FROM EMP_TEMP2;

-----------
--[실습1] 실습을 위하여 기존 테이블을 이용하여 테이블을 생성한다.
--① EMP 테이블의 내용을 이용하여 EXAM_EMP 생성
--② DEPT 테이블의 내용을 이용하여 EXAM_DEPT 생성
--③ SALGRADE 테이블의 내용을 이용하여 EXAM_SALGRADE 생성

create table EXAM_EMP as select *from emp;
create table EXAM_DEPT as select *from dept;
create table EXAM_SALGRADE as select *from salgrade;


--[실습2] 다음의 정보를 EXAM_EMP 테이블에 입력하시오.
DELETE FROM EXAM_EMP;

insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7208, 'TEST_USER8', 'STUDENT', 7201, '2016/03/09', 1200, NULL, 80);


--[실습3] EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 
--많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
update exam_emp
set deptno=80
where sal > (select avg(sal) from exam_emp where deptno=50);


--[실습4] EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 
--늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
update exam_emp
set deptno=80, sal=sal*1.10
where hiredate >(select min(hiredate) from exam_emp where deptno=60);


--[실습5] EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
delete from exam_emp
where empno in (select empno from exam_emp , salgrade  where sal between losal and hisal and grade=5);

SELECT * FROM exam_emp;

commit;



-- 트랜잭션(transaction) : 최소 수행 단위
-- TCL (Transaction Control Language) : 트랜잭션 제어하는 구문 

create table dept_tcl as select * from dept;

insert into dept_tcl values(50, 'DATABASE', 'SEOUL');

update dept_tcl set loc='BUSAN' where deptno=40;

delete from dept_tcl where dname='RESEARCH';

select * from dept_tcl;


-- 트랜잭션 취소
rollback;

-- 트랜잭션 최종 반영
commit;


-- 세션 : 어떤 활동을 위한 시간이나 기간
-- 데이터베이스 세션 : 데이터베이스 접속 시작 ~ 관련작업 수행 ~ 접속 종료
-- LOCK : 잠금 (수정 중인 데이터는 접근 차단)
delete from dept_tcl where deptno=50;
update dept_tcl set loc='SEOUL' where deptno=30;

select * from dept_temp;








----------------------------------------(2023.03.27)-------------------------------------------------
-- DDL : 데이터 정의어(데이터베이스 객체 생성/수정/삭제)
-- 데이터베이스 객체
-- 종류 : 테이블, 인덱스, 뷰, 데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거, ...
-- 생성 : create | 수정 : alter | 삭제 : drop

-- 1. 테이블 생성
--CREATE TABLE 테이블명(
--    열이름 1 자료형,
--    열이름 3 자료형,
--    열이름 3 자료형,
--    열이름 4 자료형
--  );

-- 테이블 생성 규칙 / 열 이름 지정 규칙
-- 1) 테이블 이름은 문자로 시작
-- 2) 테이블 이름은 30BYTE 이하
-- 3) 같은 사용자 소유의 테이블 이름은 중복될 수 없음
-- 4) 테이블 이름에 사용할 수 있는 특수문자 : $, #, _
-- 5) SQL 키워드는 테이블 이름에 사용할 수 없음     ex) SELECT, FROM, WHERE, ...

-- 자료형
-- [문자형 데이터]
-- VARCHAR2(길이) : 가변 길이 문자열 데이터 저장 (길이는 최대 4000 BYTE) -지정 길이 이하의 메모리 크기는 상관없이 입력 가능
-- CAHR(길이) : 고정 길이 문자열 데이터 저장
-- NVARCHAR2(길이) : 가변 길이(UNICODE) 데이터 저장
--      ex) name varchar2(10) : 영어는 10자, 한글은 3자까지 가능
--      ex) name nvarchar2(10) : 영어/한글 모두 10자까지 가능
-- NCHAR(길이) : 고정 길이(UNICODE)
--      ex) name char2(10) : 영어는 10자, 한글은 3자까지 가능 + 메모리 10 BYTE 고정
--      ex) name nchar2(10) : 영어/한글 모두 10자까지 가능 + 메모리 10 BYTE 고정

-- [숫자형 데이터]
-- NUMBER(전체자릿수, 소숫점자릿수)

-- [날짜형 데이터]
-- DATE : 날짜, 시간 저장
-- TIMESTAMP

-- [기타]
-- BLOB : 대용량 이진 데이터 저장(이미지, 동영상, MP3 등의 데이터를 DB에 저장 가능)
-- CLOB : 대용량 텍스트 데이터 저장
-- JSON : JSON 데이터 저장

create table emp_ddl( 
empno number(4),
ename varchar2(10),
job varchar(10),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2));

desc emp_ddl;

-- 2. 테이블 수정 : alter
-- 1) 열 추가 : add
alter table emp_temp2 add HP varchar2(20);

-- 2) 열 이름 변경 : rename
alter table emp_temp2 rename column HP to tel;

-- 3) 열 자료형 변경 : modify -단, 데이터 길이가 아닌 유형을 변경할 때는 열이 비어있어야 한다.
alter table emp_temp2 modify empno number(5);

-- 4) 특정 열 삭제 : drop
alter table emp_temp2 drop column tel;

-- 5) 테이블 명 변경
rename emp_temp2 to emp_rename;


-- 3. 테이블 삭제 : dml은 롤백이 되지만, ddl은 롤백 불가
drop table emp_rename;


-- ① 테이블 데이터 전체 삭제(dml) -되돌리기 가능
delete from emp_rename;
select*from emp_rename;

rollback; 

-- ② 테이블 데이터 전체 삭제(ddl) -되돌리기 불가
truncate table emp_rename;



--[실습] member 테이블 생성
create table member(
id char(8), name varchar2(10), addr varchar(50), nation char(4), email varchar2(50), age number(7,2));

desc member;

--[실습2]member 테이블 변경
alter table member add BIGO varchar2(20);
alter table member modify BIGO varchar2(30);
alter table member rename column remarkl to REMARK; 
    
--[error] ORA-12899: "SCOTT"."MEMBER"."NATION" 열에 대한 값이 너무 큼(실제: 12, 최대값: 4)
insert into member values('hong123', '홍길동', '서울시 은평구 불광동', '대한민국', 'hong123@naver.com', 25, null);

drop table member;

create table member(
id char(8), name varchar2(10), addr varchar(50), nation nchar(4), email varchar2(50), age number(7,2) not null);
alter table member add remark varchar2(30);



-- 데이터베이스 객체
-- 종류 : 테이블, 인덱스, 뷰, 데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거, ...
-- 생성 : create | 수정 : alter | 삭제 : drop

-- ⓐ 인덱스 : 더 빠른 검색을 도움
--  1>사용자가 직접 특정 테이블 열에 지정 가능
--  2>기본키(혹은 unique key)를 생성하면 인덱스로 지정

--(직접 지정))create index 인덱스 이름 on 테이블명 (인덱스로 사용할 열이름);
create index idx_emp_sal on emp(sal);  --emp테이블의 sal 열을 인덱스로 지정

-- select : 검색방식
-- full scan
-- index scan

select * from emp whrere emp=7900;

-- 인덱스 삭제
drop index idx_emp_sal;


-- ⓑ View : 가상 테이블
--  > 편리성 : select 문이 복잡한 경우 완화하기 위해 사용
--  > 보안성 : 테이블의 특정 열을 노출하고 싶지 않을 때 사용
-- create[or replace] [force | noforce] view 뷰이름(열이름1, 열이름2,...) --> []는 옵션사항
-- as (저장할 select 구문)
-- [with check option]
-- [with read option];

create view vm_emp20 as (select empno, ename, job, deptno from emp where empno=20);

--▲
-- 서브쿼리를 사용
select*from (select empno, ename, job, deptno from emp where empno=20);

-- 뷰 사용
select * from vm_emp20;

-- 뷰 삭제
drop view vm_emp20;

-- [옵셥] read only
create view vm_emp_read as select empno, ename, job from emp with read only;

-- view 에 insert 작업 수행
insert into vm_emp20 values (8888, 'kim', 'sales', 20);
select * from emp; --원본 삽입여부 확인

--SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
insert into vm_emp_read values (9999, 'kim', 'sales');


-- 인라인 뷰 : 일회성으로 만들어서 사용하는 뷰
-- rownum : 조회된 순서대로 일련번호 매김
select rownum, e.* from emp e;

select rownum, e.* from ( select * from emp e order by sal desc) e;

-- 급여 상위 세 사람 조회
select rownum, e.* from ( select * from emp e order by sal desc) e where rownum<=3;


-- ⓒ 시퀀스 : 규칙에 따라 순번 생성
-- create sequence 시퀀스 이름; (설정 하지 않은 건 기본값으로 세팅됨)

--create sequence 시퀀스명 
--[increment by 숫자]                    기본값 1
--[start with 숫자]                       기본값 1
--[maxvalue 숫자 | nomaxvalue] 
--[minvalue 숫자 | nominvalue]
--[cycle | nocycle]       cycle인 경우 maxvalue 에 값이 다다르면 시작값부터 다시 시작
--[cache 숫자 | nocache]    시퀀스가 생성할 번호를 미리 메모리에 할당해 놓음 (기본 cache 20)

--데이터 제외 행열만 복사
create table dept_sequence as select * from dept where 1<>1;

create sequence seq_dept_sequence
increment by 10 --10씩 증가
start with 10 --10에서부터
maxvalue 90 --최대 90까지
minvalue 0 --최소 0
nocycle --순환하지 않는(max값에 도달하면 멈춤)
cache 2; --시퀀스2개씩 메모리 잡기

-- 시퀀스 사용 : 시퀀스 이름.currval(=마지막으로 생성된 시퀀스 조회) | 시퀀스이름.nextval(시퀀스 생성)

--부서번호 입력시 시퀀스 사용
insert into dept_sequence(deptno, dname, loc) 
values (seq_dept_sequence.nextval, 'DATABASE', 'SEOUL');

SELECT * FROM dept_sequence;

-- 시퀀스 seq_dept_sequence.nextval exceeds MAXVALUE : nocycle 옵셥으로 생성했기 때문에 번호가 순환되지 않음.

drop sequence seq_dept_sequence;

create sequence 
increment by 3
start with 10
maxvalue 99
minvalue 0
cycle
cache 2;

select seq_dept_sequence.currval from dual;


-- synonym(동의어) : 테이블 뷰 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름을 부여하는 객체

-- emp테이블의 별칭을 e로 지정
create synonym e for emp;

-- public : 동의어를 데이터베이스 내 모든 사용자가 사용할 수 있도록 설정
--- create [public] synonym e for emp;

select * from e;
drop synonym e;


--[실습]
create table empidx as select * from emp;
create index idx_empidx_empno on empidx(empno); 

--[실습]
create view empidx_over15k as (select empno, ename, job, deptno, sal, comm from empidx where sal>1500);

select * from empidx_over15k;

--[실습]
create table deptseq as select * from dept;

create sequence seq_deptseq
start with 1
maxvalue 99
minvalue 1
nocycle
nocache;

select seq_deptseq.currval from dual;

-- 데이터 사전 뷰를 통해 시퀀스 확인
select * from user_sequences;


-- 제약조건 : 테이블의 특정 열에 지정
--  테이블 생성 시 제약조건 지정, or 생성 후에 alter를 통해 추가/변경 가능
--  제약조건 예) null 허용 / 불허용, 유일한 값, 특정 조건식을 만족하는 데이터만 입력가능,...
--  데이터 무결성 유지(데이터 정확성, 일관성 보장) => dml 작업시 반드시 지켜야 함
--      >영역 무결성
--      >개체 무결성
--      >참조 무결성

-- 1) not null : 빈 값 허용 불가 (무조건 값이 입력되어야 함 > 안되면 오류 발생)
create table table_notnull(
long_id varchar2(20) not null,
long_pwd varchar2(20) not null,
tel varchar2(20)
);

insert into table_notnull(long_id, long_pwd) values('hong123', 'hong123');

select * from table_notnull;

--현재 사용자가 가진 전체 제약조건 조회
select * from user_constraints;

-- 제약조건 + 제약조건 이름 지정
create table table_notnull2(
login_id varchar2(20) constraint TBNN2_LOGIN_NN not null,
login_pwd varchar2(20) constraint TBMM2_LGPWD_NN not null,
tel varchar2(20)
);

select * from user_constraints;

-- 이미 생성한 테이블에 제약조건 추가
-- 02296. 00000 - "cannot enable (%s.%s) - null values found" / (SCOTT.) 사용으로 설정 불가 - 널 값이 발견되었습니다.
alter table table_notnull modify(tel not null);

-- 이미 삽입된 대상도 체크 대상이 되므로 제약조건 지정은 테이블 생성 시 설정하는 게 편함.
--업데이트로 기입력된 값 지우고 다시 제약조건 걸어야 함...
update table_notnull set tel='010-1234-5678' where long_id = 'hong123';


-- 제약조건 명 변경
alter table table_notnull2 rename constraint TBNN2_LOGIN_NN to ID_NOT_NULL;

-- 제약조건 명 삭제
alter table table_notnull2 drop constraint ID_NOT_NULL;


-- 2) unique : 중복되지 않는 값
--      ex) 아이디, 전화번호, 
create table tb_unique(
logid varchar2(20) unique not null,
logpwd varchar2(20) not null,
tel varchar2(20)
);


--ORA-00001: 무결성 제약 조건(SCOTT.SYS_C008367)에 위배됩니다.
insert into tb_unique(logid, logpwd, tel) values('hong123', 'hong123', '010-1234-5678');
--ORA-01400: NULL을 ("SCOTT"."TB_UNIQUE"."LOGID") 안에 삽입할 수 없습니다
insert into tb_unique(logid, logpwd, tel) values(null, 'hong123', '010-1234-5678');


select * from tb_unique;

-- 테이블 생성 제약조건 지정, 변경, 삭제 not null 형태와 동일함



-- 3) primary key(pk) (인덱스 자동 생성): unique + not null
create table tb_primary(
logid varchar2(20) primary key,
logpwd varchar2(20) not null,
tel varchar2(20)
);


-- 4) 외래키(foreign key; fk) : 다른 테이블 간 관계를 정의하는데 사용(부모테이블-자식테이블 개념)
--      >특정 테이블에서 pirmary key 제약조건을 지정한 열을 다른 테이블의 특정 열에서 참조

-- 사원 추가 시 부서번호를 입력해야 함 => dept 테이블의 deptno만 삽입
-- 부모 테이블
create table dept_fk(
deptno number(2) constraint deptfk_pk primary key,
dname varchar2(14),
loc varchar(13));

-- references 참조할 테이블 명(참조할 열) : FK 지정
-- 자식 테이블
create table emp_fk(
empno number(4) constraint empfk_empno_pk primary key,
ename varchar2(10),
job varchar2(9),
deptno number(2) constraint empfk_deptno_fk references dept_fk(deptno)
);

-- ORA-02291: 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
insert into emp_fk values(1000, 'TEST', 'SALES', 10);

-- 외래키 제약 조건**
-- 부모 테이블 데이터 먼저 > 자식 테이블 데이터 나중에 입력
-- 삭제 시에는 자식 먼저 > 부모 나중에 삭제

insert into DEPT_FK values(10, 'DATABASE', 'SEOUL');

SELECT * FROM EMP_FK;

--ORA-02292: 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다.
-- DELETE FROM DEPT_FK WHERE DEPTNO=10;

-- 외래키 제약조건 옵션
-- ON DELETE CASCADE : 부모가 삭제되면 부모를 참조하는 자식 레코드도 같이 삭제
-- ON DELETE SET NULL : 부모가 삭제되면 부몰르 참조하는 자식 레코드를 NULL로 변경

create table dept_fk2(
deptno number(2) constraint deptfk_pk2 primary key,
dname varchar2(14),
loc varchar(13));

create table emp_fk2(
empno number(4) constraint empfk_empno_pk2 primary key,
ename varchar2(10),
job varchar2(9),
deptno number(2) constraint empfk_deptno_fk2 references dept_fk2(deptno) ON DELETE CASCADE);

insert into DEPT_FK2 values(10, 'DATABASE', 'SEOUL');
insert into emp_fk2 values(1000, 'TEST', 'SALES', 10);

DELETE FROM DEPT_FK2 WHERE DEPTNO=10;


-- 5) CHECK : 열에 저장할 수 있는 값의 범위 또는 패턴 지정
-- EX) 비밀번호는 3자리보다 커야 한다.
create table TB_CHECK(
logid varchar2(20) primary key,
logpwd varchar2(20) CHECK (LENGTH(LOGPWD) > 3),  --LOGPWD 의 데이터 최소 길이를 3으로 지정
tel varchar2(20)
);

--ORA-02290: 체크 제약조건(SCOTT.SYS_C008381)이 위배되었습니다.
INSERT INTO TB_CHECK VALUES('TEST', '123', '010-2666-8891');

INSERT INTO TB_CHECK VALUES('TEST', '1234', '010-2666-8891');


-- 6) DEFAULT : 기본값 지정(값이 입력되지 않으면 지정된 기본값으로 입력)
create table TB_DEFAULT(
logid varchar2(20) primary key,
logpwd varchar2(20) DEFAULT '1234',  -->값이 입력되지 않으면 1234 입력
tel varchar2(20)
);

INSERT INTO TB_DEFAULT VALUES('TEST', NULL, '010-2666-8891');  -->NULL이 입력됨
INSERT INTO TB_DEFAULT(LOGID, TEL) VALUES('TEST1', '010-2666-8891');  -->기본값이 입력됨

SELECT * FROM TB_DEFAULT;


commit;


----------------------------------------(2023.03.29)-------------------------------------------------

-- ♣


























































