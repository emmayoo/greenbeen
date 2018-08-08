select * from tab;
create table env_member(
  	join_code number(38) unique not null 
  	/*unique 제약 조건은 중복값을 허용하지 않고 null은 허용*/  	
  , join_id varchar2(20) primary key /*회원아이디*/
  , join_pwd varchar2(20) not null /*회원비번*/
  , join_name varchar2(50) not null /*회원이름*/
  , join_phone varchar2(20) not null /*폰번호 */
  , join_email varchar2(100) not null /*전자우편 주소*/
  , join_regdate date /*가입 날짜*/
  , join_state number(10) /*가입회원 1, 탈퇴회원 2 */
  , join_delcont varchar2(4000) /*탈퇴 사유 */
  , join_deldate date /*탈퇴 날짜 */
);
alter table env_member add(position varchar2(50));

alter table env_member add(point number(20));

alter table env_member add(quiz_date date);

update ENV_MEMBER set position='master';
delete env_member where join_id='spring';
alter table env_member modify join_pwd varchar2(1000);

select * from env_member;

/***** member 테이블의 join_code 시퀀스 생성 *****/
create sequence member_joincode_seq 
increment by 1 start with 1 nocache;

--drop sequence join_member_joincode_seq; 

insert into member (
	join_code,
	join_id,
	join_pwd,
	join_name,
	join_phone,
	join_email,
	join_regdate,
	join_state)
values(member_joincode_seq.nextval,'aaaaa',
'77777','홍길동','010-9999-9999','hong@naver.com',sysdate,1);


update ENV_MEMBER set join_state=1
