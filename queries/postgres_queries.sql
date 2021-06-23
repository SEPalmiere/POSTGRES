CREATE ROLE professores NOCREATEROLE nocreatedb inherit nologin nobypassrls connection limit 10;
ALTER ROLE professores PASSWORD '123';
CREATE ROLE daniel LOGIN PASSWORD '123';
DROP ROLE daniel;
CREATE ROLE daniel LOGIN PASSWORD '123' IN ROLE professores;
CREATE ROLE daniel LOGIN PASSWORD '123' ROLE professores;
CREATE ROLE daniel INHERIT LOGIN PASSWORD '123' IN ROLE professores;

CREATE TABLE teste nome 'varchar';
GRANT ALL ON TABLE teste TO professores;

REVOKE professores FROM daniel;
