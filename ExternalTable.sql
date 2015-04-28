-- insert data from external table

CREATE TABLE SCHEMA_NAME.TABLE_NAME_EXT (
  term_code     varchar2(6),
  pidm          number(8),
  process_name  varchar2(15),
  pin           varchar2(6),
  activity_date varchar2(30)
)
ORGANIZATION EXTERNAL (
  TYPE oracle_loader
  DEFAULT DIRECTORY DATA_HOME
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    badfile DATA_HOME:'TABLE_NAME_EXT.bad'
    logfile DATA_HOME:'TABLE_NAME_EXT.log'
    FIELDS TERMINATED BY ','
    LRTRIM (
      term_code,
      pidm,
      process_name,
      pin,
      activity_date
    )
  )LOCATION ('file_name.csv')
)REJECT LIMIT UNLIMITED;

insert into schema_name.table_name (
  select term_code, pidm, process_name, pin, to_date(activity_date, 'mm/dd/yyyy HH24:MI')
  from SCHEMA_NAME.TABLE_NAME_EXT 
  -- where not exists?
);

-- commit;

-- DROP TABLE SCHEMA_NAME.TABLE_NAME_EXT;
