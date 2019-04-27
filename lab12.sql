
-- PARTE 1

-- EJERCICIO 1
SELECT * FROM PC;

SELECT model, speed, ram, hd, price, ranki FROM 
(
SELECT model, speed, ram, hd, price, RANK() OVER( ORDER BY abs(price - 40) ASC  ) AS ranki
from pc
) t
WHERE t.ranki = 1


CREATE OR REPLACE FUNCTION cercano(pre FLOAT)
RETURNS TABLE(
	modelo VARCHAR,
	velocidad INT,
	ram INT,
	hd VARCHAR,
	precio FLOAT,
	lugar bigint
) AS $$
DECLARE
	aprox FLOAT := pre;
	
BEGIN

	IF aprox <0 THEN
		RAISE EXCEPTION 'Ingresaste numero negativo';
	END IF;
	
	RETURN QUERY
	SELECT t.model, t.speed, t.ram, t.hd, t.price, t.ranki FROM
	(
	SELECT pc.model, pc.speed, pc.ram, pc.hd, pc.price, RANK() OVER( ORDER BY abs(price - 40) ASC  ) AS ranki
	from pc
	) t
	WHERE t.ranki = 1;
	
END;
$$ LANGUAGE plpgsql;
	
SELECT cercano(60);


-- EJERCICIO 2
SELECT laptop.model, laptop.speed, laptop.ram, laptop.hd, laptop.screen, laptop.price, product.maker
FROM laptop
INNER JOIN product ON product.model = laptop.model
WHERE laptop.speed >=5 AND laptop.ram >= 5 AND laptop.hd >=8;

select * from laptop;


DROP FUNCTION minimo(INTEGER, INTEGER, INTEGER);

CREATE OR REPLACE FUNCTION minimo(s INTEGER, r INTEGER, h INTEGER)
RETURNS TABLE(
	modelo VARCHAR,
	velocidad INTEGER,
	ram INTEGER,
	hd INTEGER,
	pantalla INTEGER,
	precio FLOAT,
	creador VARCHAR
) AS $$
DECLARE
	spd INTEGER := s;
	rm INTEGER := r;
	high_def INTEGER := h;
	
BEGIN

	IF spd <0 THEN
		RAISE EXCEPTION 'Ingresaste numero negativo';
	END IF;
	
	IF rm <0 THEN
		RAISE EXCEPTION 'Ingresaste numero negativo';
	END IF;
	
	IF high_def <0 THEN
		RAISE EXCEPTION 'Ingresaste numero negativo';
	END IF;
	
	RETURN QUERY
	SELECT laptop.model, laptop.speed, laptop.ram, laptop.hd, laptop.screen, laptop.price, product.maker
	FROM laptop
	INNER JOIN product ON product.model = laptop.model
	WHERE laptop.speed >= spd AND laptop.ram >= rm AND laptop.hd >=high_def;
	
END;
$$ LANGUAGE plpgsql;

SELECT minimo(5,5,8);


---------------------------------------------------------
--EJERCICIO 3

select * from printer;

INSERT INTO printer (model, color, type, price) VALUES(
	'p2',
	'azul',
	'pt2',
	100
);

SELECT DISTINCT pc.model, printer.model
FROM pc, printer
WHERE pc.price + printer.price > 360 AND pc.speed >= 5;

DROP FUNCTION pcANDprinter;

CREATE OR REPLACE FUNCTION pcANDprinter(prc INTEGER, sp INTEGER)
RETURNS TABLE(
	compu VARCHAR,
	impresora VARCHAR
) AS $$
DECLARE
	sumatoria INTEGER := prc;
	velocidad_min INTEGER := sp;
	
BEGIN

	IF sumatoria <0 THEN
		RAISE EXCEPTION 'Ingresaste numero negativo';
	END IF;
	
	IF velocidad_min <0 THEN
		RAISE EXCEPTION 'Ingresaste numero negativo';
	END IF;
	
	
	RETURN QUERY
		SELECT DISTINCT pc.model, printer.model
		FROM pc, printer
		WHERE pc.price + printer.price > sumatoria AND pc.speed >= velocidad_min;

	
END;
$$ LANGUAGE plpgsql;

SELECT pcANDprinter(360,5);


----------------------------------------------------------------------
--EJERCICIO 4


----------------------------------------------------------------------
--EJERCICIO 5

SELECT DISTINCT count(pc.model), count(laptop.model), count(printer.model)
from pc, laptop, printer;

SELECT 
	(SELECT COUNT(*) FROM pc WHERE pc.price >= 250) AS compus, 
	(SELECT COUNT(*) FROM laptop WHERE laptop.price >= 250) AS laptops, 
	(SELECT COUNT(*) FROM printer WHERE printer.price >= 250) AS impresoras;

DROP FUNCTION productosBudget;

CREATE OR REPLACE FUNCTION productosBudget(prc INTEGER)
RETURNS TABLE(
	compu bigint,
	laptop bigint,
	impresora bigint
) AS $$
DECLARE
	budget INTEGER := prc;
	
BEGIN

	IF budget <0 THEN
		RAISE EXCEPTION 'Ingresaste numero negativo';
	END IF;
		
	RETURN QUERY
		SELECT 
			(SELECT COUNT(*) FROM pc WHERE pc.price >= budget) AS compus, 
			(SELECT COUNT(*) FROM laptop WHERE laptop.price >= budget) AS laptops, 
			(SELECT COUNT(*) FROM printer WHERE printer.price >= budget) AS impresoras;
	
END;
$$ LANGUAGE plpgsql;

SELECT productosBudget(250);
