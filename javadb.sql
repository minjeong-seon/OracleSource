-- userTBL 테이블 생성 (no에 pk 지정: pk_userTBL)
create table userTBL(
no number(4) constraint pk_userTBL primary key,
username varchar2(12) not null,
birthYear number(4) not null,
addr varchar2(100) not null,
mobile varchar2(20));


--userTBL 시퀀스 생성 : user_seq(1씩 증가하는 기본모드)
create sequence user_seq;


-- insert (no : user_seq 값 넣기)
insert into userTBL values(user_seq.nextval, '홍길동', 1989, '서울시 은평구 불광동 387-4', '010-1111-2222');

commit;

select * from userTBL;

drop table usertbl;

----------------------------------------------------------------------------------------------------
-----------------------[JAVA - SHOP 패키지 구현]-----------------------

-- pqytype
-- paytype table 생성 : pay_no(숫자 1자리, pk), info(문자 card/cash 등 영문 4자리)
-- paytype_seq 생성
create table paytype(
pay_no number(1) constraint payno_pk primary key,
info varchar2(10) not null);

create sequence paytype_seq;

insert into paytype values(paytype_seq.nextval, 'card');
insert into paytype values(paytype_seq.nextval, 'cash');

select * from paytype;

-- shop
-- user 테이블 생성 : user_id(숫자 4자리,pk), name(문자-한글), pay_no(숫자 1자리: paytype 테이블의 pay_no 참조, fk)
create table suser(
user_id number(4) constraint userid_pk primary key,
name varchar2(12) not null,
pay_no number(1) not null constraint paynopk_fk references paytype(pay_no));


-- product
-- product 테이블 생성 : product_id(숫자 8자리, pk), pname(문자), price(숫자), content(문자)
create table product(
product_id number(8) constraint pid_pk primary key,
pname varchar2(20) not null,
price number(8) not null,
content varchar2(50) not null);

create sequence product_seq;


--order
-- order 테이블 생성 : order_id(숫자 8자리, pk), user_id(user 테이블 참조), product_id(priduct 테이블 참조,fk)
-- order_seq 생성
create table sorder(
order_id number(8) constraint orderid_pk primary key,
user_id number(4) not null constraint useridfk_pk references suser(user_id),
product_id number(8) not null constraint pidfk_pk references product(product_id));

create sequence order_seq;



select * from suser;


