/* Dynamic SQL to find missing foreign keys */

declare

  cursor cons is
    select cols.table_name, cons.constraint_name, cols.column_name, cons.r_constraint_name
      from all_constraints cons 
      join all_cons_columns cols on cons.constraint_name = cols.constraint_name
     where cons.table_name in ('TABLE_ONE','TABLE_TWO')
       and cons.constraint_type = 'R' and cons.status = 'ENABLED';

  fk_tab varchar2(12);
  
begin

  for rec in cons loop
        
    fk_tab := substr(rec.r_constraint_name,4,7);
    
      dbms_output.put_line(
        'select * from '|| rec.table_name ||
        ' where '|| rec.column_name ||' is not null and '|| rec.column_name ||' not in' || 
        ' (select '|| fk_tab ||'_CODE from '|| fk_tab ||');'
      );
    
  end loop;
  
end;
