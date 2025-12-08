--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2025-12-07 17:49:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16968)
-- Name: analytical_exec; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA analytical_exec;


ALTER SCHEMA analytical_exec OWNER TO postgres;

--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA analytical_exec; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA analytical_exec IS 'Схема для обработки аналитики ';


--
-- TOC entry 8 (class 2615 OID 16974)
-- Name: directory_exec; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA directory_exec;


ALTER SCHEMA directory_exec OWNER TO postgres;

--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA directory_exec; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA directory_exec IS 'Схема для работы с директориями';


--
-- TOC entry 9 (class 2615 OID 16976)
-- Name: files_exec; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA files_exec;


ALTER SCHEMA files_exec OWNER TO postgres;

--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA files_exec; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA files_exec IS 'Схема для работы с файлами';


--
-- TOC entry 7 (class 2615 OID 16954)
-- Name: guides_exec; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA guides_exec;


ALTER SCHEMA guides_exec OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA guides_exec; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA guides_exec IS 'Схема для манипулирования данными справочников';


--
-- TOC entry 10 (class 2615 OID 16977)
-- Name: perceptron_exec; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA perceptron_exec;


ALTER SCHEMA perceptron_exec OWNER TO postgres;

--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA perceptron_exec; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA perceptron_exec IS 'Схема для работы с моделями НС';


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'Содержит все таблицы базы данных МГО';


--
-- TOC entry 285 (class 1255 OID 17054)
-- Name: add_diff_images(character varying, character varying, character varying, character varying, character varying, character varying, bigint, bigint); Type: PROCEDURE; Schema: analytical_exec; Owner: postgres
--

CREATE PROCEDURE analytical_exec.add_diff_images(IN name_forward_ character varying, IN name_back_ character varying, IN name_left_ character varying, IN name_right_ character varying, IN name_up_ character varying, IN name_down_ character varying, IN gobj_id_ bigint, IN directory_id_ bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
INSERT INTO public."Image"(name_file, date_create, type_image_id, perspective_id, directory_id, gobj_id)
VALUES
(name_forward_, CURRENT_DATE, 2, 1, directory_id_, gobj_id_),
(name_back_, CURRENT_DATE, 2, 2, directory_id_, gobj_id_),
(name_left_, CURRENT_DATE, 2, 3, directory_id_, gobj_id_),
(name_right_, CURRENT_DATE, 2, 4, directory_id_, gobj_id_),
(name_up_, CURRENT_DATE, 2, 5, directory_id_, gobj_id_),
(name_down_, CURRENT_DATE, 2, 6, directory_id_, gobj_id_);
END;$$;


ALTER PROCEDURE analytical_exec.add_diff_images(IN name_forward_ character varying, IN name_back_ character varying, IN name_left_ character varying, IN name_right_ character varying, IN name_up_ character varying, IN name_down_ character varying, IN gobj_id_ bigint, IN directory_id_ bigint) OWNER TO postgres;

--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 285
-- Name: PROCEDURE add_diff_images(IN name_forward_ character varying, IN name_back_ character varying, IN name_left_ character varying, IN name_right_ character varying, IN name_up_ character varying, IN name_down_ character varying, IN gobj_id_ bigint, IN directory_id_ bigint); Type: COMMENT; Schema: analytical_exec; Owner: postgres
--

COMMENT ON PROCEDURE analytical_exec.add_diff_images(IN name_forward_ character varying, IN name_back_ character varying, IN name_left_ character varying, IN name_right_ character varying, IN name_up_ character varying, IN name_down_ character varying, IN gobj_id_ bigint, IN directory_id_ bigint) IS 'Процедура добавления изображений-отличий для смоделированного ГО';


--
-- TOC entry 286 (class 1255 OID 17050)
-- Name: add_diff_value(bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: PROCEDURE; Schema: analytical_exec; Owner: postgres
--

CREATE PROCEDURE analytical_exec.add_diff_value(IN diff_count_vertex_ bigint, IN diff_count_edge_ bigint, IN diff_count_face_ bigint, IN diff_map_square_ bigint, IN diff_map_distance_ bigint, IN diff_map_angle_ bigint, IN diff_forward_ bigint, IN diff_back_ bigint, IN diff_left_ bigint, IN diff_right_ bigint, IN diff_down_ bigint, IN diff_up_ bigint, IN result_id_ bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
INSERT INTO public."Difference_value"(value, date_define, diff_id, u_measurement_id, result_id)
VALUES
(diff_count_vertex_, CURRENT_DATE, 1, 1, result_id_),
(diff_count_edge_, CURRENT_DATE, 2, 1, result_id_),
(diff_count_face_, CURRENT_DATE, 3, 1, result_id_),
(diff_map_square_, CURRENT_DATE, 4, 1, result_id_),
(diff_map_distance_, CURRENT_DATE, 5, 1, result_id_),
(diff_map_angle_, CURRENT_DATE, 6, 1, result_id_),
(diff_forward_, CURRENT_DATE, 7, 1, result_id_),
(diff_back_, CURRENT_DATE, 8, 1, result_id_),
(diff_left_, CURRENT_DATE, 9, 1, result_id_),
(diff_right_, CURRENT_DATE, 10, 1, result_id_),
(diff_up_, CURRENT_DATE, 11, 1, result_id_),
(diff_down_, CURRENT_DATE, 12, 1, result_id_);
END;$$;


ALTER PROCEDURE analytical_exec.add_diff_value(IN diff_count_vertex_ bigint, IN diff_count_edge_ bigint, IN diff_count_face_ bigint, IN diff_map_square_ bigint, IN diff_map_distance_ bigint, IN diff_map_angle_ bigint, IN diff_forward_ bigint, IN diff_back_ bigint, IN diff_left_ bigint, IN diff_right_ bigint, IN diff_down_ bigint, IN diff_up_ bigint, IN result_id_ bigint) OWNER TO postgres;

--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 286
-- Name: PROCEDURE add_diff_value(IN diff_count_vertex_ bigint, IN diff_count_edge_ bigint, IN diff_count_face_ bigint, IN diff_map_square_ bigint, IN diff_map_distance_ bigint, IN diff_map_angle_ bigint, IN diff_forward_ bigint, IN diff_back_ bigint, IN diff_left_ bigint, IN diff_right_ bigint, IN diff_down_ bigint, IN diff_up_ bigint, IN result_id_ bigint); Type: COMMENT; Schema: analytical_exec; Owner: postgres
--

COMMENT ON PROCEDURE analytical_exec.add_diff_value(IN diff_count_vertex_ bigint, IN diff_count_edge_ bigint, IN diff_count_face_ bigint, IN diff_map_square_ bigint, IN diff_map_distance_ bigint, IN diff_map_angle_ bigint, IN diff_forward_ bigint, IN diff_back_ bigint, IN diff_left_ bigint, IN diff_right_ bigint, IN diff_down_ bigint, IN diff_up_ bigint, IN result_id_ bigint) IS 'Процедура добавления отличий для записи Result_compare';


--
-- TOC entry 288 (class 1255 OID 17034)
-- Name: add_result_compare(bigint, bigint, bigint, bigint); Type: FUNCTION; Schema: analytical_exec; Owner: postgres
--

CREATE FUNCTION analytical_exec.add_result_compare(required_gobj_id_ bigint, modeled_gobj_id_ bigint, class_obj_id_ bigint, model_nn_id_ bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
	new_row_id INTEGER;
BEGIN
	INSERT INTO public."Result_compare"(date_compare, required_gobj_id, modeled_gobj_id, 
										class_obj_id, model_nn_id)
	VALUES(CURRENT_DATE, required_gobj_id_, modeled_gobj_id_, class_obj_id_, model_nn_id_)
	RETURNING id INTO new_row_id;
	RETURN new_row_id;
END;
$$;


ALTER FUNCTION analytical_exec.add_result_compare(required_gobj_id_ bigint, modeled_gobj_id_ bigint, class_obj_id_ bigint, model_nn_id_ bigint) OWNER TO postgres;

--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 288
-- Name: FUNCTION add_result_compare(required_gobj_id_ bigint, modeled_gobj_id_ bigint, class_obj_id_ bigint, model_nn_id_ bigint); Type: COMMENT; Schema: analytical_exec; Owner: postgres
--

COMMENT ON FUNCTION analytical_exec.add_result_compare(required_gobj_id_ bigint, modeled_gobj_id_ bigint, class_obj_id_ bigint, model_nn_id_ bigint) IS 'Функция добавления записи в таблицу Result_compare и возвращение id добавленной записи';


--
-- TOC entry 287 (class 1255 OID 17056)
-- Name: change_type_result_compare(bigint, bigint); Type: PROCEDURE; Schema: analytical_exec; Owner: postgres
--

CREATE PROCEDURE analytical_exec.change_type_result_compare(IN class_obj_id_ bigint, IN id_ bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
	UPDATE public."Result_compare"
	SET class_obj_id = class_obj_id_
	WHERE id = id_;
END;$$;


ALTER PROCEDURE analytical_exec.change_type_result_compare(IN class_obj_id_ bigint, IN id_ bigint) OWNER TO postgres;

--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 287
-- Name: PROCEDURE change_type_result_compare(IN class_obj_id_ bigint, IN id_ bigint); Type: COMMENT; Schema: analytical_exec; Owner: postgres
--

COMMENT ON PROCEDURE analytical_exec.change_type_result_compare(IN class_obj_id_ bigint, IN id_ bigint) IS 'Процедура изменения класса объекта записи Result_compare на класс к которому отнесла модель НС';


--
-- TOC entry 284 (class 1255 OID 17051)
-- Name: check_exist_result_compare(bigint); Type: FUNCTION; Schema: analytical_exec; Owner: postgres
--

CREATE FUNCTION analytical_exec.check_exist_result_compare(gobj_id_ bigint) RETURNS boolean
    LANGUAGE plpgsql
    AS $$DECLARE
	count_row INTEGER;
	exist_check BOOLEAN;
BEGIN
	SELECT COUNT(*) INTO count_row 
	FROM public."Result_compare"
	WHERE modeled_gobj_id = gobj_id_;
	
	IF count_row = 0 THEN 
		exist_check = false;
	ELSE 
		exist_check = true;
	END IF;
	
	RETURN exist_check;
END;$$;


ALTER FUNCTION analytical_exec.check_exist_result_compare(gobj_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 284
-- Name: FUNCTION check_exist_result_compare(gobj_id_ bigint); Type: COMMENT; Schema: analytical_exec; Owner: postgres
--

COMMENT ON FUNCTION analytical_exec.check_exist_result_compare(gobj_id_ bigint) IS 'Функция проверки наличия записи в  Result_compare для смоделированного файла ГО';


--
-- TOC entry 277 (class 1255 OID 17015)
-- Name: check_files_directory(bigint); Type: FUNCTION; Schema: directory_exec; Owner: postgres
--

CREATE FUNCTION directory_exec.check_files_directory(directory_id_ bigint) RETURNS TABLE(id bigint, exist boolean)
    LANGUAGE plpgsql
    AS $$DECLARE
 count_obj bigint;
BEGIN
	SELECT COUNT(*) INTO count_obj
	FROM public."Geometry_object" as gobj 
	WHERE gobj.directory_id = directory_id_
	GROUP BY gobj.directory_id;

	RETURN QUERY 
		SELECT pers.id as id,	
			CASE WHEN res_dir.perspective_id = 1 THEN true
				 WHEN res_dir.perspective_id = 2 THEN true
				 WHEN res_dir.perspective_id = 3 THEN true
				 WHEN res_dir.perspective_id = 4 THEN true
				 WHEN res_dir.perspective_id = 5 THEN true
				 WHEN res_dir.perspective_id = 6 THEN true
				 ELSE false
			END as exist
		FROM (	SELECT pers.id as pers_id, perspective_id
				FROM public."Image" as img
				RIGHT JOIN public."Perspective" as pers 
				ON pers.id = img.perspective_id
				LEFT JOIN public."Directory" as dir
				ON dir.id = img.directory_id   
				WHERE dir.id = directory_id_
			 ) as res_dir
		RIGHT JOIN public."Perspective" as pers
		ON pers.id = pers_id
		UNION
		SELECT 7 as id, 
			CASE WHEN count_obj > 0 THEN true
			ELSE false
			END as exist
		;
END
$$;


ALTER FUNCTION directory_exec.check_files_directory(directory_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 277
-- Name: FUNCTION check_files_directory(directory_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON FUNCTION directory_exec.check_files_directory(directory_id_ bigint) IS 'Функция проверки наличия файлов изображений и файла obj в выбранной директории';


--
-- TOC entry 263 (class 1255 OID 16975)
-- Name: directory_add(character varying, bigint); Type: PROCEDURE; Schema: directory_exec; Owner: postgres
--

CREATE PROCEDURE directory_exec.directory_add(IN name_ character varying, IN parent_id_ bigint)
    LANGUAGE sql
    AS $$SELECT SETVAL('public."Directory_id_seq"', (SELECT MAX(id) + 1 FROM public."Directory"), false);
INSERT INTO public."Directory" (name, parent_id)
VALUES (name_, parent_id_)$$;


ALTER PROCEDURE directory_exec.directory_add(IN name_ character varying, IN parent_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 263
-- Name: PROCEDURE directory_add(IN name_ character varying, IN parent_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON PROCEDURE directory_exec.directory_add(IN name_ character varying, IN parent_id_ bigint) IS 'Процедура добавления директории';


--
-- TOC entry 291 (class 1255 OID 17053)
-- Name: directory_add_ret_id(character varying, bigint); Type: FUNCTION; Schema: directory_exec; Owner: postgres
--

CREATE FUNCTION directory_exec.directory_add_ret_id(name_ character varying, parent_id_ bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
	new_row_id INTEGER;
BEGIN
	PERFORM SETVAL('public."Directory_id_seq"', (SELECT MAX(id) + 1 FROM public."Directory"), false);
	INSERT INTO public."Directory" (name, parent_id)
	VALUES (name_, parent_id_)
	RETURNING id INTO new_row_id;
	RETURN new_row_id;
END;
$$;


ALTER FUNCTION directory_exec.directory_add_ret_id(name_ character varying, parent_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 291
-- Name: FUNCTION directory_add_ret_id(name_ character varying, parent_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON FUNCTION directory_exec.directory_add_ret_id(name_ character varying, parent_id_ bigint) IS 'Функция добавления директории и возвращающая его id';


--
-- TOC entry 264 (class 1255 OID 16978)
-- Name: directory_change(bigint, character varying); Type: PROCEDURE; Schema: directory_exec; Owner: postgres
--

CREATE PROCEDURE directory_exec.directory_change(IN id_ bigint, IN name_ character varying)
    LANGUAGE sql
    AS $$UPDATE public."Directory"
SET name = name_
WHERE id = id_$$;


ALTER PROCEDURE directory_exec.directory_change(IN id_ bigint, IN name_ character varying) OWNER TO postgres;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 264
-- Name: PROCEDURE directory_change(IN id_ bigint, IN name_ character varying); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON PROCEDURE directory_exec.directory_change(IN id_ bigint, IN name_ character varying) IS 'Процедура изменения директории';


--
-- TOC entry 289 (class 1255 OID 17077)
-- Name: get_image_path(bigint); Type: FUNCTION; Schema: directory_exec; Owner: postgres
--

CREATE FUNCTION directory_exec.get_image_path(image_id_ bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
	directory_id_ INTEGER;
	path_img CHARACTER VARYING(255);
BEGIN
	SELECT img_t.directory_id INTO directory_id_ 
	FROM public."Image" as img_t
	WHERE img_t.id = image_id_;
	
		WITH RECURSIVE ancestor_path AS (
    	-- Нерекурсивная часть (anchor): Начинаем с целевой директории
			SELECT dir.id, 1 AS level, name, parent_id
			FROM public."Directory" as dir
			WHERE dir.id = directory_id_

			UNION ALL

			-- Рекурсивная часть: Поднимаемся вверх по иерархии к родителю
			SELECT d.id, ap.level + 1 AS level, d.name, d.parent_id
			FROM public."Directory" as d
			JOIN ancestor_path ap ON d.id = ap.parent_id
		)

		SELECT formed.d || '/' || img_t.name_file as path
		INTO path_img
		FROM
		(	SELECT STRING_AGG(name, '/'  ORDER BY level DESC) as d
			FROM ancestor_path
		) as formed, public."Image" as img_t 
		WHERE img_t.id = image_id_;
		
		RETURN path_img;
END
$$;


ALTER FUNCTION directory_exec.get_image_path(image_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 289
-- Name: FUNCTION get_image_path(image_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON FUNCTION directory_exec.get_image_path(image_id_ bigint) IS 'Функция возвращающая путь к выбранному изображению';


--
-- TOC entry 278 (class 1255 OID 17024)
-- Name: get_images_directory(bigint); Type: FUNCTION; Schema: directory_exec; Owner: postgres
--

CREATE FUNCTION directory_exec.get_images_directory(directory_id_ bigint) RETURNS TABLE(path text, perspective_id bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN

	RETURN QUERY 
		WITH RECURSIVE ancestor_path AS (
    	-- Нерекурсивная часть (anchor): Начинаем с целевой директории
			SELECT dir.id, 1 AS level, name, parent_id
			FROM public."Directory" as dir
			WHERE dir.id = directory_id_

			UNION ALL

			-- Рекурсивная часть: Поднимаемся вверх по иерархии к родителю
			SELECT d.id, ap.level + 1 AS level, d.name, d.parent_id
			FROM public."Directory" as d
			JOIN ancestor_path ap ON d.id = ap.parent_id
		)

		SELECT formed.d || '/' || img.name_file as path, img.perspective_id 
		FROM
		(	SELECT STRING_AGG(name, '/'  ORDER BY level DESC) as d
			FROM ancestor_path
		) as formed, public."Image" as img 
		WHERE img.directory_id = directory_id_;
END
$$;


ALTER FUNCTION directory_exec.get_images_directory(directory_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 278
-- Name: FUNCTION get_images_directory(directory_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON FUNCTION directory_exec.get_images_directory(directory_id_ bigint) IS 'Функция возвращающая пути к изображениям выбранной директории';


--
-- TOC entry 282 (class 1255 OID 17029)
-- Name: get_model_nn_directory(bigint); Type: FUNCTION; Schema: directory_exec; Owner: postgres
--

CREATE FUNCTION directory_exec.get_model_nn_directory(perceptron_id_ bigint) RETURNS TABLE(path text)
    LANGUAGE plpgsql
    AS $$
DECLARE
	directory_id_ INTEGER;
BEGIN
	SELECT nn.directory_id INTO directory_id_ 
	FROM public."Model_nn" as nn
	WHERE nn.id = perceptron_id_;
	
	RETURN QUERY 
		WITH RECURSIVE ancestor_path AS (
    	-- Нерекурсивная часть (anchor): Начинаем с целевой директории
			SELECT dir.id, 1 AS level, name, parent_id
			FROM public."Directory" as dir
			WHERE dir.id = directory_id_

			UNION ALL

			-- Рекурсивная часть: Поднимаемся вверх по иерархии к родителю
			SELECT d.id, ap.level + 1 AS level, d.name, d.parent_id
			FROM public."Directory" as d
			JOIN ancestor_path ap ON d.id = ap.parent_id
		)

		SELECT formed.d || '/' || m_nn.name_file as path
		FROM
		(	SELECT STRING_AGG(name, '/'  ORDER BY level DESC) as d
			FROM ancestor_path
		) as formed, public."Model_nn" as m_nn 
		WHERE m_nn.id = perceptron_id_;
END
$$;


ALTER FUNCTION directory_exec.get_model_nn_directory(perceptron_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 282
-- Name: FUNCTION get_model_nn_directory(perceptron_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON FUNCTION directory_exec.get_model_nn_directory(perceptron_id_ bigint) IS 'Функция возвращающая путь к выбранной модели НС';


--
-- TOC entry 290 (class 1255 OID 17147)
-- Name: get_obj_path(bigint); Type: FUNCTION; Schema: directory_exec; Owner: postgres
--

CREATE FUNCTION directory_exec.get_obj_path(gobj_id_ bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
	directory_id_ INTEGER;
	path_obj CHARACTER VARYING(255);
BEGIN
	SELECT gobj_t.directory_id INTO directory_id_ 
	FROM public."Geometry_object" as gobj_t
	WHERE gobj_t.id = gobj_id_;
	
		WITH RECURSIVE ancestor_path AS (
    	-- Нерекурсивная часть (anchor): Начинаем с целевой директории
			SELECT dir.id, 1 AS level, name, parent_id
			FROM public."Directory" as dir
			WHERE dir.id = directory_id_

			UNION ALL

			-- Рекурсивная часть: Поднимаемся вверх по иерархии к родителю
			SELECT d.id, ap.level + 1 AS level, d.name, d.parent_id
			FROM public."Directory" as d
			JOIN ancestor_path ap ON d.id = ap.parent_id
		)

		SELECT formed.d || '/' || gobj_t.name_file as path
		INTO path_obj
		FROM
		(	SELECT STRING_AGG(name, '/'  ORDER BY level DESC) as d
			FROM ancestor_path
		) as formed, public."Geometry_object" as gobj_t 
		WHERE gobj_t.id = gobj_id_;
		
		RETURN path_obj;
END
$$;


ALTER FUNCTION directory_exec.get_obj_path(gobj_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 290
-- Name: FUNCTION get_obj_path(gobj_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON FUNCTION directory_exec.get_obj_path(gobj_id_ bigint) IS 'Функция возвращающая путь к выбранному ГО';


--
-- TOC entry 283 (class 1255 OID 17035)
-- Name: get_object_directory(bigint); Type: FUNCTION; Schema: directory_exec; Owner: postgres
--

CREATE FUNCTION directory_exec.get_object_directory(directory_id_ bigint) RETURNS TABLE(path text, id bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN

	RETURN QUERY 
		WITH RECURSIVE ancestor_path AS (
    	-- Нерекурсивная часть (anchor): Начинаем с целевой директории
			SELECT dir.id, 1 AS level, name, parent_id
			FROM public."Directory" as dir
			WHERE dir.id = directory_id_

			UNION ALL

			-- Рекурсивная часть: Поднимаемся вверх по иерархии к родителю
			SELECT d.id, ap.level + 1 AS level, d.name, d.parent_id
			FROM public."Directory" as d
			JOIN ancestor_path ap ON d.id = ap.parent_id
		)

		SELECT formed.d || '/' || obj.name_file as path, obj.id 
		FROM
		(	SELECT STRING_AGG(name, '/'  ORDER BY level DESC) as d
			FROM ancestor_path
		) as formed, public."Geometry_object" as obj 
		WHERE obj.directory_id = directory_id_
		LIMIT 1;
END
$$;


ALTER FUNCTION directory_exec.get_object_directory(directory_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 283
-- Name: FUNCTION get_object_directory(directory_id_ bigint); Type: COMMENT; Schema: directory_exec; Owner: postgres
--

COMMENT ON FUNCTION directory_exec.get_object_directory(directory_id_ bigint) IS 'Функция возвращающая один ГО в выбранной директории';


--
-- TOC entry 265 (class 1255 OID 16979)
-- Name: add_file_gobject(character varying, bigint, bigint); Type: PROCEDURE; Schema: files_exec; Owner: postgres
--

CREATE PROCEDURE files_exec.add_file_gobject(IN name_file_ character varying, IN directory_id_ bigint, IN type_obj_id_ bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO public."Geometry_object" (name_file, date_create, directory_id, type_obj_id)
	VALUES (name_file_, CURRENT_DATE, directory_id_, type_obj_id_);
END;$$;


ALTER PROCEDURE files_exec.add_file_gobject(IN name_file_ character varying, IN directory_id_ bigint, IN type_obj_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 265
-- Name: PROCEDURE add_file_gobject(IN name_file_ character varying, IN directory_id_ bigint, IN type_obj_id_ bigint); Type: COMMENT; Schema: files_exec; Owner: postgres
--

COMMENT ON PROCEDURE files_exec.add_file_gobject(IN name_file_ character varying, IN directory_id_ bigint, IN type_obj_id_ bigint) IS 'Процедура добавления ГО';


--
-- TOC entry 279 (class 1255 OID 17017)
-- Name: add_file_image(character varying, bigint, bigint, bigint); Type: PROCEDURE; Schema: files_exec; Owner: postgres
--

CREATE PROCEDURE files_exec.add_file_image(IN name_file_ character varying, IN type_image_id_ bigint, IN perspective_id_ bigint, IN directory_id_ bigint)
    LANGUAGE plpgsql
    AS $$
DECLARE
	 gobj_id_formed bigint;
	 
BEGIN
	SELECT gobj.id INTO gobj_id_formed
	FROM public."Geometry_object" as gobj
	WHERE gobj.directory_id = directory_id_
	LIMIT 1;

	INSERT INTO public."Image" (name_file, date_create, type_image_id, perspective_id, directory_id, gobj_id)
	VALUES(name_file_, CURRENT_DATE, type_image_id_, perspective_id_, directory_id_, gobj_id_formed);
END;
$$;


ALTER PROCEDURE files_exec.add_file_image(IN name_file_ character varying, IN type_image_id_ bigint, IN perspective_id_ bigint, IN directory_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 279
-- Name: PROCEDURE add_file_image(IN name_file_ character varying, IN type_image_id_ bigint, IN perspective_id_ bigint, IN directory_id_ bigint); Type: COMMENT; Schema: files_exec; Owner: postgres
--

COMMENT ON PROCEDURE files_exec.add_file_image(IN name_file_ character varying, IN type_image_id_ bigint, IN perspective_id_ bigint, IN directory_id_ bigint) IS 'Процедура добавления изображения';


--
-- TOC entry 280 (class 1255 OID 17019)
-- Name: check_exist_gobj(bigint); Type: FUNCTION; Schema: files_exec; Owner: postgres
--

CREATE FUNCTION files_exec.check_exist_gobj(directory_id_ bigint) RETURNS boolean
    LANGUAGE plpgsql
    AS $$DECLARE
	exist bool;
	count_gobj bigint;
BEGIN
	SELECT COUNT(*) INTO count_gobj
	FROM public."Geometry_object" as gobj
	WHERE gobj.directory_id = directory_id_
	GROUP BY gobj.directory_id;
	
	IF count_gobj > 0 THEN
		exist = true;
	ELSE  exist = false;
	END IF;
	RETURN exist;

END;$$;


ALTER FUNCTION files_exec.check_exist_gobj(directory_id_ bigint) OWNER TO postgres;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 280
-- Name: FUNCTION check_exist_gobj(directory_id_ bigint); Type: COMMENT; Schema: files_exec; Owner: postgres
--

COMMENT ON FUNCTION files_exec.check_exist_gobj(directory_id_ bigint) IS 'Функция, проверяющая наличие ГО в выбранной директории';


--
-- TOC entry 255 (class 1255 OID 16960)
-- Name: difference_guide_add(character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.difference_guide_add(IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$SELECT SETVAL('public."Difference_guide_id_seq"', (SELECT MAX(id) + 1 FROM public."Difference_guide"), false);
INSERT INTO public."Difference_guide" (name, short_name)
VALUES (name_, short_name_)$$;


ALTER PROCEDURE guides_exec.difference_guide_add(IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 255
-- Name: PROCEDURE difference_guide_add(IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.difference_guide_add(IN name_ character varying, IN short_name_ character varying) IS 'Процедура добавления отличия в справочник';


--
-- TOC entry 257 (class 1255 OID 16970)
-- Name: difference_guide_upd(bigint, character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.difference_guide_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$UPDATE public."Difference_guide" 
SET name = name_, short_name = short_name_
WHERE id = id_$$;


ALTER PROCEDURE guides_exec.difference_guide_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 257
-- Name: PROCEDURE difference_guide_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.difference_guide_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) IS 'Процедура обновления отличия в справочнике';


--
-- TOC entry 253 (class 1255 OID 16956)
-- Name: perspective_add(character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.perspective_add(IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$
SELECT SETVAL('public."Perspective_id_seq"', (SELECT MAX(id) + 1 FROM public."Perspective"), false);
INSERT INTO public."Perspective" (name, short_name)
VALUES (name_, short_name_);
$$;


ALTER PROCEDURE guides_exec.perspective_add(IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 253
-- Name: PROCEDURE perspective_add(IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.perspective_add(IN name_ character varying, IN short_name_ character varying) IS 'Процедура добавления ракурса в справочник';


--
-- TOC entry 254 (class 1255 OID 16959)
-- Name: perspective_upd(bigint, character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.perspective_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$UPDATE public."Perspective" 
SET name = name_, short_name = short_name_
WHERE id = id_$$;


ALTER PROCEDURE guides_exec.perspective_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 254
-- Name: PROCEDURE perspective_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.perspective_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) IS 'Процедура обновления ракурса в справочнике';


--
-- TOC entry 256 (class 1255 OID 16962)
-- Name: type_image_add(character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.type_image_add(IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$SELECT SETVAL('public."Type_image_id_seq"', (SELECT MAX(id) + 1 FROM public."Type_image"), false);
INSERT INTO public."Type_image" (name, short_name)
VALUES (name_, short_name_)$$;


ALTER PROCEDURE guides_exec.type_image_add(IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 256
-- Name: PROCEDURE type_image_add(IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.type_image_add(IN name_ character varying, IN short_name_ character varying) IS 'Процедура добавления типа изображения в справочник';


--
-- TOC entry 258 (class 1255 OID 16971)
-- Name: type_image_upd(bigint, character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.type_image_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$UPDATE public."Type_image" 
SET name = name_, short_name = short_name_
WHERE id = id_$$;


ALTER PROCEDURE guides_exec.type_image_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 258
-- Name: PROCEDURE type_image_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.type_image_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) IS 'Процедура обновления типа изображения в справочнике';


--
-- TOC entry 261 (class 1255 OID 16964)
-- Name: type_object_add(character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.type_object_add(IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$SELECT SETVAL('public."Type_object_id_seq"', (SELECT MAX(id) + 1 FROM public."Type_object"), false);
INSERT INTO public."Type_object" (name, short_name)
VALUES (name_, short_name_)$$;


ALTER PROCEDURE guides_exec.type_object_add(IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 261
-- Name: PROCEDURE type_object_add(IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.type_object_add(IN name_ character varying, IN short_name_ character varying) IS 'Процедура добавления типа объекта в справочник';


--
-- TOC entry 259 (class 1255 OID 16972)
-- Name: type_object_upd(bigint, character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.type_object_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$UPDATE public."Type_object" 
SET name = name_, short_name = short_name_
WHERE id = id_$$;


ALTER PROCEDURE guides_exec.type_object_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 259
-- Name: PROCEDURE type_object_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.type_object_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) IS 'Процедура обновления типа объекта в справочнике';


--
-- TOC entry 262 (class 1255 OID 16966)
-- Name: unit_measurement_add(character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.unit_measurement_add(IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$SELECT SETVAL('public."Unit_measurement_id_seq"', (SELECT MAX(id) + 1 FROM public."Unit_measurement"), false);
INSERT INTO public."Unit_measurement" (name, short_name)
VALUES (name_, short_name_)$$;


ALTER PROCEDURE guides_exec.unit_measurement_add(IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 262
-- Name: PROCEDURE unit_measurement_add(IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.unit_measurement_add(IN name_ character varying, IN short_name_ character varying) IS 'Процедура добавления единицы измерения в справочник';


--
-- TOC entry 260 (class 1255 OID 16973)
-- Name: unit_measurement_upd(bigint, character varying, character varying); Type: PROCEDURE; Schema: guides_exec; Owner: postgres
--

CREATE PROCEDURE guides_exec.unit_measurement_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying)
    LANGUAGE sql
    AS $$UPDATE public."Unit_measurement" 
SET name = name_, short_name = short_name_
WHERE id = id_$$;


ALTER PROCEDURE guides_exec.unit_measurement_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 260
-- Name: PROCEDURE unit_measurement_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying); Type: COMMENT; Schema: guides_exec; Owner: postgres
--

COMMENT ON PROCEDURE guides_exec.unit_measurement_upd(IN id_ bigint, IN name_ character varying, IN short_name_ character varying) IS 'Процедура обновления единицы измерения в справочнике';


--
-- TOC entry 281 (class 1255 OID 17021)
-- Name: add_modell_nn(character varying, bigint, character varying, bigint); Type: PROCEDURE; Schema: perceptron_exec; Owner: postgres
--

CREATE PROCEDURE perceptron_exec.add_modell_nn(IN name_file_ character varying, IN directory_id_ bigint, IN name_file_history_ character varying, IN err_resolve_ bigint)
    LANGUAGE sql
    AS $$INSERT INTO public."Model_nn" (name_file, date_create, directory_id, name_file_history, err_resolve)
VALUES(name_file_, CURRENT_DATE, directory_id_, name_file_history_, err_resolve_)$$;


ALTER PROCEDURE perceptron_exec.add_modell_nn(IN name_file_ character varying, IN directory_id_ bigint, IN name_file_history_ character varying, IN err_resolve_ bigint) OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 281
-- Name: PROCEDURE add_modell_nn(IN name_file_ character varying, IN directory_id_ bigint, IN name_file_history_ character varying, IN err_resolve_ bigint); Type: COMMENT; Schema: perceptron_exec; Owner: postgres
--

COMMENT ON PROCEDURE perceptron_exec.add_modell_nn(IN name_file_ character varying, IN directory_id_ bigint, IN name_file_history_ character varying, IN err_resolve_ bigint) IS 'Процедура добавления модели НС';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16784)
-- Name: Difference_guide; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Difference_guide" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    short_name character varying(30)
);


ALTER TABLE public."Difference_guide" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16932)
-- Name: Difference_guide_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Difference_guide_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Difference_guide_id_seq" OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 231
-- Name: Difference_guide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Difference_guide_id_seq" OWNED BY public."Difference_guide".id;


--
-- TOC entry 221 (class 1259 OID 16787)
-- Name: Difference_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Difference_value" (
    id bigint NOT NULL,
    value bigint NOT NULL,
    date_define date NOT NULL,
    diff_id bigint NOT NULL,
    u_measurement_id bigint NOT NULL,
    result_id bigint NOT NULL
);


ALTER TABLE public."Difference_value" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16936)
-- Name: Difference_value_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Difference_value_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Difference_value_id_seq" OWNER TO postgres;

--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 233
-- Name: Difference_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Difference_value_id_seq" OWNED BY public."Difference_value".id;


--
-- TOC entry 222 (class 1259 OID 16790)
-- Name: Directory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Directory" (
    id bigint NOT NULL,
    name character varying(250) NOT NULL,
    parent_id bigint
);


ALTER TABLE public."Directory" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16938)
-- Name: Directory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Directory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Directory_id_seq" OWNER TO postgres;

--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 234
-- Name: Directory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Directory_id_seq" OWNED BY public."Directory".id;


--
-- TOC entry 223 (class 1259 OID 16793)
-- Name: Geometry_object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Geometry_object" (
    id bigint NOT NULL,
    name_file character varying(50) NOT NULL,
    date_create date NOT NULL,
    directory_id bigint NOT NULL,
    type_obj_id bigint NOT NULL
);


ALTER TABLE public."Geometry_object" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16940)
-- Name: Geometry_object_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Geometry_object_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Geometry_object_id_seq" OWNER TO postgres;

--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 235
-- Name: Geometry_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Geometry_object_id_seq" OWNED BY public."Geometry_object".id;


--
-- TOC entry 224 (class 1259 OID 16796)
-- Name: Image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Image" (
    id bigint NOT NULL,
    name_file character varying(50) NOT NULL,
    date_create date NOT NULL,
    type_image_id bigint NOT NULL,
    perspective_id bigint NOT NULL,
    directory_id bigint NOT NULL,
    gobj_id bigint NOT NULL
);


ALTER TABLE public."Image" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16942)
-- Name: Image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Image_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Image_id_seq" OWNER TO postgres;

--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 236
-- Name: Image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Image_id_seq" OWNED BY public."Image".id;


--
-- TOC entry 225 (class 1259 OID 16799)
-- Name: Model_nn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Model_nn" (
    id bigint NOT NULL,
    name_file character varying(250) NOT NULL,
    date_create date NOT NULL,
    directory_id bigint NOT NULL,
    name_file_history character varying(250) NOT NULL,
    err_resolve bigint NOT NULL
);


ALTER TABLE public."Model_nn" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16944)
-- Name: Model_nn_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Model_nn_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Model_nn_id_seq" OWNER TO postgres;

--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 237
-- Name: Model_nn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Model_nn_id_seq" OWNED BY public."Model_nn".id;


--
-- TOC entry 226 (class 1259 OID 16802)
-- Name: Perspective; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Perspective" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    short_name character varying(30)
);


ALTER TABLE public."Perspective" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16934)
-- Name: Perspective_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Perspective_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Perspective_id_seq" OWNER TO postgres;

--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 232
-- Name: Perspective_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Perspective_id_seq" OWNED BY public."Perspective".id;


--
-- TOC entry 227 (class 1259 OID 16805)
-- Name: Result_compare; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Result_compare" (
    id bigint NOT NULL,
    date_compare date NOT NULL,
    required_gobj_id bigint NOT NULL,
    modeled_gobj_id bigint NOT NULL,
    class_obj_id bigint NOT NULL,
    model_nn_id bigint NOT NULL
);


ALTER TABLE public."Result_compare" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16946)
-- Name: Result_compare_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Result_compare_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Result_compare_id_seq" OWNER TO postgres;

--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 238
-- Name: Result_compare_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Result_compare_id_seq" OWNED BY public."Result_compare".id;


--
-- TOC entry 228 (class 1259 OID 16808)
-- Name: Type_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Type_image" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    short_name character varying(30)
);


ALTER TABLE public."Type_image" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16948)
-- Name: Type_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Type_image_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Type_image_id_seq" OWNER TO postgres;

--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 239
-- Name: Type_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Type_image_id_seq" OWNED BY public."Type_image".id;


--
-- TOC entry 229 (class 1259 OID 16811)
-- Name: Type_object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Type_object" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    short_name character varying(30)
);


ALTER TABLE public."Type_object" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16950)
-- Name: Type_object_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Type_object_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Type_object_id_seq" OWNER TO postgres;

--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 240
-- Name: Type_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Type_object_id_seq" OWNED BY public."Type_object".id;


--
-- TOC entry 230 (class 1259 OID 16814)
-- Name: Unit_measurement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Unit_measurement" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    short_name character varying(30)
);


ALTER TABLE public."Unit_measurement" OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16952)
-- Name: Unit_measurement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Unit_measurement_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Unit_measurement_id_seq" OWNER TO postgres;

--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 241
-- Name: Unit_measurement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Unit_measurement_id_seq" OWNED BY public."Unit_measurement".id;


--
-- TOC entry 251 (class 1259 OID 17143)
-- Name: diffs_by_result; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.diffs_by_result AS
 SELECT d_g.name AS d_v_name,
    d_v.value AS d_v_value,
    d_v.result_id AS d_v_result_id
   FROM (public."Difference_value" d_v
     LEFT JOIN public."Difference_guide" d_g ON ((d_v.diff_id = d_g.id)));


ALTER VIEW public.diffs_by_result OWNER TO postgres;

--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 251
-- Name: VIEW diffs_by_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.diffs_by_result IS 'Представление отличий, хранящихся во всех результатах сравнения';


--
-- TOC entry 252 (class 1259 OID 17149)
-- Name: dirs_without_compare; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.dirs_without_compare AS
SELECT
    NULL::bigint AS id,
    NULL::character varying(250) AS name,
    NULL::bigint AS parent_id;


ALTER VIEW public.dirs_without_compare OWNER TO postgres;

--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 252
-- Name: VIEW dirs_without_compare; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.dirs_without_compare IS 'Представление всех каталогов за исключением каталогов, в которых хранятся изображения-отличия';


--
-- TOC entry 244 (class 1259 OID 17073)
-- Name: gobj_modeled_by_result; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.gobj_modeled_by_result AS
 SELECT gobj.id AS gobj_id,
    t_o.name AS t_o_name,
    t_o.id AS t_o_id,
    gobj.date_create,
    gobj.name_file AS go_file,
    r_c.id AS r_c_id,
    directory_exec.get_obj_path(gobj.id) AS gobj_path
   FROM ((public."Geometry_object" gobj
     LEFT JOIN public."Type_object" t_o ON ((gobj.type_obj_id = t_o.id)))
     LEFT JOIN public."Result_compare" r_c ON ((gobj.id = r_c.modeled_gobj_id)));


ALTER VIEW public.gobj_modeled_by_result OWNER TO postgres;

--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 244
-- Name: VIEW gobj_modeled_by_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.gobj_modeled_by_result IS 'Представление, содержащее информацию о смоделированном ГО (для формирования отчета сравнения)';


--
-- TOC entry 243 (class 1259 OID 17069)
-- Name: gobj_required_by_result; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.gobj_required_by_result AS
 SELECT gobj.id AS gobj_id,
    t_o.name AS t_o_name,
    t_o.id AS t_o_id,
    gobj.date_create,
    gobj.name_file AS go_file,
    r_c.id AS r_c_id,
    directory_exec.get_obj_path(gobj.id) AS gobj_path
   FROM ((public."Geometry_object" gobj
     LEFT JOIN public."Type_object" t_o ON ((gobj.type_obj_id = t_o.id)))
     LEFT JOIN public."Result_compare" r_c ON ((gobj.id = r_c.required_gobj_id)));


ALTER VIEW public.gobj_required_by_result OWNER TO postgres;

--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 243
-- Name: VIEW gobj_required_by_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.gobj_required_by_result IS 'Представление, содержащее информацию о требуемом ГО (для формирования отчета сравнения)';


--
-- TOC entry 247 (class 1259 OID 17120)
-- Name: imgs_diff_path_by_result; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.imgs_diff_path_by_result AS
 SELECT t_i.name AS t_i_name,
    r_c.id AS r_c_id,
    pers.id AS pers_id,
    pers.name AS pers_name,
    ( SELECT directory_exec.get_image_path(img.id) AS get_image_path) AS path
   FROM ((((public."Image" img
     LEFT JOIN public."Perspective" pers ON ((img.perspective_id = pers.id)))
     LEFT JOIN public."Type_image" t_i ON ((img.type_image_id = t_i.id)))
     LEFT JOIN public."Geometry_object" gobj ON ((gobj.id = img.gobj_id)))
     LEFT JOIN public."Result_compare" r_c ON ((gobj.id = r_c.modeled_gobj_id)))
  WHERE (t_i.id = 2);


ALTER VIEW public.imgs_diff_path_by_result OWNER TO postgres;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 247
-- Name: VIEW imgs_diff_path_by_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.imgs_diff_path_by_result IS 'Представление, содержащее информацию о пути к изображениям-отличиям(для формирования отчета сравнения)';


--
-- TOC entry 246 (class 1259 OID 17115)
-- Name: imgs_real_mod_path_by_result; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.imgs_real_mod_path_by_result AS
 SELECT t_i.name AS t_i_name,
    r_c.id AS r_c_id,
    pers.id AS pers_id,
    pers.name AS pers_name,
    ( SELECT directory_exec.get_image_path(img.id) AS get_image_path) AS path
   FROM ((((public."Image" img
     LEFT JOIN public."Perspective" pers ON ((img.perspective_id = pers.id)))
     LEFT JOIN public."Type_image" t_i ON ((img.type_image_id = t_i.id)))
     LEFT JOIN public."Geometry_object" gobj ON ((gobj.id = img.gobj_id)))
     LEFT JOIN public."Result_compare" r_c ON ((gobj.id = r_c.modeled_gobj_id)))
  WHERE (t_i.id = 1);


ALTER VIEW public.imgs_real_mod_path_by_result OWNER TO postgres;

--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 246
-- Name: VIEW imgs_real_mod_path_by_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.imgs_real_mod_path_by_result IS 'Представление, содержащее информацию о пути к фактическим изображениям смоделированного ГО(для формирования отчета сравнения)';


--
-- TOC entry 245 (class 1259 OID 17110)
-- Name: imgs_real_req_path_by_result; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.imgs_real_req_path_by_result AS
 SELECT t_i.name AS t_i_name,
    r_c.id AS r_c_id,
    pers.id AS pers_id,
    pers.name AS pers_name,
    ( SELECT directory_exec.get_image_path(img.id) AS get_image_path) AS path
   FROM ((((public."Image" img
     LEFT JOIN public."Perspective" pers ON ((img.perspective_id = pers.id)))
     LEFT JOIN public."Type_image" t_i ON ((img.type_image_id = t_i.id)))
     LEFT JOIN public."Geometry_object" gobj ON ((gobj.id = img.gobj_id)))
     LEFT JOIN public."Result_compare" r_c ON ((gobj.id = r_c.required_gobj_id)))
  WHERE (t_i.id = 1);


ALTER VIEW public.imgs_real_req_path_by_result OWNER TO postgres;

--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 245
-- Name: VIEW imgs_real_req_path_by_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.imgs_real_req_path_by_result IS 'Представление, содержащее информацию о пути к фактическим изображениям требуемого ГО(для формирования отчета сравнения)';


--
-- TOC entry 248 (class 1259 OID 17125)
-- Name: modeled_files_obj_dir; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.modeled_files_obj_dir AS
 SELECT dir.id,
    dir.name,
    dir.parent_id,
    r_c.id AS r_c_id
   FROM ((public."Directory" dir
     LEFT JOIN public."Geometry_object" g_o ON ((dir.id = g_o.directory_id)))
     LEFT JOIN public."Result_compare" r_c ON ((g_o.id = r_c.modeled_gobj_id)))
  WHERE ((g_o.type_obj_id = 1) AND (r_c.id IS NULL))
  GROUP BY dir.id, dir.name, dir.parent_id, r_c.id
  ORDER BY dir.id;


ALTER VIEW public.modeled_files_obj_dir OWNER TO postgres;

--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 248
-- Name: VIEW modeled_files_obj_dir; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.modeled_files_obj_dir IS 'Представление, содержащее список директорий для смоделированных ГО(для выбора смоделированного ГО перед формированием отчета)';


--
-- TOC entry 249 (class 1259 OID 17129)
-- Name: required_files_obj_dir; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.required_files_obj_dir AS
 SELECT dir.id,
    dir.name,
    dir.parent_id
   FROM (public."Directory" dir
     LEFT JOIN public."Geometry_object" g_o ON ((dir.id = g_o.directory_id)))
  WHERE (g_o.type_obj_id = 2)
  GROUP BY dir.id, dir.name, dir.parent_id
  ORDER BY dir.id;


ALTER VIEW public.required_files_obj_dir OWNER TO postgres;

--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 249
-- Name: VIEW required_files_obj_dir; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.required_files_obj_dir IS 'Представление, содержащее список директорий для требуемого ГО(для выбора требуемого ГО перед формированием отчета)';


--
-- TOC entry 250 (class 1259 OID 17138)
-- Name: result_compare_report; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.result_compare_report AS
 SELECT r_c.id AS r_c_id,
    r_c.date_compare AS r_c_date,
    g_o_req.name_file AS req_file,
    g_o_mod.name_file AS mod_file,
    t_o.name AS t_o_name,
    m_nn.name_file
   FROM ((((public."Result_compare" r_c
     LEFT JOIN public."Geometry_object" g_o_req ON ((r_c.required_gobj_id = g_o_req.id)))
     LEFT JOIN public."Geometry_object" g_o_mod ON ((r_c.modeled_gobj_id = g_o_mod.id)))
     LEFT JOIN public."Type_object" t_o ON ((r_c.class_obj_id = t_o.id)))
     LEFT JOIN public."Model_nn" m_nn ON ((r_c.model_nn_id = m_nn.id)));


ALTER VIEW public.result_compare_report OWNER TO postgres;

--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 250
-- Name: VIEW result_compare_report; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.result_compare_report IS 'Представление, содержащее все отчеты сравнения (для формирования отчета)';


--
-- TOC entry 242 (class 1259 OID 17057)
-- Name: result_compare_with_model_nn; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.result_compare_with_model_nn AS
 SELECT r_c.id AS r_c_id,
    r_c.date_compare,
    t_o.name,
    m_nn.id AS m_nn_id,
    m_nn.name_file,
    m_nn.date_create,
    m_nn.err_resolve
   FROM ((public."Result_compare" r_c
     LEFT JOIN public."Type_object" t_o ON ((t_o.id = r_c.class_obj_id)))
     LEFT JOIN public."Model_nn" m_nn ON ((m_nn.id = r_c.model_nn_id)));


ALTER VIEW public.result_compare_with_model_nn OWNER TO postgres;

--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 242
-- Name: VIEW result_compare_with_model_nn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.result_compare_with_model_nn IS 'Представление, содержащее результат сравнения и информацию о модели НС (для формирования отчета сравнения)';


--
-- TOC entry 4761 (class 2604 OID 16933)
-- Name: Difference_guide id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Difference_guide" ALTER COLUMN id SET DEFAULT nextval('public."Difference_guide_id_seq"'::regclass);


--
-- TOC entry 4762 (class 2604 OID 16937)
-- Name: Difference_value id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Difference_value" ALTER COLUMN id SET DEFAULT nextval('public."Difference_value_id_seq"'::regclass);


--
-- TOC entry 4763 (class 2604 OID 16939)
-- Name: Directory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Directory" ALTER COLUMN id SET DEFAULT nextval('public."Directory_id_seq"'::regclass);


--
-- TOC entry 4764 (class 2604 OID 16941)
-- Name: Geometry_object id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Geometry_object" ALTER COLUMN id SET DEFAULT nextval('public."Geometry_object_id_seq"'::regclass);


--
-- TOC entry 4765 (class 2604 OID 16943)
-- Name: Image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image" ALTER COLUMN id SET DEFAULT nextval('public."Image_id_seq"'::regclass);


--
-- TOC entry 4766 (class 2604 OID 16945)
-- Name: Model_nn id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Model_nn" ALTER COLUMN id SET DEFAULT nextval('public."Model_nn_id_seq"'::regclass);


--
-- TOC entry 4767 (class 2604 OID 16935)
-- Name: Perspective id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Perspective" ALTER COLUMN id SET DEFAULT nextval('public."Perspective_id_seq"'::regclass);


--
-- TOC entry 4768 (class 2604 OID 16947)
-- Name: Result_compare id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result_compare" ALTER COLUMN id SET DEFAULT nextval('public."Result_compare_id_seq"'::regclass);


--
-- TOC entry 4769 (class 2604 OID 16949)
-- Name: Type_image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Type_image" ALTER COLUMN id SET DEFAULT nextval('public."Type_image_id_seq"'::regclass);


--
-- TOC entry 4770 (class 2604 OID 16951)
-- Name: Type_object id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Type_object" ALTER COLUMN id SET DEFAULT nextval('public."Type_object_id_seq"'::regclass);


--
-- TOC entry 4771 (class 2604 OID 16953)
-- Name: Unit_measurement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unit_measurement" ALTER COLUMN id SET DEFAULT nextval('public."Unit_measurement_id_seq"'::regclass);


--
-- TOC entry 4963 (class 0 OID 16784)
-- Dependencies: 220
-- Data for Name: Difference_guide; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Difference_guide" (id, name, short_name) FROM stdin;
1	Отличие кол-ва вершин	кол-во вершин
2	Отличие кол-ва ребер	кол-во ребер
3	Отличие кол-ва граней	кол-во граней
4	Отличие карт площадей граней	площади граней
5	Отличие карт длин ребер	длины ребер
6	Отличие карт углов между ребрами	 углы между ребрами
7	Отличие вида спереди	вид спереди
8	Отличие вида сзади	вид сзади
9	Отличие вида слева	вид слева
10	Отличие вида справа	вид справа
13	Новый вид	вид
11	Отличие вида сверху	вид сверху
12	Отличие вида снизу	вид снизу
\.


--
-- TOC entry 4964 (class 0 OID 16787)
-- Dependencies: 221
-- Data for Name: Difference_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Difference_value" (id, value, date_define, diff_id, u_measurement_id, result_id) FROM stdin;
109	0	2025-11-23	1	1	51
110	0	2025-11-23	2	1	51
111	0	2025-11-23	3	1	51
112	0	2025-11-23	4	1	51
113	0	2025-11-23	5	1	51
114	0	2025-11-23	6	1	51
115	0	2025-11-23	7	1	51
116	0	2025-11-23	8	1	51
117	0	2025-11-23	9	1	51
118	0	2025-11-23	10	1	51
119	0	2025-11-23	11	1	51
120	0	2025-11-23	12	1	51
49	1	2025-11-23	1	1	8
50	1	2025-11-23	2	1	8
51	1	2025-11-23	3	1	8
52	1	2025-11-23	4	1	8
53	1	2025-11-23	5	1	8
54	1	2025-11-23	6	1	8
55	1	2025-11-23	7	1	8
56	1	2025-11-23	8	1	8
57	1	2025-11-23	9	1	8
58	1	2025-11-23	10	1	8
59	1	2025-11-23	11	1	8
60	1	2025-11-23	12	1	8
121	0	2025-11-23	1	1	52
122	0	2025-11-23	2	1	52
123	0	2025-11-23	3	1	52
124	0	2025-11-23	4	1	52
125	0	2025-11-23	5	1	52
126	0	2025-11-23	6	1	52
127	0	2025-11-23	7	1	52
128	0	2025-11-23	8	1	52
129	0	2025-11-23	9	1	52
130	0	2025-11-23	10	1	52
131	0	2025-11-23	11	1	52
132	0	2025-11-23	12	1	52
133	0	2025-11-23	1	1	53
134	0	2025-11-23	2	1	53
135	0	2025-11-23	3	1	53
136	0	2025-11-23	4	1	53
137	0	2025-11-23	5	1	53
138	0	2025-11-23	6	1	53
139	0	2025-11-23	7	1	53
140	0	2025-11-23	8	1	53
141	0	2025-11-23	9	1	53
142	0	2025-11-23	10	1	53
143	0	2025-11-23	11	1	53
144	0	2025-11-23	12	1	53
145	0	2025-11-23	1	1	54
146	0	2025-11-23	2	1	54
147	0	2025-11-23	3	1	54
148	0	2025-11-23	4	1	54
149	0	2025-11-23	5	1	54
150	0	2025-11-23	6	1	54
151	0	2025-11-23	7	1	54
152	0	2025-11-23	8	1	54
153	0	2025-11-23	9	1	54
154	0	2025-11-23	10	1	54
155	0	2025-11-23	11	1	54
156	0	2025-11-23	12	1	54
157	0	2025-11-23	1	1	56
158	0	2025-11-23	2	1	56
159	0	2025-11-23	3	1	56
160	0	2025-11-23	4	1	56
161	0	2025-11-23	5	1	56
162	0	2025-11-23	6	1	56
163	0	2025-11-23	7	1	56
164	0	2025-11-23	8	1	56
165	0	2025-11-23	9	1	56
166	0	2025-11-23	10	1	56
167	0	2025-11-23	11	1	56
168	0	2025-11-23	12	1	56
169	0	2025-12-03	1	1	57
170	0	2025-12-03	2	1	57
171	0	2025-12-03	3	1	57
172	0	2025-12-03	4	1	57
173	0	2025-12-03	5	1	57
174	0	2025-12-03	6	1	57
175	0	2025-12-03	7	1	57
176	0	2025-12-03	8	1	57
177	0	2025-12-03	9	1	57
178	0	2025-12-03	10	1	57
179	0	2025-12-03	11	1	57
180	0	2025-12-03	12	1	57
181	0	2025-12-03	1	1	63
182	0	2025-12-03	2	1	63
183	0	2025-12-03	3	1	63
184	0	2025-12-03	4	1	63
185	0	2025-12-03	5	1	63
186	0	2025-12-03	6	1	63
187	0	2025-12-03	7	1	63
188	0	2025-12-03	8	1	63
189	0	2025-12-03	9	1	63
190	0	2025-12-03	10	1	63
191	0	2025-12-03	11	1	63
192	0	2025-12-03	12	1	63
193	80	2025-12-03	1	1	64
194	85	2025-12-03	2	1	64
195	85	2025-12-03	3	1	64
196	100	2025-12-03	4	1	64
197	100	2025-12-03	5	1	64
198	100	2025-12-03	6	1	64
199	70	2025-12-03	7	1	64
200	77	2025-12-03	8	1	64
201	0	2025-12-03	9	1	64
202	0	2025-12-03	10	1	64
203	73	2025-12-03	11	1	64
204	0	2025-12-03	12	1	64
205	80	2025-12-03	1	1	65
206	85	2025-12-03	2	1	65
207	85	2025-12-03	3	1	65
208	100	2025-12-03	4	1	65
209	100	2025-12-03	5	1	65
210	100	2025-12-03	6	1	65
211	70	2025-12-03	7	1	65
212	77	2025-12-03	8	1	65
213	0	2025-12-03	9	1	65
214	0	2025-12-03	10	1	65
215	73	2025-12-03	11	1	65
216	0	2025-12-03	12	1	65
217	80	2025-12-03	1	1	66
218	85	2025-12-03	2	1	66
219	85	2025-12-03	3	1	66
220	100	2025-12-03	4	1	66
221	100	2025-12-03	5	1	66
222	100	2025-12-03	6	1	66
223	70	2025-12-03	7	1	66
224	77	2025-12-03	8	1	66
225	0	2025-12-03	9	1	66
226	0	2025-12-03	10	1	66
227	73	2025-12-03	11	1	66
228	0	2025-12-03	12	1	66
229	80	2025-12-03	1	1	67
230	85	2025-12-03	2	1	67
231	85	2025-12-03	3	1	67
232	100	2025-12-03	4	1	67
233	100	2025-12-03	5	1	67
234	100	2025-12-03	6	1	67
235	70	2025-12-03	7	1	67
236	77	2025-12-03	8	1	67
237	0	2025-12-03	9	1	67
238	0	2025-12-03	10	1	67
239	73	2025-12-03	11	1	67
240	0	2025-12-03	12	1	67
241	80	2025-12-03	1	1	68
242	85	2025-12-03	2	1	68
243	85	2025-12-03	3	1	68
244	100	2025-12-03	4	1	68
245	100	2025-12-03	5	1	68
246	100	2025-12-03	6	1	68
247	70	2025-12-03	7	1	68
248	77	2025-12-03	8	1	68
249	0	2025-12-03	9	1	68
250	0	2025-12-03	10	1	68
251	73	2025-12-03	11	1	68
252	0	2025-12-03	12	1	68
253	80	2025-12-05	1	1	69
254	85	2025-12-05	2	1	69
255	85	2025-12-05	3	1	69
256	100	2025-12-05	4	1	69
257	100	2025-12-05	5	1	69
258	100	2025-12-05	6	1	69
259	70	2025-12-05	7	1	69
260	77	2025-12-05	8	1	69
261	0	2025-12-05	9	1	69
262	0	2025-12-05	10	1	69
263	73	2025-12-05	11	1	69
264	0	2025-12-05	12	1	69
265	80	2025-12-05	1	1	70
266	85	2025-12-05	2	1	70
267	85	2025-12-05	3	1	70
268	100	2025-12-05	4	1	70
269	100	2025-12-05	5	1	70
270	100	2025-12-05	6	1	70
271	70	2025-12-05	7	1	70
272	77	2025-12-05	8	1	70
273	0	2025-12-05	9	1	70
274	0	2025-12-05	10	1	70
275	73	2025-12-05	11	1	70
276	0	2025-12-05	12	1	70
277	80	2025-12-05	1	1	71
278	85	2025-12-05	2	1	71
279	85	2025-12-05	3	1	71
280	100	2025-12-05	4	1	71
281	100	2025-12-05	5	1	71
282	100	2025-12-05	6	1	71
283	70	2025-12-05	7	1	71
284	77	2025-12-05	8	1	71
285	0	2025-12-05	9	1	71
286	0	2025-12-05	10	1	71
287	73	2025-12-05	11	1	71
288	0	2025-12-05	12	1	71
289	80	2025-12-05	1	1	72
290	85	2025-12-05	2	1	72
291	85	2025-12-05	3	1	72
292	100	2025-12-05	4	1	72
293	100	2025-12-05	5	1	72
294	100	2025-12-05	6	1	72
295	70	2025-12-05	7	1	72
296	77	2025-12-05	8	1	72
297	0	2025-12-05	9	1	72
298	0	2025-12-05	10	1	72
299	73	2025-12-05	11	1	72
300	0	2025-12-05	12	1	72
301	80	2025-12-05	1	1	73
302	85	2025-12-05	2	1	73
303	85	2025-12-05	3	1	73
304	100	2025-12-05	4	1	73
305	100	2025-12-05	5	1	73
306	100	2025-12-05	6	1	73
307	70	2025-12-05	7	1	73
308	77	2025-12-05	8	1	73
309	0	2025-12-05	9	1	73
310	0	2025-12-05	10	1	73
311	73	2025-12-05	11	1	73
312	0	2025-12-05	12	1	73
313	80	2025-12-05	1	1	74
314	85	2025-12-05	2	1	74
315	85	2025-12-05	3	1	74
316	100	2025-12-05	4	1	74
317	100	2025-12-05	5	1	74
318	100	2025-12-05	6	1	74
319	70	2025-12-05	7	1	74
320	77	2025-12-05	8	1	74
321	0	2025-12-05	9	1	74
322	0	2025-12-05	10	1	74
323	73	2025-12-05	11	1	74
324	0	2025-12-05	12	1	74
325	80	2025-12-05	1	1	75
326	85	2025-12-05	2	1	75
327	85	2025-12-05	3	1	75
328	100	2025-12-05	4	1	75
329	100	2025-12-05	5	1	75
330	100	2025-12-05	6	1	75
331	70	2025-12-05	7	1	75
332	77	2025-12-05	8	1	75
333	0	2025-12-05	9	1	75
334	33	2025-12-05	10	1	75
335	73	2025-12-05	11	1	75
336	28	2025-12-05	12	1	75
337	0	2025-12-05	1	1	76
338	0	2025-12-05	2	1	76
339	0	2025-12-05	3	1	76
340	0	2025-12-05	4	1	76
341	0	2025-12-05	5	1	76
342	0	2025-12-05	6	1	76
343	0	2025-12-05	7	1	76
344	0	2025-12-05	8	1	76
345	0	2025-12-05	9	1	76
346	0	2025-12-05	10	1	76
347	0	2025-12-05	11	1	76
348	0	2025-12-05	12	1	76
349	80	2025-12-05	1	1	77
350	85	2025-12-05	2	1	77
351	85	2025-12-05	3	1	77
352	100	2025-12-05	4	1	77
353	100	2025-12-05	5	1	77
354	100	2025-12-05	6	1	77
355	70	2025-12-05	7	1	77
356	77	2025-12-05	8	1	77
357	0	2025-12-05	9	1	77
358	33	2025-12-05	10	1	77
359	73	2025-12-05	11	1	77
360	28	2025-12-05	12	1	77
361	80	2025-12-05	1	1	78
362	85	2025-12-05	2	1	78
363	85	2025-12-05	3	1	78
364	100	2025-12-05	4	1	78
365	100	2025-12-05	5	1	78
366	100	2025-12-05	6	1	78
367	73	2025-12-05	7	1	78
368	74	2025-12-05	8	1	78
369	28	2025-12-05	9	1	78
370	50	2025-12-05	10	1	78
371	28	2025-12-05	11	1	78
372	39	2025-12-05	12	1	78
373	80	2025-12-06	1	1	79
374	85	2025-12-06	2	1	79
375	85	2025-12-06	3	1	79
376	100	2025-12-06	4	1	79
377	100	2025-12-06	5	1	79
378	100	2025-12-06	6	1	79
379	28	2025-12-06	7	1	79
380	39	2025-12-06	8	1	79
381	50	2025-12-06	9	1	79
382	77	2025-12-06	10	1	79
383	85	2025-12-06	11	1	79
384	26	2025-12-06	12	1	79
385	80	2025-12-06	1	1	80
386	85	2025-12-06	2	1	80
387	85	2025-12-06	3	1	80
388	100	2025-12-06	4	1	80
389	100	2025-12-06	5	1	80
390	100	2025-12-06	6	1	80
391	28	2025-12-06	7	1	80
392	39	2025-12-06	8	1	80
393	50	2025-12-06	9	1	80
394	77	2025-12-06	10	1	80
395	85	2025-12-06	11	1	80
396	26	2025-12-06	12	1	80
397	80	2025-12-06	1	1	81
398	85	2025-12-06	2	1	81
399	85	2025-12-06	3	1	81
400	100	2025-12-06	4	1	81
401	100	2025-12-06	5	1	81
402	100	2025-12-06	6	1	81
403	79	2025-12-06	7	1	81
404	69	2025-12-06	8	1	81
405	69	2025-12-06	9	1	81
406	74	2025-12-06	10	1	81
407	72	2025-12-06	11	1	81
408	79	2025-12-06	12	1	81
409	91	2025-12-07	1	1	88
410	91	2025-12-07	2	1	88
411	91	2025-12-07	3	1	88
412	100	2025-12-07	4	1	88
413	100	2025-12-07	5	1	88
414	100	2025-12-07	6	1	88
415	74	2025-12-07	7	1	88
416	90	2025-12-07	8	1	88
417	66	2025-12-07	9	1	88
418	89	2025-12-07	10	1	88
419	71	2025-12-07	11	1	88
420	90	2025-12-07	12	1	88
421	91	2025-12-07	1	1	89
422	91	2025-12-07	2	1	89
423	91	2025-12-07	3	1	89
424	100	2025-12-07	4	1	89
425	100	2025-12-07	5	1	89
426	100	2025-12-07	6	1	89
427	74	2025-12-07	7	1	89
428	90	2025-12-07	8	1	89
429	66	2025-12-07	9	1	89
430	89	2025-12-07	10	1	89
431	71	2025-12-07	11	1	89
432	90	2025-12-07	12	1	89
433	80	2025-12-07	1	1	90
434	85	2025-12-07	2	1	90
435	85	2025-12-07	3	1	90
436	100	2025-12-07	4	1	90
437	100	2025-12-07	5	1	90
438	100	2025-12-07	6	1	90
439	33	2025-12-07	7	1	90
440	81	2025-12-07	8	1	90
441	69	2025-12-07	9	1	90
442	1	2025-12-07	10	1	90
443	72	2025-12-07	11	1	90
444	79	2025-12-07	12	1	90
445	0	2025-12-07	1	1	91
446	0	2025-12-07	2	1	91
447	0	2025-12-07	3	1	91
448	0	2025-12-07	4	1	91
449	0	2025-12-07	5	1	91
450	0	2025-12-07	6	1	91
451	0	2025-12-07	7	1	91
452	0	2025-12-07	8	1	91
453	0	2025-12-07	9	1	91
454	0	2025-12-07	10	1	91
455	0	2025-12-07	11	1	91
456	0	2025-12-07	12	1	91
457	0	2025-12-07	1	1	92
458	0	2025-12-07	2	1	92
459	0	2025-12-07	3	1	92
460	0	2025-12-07	4	1	92
461	0	2025-12-07	5	1	92
462	0	2025-12-07	6	1	92
463	73	2025-12-07	7	1	92
464	0	2025-12-07	8	1	92
465	43	2025-12-07	9	1	92
466	69	2025-12-07	10	1	92
467	33	2025-12-07	11	1	92
468	44	2025-12-07	12	1	92
\.


--
-- TOC entry 4965 (class 0 OID 16790)
-- Dependencies: 222
-- Data for Name: Directory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Directory" (id, name, parent_id) FROM stdin;
2	object 2	1
3	object3	2
5	object5	4
1	object_up	\N
6	object22	1
4	object1_123	\N
8	object1_25	\N
9	object1_14	\N
10	object1_1233	9
11	object24	8
7	object1_124	\N
12	sa	\N
13	sas	\N
14	new1	3
15	n2	\N
16	qw	\N
17	dssd	\N
18	directories_diff_images/compare50/	\N
19	directories_diff_images/compare51/	\N
20	directories_diff_images/compare52/	\N
21	compare53	\N
22	compare54	\N
23	compare55	\N
24	dn1	\N
25	dn2	\N
26	dn3	\N
27	compare56	\N
28	compare57	\N
29	compare58	\N
30	compare59	\N
31	compare60	\N
32	compare61	\N
33	compare62	\N
34	compare63	\N
35	dn4	\N
36	compare64	\N
37	compare65	\N
38	compare66	\N
39	compare67	\N
40	compare68	\N
41	compare69	\N
42	compare70	\N
43	compare71	\N
44	compare72	\N
45	compare73	\N
46	compare74	\N
47	compare75	\N
48	compare76	\N
49	compare77	\N
50	a1	\N
51	a2	\N
52	compare78	\N
53	a3	\N
54	a4	\N
55	compare79	\N
56	compare80	\N
57	b1	\N
58	b2	\N
59	compare81	\N
60	monkey1	\N
61	compare82	\N
62	monkey2	\N
63	compare83	\N
64	am1	\N
65	compare84	\N
66	am2	\N
67	compare85	\N
68	am3	\N
69	compare86	\N
70	am4	\N
71	compare87	\N
72	am5	\N
73	compare88	\N
74	am6	\N
75	compare89	\N
76	compare90	\N
77	compare91	\N
78	compare92	\N
\.


--
-- TOC entry 4966 (class 0 OID 16793)
-- Dependencies: 223
-- Data for Name: Geometry_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Geometry_object" (id, name_file, date_create, directory_id, type_obj_id) FROM stdin;
1	file_go.obj	2025-11-04	1	1
3	file_gobj.obj	2025-11-04	1	1
4	file_gobj.obj	2025-11-04	1	1
6	file_gobj.obj	2025-11-04	1	1
7	file_gobj.obj	2025-11-04	1	1
8	file_gobj.obj	2025-11-04	1	1
9	file_gobj_1.obj	2025-11-04	1	1
10	file_gobj_dir1.sda.obj	2025-11-04	1	1
11	file_gobj_dir1..obj	2025-11-04	1	1
12	file_gobj_dir1..png	2025-11-04	1	1
2	file_gobj.obj	2025-11-04	2	1
5	file_gobj.obj	2025-11-04	3	1
13	file_gobj_dir13.obj	2025-11-04	13	2
14	file_gobj_dir14.obj	2025-11-04	14	1
15	file_gobj_dir15_type_obj2.obj	2025-11-04	15	2
16	file_gobj_dir16_type_obj2.obj	2025-11-04	16	2
17	file_gobj_dir17_type_obj1.obj	2025-11-05	17	1
18	file_gobj_dir24_type_obj1.obj	2025-11-23	24	1
19	file_gobj_dir24_type_obj1.obj	2025-11-23	24	1
20	file_gobj_dir24_type_obj1.obj	2025-11-23	24	1
21	file_gobj_dir24_type_obj1.obj	2025-11-23	24	1
22	file_gobj_dir24_type_obj1.obj	2025-11-23	24	2
23	file_gobj_dir27_type_obj1.obj	2025-12-01	27	1
24	file_gobj_dir35_type_obj1.obj	2025-12-03	35	1
25	file_gobj_dir50_type_obj1.obj	2025-12-05	50	1
26	file_gobj_dir51_type_obj2.obj	2025-12-05	51	2
27	file_gobj_dir53_type_obj1.obj	2025-12-06	53	1
28	file_gobj_dir54_type_obj2.obj	2025-12-06	54	2
29	file_gobj_dir57_type_obj1.obj	2025-12-06	57	1
30	file_gobj_dir58_type_obj2.obj	2025-12-06	58	2
31	file_gobj_dir60_type_obj1.obj	2025-12-07	60	1
32	file_gobj_dir62_type_obj1.obj	2025-12-07	62	1
33	file_gobj_dir64_type_obj1.obj	2025-12-07	64	1
34	file_gobj_dir66_type_obj1.obj	2025-12-07	66	1
35	file_gobj_dir68_type_obj1.obj	2025-12-07	68	1
36	file_gobj_dir70_type_obj1.obj	2025-12-07	70	1
37	file_gobj_dir72_type_obj1.obj	2025-12-07	72	1
38	file_gobj_dir74_type_obj1.obj	2025-12-07	74	1
\.


--
-- TOC entry 4967 (class 0 OID 16796)
-- Dependencies: 224
-- Data for Name: Image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Image" (id, name_file, date_create, type_image_id, perspective_id, directory_id, gobj_id) FROM stdin;
1	вид сверху.png	2025-11-04	1	1	1	1
17	img_dir15_persp4_type_img1.png	2025-11-05	1	4	15	15
28	img_dir16_persp6_type_img1.png	2025-11-16	1	6	16	16
2	img2.png	2025-11-04	1	2	2	1
3	img_dir1_persp.png	2025-11-04	1	1	1	1
4	img_dir2_persp.png	2025-11-04	1	1	2	2
5	img_dir3_persp.png	2025-11-04	1	1	3	5
11	img_dir16_persp5_type_img1.png	2025-11-04	1	5	16	16
12	img_dir13_persp5_type_img1.png	2025-11-04	1	5	13	13
13	img_dir3_persp5_type_img1.png	2025-11-04	1	5	3	5
14	img_dir15_persp6_type_img1.png	2025-11-05	1	6	15	15
15	img_dir13_persp3_type_img1.png	2025-11-05	1	3	13	13
16	img_dir15_persp3_type_img1.png	2025-11-05	1	3	15	15
18	img_dir15_persp1_type_img1.png	2025-11-05	1	1	15	15
19	img_dir13_persp6_type_img1.png	2025-11-05	1	6	13	13
20	img_dir15_persp5_type_img1.png	2025-11-08	1	5	15	15
21	img_dir15_persp2_type_img1.png	2025-11-08	1	2	15	15
22	img_dir14_persp5_type_img1.png	2025-11-08	1	5	14	14
23	img_dir14_persp6_type_img1.png	2025-11-08	1	6	14	14
24	img_dir14_persp3_type_img1.png	2025-11-08	1	3	14	14
25	img_dir14_persp4_type_img1.png	2025-11-08	1	4	14	14
26	img_dir14_persp1_type_img1.png	2025-11-08	1	1	14	14
27	img_dir14_persp2_type_img1.png	2025-11-08	1	2	14	14
29	diff_forward.png	2025-11-23	2	1	20	15
30	diff_back.png	2025-11-23	2	2	20	15
31	diff_left.png	2025-11-23	2	3	20	15
32	diff_right.png	2025-11-23	2	4	20	15
33	diff_up.png	2025-11-23	2	5	20	15
34	diff_down.png	2025-11-23	2	6	20	15
35	diff_forward.png	2025-11-23	2	1	21	15
36	diff_back.png	2025-11-23	2	2	21	15
37	diff_left.png	2025-11-23	2	3	21	15
38	diff_right.png	2025-11-23	2	4	21	15
39	diff_up.png	2025-11-23	2	5	21	15
40	diff_down.png	2025-11-23	2	6	21	15
41	diff_forward.png	2025-11-23	2	1	22	15
42	diff_back.png	2025-11-23	2	2	22	15
43	diff_left.png	2025-11-23	2	3	22	15
44	diff_right.png	2025-11-23	2	4	22	15
45	diff_up.png	2025-11-23	2	5	22	15
46	diff_down.png	2025-11-23	2	6	22	15
47	img_dir24_persp5_type_img1.png	2025-11-23	1	5	24	18
48	img_dir24_persp6_type_img1.png	2025-11-23	1	6	24	18
49	img_dir24_persp3_type_img1.png	2025-11-23	1	3	24	18
50	img_dir24_persp4_type_img1.png	2025-11-23	1	4	24	18
51	img_dir24_persp1_type_img1.png	2025-11-23	1	1	24	18
52	img_dir24_persp2_type_img1.png	2025-11-23	1	2	24	18
53	diff_forward.png	2025-11-23	2	1	27	18
54	diff_back.png	2025-11-23	2	2	27	18
55	diff_left.png	2025-11-23	2	3	27	18
56	diff_right.png	2025-11-23	2	4	27	18
57	diff_up.png	2025-11-23	2	5	27	18
58	diff_down.png	2025-11-23	2	6	27	18
59	diff_forward.png	2025-12-03	2	1	28	18
60	diff_back.png	2025-12-03	2	2	28	18
61	diff_left.png	2025-12-03	2	3	28	18
62	diff_right.png	2025-12-03	2	4	28	18
63	diff_up.png	2025-12-03	2	5	28	18
64	diff_down.png	2025-12-03	2	6	28	18
65	diff_forward.png	2025-12-03	2	1	34	18
66	diff_back.png	2025-12-03	2	2	34	18
67	diff_left.png	2025-12-03	2	3	34	18
68	diff_right.png	2025-12-03	2	4	34	18
69	diff_up.png	2025-12-03	2	5	34	18
70	diff_down.png	2025-12-03	2	6	34	18
71	img_dir35_persp5_type_img1.png	2025-12-03	1	5	35	24
72	img_dir35_persp6_type_img1.png	2025-12-03	1	6	35	24
73	img_dir35_persp3_type_img1.png	2025-12-03	1	3	35	24
74	img_dir35_persp4_type_img1.png	2025-12-03	1	4	35	24
75	img_dir35_persp1_type_img1.png	2025-12-03	1	1	35	24
76	img_dir35_persp2_type_img1.png	2025-12-03	1	2	35	24
77	diff_forward.png	2025-12-03	2	1	36	18
78	diff_back.png	2025-12-03	2	2	36	18
79	diff_left.png	2025-12-03	2	3	36	18
80	diff_right.png	2025-12-03	2	4	36	18
81	diff_up.png	2025-12-03	2	5	36	18
82	diff_down.png	2025-12-03	2	6	36	18
83	diff_forward.png	2025-12-03	2	1	37	18
84	diff_back.png	2025-12-03	2	2	37	18
85	diff_left.png	2025-12-03	2	3	37	18
86	diff_right.png	2025-12-03	2	4	37	18
87	diff_up.png	2025-12-03	2	5	37	18
88	diff_down.png	2025-12-03	2	6	37	18
89	diff_forward.png	2025-12-03	2	1	38	18
90	diff_back.png	2025-12-03	2	2	38	18
91	diff_left.png	2025-12-03	2	3	38	18
92	diff_right.png	2025-12-03	2	4	38	18
93	diff_up.png	2025-12-03	2	5	38	18
94	diff_down.png	2025-12-03	2	6	38	18
95	diff_forward.png	2025-12-03	2	1	39	18
96	diff_back.png	2025-12-03	2	2	39	18
97	diff_left.png	2025-12-03	2	3	39	18
98	diff_right.png	2025-12-03	2	4	39	18
99	diff_up.png	2025-12-03	2	5	39	18
100	diff_down.png	2025-12-03	2	6	39	18
101	diff_forward.png	2025-12-03	2	1	40	18
102	diff_back.png	2025-12-03	2	2	40	18
103	diff_left.png	2025-12-03	2	3	40	18
104	diff_right.png	2025-12-03	2	4	40	18
105	diff_up.png	2025-12-03	2	5	40	18
106	diff_down.png	2025-12-03	2	6	40	18
107	diff_forward.png	2025-12-05	2	1	41	18
108	diff_back.png	2025-12-05	2	2	41	18
109	diff_left.png	2025-12-05	2	3	41	18
110	diff_right.png	2025-12-05	2	4	41	18
111	diff_up.png	2025-12-05	2	5	41	18
112	diff_down.png	2025-12-05	2	6	41	18
113	diff_forward.png	2025-12-05	2	1	42	18
114	diff_back.png	2025-12-05	2	2	42	18
115	diff_left.png	2025-12-05	2	3	42	18
116	diff_right.png	2025-12-05	2	4	42	18
117	diff_up.png	2025-12-05	2	5	42	18
118	diff_down.png	2025-12-05	2	6	42	18
119	diff_forward.png	2025-12-05	2	1	43	18
120	diff_back.png	2025-12-05	2	2	43	18
121	diff_left.png	2025-12-05	2	3	43	18
122	diff_right.png	2025-12-05	2	4	43	18
123	diff_up.png	2025-12-05	2	5	43	18
124	diff_down.png	2025-12-05	2	6	43	18
125	diff_forward.png	2025-12-05	2	1	44	18
126	diff_back.png	2025-12-05	2	2	44	18
127	diff_left.png	2025-12-05	2	3	44	18
128	diff_right.png	2025-12-05	2	4	44	18
129	diff_up.png	2025-12-05	2	5	44	18
130	diff_down.png	2025-12-05	2	6	44	18
131	diff_forward.png	2025-12-05	2	1	45	18
132	diff_back.png	2025-12-05	2	2	45	18
133	diff_left.png	2025-12-05	2	3	45	18
134	diff_right.png	2025-12-05	2	4	45	18
135	diff_up.png	2025-12-05	2	5	45	18
136	diff_down.png	2025-12-05	2	6	45	18
137	diff_forward.png	2025-12-05	2	1	46	18
138	diff_back.png	2025-12-05	2	2	46	18
139	diff_left.png	2025-12-05	2	3	46	18
140	diff_right.png	2025-12-05	2	4	46	18
141	diff_up.png	2025-12-05	2	5	46	18
142	diff_down.png	2025-12-05	2	6	46	18
143	diff_forward.png	2025-12-05	2	1	47	18
144	diff_back.png	2025-12-05	2	2	47	18
145	diff_left.png	2025-12-05	2	3	47	18
146	diff_right.png	2025-12-05	2	4	47	18
147	diff_up.png	2025-12-05	2	5	47	18
148	diff_down.png	2025-12-05	2	6	47	18
149	diff_forward.png	2025-12-05	2	1	48	18
150	diff_back.png	2025-12-05	2	2	48	18
151	diff_left.png	2025-12-05	2	3	48	18
152	diff_right.png	2025-12-05	2	4	48	18
153	diff_up.png	2025-12-05	2	5	48	18
154	diff_down.png	2025-12-05	2	6	48	18
155	diff_forward.png	2025-12-05	2	1	49	18
156	diff_back.png	2025-12-05	2	2	49	18
157	diff_left.png	2025-12-05	2	3	49	18
158	diff_right.png	2025-12-05	2	4	49	18
159	diff_up.png	2025-12-05	2	5	49	18
160	diff_down.png	2025-12-05	2	6	49	18
161	img_dir50_persp5_type_img1.png	2025-12-05	1	5	50	25
162	img_dir50_persp6_type_img1.png	2025-12-05	1	6	50	25
163	img_dir50_persp3_type_img1.png	2025-12-05	1	3	50	25
164	img_dir50_persp4_type_img1.png	2025-12-05	1	4	50	25
165	img_dir50_persp1_type_img1.png	2025-12-05	1	1	50	25
166	img_dir50_persp2_type_img1.png	2025-12-05	1	2	50	25
167	img_dir51_persp5_type_img1.png	2025-12-05	1	5	51	26
168	img_dir51_persp6_type_img1.png	2025-12-05	1	6	51	26
169	img_dir51_persp3_type_img1.png	2025-12-05	1	3	51	26
170	img_dir51_persp4_type_img1.png	2025-12-05	1	4	51	26
171	img_dir51_persp1_type_img1.png	2025-12-05	1	1	51	26
172	img_dir51_persp2_type_img1.png	2025-12-05	1	2	51	26
173	diff_forward.png	2025-12-05	2	1	52	26
174	diff_back.png	2025-12-05	2	2	52	26
175	diff_left.png	2025-12-05	2	3	52	26
176	diff_right.png	2025-12-05	2	4	52	26
177	diff_up.png	2025-12-05	2	5	52	26
178	diff_down.png	2025-12-05	2	6	52	26
179	img_dir53_persp5_type_img1.png	2025-12-06	1	5	53	27
180	img_dir53_persp6_type_img1.png	2025-12-06	1	6	53	27
181	img_dir53_persp3_type_img1.png	2025-12-06	1	3	53	27
182	img_dir53_persp4_type_img1.png	2025-12-06	1	4	53	27
183	img_dir53_persp1_type_img1.png	2025-12-06	1	1	53	27
184	img_dir53_persp2_type_img1.png	2025-12-06	1	2	53	27
185	img_dir54_persp5_type_img1.png	2025-12-06	1	5	54	28
186	img_dir54_persp6_type_img1.png	2025-12-06	1	6	54	28
187	img_dir54_persp3_type_img1.png	2025-12-06	1	3	54	28
188	img_dir54_persp4_type_img1.png	2025-12-06	1	4	54	28
189	img_dir54_persp1_type_img1.png	2025-12-06	1	1	54	28
190	img_dir54_persp2_type_img1.png	2025-12-06	1	2	54	28
191	diff_forward.png	2025-12-06	2	1	55	27
192	diff_back.png	2025-12-06	2	2	55	27
193	diff_left.png	2025-12-06	2	3	55	27
194	diff_right.png	2025-12-06	2	4	55	27
195	diff_up.png	2025-12-06	2	5	55	27
196	diff_down.png	2025-12-06	2	6	55	27
197	diff_forward.png	2025-12-06	2	1	56	27
198	diff_back.png	2025-12-06	2	2	56	27
199	diff_left.png	2025-12-06	2	3	56	27
200	diff_right.png	2025-12-06	2	4	56	27
201	diff_up.png	2025-12-06	2	5	56	27
202	diff_down.png	2025-12-06	2	6	56	27
203	img_dir57_persp5_type_img1.png	2025-12-06	1	5	57	29
204	img_dir57_persp6_type_img1.png	2025-12-06	1	6	57	29
205	img_dir57_persp3_type_img1.png	2025-12-06	1	3	57	29
206	img_dir57_persp4_type_img1.png	2025-12-06	1	4	57	29
207	img_dir57_persp1_type_img1.png	2025-12-06	1	1	57	29
208	img_dir57_persp2_type_img1.png	2025-12-06	1	2	57	29
209	img_dir58_persp5_type_img1.png	2025-12-06	1	5	58	30
210	img_dir58_persp6_type_img1.png	2025-12-06	1	6	58	30
211	img_dir58_persp3_type_img1.png	2025-12-06	1	3	58	30
212	img_dir58_persp4_type_img1.png	2025-12-06	1	4	58	30
213	img_dir58_persp1_type_img1.png	2025-12-06	1	1	58	30
214	img_dir58_persp2_type_img1.png	2025-12-06	1	2	58	30
215	diff_forward.png	2025-12-06	2	1	59	29
216	diff_back.png	2025-12-06	2	2	59	29
217	diff_left.png	2025-12-06	2	3	59	29
218	diff_right.png	2025-12-06	2	4	59	29
219	diff_up.png	2025-12-06	2	5	59	29
220	diff_down.png	2025-12-06	2	6	59	29
221	img_dir60_persp5_type_img1.png	2025-12-07	1	5	60	31
222	img_dir60_persp6_type_img1.png	2025-12-07	1	6	60	31
223	img_dir60_persp3_type_img1.png	2025-12-07	1	3	60	31
224	img_dir60_persp4_type_img1.png	2025-12-07	1	4	60	31
225	img_dir60_persp1_type_img1.png	2025-12-07	1	1	60	31
226	img_dir60_persp2_type_img1.png	2025-12-07	1	2	60	31
227	img_dir62_persp5_type_img1.png	2025-12-07	1	5	62	32
228	img_dir62_persp6_type_img1.png	2025-12-07	1	6	62	32
229	img_dir62_persp3_type_img1.png	2025-12-07	1	3	62	32
230	img_dir62_persp4_type_img1.png	2025-12-07	1	4	62	32
231	img_dir62_persp1_type_img1.png	2025-12-07	1	1	62	32
232	img_dir62_persp2_type_img1.png	2025-12-07	1	2	62	32
233	img_dir64_persp5_type_img1.png	2025-12-07	1	5	64	33
234	img_dir64_persp6_type_img1.png	2025-12-07	1	6	64	33
235	img_dir64_persp3_type_img1.png	2025-12-07	1	3	64	33
236	img_dir64_persp4_type_img1.png	2025-12-07	1	4	64	33
237	img_dir64_persp1_type_img1.png	2025-12-07	1	1	64	33
238	img_dir64_persp2_type_img1.png	2025-12-07	1	2	64	33
239	img_dir66_persp5_type_img1.png	2025-12-07	1	5	66	34
240	img_dir66_persp6_type_img1.png	2025-12-07	1	6	66	34
241	img_dir66_persp3_type_img1.png	2025-12-07	1	3	66	34
242	img_dir66_persp4_type_img1.png	2025-12-07	1	4	66	34
243	img_dir66_persp1_type_img1.png	2025-12-07	1	1	66	34
244	img_dir66_persp2_type_img1.png	2025-12-07	1	2	66	34
245	img_dir68_persp5_type_img1.png	2025-12-07	1	5	68	35
246	img_dir68_persp6_type_img1.png	2025-12-07	1	6	68	35
247	img_dir68_persp3_type_img1.png	2025-12-07	1	3	68	35
248	img_dir68_persp4_type_img1.png	2025-12-07	1	4	68	35
249	img_dir68_persp1_type_img1.png	2025-12-07	1	1	68	35
250	img_dir68_persp2_type_img1.png	2025-12-07	1	2	68	35
251	img_dir70_persp5_type_img1.png	2025-12-07	1	5	70	36
252	img_dir70_persp6_type_img1.png	2025-12-07	1	6	70	36
253	img_dir70_persp3_type_img1.png	2025-12-07	1	3	70	36
254	img_dir70_persp4_type_img1.png	2025-12-07	1	4	70	36
255	img_dir70_persp1_type_img1.png	2025-12-07	1	1	70	36
256	img_dir70_persp2_type_img1.png	2025-12-07	1	2	70	36
257	img_dir72_persp5_type_img1.png	2025-12-07	1	5	72	37
258	img_dir72_persp6_type_img1.png	2025-12-07	1	6	72	37
259	img_dir72_persp3_type_img1.png	2025-12-07	1	3	72	37
260	img_dir72_persp4_type_img1.png	2025-12-07	1	4	72	37
261	img_dir72_persp1_type_img1.png	2025-12-07	1	1	72	37
262	img_dir72_persp2_type_img1.png	2025-12-07	1	2	72	37
263	diff_forward.png	2025-12-07	2	1	73	37
264	diff_back.png	2025-12-07	2	2	73	37
265	diff_left.png	2025-12-07	2	3	73	37
266	diff_right.png	2025-12-07	2	4	73	37
267	diff_up.png	2025-12-07	2	5	73	37
268	diff_down.png	2025-12-07	2	6	73	37
269	img_dir74_persp5_type_img1.png	2025-12-07	1	5	74	38
270	img_dir74_persp6_type_img1.png	2025-12-07	1	6	74	38
271	img_dir74_persp3_type_img1.png	2025-12-07	1	3	74	38
272	img_dir74_persp4_type_img1.png	2025-12-07	1	4	74	38
273	img_dir74_persp1_type_img1.png	2025-12-07	1	1	74	38
274	img_dir74_persp2_type_img1.png	2025-12-07	1	2	74	38
275	diff_forward.png	2025-12-07	2	1	75	38
276	diff_back.png	2025-12-07	2	2	75	38
277	diff_left.png	2025-12-07	2	3	75	38
278	diff_right.png	2025-12-07	2	4	75	38
279	diff_up.png	2025-12-07	2	5	75	38
280	diff_down.png	2025-12-07	2	6	75	38
281	diff_forward.png	2025-12-07	2	1	76	27
282	diff_back.png	2025-12-07	2	2	76	27
283	diff_left.png	2025-12-07	2	3	76	27
284	diff_right.png	2025-12-07	2	4	76	27
285	diff_up.png	2025-12-07	2	5	76	27
286	diff_down.png	2025-12-07	2	6	76	27
287	diff_forward.png	2025-12-07	2	1	77	18
288	diff_back.png	2025-12-07	2	2	77	18
289	diff_left.png	2025-12-07	2	3	77	18
290	diff_right.png	2025-12-07	2	4	77	18
291	diff_up.png	2025-12-07	2	5	77	18
292	diff_down.png	2025-12-07	2	6	77	18
293	diff_forward.png	2025-12-07	2	1	78	18
294	diff_back.png	2025-12-07	2	2	78	18
295	diff_left.png	2025-12-07	2	3	78	18
296	diff_right.png	2025-12-07	2	4	78	18
297	diff_up.png	2025-12-07	2	5	78	18
298	diff_down.png	2025-12-07	2	6	78	18
\.


--
-- TOC entry 4968 (class 0 OID 16799)
-- Dependencies: 225
-- Data for Name: Model_nn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Model_nn" (id, name_file, date_create, directory_id, name_file_history, err_resolve) FROM stdin;
2	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
3	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
4	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
5	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
6	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
7	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
8	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
9	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
10	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
11	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
12	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
13	model_epochs10_err5_cneuron4_sizedata50.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata50_history.pkl	5
14	model_epochs10_err5_cneuron4_sizedata20.keras	2025-11-10	12	model_epochs10_err5_cneuron4_sizedata20_history.pkl	5
15	model_epochs10_err15_cneuron3.keras	2025-11-10	12	model_epochs10_err15_cneuron3_history.pkl	15
16	model_epochs1.keras	2025-11-10	12	model_epochs1_history.pkl	15
17	model_epochs1.keras	2025-11-10	12	model_epochs1_history.pkl	15
18	model_epochs1.keras	2025-11-10	12	model_epochs1_history.pkl	15
19	model_epochs1.keras	2025-11-10	12	model_epochs1_history.pkl	15
20	model_epochs5_err5_cneuron3_sizedata25.keras	2025-11-10	13	model_epochs5_err5_cneuron3_sizedata25_history.pkl	5
21	model_epochs5_err5_cneuron5_sizedata25.keras	2025-11-10	13	model_epochs5_err5_cneuron5_sizedata25_history.pkl	5
22	model_epochs5_err5_cneuron5_sizedata25_2025_11_11_20_33_58.keras	2025-11-11	15	model_epochs5_err5_cneuron5_sizedata25_2025_11_11_20_33_58_history.pkl	5
23	model_epochs5_err5_cneuron4_sizedata25_2025_11_11_20_37_34.keras	2025-11-11	16	model_epochs5_err5_cneuron4_sizedata25_2025_11_11_20_37_34_history.pkl	5
24	model_epochs5_err5_cneuron5_sizedata5_2025_12_03_15_32_06.keras	2025-12-03	12	model_epochs5_err5_cneuron5_sizedata5_2025_12_03_15_32_06_history.pkl	5
\.


--
-- TOC entry 4969 (class 0 OID 16802)
-- Dependencies: 226
-- Data for Name: Perspective; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Perspective" (id, name, short_name) FROM stdin;
3	Вид слева	Слева
4	Вид справа	Справа
1	Вид спереди	Спереди
5	Вид сверху	Сверху
6	Вид снизу	Снизу
2	Вид сзади	Сзади
\.


--
-- TOC entry 4970 (class 0 OID 16805)
-- Dependencies: 227
-- Data for Name: Result_compare; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Result_compare" (id, date_compare, required_gobj_id, modeled_gobj_id, class_obj_id, model_nn_id) FROM stdin;
8	2025-11-23	1	2	1	2
11	2025-11-23	1	1	1	2
12	2025-11-23	1	1	1	2
16	2025-11-23	1	1	1	2
18	2025-11-23	1	1	1	2
21	2025-11-23	1	1	1	2
50	2025-11-23	15	15	3	3
51	2025-11-23	15	15	3	3
52	2025-11-23	15	15	5	3
53	2025-11-23	15	15	5	3
54	2025-11-23	15	15	5	3
55	2025-11-23	14	14	3	3
56	2025-11-23	18	18	5	3
57	2025-12-03	18	18	5	10
58	2025-12-03	23	18	3	5
59	2025-12-03	23	18	3	5
60	2025-12-03	23	18	3	9
61	2025-12-03	23	18	3	24
62	2025-12-03	23	18	3	10
63	2025-12-03	18	18	5	10
64	2025-12-03	24	18	4	13
65	2025-12-03	24	18	5	24
66	2025-12-03	24	18	5	24
67	2025-12-03	24	18	5	24
68	2025-12-03	24	18	5	24
69	2025-12-05	24	18	5	24
70	2025-12-05	24	18	5	24
71	2025-12-05	24	18	5	24
72	2025-12-05	24	18	5	24
73	2025-12-05	24	18	5	24
74	2025-12-05	24	18	5	24
75	2025-12-05	24	18	5	24
76	2025-12-05	18	18	4	24
77	2025-12-05	24	18	5	24
78	2025-12-05	25	26	5	24
79	2025-12-06	27	28	5	24
80	2025-12-06	27	28	4	23
81	2025-12-06	30	29	5	24
82	2025-12-07	30	31	3	24
83	2025-12-07	30	32	3	24
84	2025-12-07	30	33	3	24
85	2025-12-07	30	34	3	24
86	2025-12-07	30	35	3	24
87	2025-12-07	30	36	3	24
88	2025-12-07	30	37	5	24
89	2025-12-07	30	38	5	24
90	2025-12-07	30	27	5	24
91	2025-12-07	18	18	4	24
92	2025-12-07	26	18	5	24
\.


--
-- TOC entry 4971 (class 0 OID 16808)
-- Dependencies: 228
-- Data for Name: Type_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Type_image" (id, name, short_name) FROM stdin;
1	Фактическое	фактич.
2	Изображение-разница	разница
\.


--
-- TOC entry 4972 (class 0 OID 16811)
-- Dependencies: 229
-- Data for Name: Type_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Type_object" (id, name, short_name) FROM stdin;
1	смоделированный	смоделир.
2	требуемый	треб.
3	необработанный	необр.
4	соответствующий	соотв.
5	несоответствующий	несоотв.
\.


--
-- TOC entry 4973 (class 0 OID 16814)
-- Dependencies: 230
-- Data for Name: Unit_measurement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Unit_measurement" (id, name, short_name) FROM stdin;
1	%	%
3	единица	ед.
4	н	н
2	штука	шт.
\.


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 231
-- Name: Difference_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Difference_guide_id_seq"', 13, true);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 233
-- Name: Difference_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Difference_value_id_seq"', 468, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 234
-- Name: Directory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Directory_id_seq"', 78, true);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 235
-- Name: Geometry_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Geometry_object_id_seq"', 38, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 236
-- Name: Image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Image_id_seq"', 298, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 237
-- Name: Model_nn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Model_nn_id_seq"', 24, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 232
-- Name: Perspective_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Perspective_id_seq"', 6, true);


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 238
-- Name: Result_compare_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Result_compare_id_seq"', 92, true);


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 239
-- Name: Type_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Type_image_id_seq"', 2, true);


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 240
-- Name: Type_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Type_object_id_seq"', 5, true);


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 241
-- Name: Unit_measurement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Unit_measurement_id_seq"', 4, true);


--
-- TOC entry 4773 (class 2606 OID 16818)
-- Name: Difference_guide Difference_guide_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Difference_guide"
    ADD CONSTRAINT "Difference_guide_pkey" PRIMARY KEY (id);


--
-- TOC entry 4775 (class 2606 OID 16820)
-- Name: Difference_value Difference_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Difference_value"
    ADD CONSTRAINT "Difference_value_pkey" PRIMARY KEY (id);


--
-- TOC entry 4777 (class 2606 OID 16822)
-- Name: Directory Directory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Directory"
    ADD CONSTRAINT "Directory_pkey" PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 16824)
-- Name: Geometry_object Geometry_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Geometry_object"
    ADD CONSTRAINT "Geometry_object_pkey" PRIMARY KEY (id);


--
-- TOC entry 4781 (class 2606 OID 16826)
-- Name: Image Image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "Image_pkey" PRIMARY KEY (id);


--
-- TOC entry 4783 (class 2606 OID 16828)
-- Name: Model_nn Model_nn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Model_nn"
    ADD CONSTRAINT "Model_nn_pkey" PRIMARY KEY (id);


--
-- TOC entry 4785 (class 2606 OID 16830)
-- Name: Perspective Perspective_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Perspective"
    ADD CONSTRAINT "Perspective_pkey" PRIMARY KEY (id);


--
-- TOC entry 4787 (class 2606 OID 16832)
-- Name: Result_compare Result_compare_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result_compare"
    ADD CONSTRAINT "Result_compare_pkey" PRIMARY KEY (id);


--
-- TOC entry 4789 (class 2606 OID 16834)
-- Name: Type_image Type_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Type_image"
    ADD CONSTRAINT "Type_image_pkey" PRIMARY KEY (id);


--
-- TOC entry 4791 (class 2606 OID 16836)
-- Name: Type_object Type_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Type_object"
    ADD CONSTRAINT "Type_object_pkey" PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 16838)
-- Name: Unit_measurement Unit_measurement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unit_measurement"
    ADD CONSTRAINT "Unit_measurement_pkey" PRIMARY KEY (id);


--
-- TOC entry 4962 (class 2618 OID 17152)
-- Name: dirs_without_compare _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.dirs_without_compare AS
 SELECT dir.id,
    dir.name,
    dir.parent_id
   FROM ((public."Directory" dir
     LEFT JOIN public."Image" img ON ((dir.id = img.directory_id)))
     LEFT JOIN public."Type_image" t_i ON ((t_i.id = img.type_image_id)))
EXCEPT
 SELECT dir.id,
    dir.name,
    dir.parent_id
   FROM ((public."Directory" dir
     LEFT JOIN public."Image" img ON ((dir.id = img.directory_id)))
     LEFT JOIN public."Type_image" t_i ON ((t_i.id = img.type_image_id)))
  WHERE (img.type_image_id = 2)
  GROUP BY dir.id, dir.name
  ORDER BY 2;


--
-- TOC entry 4794 (class 2606 OID 16839)
-- Name: Difference_value FK_Difference_value_to_Difference_guide; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Difference_value"
    ADD CONSTRAINT "FK_Difference_value_to_Difference_guide" FOREIGN KEY (diff_id) REFERENCES public."Difference_guide"(id) ON UPDATE CASCADE;


--
-- TOC entry 4795 (class 2606 OID 16844)
-- Name: Difference_value FK_Difference_value_to_Result_compare; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Difference_value"
    ADD CONSTRAINT "FK_Difference_value_to_Result_compare" FOREIGN KEY (result_id) REFERENCES public."Result_compare"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4796 (class 2606 OID 16849)
-- Name: Difference_value FK_Difference_value_to_UMeasurement; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Difference_value"
    ADD CONSTRAINT "FK_Difference_value_to_UMeasurement" FOREIGN KEY (u_measurement_id) REFERENCES public."Unit_measurement"(id) ON UPDATE CASCADE;


--
-- TOC entry 4797 (class 2606 OID 16854)
-- Name: Directory FK_Directory_to_Directory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Directory"
    ADD CONSTRAINT "FK_Directory_to_Directory" FOREIGN KEY (parent_id) REFERENCES public."Directory"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4798 (class 2606 OID 16859)
-- Name: Geometry_object FK_Geometry_object_to_Directory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Geometry_object"
    ADD CONSTRAINT "FK_Geometry_object_to_Directory" FOREIGN KEY (directory_id) REFERENCES public."Directory"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4799 (class 2606 OID 16864)
-- Name: Geometry_object FK_Geometry_object_to_Type_obj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Geometry_object"
    ADD CONSTRAINT "FK_Geometry_object_to_Type_obj" FOREIGN KEY (type_obj_id) REFERENCES public."Type_object"(id) ON UPDATE CASCADE;


--
-- TOC entry 4800 (class 2606 OID 16869)
-- Name: Image FK_Image_to_Directory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "FK_Image_to_Directory" FOREIGN KEY (directory_id) REFERENCES public."Directory"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4801 (class 2606 OID 16874)
-- Name: Image FK_Image_to_GObj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "FK_Image_to_GObj" FOREIGN KEY (gobj_id) REFERENCES public."Geometry_object"(id) ON UPDATE CASCADE;


--
-- TOC entry 4802 (class 2606 OID 16879)
-- Name: Image FK_Image_to_Perspective; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "FK_Image_to_Perspective" FOREIGN KEY (perspective_id) REFERENCES public."Perspective"(id) ON UPDATE CASCADE;


--
-- TOC entry 4803 (class 2606 OID 16884)
-- Name: Image FK_Image_to_Type_image; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "FK_Image_to_Type_image" FOREIGN KEY (type_image_id) REFERENCES public."Type_image"(id) ON UPDATE CASCADE;


--
-- TOC entry 4804 (class 2606 OID 16889)
-- Name: Model_nn FK_Model_nn_to_Directory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Model_nn"
    ADD CONSTRAINT "FK_Model_nn_to_Directory" FOREIGN KEY (directory_id) REFERENCES public."Directory"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4805 (class 2606 OID 16894)
-- Name: Result_compare FK_Result_compare_to_GObj_mod; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result_compare"
    ADD CONSTRAINT "FK_Result_compare_to_GObj_mod" FOREIGN KEY (modeled_gobj_id) REFERENCES public."Geometry_object"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4806 (class 2606 OID 16899)
-- Name: Result_compare FK_Result_compare_to_GObj_req; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result_compare"
    ADD CONSTRAINT "FK_Result_compare_to_GObj_req" FOREIGN KEY (required_gobj_id) REFERENCES public."Geometry_object"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4807 (class 2606 OID 16904)
-- Name: Result_compare FK_Result_compare_to_Model_nn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result_compare"
    ADD CONSTRAINT "FK_Result_compare_to_Model_nn" FOREIGN KEY (model_nn_id) REFERENCES public."Model_nn"(id) ON UPDATE CASCADE;


--
-- TOC entry 4808 (class 2606 OID 16909)
-- Name: Result_compare FK_Result_compare_to_Type_object; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Result_compare"
    ADD CONSTRAINT "FK_Result_compare_to_Type_object" FOREIGN KEY (class_obj_id) REFERENCES public."Type_object"(id) ON UPDATE CASCADE;


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2025-12-07 17:49:13

--
-- PostgreSQL database dump complete
--

