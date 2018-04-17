--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2 (Debian 10.2-1.pgdg90+1)
-- Dumped by pg_dump version 10.2 (Debian 10.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: items_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE items_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE items_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE items (
    id integer DEFAULT nextval('items_seq'::regclass) NOT NULL,
    score integer NOT NULL,
    mass integer NOT NULL,
    category smallint NOT NULL,
    deposited_by integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    extra_info json
);


ALTER TABLE items OWNER TO postgres;

--
-- Name: users_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_seq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer DEFAULT nextval('users_seq'::regclass) NOT NULL,
    can character varying(16) NOT NULL,
    display_name character varying(50) NOT NULL,
    phone_number character varying(10),
    active boolean NOT NULL,
    name character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE users OWNER TO postgres;

--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY items (id, score, mass, category, deposited_by, created_at, extra_info) FROM stdin;
2       123     1000    1       1       2018-04-16 22:30:00     \N
3       149     300     3       2       2018-04-16 22:50:00     \N
4       2039    500     2       3       2018-04-16 23:40:00     \N
5       995     250     2       1       2018-04-17 02:00:00     \N
6       301     102     1       2       2018-04-17 09:13:00     \N
7       23      300     1       12      2018-04-17 12:30:00     \N
8       556     520     2       12      2018-04-17 13:10:00     {"idk": "try"}
9       440     200     8       2       2018-04-17 09:45:23     \N
10      123     456     10      15      2018-04-18 03:27:40     \N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, can, display_name, phone_number, active, name) FROM stdin;
1       1001234567890012        Lionell Loh     8123890 t       lionell
2       8000100020003000        Andre HL        84567890        t       andre
3       8008123456780012        Nikos   88123488        t       nikos
5       8008123456788008        Claire  \N      t       claire
12      6969123412341234        Emir Hamzah     09878909        t       emir
15      6349001200224444        Luo Qi  80001202        t       luoqi
16      1234123400000000        Naomi   92920000        t       naomao
\.


--
-- Name: items_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('items_seq', 10, true);


--
-- Name: users_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_seq', 16, true);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: users users_can_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_can_key UNIQUE (can);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_created_at_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_created_at_1 ON items USING btree (created_at);


--
-- Name: idx_deposited_by_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_deposited_by_1 ON items USING btree (deposited_by);


--
-- Name: items items_deposited_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_deposited_by_fkey FOREIGN KEY (deposited_by) REFERENCES users(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--
