--대소문자 구별하지 않음(단, 비밀번호는 구별함)
--CREAT : 생성 | ALTER : 수정 | DROP: 삭제 | DELETE : 삭제

-- 오라클 버전이 변경되면서 사용자 생성 시 요구되는 접두사 : C##
-- ▼ 아래 구문을 통해 접두사 생략 가능
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


-- ♣ 사용자(USER) : 데이터베이스에 접속하여 데이터를 관리하는 계정 (ex- SCOTT, HR,...)
--         >테이블, 인덱스, 뷰 등 여러 객체가 사용자별로 생성됨

-- ♣ 스키마(SCHEMA) : 데이터간 관계, 데이터 구조, 제약조건 등 데이터를 관리 저장하기 위해 정의한 데이터베이스 구조의 범위
--            >오라클DB에서는 스키마와 유저가 같은 개념

-- ♣ 사용자 생성 : 사용자 생성 권한이 필요 => sys, system이 소유

-- ▼USER 생성(공간 할당): CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
-- ▼USER생성은 SYS, SYSTEM만 가능**
CREATE USER JAVADB IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

--▼GRANT: 권한 부여(사용자 생성만으로는 아무것도 못함)
--grant 권한1, 권한2, 권한2,.... to 계정이름
GRANT CONNECT, RESOURCE TO JAVADB;





CREATE USER SCOTT IDENTIFIED BY TIGER
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

--scott에 부여된 권한(= 커넥스, 리소스)
GRANT CONNECT, RESOURCE TO SCOTT;
grant create view to scott;

select * from all_users;
GRANT UNLIMITED TABLESPACE TO SCOTT;
 
 
 
 
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT IDENTIFIED BY TIGER;
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;


---------------------------------------------------------------------------------------------------------------------------

-- ♣ 권한/권리
--  1) 시스템 권한
--      ① 사용자 생성 (CREATE USER) / 수정 (ALTER USER) / 삭제 (DROP USER)
--      ② 데이터베이스 접근 (CREATE SESSION) / 수정 (ALTER SESSION)
--      ③ 여러 객체 생성 (ex - view, synonym 등)

-- 2) 객체 권한
--      ① 테이블 수정, 삭제 / 인덱스 생성, 삽입, 참조, 조회, 수정
--      ② 뷰 삭제, 삽입, 생성, 조회, 수정
--      ③ 시퀀스 수정, 조회
--      ④ 프로시저, 함수, 패키지 권한



-- [테스트 유저 생성]
CREATE USER TEST IDENTIFIED BY 12345;

-- 사용자 생성 후 접속권한 부여 필요
-- CREATE SESSION 권한을 TEST 사용자에 부여
GRANT CREATE SESSION TO TEST;

-- 권한 부여(리소스 접근, 테이블 생성)
GRANT RESOURCE, CREATE TABLE TO TEST;

-- 테이블 스페이스 USERS에 대한 권한 부여
ALTER USER TEST DEFAULT TABLESPACE USERS;
ALTER USER TEST TEMPORARY TABLESPACE TEMP;
ALTER USER TEST QUOTA 2M ON USERS;      --USERS에 2mb 공간 할당

-- TEST가 생성한 MEMBER 테이블 접근 권한을 SCOTT에 부여할 수도 있음
-- GRANT SELECT ON MEMBER TO SCOTT;

-- ♣ 권한 취소 : REVOKE
-- SCOTT 사용자에 부여된 MEMBER 테이블에 대한 조회, 삽입 권한을 취소
-- REVOKE SELECT, INSERT ON MEMBER FROM SCOTT;

-- ♣ 롤 : 여러 권한들의 모임
--      > CONNECT 롤 : CREATE SESSION 권한
--      > RESOURCE 롤 : CREATE TRIGGER, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TABLE,...etc.




-- 사용자 삭제
DROP USER TEST;
-- ▲ ORA-01922: 'TEST'(을)를 삭제하려면 CASCADE를 지정하여야 합니다
DROP USER TEST CASCADE;
-- ▲ TEST와 관련된 모든 객체 같이 삭제



-- 사용자 생성 + 테이블 스페이스 권한 한번에 부여
CREATE USER TEST2 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- 권한 부여
GRANT CONNECT, RESOURCE TO TEST2;

-- ORA-01950: 테이블스페이스 'USERS'에 대한 권한이 없습니다.
-- 공간 할당해서 권한 부여
ALTER USER javadb QUOTA 2M ON USERS; 


