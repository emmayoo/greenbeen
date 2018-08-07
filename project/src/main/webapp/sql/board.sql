--질문있어요
create table board_question (
	num number primary key, -- key
	writer varchar2(20) not null, -- 작성자
	subject varchar2(50) not null, -- 제목
	content varchar2(500) not null, -- 본문
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ref number not null, -- 답변글끼리 그룹
	re_step number not null, -- ref내의 순서
	re_level number not null, -- 들여쓰기
	ip varchar2(20) not null, -- 작성자 ip
	attach varchar2(100), --첨부파일
	reg_date date not null, -- 작성일
	updatedate date not null, -- 수정일
	del char(1)
);

select * from BOARD_question;
delete BOARD_QUESTION where num =20

insert into board_question values(1,'유연주','insert로 넣은 첫글','insert로 넣은 첫글','a@a.a',0,'1',1,0,0,'0:0:0:0',null,sysdate,sysdate,'n');
insert into board_question values(2,'유연주','insert로 넣은 글2','insert로 넣은 글2','a@a.a',0,'1',2,0,0,'0:0:0:0',null,sysdate,sysdate,'n');
insert into board_question values(3,'유연주3','insert로 넣은 글3','insert로 넣은 글3','a@a.a',0,'1',3,0,0,'0:0:0:0',null,sysdate,sysdate,'n');
insert into board_question values(11,'유연주11','insert로 넣은 글11','insert로 넣은 글11','a@a.a',0,'1',11,0,0,'0:0:0:0',null,sysdate,sysdate,'n');
insert into board_question values(19.5,'유연주19.5','insert로 넣은 글11','insert로 넣은 글11','a@a.a',0,'1',11,0,0,'0:0:0:0',null,sysdate,sysdate,'n');
select nvl(max(num),0) + 1 from board_question
drop table board_notice purge;

create table board_notice_reply (
	rno number primary key,
	bno number not null references board(num), -- 부모 테이블(board)에 참조를 받고 있기 때문에, num값에 있는 값들만 등록이 된다
	replytext varchar2(500) not null,
	replyer varchar2(50) not null,
	regdate date not null,
	updatedate date not null
);


select * from REPLYBOARD;
select * from board order by num desc;
insert into REPLYBOARD values(10,262,'11','나',sysdate,sysdate);

--자료실 (files)
create table board_files (
	num number primary key, -- key
	writer varchar2(20) not null, -- 작성자(자격 있는 사람만)
	subject varchar2(50) not null, -- 제목
	content varchar2(500) not null, -- 본문
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ip varchar2(20) not null, -- 작성자 ip
	attach varchar2(100), --첨부파일
	reg_date date not null, -- 작성일
	updatedate date not null, -- 수정일
	del char(1)
);
insert into board_files values(1,'유연주','files 첫글','insert로 넣은 첫글','a@a.a',0,'1','0:0:0:0',null,sysdate,sysdate,'n');
select * from board_files
--공지사항 (notice)
create table board_notice (
	num number primary key, -- key
	writer varchar2(20) not null, -- 작성자(자격 있는 사람만)
	subject varchar2(50) not null, -- 제목
	content varchar2(500) not null, -- 본문
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ip varchar2(20) not null, -- 작성자 ip
	attach varchar2(100), --첨부파일
	reg_date date not null, -- 작성일
	updatedate date not null, -- 수정일
	del char(1)
);
delete BOARD_NOTICE
insert into board_notice values(2,'유연주','notice 첫글','insert로 넣은 첫글','a@a.a',0,'1','0:0:0:0',null,sysdate,sysdate,'n');
--홍보플러스(ad) - 회사홍보 (ad_com)
create table board_ad_com (
	num number primary key, -- key
	writer varchar2(20) not null, -- 작성자(자격 있는 사람만)
	subject varchar2(50) not null, -- 제목
	content varchar2(500) not null, -- 본문
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ip varchar2(20) not null, -- 작성자 ip
	attach varchar2(100), --첨부파일
	reg_date date not null, -- 작성일
	updatedate date not null, -- 수정일
	del char(1)
);
insert into board_ad_com values(2,'유연주','회사홍보 첫글','insert로 넣은 첫글','a@a.a',0,'1','0:0:0:0',null,sysdate,sysdate,'n');
--홍보플러스(ad) - 우수회사 (ad_best)
create table board_ad_best (
	num number primary key, -- key
	writer varchar2(20) not null, -- 작성자(자격 있는 사람만)
	subject varchar2(50) not null, -- 제목
	content varchar2(500) not null, -- 본문
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ip varchar2(20) not null, -- 작성자 ip
	attach varchar2(100), --첨부파일
	reg_date date not null, -- 작성일
	updatedate date not null, -- 수정일
	del char(1)
);
select * from board_ad_best;
insert into board_ad_best values(1,'유연주','우수회사 첫글','insert로 넣은 첫글','a@a.a',0,'1','0:0:0:0',null,sysdate,sysdate,'n');
--지식플러스(know) - 오늘의 퀴즈 (know_quiz)
create table board_know_quiz (
	num number references board_know_news(num), -- key
	writer varchar2(20) not null, -- 작성자(자격 있는 사람만)
	subject varchar2(50) not null, -- 제목
  	QUESTION LONG not null, 
	ANSWER1 VARCHAR2(50), 
	ANSWER2 VARCHAR2(50), 
	ANSWER3 VARCHAR2(50), 
	ANSWER4 VARCHAR2(50), 
	ANSWER5 VARCHAR2(50), 
	ANSWER_CORRECT VARCHAR2(1000), 
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ip varchar2(20) not null, -- 작성자 ip
	attach varchar2(100), --첨부파일
	reg_date date not null, -- 작성일
	updatedate date not null, -- 수정일
	del char(1)  
);

drop board_know_quiz purge;



insert into board_know_quiz values(1,'유연주','오늘의 퀴즈 첫글','insert로 넣은 첫글','a@a.a',0,'1','0:0:0:0',null,sysdate,sysdate,'n');
--지식플러스(know) - 오늘의 뉴스 (know_news)
create table board_know_news (
	num number primary key, -- key
	writer varchar2(20) not null, -- 작성자(자격 있는 사람만)
	subject varchar2(50) not null, -- 제목
	content varchar2(500) not null, -- 본문
	email varchar2(30) , -- 이메일
	readcount number default 0, -- 읽은 횟수
	passwd varchar2(12) not null, -- 암호
	ip varchar2(20) not null, -- 작성자 ip
	attach varchar2(100), --첨부파일
	reg_date date not null, -- 작성일
	updatedate date not null, -- 수정일
	del char(1)
);
insert into board_know_news values(1,'유연주','오늘의 뉴스 첫글','insert로 넣은 첫글','a@a.a',0,'1','0:0:0:0',null,sysdate,sysdate,'n');



select * from (select a.*,rowNum rn from (
			select * from board_question where
				subject like '%7/%' or
				content like '%7/%' or
				writer like '%7/%'	
				 order by ref desc,re_step) a )