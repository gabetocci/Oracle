-- find non alphanumeric names, with zero or more spaces, or apostrope, or period, or hyphen, or suffix
select id, first_name, mi, last_name, user, origin, activity_date
from table_name
where entity_ind = 'P'
  and (REGEXP_LIKE(first_name, '[^[:alnum:][:space:]?|''|(\.)|-]') or
       REGEXP_LIKE(mi,         '[^[:alnum:][:space:]?|''|(\.)|-]') or 
       REGEXP_LIKE(last_name,  '[^[:alnum:][:space:]?|''|(\.)|-]') or 

       -- starts with non-alphanumeric (spaces, paren, bracket, etc)
       REGEXP_LIKE(first_name, '^[^[:alnum:]+]') or
       REGEXP_LIKE(mi,         '^[^[:alnum:]+]') or 
       REGEXP_LIKE(last_name,  '^[^[:alnum:]+]') or       

       -- look for case-sensitive issues (names should be mixed case)
       REGEXP_LIKE(first_name, '^[a-z]+') or
       REGEXP_LIKE(mi,         '^[a-z]+') or 
       REGEXP_LIKE(last_name,  '^[a-z]+') or      

       -- ends with comma or includes periods (only punctuation allowed within any name field will be hyphen and apostrophe)
       REGEXP_LIKE(first_name, '[,]$|[.]+') or
       REGEXP_LIKE(mi,         '[,]$|[.]+') or 
       REGEXP_LIKE(last_name,  '[,]$|[.]+') or            

       -- look for N/A in middle name field (should get caught in character pattern search, but never hurts to be sure)
       upper(mi) like '%N/A%' or

       -- look for saulutories, honorifics, and other prefixes/suffixes (should get caught by looking for period, but leave to be explicit)
       upper(first_name) like '%JR.%' or
       upper(first_name) like '%SR.%' or
       upper(first_name) like '%DR.%' or
       upper(first_name) like '%MR.%' or
       upper(first_name) like '%MRS.%' or
       upper(first_name) like '%III.%' or
       upper(first_name) like '%MD.%' or

       upper(mi) like '%JR.%' or
       upper(mi) like '%SR.%' or
       upper(mi) like '%DR.%' or
       upper(mi) like '%MR.%' or
       upper(mi) like '%MRS.%' or
       upper(mi) like '%III.%' or
       upper(mi) like '%MD.%' or
       
       upper(last_name) like '%JR.%' or
       upper(last_name) like '%SR.%' or
       upper(last_name) like '%DR.%' or
       upper(last_name) like '%MR.%' or
       upper(last_name) like '%MRS.%' or
       upper(last_name) like '%III.%' or
       upper(last_name) like '%MD.%' or
       
       -- same without periods (isoloated by leading and trailing spaces)
       upper(first_name) like '% JR %' or
       upper(first_name) like '% SR %' or
       upper(first_name) like '% DR %' or
       upper(first_name) like '% MR %' or
       upper(first_name) like '% MRS %' or
       upper(first_name) like '% III %' or
       upper(first_name) like '% MD %' or

       upper(mi) like '% JR %' or
       upper(mi) like '% SR %' or
       upper(mi) like '% DR %' or
       upper(mi) like '% MR %' or
       upper(mi) like '% MRS %' or
       upper(mi) like '% III %' or
       upper(mi) like '% MD %' or
       
       upper(last_name) like '% JR %' or
       upper(last_name) like '% SR %' or
       upper(last_name) like '% DR %' or
       upper(last_name) like '% MR %' or
       upper(last_name) like '% MRS %' or
       upper(last_name) like '% III %' or
       upper(last_name) like '% MD %'        
       
       );
