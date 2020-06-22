select p.pub_type, count(*) as pub_count
from pub p, field f
where p.pub_key = f.pub_key
group by p.pub_type
order by pub_count desc