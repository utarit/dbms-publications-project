select a.name as "author_name", count(*) as pub_count
from Author a
inner join authored ad on a.author_id = ad.author_id
inner join publication p on ad.pub_id = p.pub_id
group by a.name
having count(*) >= 150 and count(*) < 200
order by pub_count asc, a.name