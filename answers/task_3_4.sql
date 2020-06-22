select CONCAT_WS('-', d, d+10) as decade, count(*) as total
from generate_series(1940,2020) as d, publication p
where p.year >= d and p.year < d+10
group by d
 

