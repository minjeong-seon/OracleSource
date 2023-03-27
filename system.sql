--대소문자 구별하지 않음(단, 비밀번호는 구별함)
--CREAT : 생성 | ALTER : 수정 | DROP: 삭제 | DELETE : 삭제
--
--오라클 버전이 변경되면서 사용자 생성 시 C## 문자를 넣어서 만들도록 변경됨
--
--▼JAVADB -> C##JAVADB 이런 방식을 사용하지 않겠음
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

--▼USER 생성(공간 할당): CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
--▼USER생성은 SYS, SYSTEM만 가능**
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






















