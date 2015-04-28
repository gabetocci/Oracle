select distinct
       person.id                    id,
       person.first_name            first_name,
       person.last_name             last_name,
       '&Year'                      year,
       maxyear.maxyear              max_year,
       mailing_address.street_line1 mailing_street,
       mailing_address.city         mailing_city,
       mailing_address.stat_code    mailing_state,
       mailing_address.zip          mailing_zip,
       (select area_code ||'-'|| number 
          from telephone 
         where telephone_id = person_id
           and telephone_code in ('X','XA','XE')
           and telephone_entry_year between '&Year' and maxyear.maxyear)
                                    phone_number
  from person,

       -- inline view exmaple
       (select * from address
         where address_type = 'MA'
           and address_seqno = 
               (select max(addr2.address_seqno) from address addr2
                 where address.address_id       = addr2.address_id
                   and address.address_type     = addr2.address_type
                   and addr2.address_from_date <= sysdate
                   and(addr2.address_to_date is null or addr2.address_to_date >= sysdate))
        ) mailing_address,

        -- dual inline view
       (select 
         (select substr('&Year',0,4)   from dual where mod('&Year',2) = '1') ||
         (select substr('&Year',0,4)+1 from dual where mod('&Year',2) = '0')  maxyear 
        from dual) maxyear
                    
 where person.person_type = 'P'
 
       -- various subquery examples
   and person.some_code =
       (select referenced_code from person_codes 
         where codes_year = '&Year')
   and not exists
       (select * from places
         where places.id = person.id
           and places_year <> '&Year')
   and person.id in
       (select event_id from events
         where event_year between '&Year' and maxyear.maxyear);
