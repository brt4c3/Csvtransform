CREATE TABLE IF NOT EXISTS public."テスト"
(
    "Name" character varying(80) COLLATE pg_catalog."default",
    "Age" character varying(80) COLLATE pg_catalog."default",
    "City" character varying(80) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."テスト"
    OWNER to postgres;