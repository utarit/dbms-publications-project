select a.name as "author_name", count(*) as pub_count
from Author a
inner join authored ad on a.author_id = ad.author_id
inner join publication p on ad.pub_id = p.pub_id
inner join article art on art.pub_id = p.pub_id
where art.journal like '%IEEE%'
group by a.name
order by pub_count desc, a.name asc
limit 50