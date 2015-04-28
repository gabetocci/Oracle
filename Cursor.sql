/* execute procedure on cursor, and then display values */

declare
    
  TYPE t_rec IS RECORD (
    r_level  varchar2(2),
    r_sCode  varchar2(1),
    r_sDesc  varchar2(35),
    r_hCount number,
    r_fte    varchar2(10)
    );
    
  TYPE t_cursor IS REF CURSOR RETURN t_rec;
    rc  t_cursor;
    rec t_rec;
    
begin

  schema_owner.package_name.p_procedure_name(rc);

  for rec in rc loop
    dbms_output.put_line(rec.r_level||' : '||rec.r_sCode||' : '||rec.r_sDesc||' : '||rec.r_hCount||' : '||rec.r_fte);
  end loop;

end;
