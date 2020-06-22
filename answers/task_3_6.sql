select
    tb2.y as "year",
    tb2.name,
    tb2.co as "count"
from
    (
        select
            tb1.y,
            max(tb1.co) as max_co
        from
            (
                select
                    y,
                    count(p.pub_id) as co
                from
                    generate_series(1940, 1990) as y,
                    author a
                    inner join authored ad on a.author_id = ad.author_id
                    inner join publication p on p.pub_id = ad.pub_id
                where
                    p.year = y
                group by
                    y,
                    a.author_id
            ) as tb1
        group by
            tb1.y
    ) as tb1,
    (
        select
            y,
            a.name,
            count(p.pub_id) as co
        from
            generate_series(1940, 1990) as y,
            author a
            inner join authored ad on a.author_id = ad.author_id
            inner join publication p on p.pub_id = ad.pub_id
        where
            p.year = y
        group by
            y,
            a.author_id
    ) as tb2
where
    tb1.y = tb2.y
    and tb2.co = tb1.max_co
order by
    tb2.y asc,
    tb2.name asc