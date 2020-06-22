select a1.name, count(distinct a2.author_id) as collab_count
from author a1 
inner join authored d1 on a1.author_id = d1.author_id 
inner join authored d2 on d1.pub_id = d2.pub_id
inner join author a2 on d2.author_id = a2.author_id and a1.author_id != a2.author_id
group by a1.author_id
order by collab_count desc, a1.name asc
limit 1000