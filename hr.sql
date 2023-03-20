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
    commission_pct IS NOT NULL