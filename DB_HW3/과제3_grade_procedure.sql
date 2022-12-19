CREATE DEFINER=`root`@`localhost` PROCEDURE `Grade`(in jno char(4))
BEGIN
	declare grade char(4);
    declare J char(4);
    set @J = jno;
    set @grade = concat('select spjx.pno, sum(spjx.qty), dlevel(sum(spjx.qty)) 
    from p px, spj spjx where px.pno = spjx.pno and spjx.jno = ? group by px.pno order by px.pno');
    prepare gr from @grade;
    execute gr using @J;
    deallocate prepare gr;
END