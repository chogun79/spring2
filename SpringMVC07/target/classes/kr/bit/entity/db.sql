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



