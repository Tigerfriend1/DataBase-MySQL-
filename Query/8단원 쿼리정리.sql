#8.4
#3
select * from s sx where exists(select * from sp spx where (spx.sno=sx.sno and spx.pno = "P2"));
#4
select sname from s sx where exists(select * from sp spx where sx.sno=spx.sno and exists (select *from p px where spx.pno=px.pno and px.color="red"));
select sname from s sx where exists(select * from sp spx, p px where sx.sno=spx.sno and spx.pno=px.pno and px.color = "red");
#5 x,y : s2에의해 공급된 부품을 다른 공급자들도 공급하는 공급자를 찾는것
select sname from s sx where exists(select * from sp spx, sp spy where sx.sno=spx.sno and spx.pno=spy.pno and spy.sno="s2");
#6
select sx.sname from s sx where not exists(select * from p px where not exists(select*from sp spx where spx.sno = sx.sno and spx.pno = px.pno));
#모든 부품(px)를 가진 공급자이름(sx.name) : 즉, sx.name where forall px라는 뜻 forall px는 바로 구현이 안되기에 not exist를 두번써서 표현
#7
select sname from s sx where not exists(select * from sp spx where spx.sno = sx.sno and spx.pno = "p2");
#9
select pno from p px where px.weight > 16 or exists(select * from sp spx where spx.pno=px.pno and spx.sno="s2");

##8.5
#3
select spx.pno, (sum(spx.quantity) * px.weight) as totalWeight from sp spx, p px where px.pno = spx.pno group by spx.pno; 
#4
select spx.pno, sum(spx.quantity) as totqty from sp spx, p px where spx.pno= px.pno group by px.pno;
#5
select sum(spx.quantity) as grandtotal from sp spx;
#6
select sx.sno, count(spx.pno) from sp spx, s sx where spx.sno=sx.sno group by sx.sno;

##8.6
#9을 표현하는 "Having"
select pno from p px where exists(select * from sp spx where spx.pno=px.pno and exists(select * from s sx where spx.sno=sx.sno));
select pno from sp group by sp.pno having count(sp.sno)>=1; #정답, 그룹뒤에 쓰는 where역할
select pno, count(sp.pno) from sp group by sp.pno; #그냥 조건은 없이 카운트 값을 다출력
#11
select sname from s sx where exists(select * from p px, sp spx where px.color = "red" and spx.pno=px.pno and spx.sno=sx.sno);
select sname from s sx where exists(select * from sp spx where spx.sno=sx.sno and exists(select * from p px where spx.pno=px.pno and px.color = "red"));

#18
select pno, weight from p where weight*454>1000;
#19 공급된 모든부품의 번호를 찾는다. 한번이라도 공급된적있는 = 적어도 한번 : exists
select distinct pno from p px where exists(select * from sp spx where spx.pno=px.pno);
#20 오름차순과 내림차순
select sno, pno from sp where quantity>0 order by sno asc, pno desc;
#21 비교문 2개이상일때 분리해서 and로 쓰기.
select pno from p where 16<weight and weight<19;
#22 공급된 p2
select sum(spx.quantity) from sp spx where exists(select * from p px where px.pno=spx.pno and px.pno="P2");
#23 
select distinct pno from sp spx where exists(select * from s sx where sx.sno=spx.sno);
select distinct pno from sp ;
#25 업데이트를 통해 행의 값을 바꿀 수 있다.
update p set color="yellow", weight=weight+5, city="oslo" where pno="p2";

#트리거 49페이지
delete from dept where budget="1m";
delete from s where city="London";

alter table s auto_increment=1;

select pname from part where exists(select * supplier
select sname, city from supplier where not exsists(select * from suppliers where suppliers.sname=supplier.sname and exists(select * from project where suppliers.pro_name =project.pro_name and project.city="Busan"));
select pro_name, budget from project where exists(select * from uses where uses.part_no=part.part_no and  exists(select * from can_supply where can_supply.sname=supplier.sname and supplier.city="Busan"));
select sname, city from supplier where not exists(select*from part where not exists (select * from uses where uses.part_no=part.part_no and project.pro_name=uses.pro_name and project.budget>=50000)); 
select sname, city, status from supplier  where not exists(select * from suppliers where suppliers.sname=supplier.sname and suppliers.pro_name=project.pro_name));


select sname from s sx where not exists(select * from sp spx where spx.sno = sx.sno and spx.pno = "p2");

select sx.sname from s sx where not exists (select * from p px where not exists (select * from sp spx where spx.sno = sx.sno and spx.pno = px.pno));
