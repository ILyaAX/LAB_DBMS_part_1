-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: human_resources_department | type: DATABASE --
DROP DATABASE IF EXISTS human_resources_department;
CREATE DATABASE human_resources_department
    WITH 
    OWNER = ax_postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- object: human_resources_department | type: SCHEMA --
-- DROP SCHEMA IF EXISTS human_resources_department CASCADE;
CREATE SCHEMA human_resources_department;
-- ddl-end --
-- ALTER SCHEMA human_resources_department OWNER TO postgres;
-- ddl-end --
COMMENT ON SCHEMA human_resources_department IS E'Тестовый вариант БД "Отдел кадров" к лабораторным СУБД 1 часть';
-- ddl-end --

SET search_path TO pg_catalog,public,human_resources_department;
-- ddl-end --

-- object: public.employee | type: TABLE --
-- DROP TABLE IF EXISTS public.employee CASCADE;
CREATE TABLE public.employee (
	id_employee smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	surname varchar(50) NOT NULL,
	name varchar(50) NOT NULL,
	patronymic varchar(50),
	address varchar(350) NOT NULL,
	date_birth date NOT NULL,
	military_duty varchar(50),
	CONSTRAINT employee_pk PRIMARY KEY (id_employee)

);
-- ddl-end --
-- ALTER TABLE public.employee OWNER TO postgres;
-- ddl-end --

-- object: public.passport | type: TABLE --
-- DROP TABLE IF EXISTS public.passport CASCADE;
CREATE TABLE public.passport (
	series numeric(4) NOT NULL,
	number numeric(6) NOT NULL,
	date_issue date NOT NULL,
	issued_by varchar(200) NOT NULL,
	id_employee_employee smallint
);
-- ddl-end --
-- ALTER TABLE public.passport OWNER TO postgres;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.passport DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.passport ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee_employee)
REFERENCES public.employee (id_employee) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: passport_uq | type: CONSTRAINT --
-- ALTER TABLE public.passport DROP CONSTRAINT IF EXISTS passport_uq CASCADE;
ALTER TABLE public.passport ADD CONSTRAINT passport_uq UNIQUE (id_employee_employee);
-- ddl-end --

-- object: public.family_info | type: TABLE --
-- DROP TABLE IF EXISTS public.family_info CASCADE;
CREATE TABLE public.family_info (
	marital_status varchar(100) NOT NULL,
	id_employee_employee smallint,
	id_family smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 32767 START WITH 1 CACHE 1 ),
	CONSTRAINT family_info_pk PRIMARY KEY (id_family)

);
-- ddl-end --
-- ALTER TABLE public.family_info OWNER TO postgres;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.family_info DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.family_info ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee_employee)
REFERENCES public.employee (id_employee) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: family_info_uq | type: CONSTRAINT --
-- ALTER TABLE public.family_info DROP CONSTRAINT IF EXISTS family_info_uq CASCADE;
ALTER TABLE public.family_info ADD CONSTRAINT family_info_uq UNIQUE (id_employee_employee);
-- ddl-end --

-- object: public.business_trip | type: TABLE --
-- DROP TABLE IF EXISTS public.business_trip CASCADE;
CREATE TABLE public.business_trip (
	id_trip integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	city varchar(100) NOT NULL,
	target varchar(350),
	date_begin date NOT NULL,
	CONSTRAINT business_trip_pk PRIMARY KEY (id_trip)

);
-- ddl-end --
-- ALTER TABLE public.business_trip OWNER TO postgres;
-- ddl-end --

-- object: public.trip_report | type: TABLE --
-- DROP TABLE IF EXISTS public.trip_report CASCADE;
CREATE TABLE public.trip_report (
	prepaid_expense money,
	id_employee_employee smallint,
	id_trip_business_trip integer,
	id_trip_report integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	CONSTRAINT trip_report_pk PRIMARY KEY (id_trip_report)

);
-- ddl-end --
-- ALTER TABLE public.trip_report OWNER TO postgres;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.trip_report DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.trip_report ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee_employee)
REFERENCES public.employee (id_employee) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: business_trip_fk | type: CONSTRAINT --
-- ALTER TABLE public.trip_report DROP CONSTRAINT IF EXISTS business_trip_fk CASCADE;
ALTER TABLE public.trip_report ADD CONSTRAINT business_trip_fk FOREIGN KEY (id_trip_business_trip)
REFERENCES public.business_trip (id_trip) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.department | type: TABLE --
-- DROP TABLE IF EXISTS public.department CASCADE;
CREATE TABLE public.department (
	id_department smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 1 MAXVALUE 32767 START WITH 1 CACHE 1 ),
	dep_name varchar(100),
	CONSTRAINT department_pk PRIMARY KEY (id_department)

);
-- ddl-end --
-- ALTER TABLE public.department OWNER TO postgres;
-- ddl-end --

-- object: public.staffing | type: TABLE --
-- DROP TABLE IF EXISTS public.staffing CASCADE;
CREATE TABLE public.staffing (
	id_staffing smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	title varchar(100) NOT NULL,
	rate money NOT NULL,
	salary money NOT NULL,
	id_department_department smallint,
	CONSTRAINT staffing_pk PRIMARY KEY (id_staffing)

);
-- ddl-end --
-- ALTER TABLE public.staffing OWNER TO postgres;
-- ddl-end --

-- object: department_fk | type: CONSTRAINT --
-- ALTER TABLE public.staffing DROP CONSTRAINT IF EXISTS department_fk CASCADE;
ALTER TABLE public.staffing ADD CONSTRAINT department_fk FOREIGN KEY (id_department_department)
REFERENCES public.department (id_department) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.reception | type: TABLE --
-- DROP TABLE IF EXISTS public.reception CASCADE;
CREATE TABLE public.reception (
	order_num smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 32767 START WITH 1 CACHE 1 ),
	order_date date NOT NULL,
	cause varchar(350) NOT NULL,
	CONSTRAINT reception_pk PRIMARY KEY (order_num)

);
-- ddl-end --
-- ALTER TABLE public.reception OWNER TO postgres;
-- ddl-end --

-- object: public."position" | type: TABLE --
-- DROP TABLE IF EXISTS public."position" CASCADE;
CREATE TABLE public."position" (
	amount_rate money NOT NULL,
	surcharge money,
	id_employee_employee smallint,
	order_num_reception smallint,
	id_staffing_staffing smallint
);
-- ddl-end --
-- ALTER TABLE public."position" OWNER TO postgres;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public."position" DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public."position" ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee_employee)
REFERENCES public.employee (id_employee) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: position_uq | type: CONSTRAINT --
-- ALTER TABLE public."position" DROP CONSTRAINT IF EXISTS position_uq CASCADE;
ALTER TABLE public."position" ADD CONSTRAINT position_uq UNIQUE (id_employee_employee);
-- ddl-end --

-- object: reception_fk | type: CONSTRAINT --
-- ALTER TABLE public."position" DROP CONSTRAINT IF EXISTS reception_fk CASCADE;
ALTER TABLE public."position" ADD CONSTRAINT reception_fk FOREIGN KEY (order_num_reception)
REFERENCES public.reception (order_num) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: staffing_fk | type: CONSTRAINT --
-- ALTER TABLE public."position" DROP CONSTRAINT IF EXISTS staffing_fk CASCADE;
ALTER TABLE public."position" ADD CONSTRAINT staffing_fk FOREIGN KEY (id_staffing_staffing)
REFERENCES public.staffing (id_staffing) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.expenses | type: TABLE --
-- DROP TABLE IF EXISTS public.expenses CASCADE;
CREATE TABLE public.expenses (
	id_expenses integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	purpose_payment varchar(350) NOT NULL,
	recipient varchar(150),
	sum money NOT NULL,
	id_trip_report_trip_report integer NOT NULL,
	CONSTRAINT expenses_pk PRIMARY KEY (id_expenses)

);
-- ddl-end --
-- ALTER TABLE public.expenses OWNER TO postgres;
-- ddl-end --

-- object: trip_report_fk | type: CONSTRAINT --
-- ALTER TABLE public.expenses DROP CONSTRAINT IF EXISTS trip_report_fk CASCADE;
ALTER TABLE public.expenses ADD CONSTRAINT trip_report_fk FOREIGN KEY (id_trip_report_trip_report)
REFERENCES public.trip_report (id_trip_report) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.family_members | type: TABLE --
-- DROP TABLE IF EXISTS public.family_members CASCADE;
CREATE TABLE public.family_members (
	id_members smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 32767 START WITH 1 CACHE 1 ),
	surname varchar(50),
	name varchar(50),
	patronomic varchar(50),
	relation varchar(50),
	date_birth date,
	dependents bool,
	id_family_family_info smallint,
	CONSTRAINT family_members_pk PRIMARY KEY (id_members)

);
-- ddl-end --
-- ALTER TABLE public.family_members OWNER TO postgres;
-- ddl-end --

-- object: family_info_fk | type: CONSTRAINT --
-- ALTER TABLE public.family_members DROP CONSTRAINT IF EXISTS family_info_fk CASCADE;
ALTER TABLE public.family_members ADD CONSTRAINT family_info_fk FOREIGN KEY (id_family_family_info)
REFERENCES public.family_info (id_family) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


