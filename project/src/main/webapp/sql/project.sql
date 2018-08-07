create table company(
	com_name varchar2(100) not null,
	com_addr1 varchar2(30) not null,
	com_addr2 varchar2(30) not null,
	com_addr3 varchar2(200) not null,
	com_type varchar2(100) not null,
	com_typedt varchar2(250),
	com_year varchar2(20),
	com_water number(25,10),
	com_rewater number(25,10),
	com_energy number(25,10),
	com_air number(25,10),
	com_wp number(25,10),
	com_waste number(25,10),
	com_rewaste number(25,10),
	com_chemical number(25,10)
)

select * from company;
select count(*) from company;
drop table company purge;

select com_addr1,com_addr2 from company

create table korea(
	one varchar2(30),
	two varchar2(40)
)

delete korea;

select * from korea;

select count(*) from company where com_addr1='경기도';

create table ISO_code (
	state varchar2(30), 
	code varchar2(20)
)

select * from ISO_code;
insert into ISO_code values('강원도', 'KR-42');
insert into ISO_code values('경기도', 'KR-41'); 
insert into ISO_code values('경상남도', 'KR-48');
insert into ISO_code values('경상북도', 'KR-47');

insert into ISO_code values('광주광역시', 'KR-29');
insert into ISO_code values('대구광역시', 'KR-27');
insert into ISO_code values('대전광역시', 'KR-30');
insert into ISO_code values('부산광역시', 'KR-26');
insert into ISO_code values('서울특별시', 'KR-11');
insert into ISO_code values('세종특별자치시', 'KR-50');
insert into ISO_code values('울산광역시', 'KR-31');
insert into ISO_code values('인천광역시', 'KR-28');
insert into ISO_code values('전라남도', 'KR-46');
insert into ISO_code values('전라북도', 'KR-45');
insert into ISO_code values('제주특별자치도', 'KR-49');
insert into ISO_code values('충청남도', 'KR-44');
insert into ISO_code values('충청북도', 'KR-43')

