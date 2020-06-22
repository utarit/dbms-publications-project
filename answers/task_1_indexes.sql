-- CREATE INDEX field_name_index
-- ON field (field_name);

-- CREATE INDEX pub_type_index
-- on pub (pub_type);

CREATE INDEX pub_key_index on field(pub_key);
CREATE INDEX pub_key_index2 on pub(pub_key);

-- DROP INDEX field_name_index;
-- DROP INDEX pub_type_index;
-- DROP INDEX pub_key_index;
-- DROP INDEX pub_key_index2;