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
FROM TABLE T1 JOIN ON T1.EMPNO = T2.EMPNO TABLE T2 JOIN TABLE T3 ON T2.DEPTNO = T3.DEPTNO;


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
AND SAL > ANY (SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN')
ORDER BY EMPNO DESC;


----------------------------------------(2023.03.23)-------------------------------------------------
















