insert into Author(name)
select distinct field_value
from field
where field_name = 'author'

insert into Publication(pub_key, title, year)
select f.pub_key, f.field_value, cast(f2.field_value as int)
from field f, field f2
where f.pub_key = f2.pub_key
and f.field_name = 'title'
and f2.field_name = 'year'

insert into Article(pub_id, journal, month, volume, number)
select pu.pub_id, f1.field_value, f2.field_value, f3.field_value, f4.field_value
from pub p
LEFT JOIN field f1 ON p.pub_key = f1.pub_key AND f1.field_name = 'journal'
LEFT JOIN field f2 ON p.pub_key = f2.pub_key AND f2.field_name = 'month'
LEFT JOIN field f3 ON p.pub_key = f3.pub_key AND f3.field_name = 'volume'
LEFT JOIN field f4 ON p.pub_key = f4.pub_key AND f4.field_name = 'number'
LEFT JOIN publication pu ON p.pub_key = pu.pub_key
where p.pub_type = 'article'

insert into Book(pub_id, publisher, isbn)
select pu.pub_id, f1.field_value, f2.max_isbn
from pub p
LEFT JOIN field f1 ON p.pub_key = f1.pub_key AND f1.field_name = 'publisher'
LEFT JOIN (select pub_key, max(field_value) as max_isbn from field f where field_name = 'isbn' group by pub_key) as f2 ON p.pub_key = f2.pub_key
LEFT JOIN publication pu ON p.pub_key = pu.pub_key
where p.pub_type = 'book'


insert into Incollection(pub_id, book_title, publisher, isbn)
select pu.pub_id, f1.field_value, f2.field_value, f3.field_value
from pub p
LEFT JOIN field f1 ON p.pub_key = f1.pub_key AND f1.field_name = 'booktitle'
LEFT JOIN field f2 ON p.pub_key = f2.pub_key AND f2.field_name = 'publisher'
LEFT JOIN field f3 ON p.pub_key = f3.pub_key AND f3.field_name = 'isbn'
LEFT JOIN publication pu ON p.pub_key = pu.pub_key
where p.pub_type = 'incollection'

insert into Inproceedings(pub_id, book_title, editor)
select pu.pub_id, f1.field_value, f2.field_value
from pub p
LEFT JOIN field f1 ON p.pub_key = f1.pub_key AND f1.field_name = 'booktitle'
LEFT JOIN field f2 ON p.pub_key = f2.pub_key AND f2.field_name = 'editor'
LEFT JOIN publication pu ON p.pub_key = pu.pub_key
where p.pub_type = 'inproceedings'

insert into Authored(author_id, pub_id)
select a.author_id, p.pub_id
from Publication p
LEFT JOIN Field f ON p.pub_key = f.pub_key AND f.field_name = 'author'
LEFT JOIN Author a ON f.field_value = a.name 
where a.author_id is not null and p.pub_id is not null



