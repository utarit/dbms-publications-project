select t1.field_name
from (select f.field_name, p.pub_type
from field f, pub p
where p.pub_key = f.pub_key
group by f.field_name, p.pub_type) as t1
group by field_name
having count(t1.pub_type) = (select count(*) from (select distinct pub_type from pub where pub_type != '') as t3)
order by field_name asc

