-- Table: public.users

-- DROP TABLE public.users;

CREATE TABLE public.users
(
    id integer NOT NULL DEFAULT nextval('users_seq'::regclass),
    can character varying(16) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    phone_number character varying(10) COLLATE pg_catalog."default",
    active boolean NOT NULL,
    name character varying(30) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT users_can_key UNIQUE (can)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.users
    OWNER to postgres;

-- Table: public.items

-- DROP TABLE public.items;

CREATE TABLE public.items
(
    id integer NOT NULL DEFAULT nextval('items_seq'::regclass),
    score integer NOT NULL,
    mass integer NOT NULL,
    category smallint NOT NULL,
    deposited_by integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    extra_info json,
    CONSTRAINT items_pkey PRIMARY KEY (id),
    CONSTRAINT items_deposited_by_fkey FOREIGN KEY (deposited_by)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE RESTRICT
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.items
    OWNER to postgres;

-- Index: idx_created_at_1

-- DROP INDEX public.idx_created_at_1;

CREATE INDEX idx_created_at_1
    ON public.items USING btree
    (created_at)
    TABLESPACE pg_default;

-- Index: idx_deposited_by_1

-- DROP INDEX public.idx_deposited_by_1;

CREATE INDEX idx_deposited_by_1
    ON public.items USING btree
    (deposited_by)
    TABLESPACE pg_default;