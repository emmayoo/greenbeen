drop table replyBoard;
create table replyBoard (
	rno number primary key,
	bno number not null references board_question(num), -- 부모 테이블(board)에 참조를 받고 있기 때문에, num값에 있는 값들만 등록이 된다
	replytext varchar2(500) not null,
	replyer varchar2(50) not null,
	regdate date not null,
	updatedate date not null
);
delete REPLYBOARD;
select * from REPLYBOARD;
select * from board order by num desc;
insert into REPLYBOARD values(10,262,'11','나',sysdate,sysdate);