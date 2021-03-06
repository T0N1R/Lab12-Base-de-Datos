
--a 
CREATE USER administrador;

--b
CREATE USER gerente;

--c
CREATE USER operador;

--d
GRANT ALL PRIVILEGES ON DATABASE "Lab11" TO administrador WITH GRANT OPTION;
GRANT ALL ON ALL TABLES IN SCHEMA public TO administrador WITH GRANT OPTION;

--e
GRANT SELECT ON ALL TABLES IN SCHEMA public TO operador;

--f
GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA public TO gerente;

--g
GRANT CREATE ON DATABASE "Lab11" TO gerente;