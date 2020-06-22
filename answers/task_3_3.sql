(select a.name, count(*) as pub_count
from Author a
inner join authored ad on a.author_id = ad.author_id
inner join publication p on ad.pub_id = p.pub_id
inner join article art on art.pub_id = p.pub_id
where art.journal like 'IEEE Trans. Wireless Communications' and a.author_id not in ((select ad.author_id
from authored ad
inner join publication p on ad.pub_id = p.pub_id
inner join article art on art.pub_id = p.pub_id
where art.journal like 'IEEE Wireless Commun. Letters'
group by ad.author_id))
group by a.name
having count(*) >= 10
order by pub_count desc, a.name asc)
