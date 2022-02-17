SELECT USER FROM DUAL;

-- CREACION DE USUARIO
CREATE USER miusuario IDENTIFIED BY laclave
DEFAULT TABLESPACE SYSTEM
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON SYSTEM;

-- PRIVILEGIOS DE USUARIO
GRANT CREATE SESSION TO miusuario;
GRANT CREATE TABLE TO miusuario;
GRANT CREATE VIEW TO miusuario;
GRANT CREATE PROCEDURE TO miusuario;
GRANT CREATE SEQUENCE TO miusuario;

-- PRIVILEGIO ADMINISTRAR TABLAS EXISTENTES
GRANT ALL ON nombretabla TO miusuario;

-- REVOCAR PRIVILEGIOS DE LA TABLA
REVOKE ALL ON nombretabla FROM miusuario;

-- ELIMINAR USUARIO
DROP USER miusuario CASCADE;

SELECT * FROM ALL_TABLES;

--CREAR TABLA
CREATE TABLE usuario(
idusuario int, 
nombre char(10),
fecha_nacimiento date,
telefono char(10),
salario number(6,2)
);

SELECT * FROM usuario;
DESCRIBE usuario;

CREATE TABLE empleado(
id_empleado int not null,
nombre varchar2(20),
direccion varchar2(50),
id_documento varchar2(20),
sueldo number(6,2),
fecha_nacimiento date
);

SELECT * FROM empleado;
DESCRIBE empleado;

-- INSERTAR DATOS
INSERT INTO empleado VALUES (003, 'Ana', 'Avenida principal 350', '2145878855', 4000.00, to_date('10/03/1988','dd/mm/yyyy'));

-- WHERE
 create table articulos(
  codigo number(5),
  nombre varchar2(20),
  descripcion varchar2(30),
  precio number(7,2)
 );

 insert into articulos values (1,'impresora','Epson Stylus C45',400.80);
 insert into articulos values (2,'impresora','Epson Stylus C85',500);
 insert into articulos values (3,'monitor','Samsung 14',800);
 insert into articulos values (4,'teclado','ingles Biswal',100);
 insert into articulos values (5,'teclado','español Biswal',90);
 insert into articulos values (6, 'mouse', 'Genius',20);
 insert into articulos values (7, 'mouse','teclado blanco', 30);
 insert into articulos values (8, 'Computadora','Dell', 2000);

SELECT * FROM articulos;
SELECT * FROM articulos WHERE nombre = 'impresora';
SELECT nombre, descripcion FROM articulos WHERE nombre = 'mouse';

-- OPERADORES RELACIONALES =, !=, >, >=, <, <=
SELECT * FROM articulos WHERE nombre = 'monitor';
SELECT * FROM articulos WHERE nombre != 'monitor';
SELECT * FROM articulos WHERE precio > 100;
SELECT * FROM articulos WHERE precio < 100;
SELECT * FROM articulos WHERE precio >= 100;
SELECT * FROM articulos WHERE precio <= 100;

-- BORRAR REGISTROS DE UNA TABLA
 create table agenda(
  apellido varchar2(30),
  nombre varchar2(20),
  domicilio varchar2(30),
  telefono varchar2(11)
 );

 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Alvarez','Alberto','Colon 123','4234567');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Juarez','Juan','Avellaneda 135','4458787');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Lopez','Maria','Urquiza 333','4545454');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Lopez','Jose','Urquiza 333','4545454');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Salas','Susana','Gral. Paz 1234','4123456');
   
SELECT * FROM agenda;
DELETE FROM agenda WHERE nombre = 'Juan';

--ACTUALIZAR REGISTROS DE UNA TABLA
SELECT * FROM articulos;
UPDATE articulos SET nombre = 'impresora' WHERE codigo = 8;
UPDATE articulos SET nombre = 'impresora', precio = '500' WHERE codigo = 2;

/*
 SELECT * FROM articulos; 
 SELECT * FROM empleado;
*/

CREATE TABLE libros(
titulo varchar(30) not null,
autor varchar(20) not null,
editorial varchar(15) null,
precio number(5,2)
);

INSERT INTO libros VALUES('el aleph', 'borges', 'emece', null);
SELECT * FROM libros;
INSERT INTO libros VALUES('alicia', 'lewis carrol', 'campos', 300.00); 
INSERT INTO libros VALUES('el quijote','miguel de cervantes','casa del libro', 0);

-- CONSULTAR VALORES NULOS - IS NULL
 create table medicamentos(
  codigo number(5) not null,
  nombre varchar2(20) not null,
  laboratorio varchar2(20),
  precio number(5,2),
  cantidad number(3,0) not null
 );

 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(1,'Sertal gotas',null,null,100); 
 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(2,'Sertal compuesto',null,8.90,150);
 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(3,'Buscapina','Roche',null,200);

SELECT * FROM medicamentos;

SELECT * FROM medicamentos WHERE laboratorio is null;
SELECT * FROM medicamentos WHERE precio is null;
SELECT * FROM medicamentos WHERE laboratorio is not null;
SELECT * FROM medicamentos WHERE laboratorio = '';

-- CLAVES PRIMARIAS
CREATE TABLE usuarios(
nombre varchar2(20) not null,
clave varchar2(10) not null,
primary key(nombre)
);

insert into usuarios values('jose', '123456');
insert into usuarios values('manuel', '67890');

delete from articulos;
select * from articulos;
-- RECUPERAR REGISTROS ELIMINADOS CON DELETE
rollback;
-- CON TRUNCATE NO SON RECUPERABLES
truncate table articulos;

-- CONFIGURAR CAMPOS CON VALORES POR DEFECTO
DROP TABLE libros;

create table libros(
titulo varchar2(40) not null,
autor varchar2(30) default 'desconocido',
editorial varchar2(40) not null,
precio number(5,2),
cantidad number(3) default 0
);

insert into libros values('el quijote', 'miguel de cervantes', 'la casa del libro', 650.00, 10);
insert into libros values('guerra y paz', default, 'mensajero ruso', 500.00, 5);
insert into libros values('cien años de soledad', 'gabriel garcia marquez', 'sudamericana', 480.00, default);
select * from libros;

-- MANEJAR COLUMNAS CALCULADAS
SELECT titulo, precio, cantidad from libros;
select titulo, precio, cantidad, precio*cantidad from libros;
select titulo, precio, precio-(precio*0.1) from libros;
update libros set precio = precio-(precio*0.1);

-- CONCATENACION
select titulo || ' - ' || autor from libros;
select titulo || ' $' || precio from libros;

-- ALIAS
select * from articulos;
select nombre, descripcion, precio as costo from articulos;
select nombre, descripcion, precio-(precio*0.15) as descuento from articulos;
select nombre, descripcion, precio+(precio*0.20) as recargo from articulos where nombre = 'impresora';

-- FUNCIONES INTERNAS ASCII
select chr(100) from dual;
--tabla dual contiene una columna para seleccionar una pseudocolumna
select * from dual;
select ascii('d') from dual;
-- FUNCION CONCAT
select concat('buenas','tardes') from dual;
--FUNCION INITCAP
select initcap('buenas tardes') from dual;

--FUNCION LOWER
select lower('BUENAS TARDES') from dual;

-- FUNCION UPPER
select upper('buenas tardes') from dual;

-- FUNCION LPAD
select lpad('oracle',11,'abc') from dual;

-- FUNCION RPAD
select rpad('oracle',9,'abc') from dual;

-- FUNCION LTRIM
select ltrim('curso de oracle','cur') from dual;

-- FUNCION RTRIM
select rtrim('curso de oracle','cle') from dual;

-- FUNCION TRIM
select trim('  oracle  ') from dual;

--FUNCION REPLACE
select replace('www.oracle.com','w','p') from dual;

-- FUNCION SUBSTR
select substr('www.oracle.com',1,10) from dual;-- de izquierda a derecha
select substr('www.oracle.com',-3) from dual;-- de derecha a izquierda

-- FUNCION LENGTH
select length('www.oracle.com') as cantidad from dual;

-- FUNCION INSTR
select instr('curso de oracle sql','sql') from dual;

-- FUNCION TRANSLATE
select translate('curso de oracle', 'aoe', 'xyz') from dual;

-- FUNCIONES MATEMATICAS - ABS - VAOR ABSOLUTO
select abs(-50) from dual;

-- FUNCION CEIL - REDONDEA HACIA ARRIBA
select ceil(15.50) from dual;

--FUNCION FLOOR - REDONDEA HACIA ABAJO
select floor(13.90) from dual;

-- FUNCION MOD - DEVUELVE EL RESIDUO
select mod(10,3) from dual;

-- FUNCION POWER - POTENCIACION MATEMATICA
select power(10,3) from dual;

-- FUNCION ROUND - REDONDEO EN DECIMALES
select round(123.456,2) from dual;

-- FUNCION SIGN - NATURALEZA DE UN NUMERO NETERO
select sign(-100) from dual;

-- FUNCION TRUNC - CORTA DECIMALES SIN REDONDEAR
select trunc(1234.1239, 3) from dual;

-- FUNCION SQRT - RAIZ CUADRADA
select sqrt(27) from dual;

-- FUNCIONES DE FECHA Y HORA - ADD_MONTHS
select add_months(to_date('10/10/2020','dd/mm/yyyy'), 5) from dual;
select add_months(to_date('10/10/2020','dd/mm/yyyy'), -5) from dual;

-- FUNCION LAST_DAY
select last_day(to_date('09/02/2020','dd/mm/yyyy')) from dual;

-- FUNCION MONTHS_BETWEEN
select months_between(to_date('19/05/2020','dd/mm/yyyy'),
to_date('19/08/2020', 'dd/mm/yyyy')) as meses from dual;

-- FUNCION NEXT_DAY
select next_day(to_date('10/08/2020','dd/mm/yyyy'), 'LUNES') from dual;

-- FUNCION CURRENT_DATE
select current_date from dual;

-- FUNCION SYSDATE
select sysdate from dual;

-- FUNCION CURRENT_TIMESTAMP
select current_timestamp from dual;

-- FUNCION SYSTIMESTAMP
select systimestamp from dual;

-- FUNCION TO_CHAR
select to_char('10/10/2020') from dual;

-- ORDER BY
CREATE TABLE ARTICULO(
ID_ARTICULO	INT NOT NULL PRIMARY KEY,
ARTICULO VARCHAR2(50) NOT NULL,
COD_FABRICANTE	NUMBER(10) NOT NULL,
PESO NUMBER(4) NOT NULL,
CATEGORIA	VARCHAR2(50),
PRECIO_VENTA NUMBER(6,2),
PRECIO_COSTO NUMBER(6,2),
EXISTENCIAS	NUMBER(5)
);
     
insert into articulo values(2,'TALADRO WALT',1012546955,45,'CONSTRUCCION',400,560,20);
insert into articulo values(3,'ALICATE ACE',1012432365,23,'MECANICA',200,350.25,120);
insert into articulo values(4,'PALA SENIC',1012345678,16,'CONSTRUCCION',100,230.5,200);
insert into articulo values(5,'TALADRO MILLWAKEE',1012545210,55,'CONSTRUCCION',300,423.5,50);
insert into articulo values(6,'GRIFO APERTURA MANOS',1010023654,26,'PLOMERIA',400,560.25,90);
insert into articulo values(7,'FREGADERO MURAL',1015487966,200,'PLOMERIA',600,780.50,52);
insert into articulo values(8,'TALADRO ELECTRICO BOSCH',1025493013,34,'CONSTRUCCION',250,380.25,41);
insert into articulo values(9,'CEPILLO CONICO ONDULADO',1025852000,44,'EBANISTERIA',150,240.25,88);
insert into articulo values(10,'CEPILLO TAZA ONDULADO',122247789,49,'EBANISTERIA',148,240.50,90);
insert into articulo values(11,'CEPILLO TAZA TRENZADA',1016467985,	42,'EBANISTERIA',139,210.50,89);

select * from articulo;
select * from articulo order by id_articulo desc;
select * from articulo order by 4 desc;

-- AND, OR Y NOT
create table peliculas(
  codigo number(4) primary key,
  titulo varchar2(40) not null,
  actor varchar2(20),
  duracion number(3)
  );

 --Ingreso de registros

 insert into peliculas values(1020,'Mision imposible','Tom Cruise',120);
 insert into peliculas values(1021,'Harry Potter y la piedra filosofal','Daniel R.',180);
 insert into peliculas values(1022,'Harry Potter y la camara secreta','Daniel R.',190);
 insert into peliculas values(1200,'Mision imposible 2','Tom Cruise',120);
 insert into peliculas values(1234,'Mujer bonita','Richard Gere',120);
 insert into peliculas values(900,'Tootsie','D. Hoffman',90);
 insert into peliculas values(1300,'Un oso rojo','Julio Chavez',100);
 insert into peliculas values(1301,'Elsa y Fred','China Zorrilla',110);

select * from peliculas;
select * from peliculas where actor = 'Tom Cruise' or actor = 'Richard Gere';
select * from peliculas where actor = 'Tom Cruise' and duracion < 100;
select * from peliculas where not actor = 'Daniel R.';
select * from peliculas where actor = 'Daniel R.' and duracion > 180;
select * from peliculas where duracion >= 100 and duracion <= 120;

-- OPERADOR BETWEEN
drop table medicamentos;

 create table medicamentos(
  codigo number(6) not null,
  nombre varchar2(20),
  laboratorio varchar2(20),
  precio number(6,2),
  cantidad number(4),
  fechavencimiento date not null,
  primary key(codigo)
 );

 insert into medicamentos
  values(102,'Sertal','Roche',5.2,10,to_date('01/02/2020','dd/mm/yyyy'));
 insert into medicamentos 
  values(120,'Buscapina','Roche',4.10,200,to_date('01/12/2017','dd/mm/yyyy'));
 insert into medicamentos 
  values(230,'Amoxidal 500','Bayer',15.60,100,to_date('28/12/2017','dd/mm/yyyy'));
 insert into medicamentos
  values(250,'Paracetamol 500','Bago',1.90,20,to_date('01/02/2018','dd/mm/yyyy'));
 insert into medicamentos 
  values(350,'Bayaspirina','Bayer',2.10,150,to_date('01/12/2019','dd/mm/yyyy'));
 insert into medicamentos 
  values(456,'Amoxidal jarabe','Bayer',5.10,250,to_date('01/10/2020','dd/mm/yyyy'));

select * from medicamentos;
select * from medicamentos where precio between 5 and 15;
select * from medicamentos where cantidad between 100 and 200;
select * from medicamentos where fechavencimiento between '01-12-2017' and '01-02-2018';

-- OPERADOR IN
select * from medicamentos;
select * from medicamentos where laboratorio in ('Bayer', 'Bago');
select * from medicamentos where laboratorio not in ('Bayer', 'Bago');
select * from medicamentos where cantidad in (10, 200);
select * from medicamentos where extract(year from fechavencimiento) in (2019, 2020);

-- OPERADORES DE COMPARACION LIKE Y NOT LIKE
drop table empleados;
 
 create table empleados(
  nombre varchar2(30),
  documento char(8) not null,
  domicilio varchar2(30),
  fechaingreso date,
  seccion varchar2(20),
  sueldo number(6,2),
  primary key(documento)
 );
  insert into empleados
  values('Juan Perez','22333444','Colon 123',to_date('08/10/1990','dd/mm/yyyy'),'Gerencia',900.50);
 insert into empleados
  values('Ana Acosta','23444555','Caseros 987',to_date('18/12/1995','dd/mm/yyyy'),'Secretaria',590.30);
 insert into empleados
  values('Lucas Duarte','25666777','Sucre 235',to_date('15/05/2005','dd/mm/yyyy'),'Sistemas',790);
 insert into empleados
  values('Pamela Gonzalez','26777888','Sarmiento 873',to_date('12/02/1999','dd/mm/yyyy'),'Secretaria',550);
 insert into empleados
  values('Marcos Juarez','30000111','Rivadavia 801',to_date('22/09/2002','dd/mm/yyyy'),'Contaduria',630.70);
 insert into empleados
  values('Yolanda perez','35111222','Colon 180',to_date('08/10/1990','dd/mm/yyyy'),'Administracion',400);
 insert into empleados
  values('Rodolfo perez','35555888','Coronel Olmedo 588',to_date('28/05/1990','dd/mm/yyyy'),'Sistemas',800);

select * from empleados;
select * from empleados where nombre like '%erez%';
select * from empleados where nombre not like '%erez%';
select * from empleados where documento not like '%888';
select * from empleados where domicilio like 'Co%8%';
select * from empleados where seccion like 'S_________';
select * from empleados where sueldo like '%5__%';

-- FUNCION COUNT
drop table medicamentos;

 --crear nuevamente la tabla
  create table medicamentos(
  codigo number(5),
  nombre varchar2(20),
  laboratorio varchar2(20),
  precio number(6,2),
  cantidad number(3),
  fechavencimiento date not null,
  numerolote number(6) default null,
  primary key(codigo)
 );

--insertar datos en la tabla
 insert into medicamentos
  values(120,'Sertal','Roche',5.2,1,to_date('01/02/2015','dd/mm/yyyy'),123456);
 insert into medicamentos 
  values(220,'Buscapina','Roche',4.10,3,to_date('01/02/2016','dd/mm/yyyy'),null);
 insert into medicamentos 
  values(228,'Amoxidal 500','Bayer',15.60,100,to_date('01/05/2017','dd/mm/yyyy'),232566);
 insert into medicamentos
  values(324,'Paracetamol 500','Bago',1.90,20,to_date('01/02/2018','dd/mm/yyyy'),null);
 insert into medicamentos 
  values(587,'Bayaspirina',null,2.10,null,to_date('01/12/2019','dd/mm/yyyy'),556999); 
 insert into medicamentos 
  values(789,'Amoxidal jarabe','Bayer',null,null,to_date('15/12/2019','dd/mm/yyyy'),null);

select * from medicamentos;
select count(*) from medicamentos;







