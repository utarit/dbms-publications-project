-- create table if not exists ActiveAuthors (name text);

-- insert into ActiveAuthors(name)
-- select distinct a.name
-- from author a
-- inner join authored ad on a.author_id = ad.author_id
-- inner join publication p on p.pub_id = ad.pub_id
-- where p.year >= 2018 and p.year <= 2020

CREATE OR REPLACE FUNCTION add_active_author()
RETURNS trigger AS
$BODY$
BEGIN
   IF NEW.pub_id in 
		(select pub_id 
		 from publication 
		 where year >= 2018 and year <= 2020) 
   THEN
       INSERT INTO ActiveAuthors(name)
       select distinct a.name from author a where NEW.author_id = a.author_id;
   END IF;
   RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER active_author_added
AFTER INSERT
ON Authored
FOR EACH ROW 
EXECUTE PROCEDURE add_active_author();