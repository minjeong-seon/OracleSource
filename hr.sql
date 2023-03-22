--employee table 전체 내용 조회
SELECT
    *
FROM
    employees;

--emplayee table 중에서 first name, last name, job id 만 조회
SELECT
    first_name,
    last_name,
    job_id
FROM
    employees;
    
--예제 1. 사원번호가 176인 사원의 last name 조회
SELECT
    last_name
FROM
    employees
WHERE
    employee_id = 176;
    
    
--예제 2. 연봉이 12000 이상 되는 직원들의 last name, salary 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary >= 12000;


--예제 3. 연봉이 5000에서 12000범위가 아닌 사람들의 last_name, salary 를 사원명 내림차순으로 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary < 5000
    OR salary > 12000
ORDER BY
    last_name DESC;
    

--예제 4. 20번, 50번 부서에서 근무하는 모든 사원들의  LAST_NAME, 부서번호를 오름차순으로 조회
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    last_name,
    department_id;


--예제 5. 커미션을 받는 모든 사원들의 LAST_NAME, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct > 0
ORDER BY
    salary DESC,
    commision_pct DESC;


--예제 6. 연봉이 2500, 3500, 7000이 아니고, 직업이 SA_REP 나 ST_CLERK인 사원 조회
SELECT
    *
FROM
    employees
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job_id IN ( 'SA_REP', 'ST_CLERK' );


--예제 7. 2008/02/20 ~ 2008/05/01 사이에 고용된 사원들의 LAST_NAME,사번, 고용일자 조회(고용일자 내림차순 조회)
SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2008-02-20'
    AND hire_date <= '2008/05/01'
ORDER BY
    hire_date DESC;


--예제 8. 2004년도에 고용된 사원들의 last_name, hire_date 조회(고용일자 오름차순 정렬)
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2004-01-01'
    AND hire_date <= '2004-12-31'
ORDER BY
    hire_date;
    
    
--예제 9. 예제 7번을 BETWEEN A AND B 연산자로 바꿔보기
SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '2008-02-20' AND '2008/05/01'
ORDER BY
    hire_date DESC;
    
    
--예제 10. 부서가 20, 50이고, 연봉이 5000에서 12000범위인 사람들의 last_name, salary 를 연봉의 오름차순으로 정렬
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
    AND salary BETWEEN 5000 AND 12000
ORDER BY
    salary;
    
    
--예제 11. 예제 8번 변형: 2004년도에 고용된 사원들의 last_name, hire_date 조회(고용일자 오름차순 정렬)
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '04%'
ORDER BY
    hire_date;


--예제 12. LAST_NAME에 U가 포함된 사원들의 사번, LAST_NAME 조회(대소문자ㅠ)
SELECT
    last_name,
    employee_id
FROM
    employees
WHERE
    last_name LIKE '%u%'
    OR last_name LIKE '%U%';


--예제 13. LAST_NAME의 네 번째 글자가 A인 사원들의 LAST_NAME 조회
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '___a%';


--예제 14. LAST_NAME에 A 와 E글자가 포함된 사원들의 LAST_NAME 조회(LAST_NAME 오름차순 정렬)
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%e%a%'
    OR last_name LIKE '%a%e%'
    OR last_name LIKE '%A%E%'
    OR last_name LIKE '%E%A%'
ORDER BY
    last_name;


--예제 15. 매니저(manager_id)가 없는 사람들의 last_name, job_id 조회
SELECT
    last_name,
    job_id
FROM
    employees
WHERE
    manager_id IS NULL
    OR manager_id = '';


--예제 16. JOB_ID가 ST_CLERK인 사원의 부서번호 조회(단, 부서번호가 NULL인 사원은 제외)
--중복을 제거한 후 부서번호만 조회**
SELECT
    DISTINCT department_id
FROM
    employees
WHERE
        job_id = 'ST_CLERK'
    AND department_id IS NOT NULL;


--예제 17. COMMISSION_PCT 가 NULL이 아닌 사원들 중에서 COMMISSION = SALARY*COMMISSION_PCT를 구하여
--EMPLOYEE_ID, FIRST_NAME, JOB_ID 출력
SELECT
    employee_id,
    first_name,
    JOB_ID,
    commission_pct * salary AS commission
FROM
    employees
WHERE
    commission_pct IS NOT NULL;
    
    
--예제 18. FIRST_NAME이 CURTIS인 사람의 FIRST_NAME, LAST_NAME, EMAIL. PHONE_NUMBER, JOB_ID를 조회
--단, JOB_ID의 결과는 소문자로 출력되도록 한다.
SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, LOWER(JOB_ID)
FROM EMPLOYEES
WHERE FIRST_NAME ='Curtis';



--예제 19. 부서번호가 60,70, 80, 90인 사원들의 EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, JOB_ID 조회
--단, JOB_ID가 IT_PROG인 사원의 경우 프로그래머로 변경한 후 출력
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, REPLACE(JOB_ID, 'IT_PROG', '프로그래머')
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (60, 70, 80, 90);


--예제 20. JOB_ID가 AD_PRES, PU_CLERK인 사원들의  EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID 조회
--단, 사원명은 FISRT_NAME과 LAST_NAME을 연결하여 출력
SELECT EMPLOYEE_ID, DEPARTMENT_ID, JOB_ID, FIRST_NAME || ' ' || LAST_NAME
FROM EMPLOYEES
WHERE JOB_ID IN ('AD_PRES', 'PU_CLERK');


----------------------------------
--[실습4]부서 80의 각 사원에 대해 적용가능한 세율을 표시
SELECT LAST_NAME, SALARY,
DECODE(TRUNC(SALARY/2000,0), 0, 0.00,
1, 0.09,
2, 0.20,
3, 0.30,
4, 0.40,
5, 0.42,
6, 0.44,
0.45) AS TAX_RATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID=80;




-- 예제 21) 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
select max(salary)-min(salary) as sal_gap
from employees;


-- 예제 22) 매니저로 근무하는 사원들의 총 숫자 출력(매니저 중복 제거)
select count(distinct manager_id)
from employees;


-------------------------------------------
--예제 1) 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기(self-join : employees)
--hiredate, lastname, manager_id
SELECT E1.HIRE_DATE, E1.LAST_NAME, E1.MANAGER_ID, E2.HIRE_DATE AS 매니저_입사일
FROM EMPLOYEES E1 JOIN EMPLOYEES E2 ON E1.MANAGER_ID = e2.employee_id
WHERE E1.HIRE_DATE<E2.HIRE_DATE;



--예제 2) 도시 이름이 T로 시작하는 지역에 사는 사원들의 사번, last_name, 부서번호, 도시 조회
--employees, departments, locations inner join
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
AND CITY LIKE 'T%';


SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, L.CITY
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
JOIN  LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE CITY LIKE 'T%';



--예제 3) 위치 id가 1700인 사원들의 사번, last_name, 부서번호, 급여 조회
--employees, departments inner join
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.LOCATION_ID=1700;



--예제 4) 부서명, 위치 id, 각 부서별 사원수, 각 부서별 평균 연봉 조회
-- 평균 연봉은 소숫점 2자리까지
----employees, departments inner join
SELECT D.DEPARTMENT_NAME, D.LOCATION_ID, COUNT(*), ROUND(AVG(SALARY),1)
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME, D.LOCATION_ID;


--예제 5) Executive 부서에 근무하는 사원들의 부서번호, last_name, job_id 조회
----employees, departments inner join
SELECT E.DEPARTMENT_ID, E.LAST_NAME, E.JOB_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.DEPARTMENT_NAME = 'Executive';


SELECT E.DEPARTMENT_ID, E.LAST_NAME, E.JOB_ID
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'Executive';


--예제 6) 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 모든 사원들의
--부서번호, 이름(firt_name과 last_name 연결), salary, hire_date 조회
--employees self join
SELECT DISTINCT E1.DEPARTMENT_ID,
E1.FIRST_NAME || ' ' || E1.LAST_NAME AS FULL_NAME, 
E1.SALARY, E1.HIRE_DATE
FROM EMPLOYEES E1, EMPLOYEES E2
WHERE E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
AND E1.HIRE_DATE < E2.HIRE_DATE AND E1.SALARY < E2.SALARY
ORDER BY E1.DEPARTMENT_ID;
--E1그룹을 늦게 입사 + 급여가 더 높은 사원 : E2그룹은 비교군



--서브쿼리 예제 풀이--
--예제 1) LAST_NAME 에 U가 포함된 사원들과 동일 부서에 근무하는 사원들의 사번, LAST_NAME 조회
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%');



--예제 2) JOB_ID가 SA_MAN인 사원들의 최대 연봉보다 높게 받는 사원들의 LAST_NAME, JOB_ID, SALARY 조회
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='SA_MAN');



--예제 3) 커미션을 받는 사원들의 부서와 연봉이 동일한 사원들의 LAST_NAME, DEPARTMENT_ID, SALARY 조회
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL);



--예제 3) 회사 전체 평균 연봉보다 더 받는 사원들 중
--      LAST_NAME에 U가 있는 사원들이 근무하는 부서에서 근무하는 사원들의 EMPLOYEE_ID, LAST_NAME, SALARY 조회
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) 
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%');



--예제 4) LAST_NAME이 DAVIES 인 사원보다 나중에 고용된 사원들의 LAST_NAME, HIRE_DATE 조회
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE > ALL (SELECT HIRE_DATE FROM EMPLOYEES WHERE LAST_NAME = 'Davies');



--예제 5) LAST_NAME이 KING인 사람을 매니저로 두고 있는 모든 사원들의 LAST_NAME, SALARY 조회
SELECT E1.LAST_NAME, E1.SALARY, E2.FIRST_NAME AS 매니저
FROM EMPLOYEES E1, EMPLOYEES E2
WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID
AND E2.LAST_NAME = 'King';









