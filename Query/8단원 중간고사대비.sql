SELECT * FROM warehouse.s;
select * from s,p where s.city = p.city; #이건 calulus에서 왔다. p139 맨위 1,2,3참고
select * from s left join p on s.city = p.city;
select* from s right join p on s.city=p.city;

(select * from s left join p on s.city = p.city) union (select* from s right join p on s.city=p.city);
#union을 통해 fullouter join을 구현함. fullouter는 query에서 지원안해서 직접만들어야함.

#8.3
#(sx.sno, sx.city) where 조건문
#(sx.sno, sx.city)는 target-item-list임

#range of spx is sp; 
#range of sx is s;
#(sx.sno, spx.sno):이건 relational 문법임 정의한다(=) select sx.sno,spx.sno from s sx, sp spx;
#테이블이 다르면 카르티안프러덕트 / 괄호안은 카티시안 프로덕트와 프로젝트

#3. 부품 p2를 공급하는 공급자의 번호, 이름, status, 도시를 찾아라.
select * from s sx where exists (select * from sp spx where spx.sno=sx.sno and spx.pno = 'p2');
#relational에서 exists 뒤에 spx가 타겟인데 쿼리에서는 select*from sp spx로 타겟변수를 설정함.
#sx는 free니까 모든 s테이블 다 가르켜, 

#4.적어도 한개이상의 red부품을 공급하는 공급자의 이름을 찾아라.
select sx.sname from s sx where 
exists(select*from sp spx where sx.sno = spx.sno and exists(select * from p px where px.pno = spx.pno and px.color = 'red'));
#위 쿼리문을 줄이는 방법 exists를 묶어버림
select sx.sname from s sx where exists (select * from sp spx, p px where sx.sno=spx.sno and px.pno = spx.pno and px.color ='red');

#5. 공급자 s2에 의해 공급된 부품을 적어도 하나 이상 공급하는 공급자의 이름을 찾아라.
select sx.sname from s sx where exists (select * from sp spx, sp spy where sx.sno = spx.sno and spx.pno = spy.pno and spy.sno='s2');
#쉽게 생각해서 뒤에서 부터 해석하기. 결론은 exist는 s1테이블을 넘김

#6. 모든부품을 공급하는 공급자의 이름을 찾아라.
select sx.sname from s sx where not exists (select * from p px where not exists (select * from sp spx where spx.sno = sx.sno and spx.pno = px.pno));
#forall=not exists(not exists)로 표현 이건 중간고사 30년간 필수로 제출했음.

#7. 부품 p2를 공급하지 않는 공급자의 이름을 찾아라.
#8. s2 
#8번은 IF THEN을  알아야한다. 이산수학내용임. /하지만 3학년 과정에서는 8번은 요구하지 않겠다. 현장에서 필요하면 공부해서 해라.

#8.5 확장
#2. 
(select sno, sname, status, city, "공급자" as tag from s);
#3. 부품이공급된경우 부품번호와 공급된부품의 총무게
select spx.pno, sum(spx.qty) * px.weight as totalWeight from sp spx, p px where px.pno = spx.pno group by spx.pno;
# + relation에서 맨 앞에 spx가 아니라 spx.pno다. 오타 임
#4. 
select px.pno, sum(spx.qty) from p px, sp spx where spx.pno =px.pno group by px.pno;
#각 p1을 가진 것들의 썸. p2들의 썸. group by px.pno는 p1에 대해서계산 p2에 대해서 계산
## 시험에는 exists forall sum 필수로 나옴
#6번 
select sx.sno, count(spx.pno) from s sx, sp spx where spx.sno = sx.sno group by sx.sno;

#8.6 IN은 algebra도 calculus도 아니다. table expression이다. 
#s.sno과 같은건 name qualification이라고 한다.
#distint는 같은 건 빼고 출력 그림8.4참고
#order by 결과 순서대로 그림 8.5참고
#4번 first city에 있는 공급자가 second city에 있는 부품을 공급할 때 두 도시 쌍을 찾아라.
#11번
 select sx.sname from s sx where exists (select *from sp spx where sx.sno=spx.sno and exists(select* from p px where px.color = 'red' and px.pno=spx.pno));
#15번 마지막줄 where sp.sno로 바꾸기.(pno로 오타임)

alter table s auto_increment=1;

#25번

#8.7 subquery
