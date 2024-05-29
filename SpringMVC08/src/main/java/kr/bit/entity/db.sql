-- tblBoard --
create table tblBoard(
	idx int not null, -- 일련번호 자동생성하는게 아니라 최대값+1로 생성하는 방법을 사용할것이다.
	memID varchar(20) not null,
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),
	count int default 0,
	boardGroup int, -- 원글을 쓰고 댓글을 쓰면 그 원글과 댓글은 같은 그룹으로 만들어 줘야 되기 때문에 boardGroup이 만들어졌고요, 만약 boardGroup 이 0이면 다 0그룹이고 보드그룹이 1이면 다 1그룹이이 된다. 원글과, 부모글과 댓글을 하나의 그룹으로 만들기위해 부여되는 값
	boardSequence int, -- 같은 그룹안에서 댓글이 달리면 그 답글의 순서를 지정하는 시퀀스이다.
	boardLevel int,	-- 1단계 댓글인지 2단계 댓글인지에 따라서... 들여쓰기 레벨이 - 1레벨 2레밸에서... 들여쓰기를 결정하는 속성
	boardAvailable int, -- 댓글이 있는 상태에서 원글을 삭제 할 수 없기때문에 '원글(부모글)이 삭제되었는지 안되었는지 상태를 표시하는 속성'이다.
	primary key(idx)
);

			select 
				IFNULL(MAX(idx)+1, 1) as idx,
				IFNULL(MAX(boardGroup)+1, 0) as boardGroup
			from tblBoard
			
select max(idx) from tblBoard;
select ifnull(max(idx)+1, 1) from tblBoard;
select ifnull(max(boardGroup)+1, 1) from tblBoard;

insert into tblBoard select IFNULL(max(idx)+1, 1), 'bit01','게시판연습','게시판연습','관리자',now(), 0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1 from tblBoard;
insert into tblBoard select IFNULL(max(idx)+1, 1), 'bit02','게시판연습','게시판연습','관리자',now(), 0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1 from tblBoard;
insert into tblBoard select IFNULL(max(idx)+1, 1), 'bit03','게시판연습','게시판연습','관리자',now(), 0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1 from tblBoard;

select * from tblBoard;


update tblBoard set boardLevel =2 where idx in(6,7);
delete from tblBoard where idx='11';
delete from tblBoard where idx in('3','4','5','6','7');
delete from tblBoard where idx='12';

update tblBoard set title='1111', content='111111' where idx=11;

update tblBoard set title='121212', content='121212121' where idx=12;

insert into tblBoard values
(14, 'bit01','14','14','관리자',now(),0,8,0,0,1)
,(15, 'bit01','15','15','관리자',now(),0,9,0,0,1)
,(16, 'bit01','16','16','관리자',now(),0,10,0,0,1)
,(17, 'bit01','17','17','관리자',now(),0,11,0,0,1)
,(18, 'bit01','18','18','관리자',now(),0,12,0,0,1)
,(19, 'bit01','19','19','관리자',now(),0,13,0,0,1)
,(20, 'bit01','20','20','관리자',now(),0,14,0,0,1)
,(21, 'bit01','21','21','관리자',now(),0,15,0,0,1)
,(22, 'bit01','22','22','관리자',now(),0,16,0,0,1)
,(23, 'bit01','23','23','관리자',now(),0,17,0,0,1);

insert into tblBoard values
(24, 'bit01','24','24','관리자',now(),0,18,0,0,1)
,(25, 'bit01','25','25','관리자',now(),0,19,0,0,1)
,(26, 'bit01','26','26','관리자',now(),0,20,0,0,1)
,(27, 'bit01','27','27','관리자',now(),0,21,0,0,1)
,(28, 'bit01','28','28','관리자',now(),0,22,0,0,1)
,(29, 'bit01','29','29','관리자',now(),0,23,0,0,1);

insert into tblBoard values
(30, 'bit01','30','30','관리자',now(),0,24,0,0,1)
,(31, 'bit01','31','31','관리자',now(),0,25,0,0,1)
,(32, 'bit01','32','32','관리자',now(),0,26,0,0,1)
,(33, 'bit01','33','33','관리자',now(),0,27,0,0,1)
,(34, 'bit01','34','34','관리자',now(),0,28,0,0,1)
,(35, 'bit01','35','35','관리자',now(),0,29,0,0,1)
,(36, 'bit01','36','36','관리자',now(),0,30,0,0,1)
,(37, 'bit01','37','37','관리자',now(),0,31,0,0,1)
,(38, 'bit01','38','38','관리자',now(),0,32,0,0,1)
,(39, 'bit01','39','39','관리자',now(),0,33,0,0,1)
,(40, 'bit01','40','40','관리자',now(),0,34,0,0,1)
,(41, 'bit01','41','41','관리자',now(),0,35,0,0,1);
insert into tblBoard values
(42, 'bit01','42','42','관리자',now(),0,36,0,0,1)
,(43, 'bit01','43','43','관리자',now(),0,37,0,0,1)
,(44, 'bit01','44','44','관리자',now(),0,38,0,0,1)
,(45, 'bit01','45','45','관리자',now(),0,39,0,0,1)
,(46, 'bit01','46','46','관리자',now(),0,40,0,0,1)
,(47, 'bit01','47','47','관리자',now(),0,41,0,0,1)
,(48, 'bit01','48','48','관리자',now(),0,42,0,0,1)
,(49, 'bit01','49','49','관리자',now(),0,43,0,0,1)
,(50, 'bit01','50','50','관리자',now(),0,44,0,0,1)
,(51, 'bit01','51','51','관리자',now(),0,45,0,0,1);




commit;
select * from tblBoard order by boardGroup desc;

delete from tblBoard where memID='bit05';

create table tblMember(
	memID varchar(50) not null, -- 회원ID
	memPwd varchar(50) not null, -- 회원비번
	memName varchar(50) not null, -- 회원이름
	memPhone varchar(50) not null, -- 회원전화번호
	memAddr varchar(100) , -- 회원주소
	latitude decimal(13, 10) , -- 현재위치위도
	longitude decimal(13, 10) , -- 현재위치경도
	primary key(memID)
);


insert into tblMember(memID, memPwd, memName, memPhone)
values('bit01', 'bit01', '관리자', '010-1111-1111');
insert into tblMember(memID, memPwd, memName, memPhone)
values('bit02', 'bit02', '박매일', '010-2222-2222');
insert into tblMember(memID, memPwd, memName, memPhone)
values('bit03', 'bit03', '홍길동', '010-3333-3333');



