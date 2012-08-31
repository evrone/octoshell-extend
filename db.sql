--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accesses; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE accesses (
    id integer NOT NULL,
    credential_id integer,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cluster_user_id integer
);


ALTER TABLE public.accesses OWNER TO octoshell;

--
-- Name: accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accesses_id_seq OWNER TO octoshell;

--
-- Name: accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE accesses_id_seq OWNED BY accesses.id;


--
-- Name: accesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('accesses_id_seq', 4, true);


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    user_id integer,
    project_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255),
    username character varying(255)
);


ALTER TABLE public.accounts OWNER TO octoshell;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO octoshell;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('accounts_id_seq', 2, true);


--
-- Name: cluster_fields; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE cluster_fields (
    id integer NOT NULL,
    cluster_id integer,
    name character varying(255)
);


ALTER TABLE public.cluster_fields OWNER TO octoshell;

--
-- Name: cluster_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE cluster_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cluster_fields_id_seq OWNER TO octoshell;

--
-- Name: cluster_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE cluster_fields_id_seq OWNED BY cluster_fields.id;


--
-- Name: cluster_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('cluster_fields_id_seq', 5, true);


--
-- Name: cluster_users; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE cluster_users (
    id integer NOT NULL,
    project_id integer,
    state character varying(255),
    cluster_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    request_id integer
);


ALTER TABLE public.cluster_users OWNER TO octoshell;

--
-- Name: cluster_users_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE cluster_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cluster_users_id_seq OWNER TO octoshell;

--
-- Name: cluster_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE cluster_users_id_seq OWNED BY cluster_users.id;


--
-- Name: cluster_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('cluster_users_id_seq', 2, true);


--
-- Name: clusters; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE clusters (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    host character varying(255),
    description character varying(255),
    state character varying(255),
    add_user text DEFAULT 'project=%project%
host=%host%'::text,
    del_user text DEFAULT 'project=%project%
host=%host%'::text,
    add_openkey text DEFAULT 'project=%project%
user=%user%
host=%host%
public_key=%public_key%'::text,
    del_openkey text DEFAULT 'project=%project%
user=%user%
host=%host%
public_key=%public_key%'::text,
    block_user text DEFAULT 'project=%project%
host=%host%'::text,
    unblock_user text DEFAULT 'project=%project%
host=%host%'::text,
    statistic text,
    get_statistic text DEFAULT 'host=%host%'::text,
    statistic_updated_at timestamp without time zone,
    cluster_user_type character varying(255) DEFAULT 'account'::character varying
);


ALTER TABLE public.clusters OWNER TO octoshell;

--
-- Name: clusters_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE clusters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clusters_id_seq OWNER TO octoshell;

--
-- Name: clusters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE clusters_id_seq OWNED BY clusters.id;


--
-- Name: clusters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('clusters_id_seq', 2, false);


--
-- Name: credentials; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE credentials (
    id integer NOT NULL,
    public_key text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255),
    state character varying(255)
);


ALTER TABLE public.credentials OWNER TO octoshell;

--
-- Name: credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credentials_id_seq OWNER TO octoshell;

--
-- Name: credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE credentials_id_seq OWNED BY credentials.id;


--
-- Name: credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('credentials_id_seq', 3, true);


--
-- Name: fields; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE fields (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    model_type character varying(255),
    "position" integer DEFAULT 1,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.fields OWNER TO octoshell;

--
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fields_id_seq OWNER TO octoshell;

--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE fields_id_seq OWNED BY fields.id;


--
-- Name: fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('fields_id_seq', 1, false);


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE memberships (
    id integer NOT NULL,
    user_id integer,
    organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


ALTER TABLE public.memberships OWNER TO octoshell;

--
-- Name: memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.memberships_id_seq OWNER TO octoshell;

--
-- Name: memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE memberships_id_seq OWNED BY memberships.id;


--
-- Name: memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('memberships_id_seq', 2, false);


--
-- Name: organization_kinds; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE organization_kinds (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


ALTER TABLE public.organization_kinds OWNER TO octoshell;

--
-- Name: organization_kinds_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE organization_kinds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_kinds_id_seq OWNER TO octoshell;

--
-- Name: organization_kinds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE organization_kinds_id_seq OWNED BY organization_kinds.id;


--
-- Name: organization_kinds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('organization_kinds_id_seq', 4, false);


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying(255),
    approved boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255),
    abbreviation character varying(255),
    organization_kind_id integer
);


ALTER TABLE public.organizations OWNER TO octoshell;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO octoshell;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('organizations_id_seq', 5, false);


--
-- Name: pages; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    name character varying(255),
    url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.pages OWNER TO octoshell;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO octoshell;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('pages_id_seq', 1, false);


--
-- Name: position_names; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE position_names (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.position_names OWNER TO octoshell;

--
-- Name: position_names_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE position_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.position_names_id_seq OWNER TO octoshell;

--
-- Name: position_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE position_names_id_seq OWNED BY position_names.id;


--
-- Name: position_names_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('position_names_id_seq', 5, false);


--
-- Name: positions; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE positions (
    id integer NOT NULL,
    membership_id integer,
    name character varying(255),
    value character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.positions OWNER TO octoshell;

--
-- Name: positions_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.positions_id_seq OWNER TO octoshell;

--
-- Name: positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE positions_id_seq OWNED BY positions.id;


--
-- Name: positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('positions_id_seq', 2, false);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    state character varying(255),
    description text,
    organization_id integer,
    cluster_user_type character varying(255) DEFAULT 'account'::character varying,
    username character varying(255)
);


ALTER TABLE public.projects OWNER TO octoshell;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO octoshell;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('projects_id_seq', 2, true);


--
-- Name: replies; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE replies (
    id integer NOT NULL,
    user_id integer,
    ticket_id integer,
    message text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    attachment_file_name character varying(255),
    attachment_content_type character varying(255),
    attachment_file_size integer,
    attachment_updated_at timestamp without time zone
);


ALTER TABLE public.replies OWNER TO octoshell;

--
-- Name: replies_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE replies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.replies_id_seq OWNER TO octoshell;

--
-- Name: replies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE replies_id_seq OWNED BY replies.id;


--
-- Name: replies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('replies_id_seq', 5, false);


--
-- Name: request_properties; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE request_properties (
    id integer NOT NULL,
    name character varying(255),
    value character varying(255),
    request_id integer
);


ALTER TABLE public.request_properties OWNER TO octoshell;

--
-- Name: request_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE request_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.request_properties_id_seq OWNER TO octoshell;

--
-- Name: request_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE request_properties_id_seq OWNED BY request_properties.id;


--
-- Name: request_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('request_properties_id_seq', 21, true);


--
-- Name: requests; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE requests (
    id integer NOT NULL,
    project_id integer,
    cluster_id integer,
    hours integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    state character varying(255),
    size integer,
    comment character varying(255)
);


ALTER TABLE public.requests OWNER TO octoshell;

--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requests_id_seq OWNER TO octoshell;

--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE requests_id_seq OWNED BY requests.id;


--
-- Name: requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('requests_id_seq', 6, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO octoshell;

--
-- Name: sureties; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE sureties (
    id integer NOT NULL,
    user_id integer,
    organization_id integer,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    comment character varying(255)
);


ALTER TABLE public.sureties OWNER TO octoshell;

--
-- Name: sureties_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE sureties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sureties_id_seq OWNER TO octoshell;

--
-- Name: sureties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE sureties_id_seq OWNED BY sureties.id;


--
-- Name: sureties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('sureties_id_seq', 2, false);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    command text,
    stderr text,
    stdout text,
    state character varying(255),
    resource_type character varying(255),
    resource_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    procedure character varying(255),
    data text,
    event character varying(255),
    comment character varying(255),
    callbacks_performed boolean DEFAULT false,
    task_id integer
);


ALTER TABLE public.tasks OWNER TO octoshell;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO octoshell;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('tasks_id_seq', 18, true);


--
-- Name: ticket_field_relations; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE ticket_field_relations (
    id integer NOT NULL,
    ticket_question_id integer,
    ticket_field_id integer,
    required boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    use boolean DEFAULT false
);


ALTER TABLE public.ticket_field_relations OWNER TO octoshell;

--
-- Name: ticket_field_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE ticket_field_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_field_relations_id_seq OWNER TO octoshell;

--
-- Name: ticket_field_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE ticket_field_relations_id_seq OWNED BY ticket_field_relations.id;


--
-- Name: ticket_field_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('ticket_field_relations_id_seq', 15, false);


--
-- Name: ticket_field_values; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE ticket_field_values (
    id integer NOT NULL,
    value character varying(255),
    ticket_field_relation_id integer,
    ticket_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ticket_field_values OWNER TO octoshell;

--
-- Name: ticket_field_values_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE ticket_field_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_field_values_id_seq OWNER TO octoshell;

--
-- Name: ticket_field_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE ticket_field_values_id_seq OWNED BY ticket_field_values.id;


--
-- Name: ticket_field_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('ticket_field_values_id_seq', 1, false);


--
-- Name: ticket_fields; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE ticket_fields (
    id integer NOT NULL,
    name character varying(255),
    hint character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


ALTER TABLE public.ticket_fields OWNER TO octoshell;

--
-- Name: ticket_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE ticket_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_fields_id_seq OWNER TO octoshell;

--
-- Name: ticket_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE ticket_fields_id_seq OWNED BY ticket_fields.id;


--
-- Name: ticket_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('ticket_fields_id_seq', 3, false);


--
-- Name: ticket_questions; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE ticket_questions (
    id integer NOT NULL,
    ticket_question_id integer,
    question character varying(255),
    leaf boolean DEFAULT true,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ticket_questions OWNER TO octoshell;

--
-- Name: ticket_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE ticket_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_questions_id_seq OWNER TO octoshell;

--
-- Name: ticket_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE ticket_questions_id_seq OWNED BY ticket_questions.id;


--
-- Name: ticket_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('ticket_questions_id_seq', 8, false);


--
-- Name: ticket_tag_relations; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE ticket_tag_relations (
    id integer NOT NULL,
    ticket_id integer,
    ticket_tag_id integer,
    active boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ticket_tag_relations OWNER TO octoshell;

--
-- Name: ticket_tag_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE ticket_tag_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_tag_relations_id_seq OWNER TO octoshell;

--
-- Name: ticket_tag_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE ticket_tag_relations_id_seq OWNED BY ticket_tag_relations.id;


--
-- Name: ticket_tag_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('ticket_tag_relations_id_seq', 5, false);


--
-- Name: ticket_tags; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE ticket_tags (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


ALTER TABLE public.ticket_tags OWNER TO octoshell;

--
-- Name: ticket_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE ticket_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_tags_id_seq OWNER TO octoshell;

--
-- Name: ticket_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE ticket_tags_id_seq OWNED BY ticket_tags.id;


--
-- Name: ticket_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('ticket_tags_id_seq', 3, false);


--
-- Name: ticket_templates; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE ticket_templates (
    id integer NOT NULL,
    subject character varying(255),
    message text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


ALTER TABLE public.ticket_templates OWNER TO octoshell;

--
-- Name: ticket_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE ticket_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_templates_id_seq OWNER TO octoshell;

--
-- Name: ticket_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE ticket_templates_id_seq OWNED BY ticket_templates.id;


--
-- Name: ticket_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('ticket_templates_id_seq', 2, false);


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE tickets (
    id integer NOT NULL,
    subject character varying(255),
    message text,
    user_id integer,
    state character varying(255),
    url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    attachment_file_name character varying(255),
    attachment_content_type character varying(255),
    attachment_file_size integer,
    attachment_updated_at timestamp without time zone,
    ticket_question_id integer,
    project_id integer,
    cluster_id integer
);


ALTER TABLE public.tickets OWNER TO octoshell;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO octoshell;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE tickets_id_seq OWNED BY tickets.id;


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('tickets_id_seq', 3, false);


--
-- Name: users; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    crypted_password character varying(255),
    salt character varying(255),
    remember_me_token character varying(255),
    remember_me_token_expires_at timestamp without time zone,
    reset_password_token character varying(255),
    reset_password_token_expires_at timestamp without time zone,
    reset_password_email_sent_at timestamp without time zone,
    activation_state character varying(255),
    activation_token character varying(255),
    activation_token_expires_at timestamp without time zone,
    first_name character varying(255),
    last_name character varying(255),
    middle_name character varying(255),
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    admin boolean DEFAULT false,
    state character varying(255),
    token character varying(255),
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO octoshell;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO octoshell;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('users_id_seq', 6, false);


--
-- Name: values; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE "values" (
    id integer NOT NULL,
    field_id integer,
    model_id integer,
    model_type integer,
    value text,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public."values" OWNER TO octoshell;

--
-- Name: values_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.values_id_seq OWNER TO octoshell;

--
-- Name: values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE values_id_seq OWNED BY "values".id;


--
-- Name: values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('values_id_seq', 1, false);


--
-- Name: versions; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone,
    object_changes text
);


ALTER TABLE public.versions OWNER TO octoshell;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO octoshell;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('versions_id_seq', 214, true);


--
-- Name: wiki_urls; Type: TABLE; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE TABLE wiki_urls (
    id integer NOT NULL,
    page_id integer,
    url character varying(255)
);


ALTER TABLE public.wiki_urls OWNER TO octoshell;

--
-- Name: wiki_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: octoshell
--

CREATE SEQUENCE wiki_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wiki_urls_id_seq OWNER TO octoshell;

--
-- Name: wiki_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: octoshell
--

ALTER SEQUENCE wiki_urls_id_seq OWNED BY wiki_urls.id;


--
-- Name: wiki_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: octoshell
--

SELECT pg_catalog.setval('wiki_urls_id_seq', 1, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY accesses ALTER COLUMN id SET DEFAULT nextval('accesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY cluster_fields ALTER COLUMN id SET DEFAULT nextval('cluster_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY cluster_users ALTER COLUMN id SET DEFAULT nextval('cluster_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY clusters ALTER COLUMN id SET DEFAULT nextval('clusters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY credentials ALTER COLUMN id SET DEFAULT nextval('credentials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY fields ALTER COLUMN id SET DEFAULT nextval('fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY memberships ALTER COLUMN id SET DEFAULT nextval('memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY organization_kinds ALTER COLUMN id SET DEFAULT nextval('organization_kinds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY position_names ALTER COLUMN id SET DEFAULT nextval('position_names_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY positions ALTER COLUMN id SET DEFAULT nextval('positions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY replies ALTER COLUMN id SET DEFAULT nextval('replies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY request_properties ALTER COLUMN id SET DEFAULT nextval('request_properties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY sureties ALTER COLUMN id SET DEFAULT nextval('sureties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY ticket_field_relations ALTER COLUMN id SET DEFAULT nextval('ticket_field_relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY ticket_field_values ALTER COLUMN id SET DEFAULT nextval('ticket_field_values_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY ticket_fields ALTER COLUMN id SET DEFAULT nextval('ticket_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY ticket_questions ALTER COLUMN id SET DEFAULT nextval('ticket_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY ticket_tag_relations ALTER COLUMN id SET DEFAULT nextval('ticket_tag_relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY ticket_tags ALTER COLUMN id SET DEFAULT nextval('ticket_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY ticket_templates ALTER COLUMN id SET DEFAULT nextval('ticket_templates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY tickets ALTER COLUMN id SET DEFAULT nextval('tickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY "values" ALTER COLUMN id SET DEFAULT nextval('values_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: octoshell
--

ALTER TABLE ONLY wiki_urls ALTER COLUMN id SET DEFAULT nextval('wiki_urls_id_seq'::regclass);


--
-- Data for Name: accesses; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY accesses (id, credential_id, state, created_at, updated_at, cluster_user_id) FROM stdin;
2	1	closed	2012-08-21 12:10:46.733585	2012-08-29 11:59:35.578152	1
1	2	closed	2012-08-21 12:10:46.697631	2012-08-29 11:59:36.164726	1
3	1	active	2012-08-29 11:59:37.642202	2012-08-29 11:59:38.290544	2
4	3	activing	2012-08-29 12:48:44.661547	2012-08-29 12:48:44.661547	2
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY accounts (id, user_id, project_id, created_at, updated_at, state, username) FROM stdin;
1	1	1	2012-08-21 11:45:49.667293	2012-08-29 11:56:00.500893	closed	account_1
2	1	2	2012-08-29 11:58:27.13757	2012-08-29 11:58:27.239448	active	account_2
\.


--
-- Data for Name: cluster_fields; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY cluster_fields (id, cluster_id, name) FROM stdin;
1	1	Atata
2	1	Moo
3	1	Booo
4	1	Fooo
5	1	foo
\.


--
-- Data for Name: cluster_users; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY cluster_users (id, project_id, state, cluster_id, created_at, updated_at, request_id) FROM stdin;
1	1	closed	1	2012-08-21 12:06:34.938125	2012-08-29 11:59:36.804708	3
2	2	active	1	2012-08-29 11:58:39.318851	2012-08-29 12:22:47.230913	6
\.


--
-- Data for Name: clusters; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY clusters (id, name, created_at, updated_at, host, description, state, add_user, del_user, add_openkey, del_openkey, block_user, unblock_user, statistic, get_statistic, statistic_updated_at, cluster_user_type) FROM stdin;
1	Ломоносов	2012-08-21 08:35:00.526027	2012-08-29 12:00:43.239275	lomonosov.parallel.ru		active	project=%project%\r\nhost=%host%	project=%project%\r\nhost=%host%	project=%project%\r\nuser=%user%\r\nhost=%host%\r\npublic_key=%public_key%	project=%project%\r\nuser=%user%\r\nhost=%host%\r\npublic_key=%public_key%	project=%project%\r\nhost=%host%	project=%project%\r\nhost=%host%\r\nfoo=%foo%	\N	host=%host%	\N	account
\.


--
-- Data for Name: credentials; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY credentials (id, public_key, user_id, created_at, updated_at, name, state) FROM stdin;
1	atata	1	2012-08-21 09:00:43.737834	2012-08-21 09:00:43.737834	Macbook	active
2	ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD releu@me.com\n	1	2012-08-21 10:20:30.289557	2012-08-21 10:21:28.785332	iMac	closed
3	iii	1	2012-08-29 12:48:44.606106	2012-08-29 12:48:44.606106	ii	active
\.


--
-- Data for Name: fields; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY fields (id, name, code, model_type, "position", deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: memberships; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY memberships (id, user_id, organization_id, created_at, updated_at, state) FROM stdin;
1	1	1	2012-08-21 08:31:06.870304	2012-08-21 08:31:06.870304	active
\.


--
-- Data for Name: organization_kinds; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY organization_kinds (id, name, created_at, updated_at, state) FROM stdin;
1	ВУЗ	2012-08-21 08:04:23.083473	2012-08-21 08:04:23.083473	active
2	ООО	2012-08-21 08:05:59.847984	2012-08-21 08:05:59.847984	active
3	НИИ	2012-08-21 08:06:10.473092	2012-08-21 08:06:10.473092	active
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY organizations (id, name, approved, created_at, updated_at, state, abbreviation, organization_kind_id) FROM stdin;
1	Evrone	f	2012-08-21 08:08:29.570732	2012-08-21 08:08:29.570732	active	EVR	2
2	Московский Государственный Институт	f	2012-08-21 08:10:10.401863	2012-08-21 08:10:10.401863	active	МГУ	1
4	Umbrella	f	2012-08-21 13:55:09.954994	2012-08-21 13:56:08.797692	closed		3
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY pages (id, name, url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: position_names; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY position_names (id, name, created_at, updated_at) FROM stdin;
1	Факультет	2012-08-21 08:07:17.423515	2012-08-21 08:07:17.423515
2	Кафедра	2012-08-21 08:07:22.779602	2012-08-21 08:07:22.779602
3	Должность	2012-08-21 08:07:36.272265	2012-08-21 08:07:36.272265
4	Группа	2012-08-21 08:07:43.285538	2012-08-21 08:07:43.285538
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY positions (id, membership_id, name, value, created_at, updated_at) FROM stdin;
1	1	Должность	Developer	2012-08-21 08:31:06.88706	2012-08-21 08:31:06.88706
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY projects (id, name, created_at, updated_at, user_id, state, description, organization_id, cluster_user_type, username) FROM stdin;
1	Octoshell	2012-08-21 11:45:49.654544	2012-08-29 11:56:00.481888	1	closed	octoshell || octoshell	1	account	project_1
2	Octoshell2	2012-08-29 11:58:27.125575	2012-08-29 11:58:27.125575	1	active	atata	1	account	project_2
\.


--
-- Data for Name: replies; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY replies (id, user_id, ticket_id, message, created_at, updated_at, attachment_file_name, attachment_content_type, attachment_file_size, attachment_updated_at) FROM stdin;
2	2	1	Пришлите команду которой вы компилите	2012-08-21 14:21:29.616605	2012-08-21 14:21:29.616605	\N	\N	\N	\N
3	1	1	gcc ~/octoprog.c	2012-08-21 14:34:25.008063	2012-08-21 14:34:25.008063	\N	\N	\N	\N
4	2	1	Попробуйте сейчас	2012-08-21 14:34:54.152757	2012-08-21 14:34:54.152757	\N	\N	\N	\N
\.


--
-- Data for Name: request_properties; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY request_properties (id, name, value, request_id) FROM stdin;
2	Fooo	\N	2
3	Fooo	\N	1
1	Fooo	atata	3
4	Fooo	\N	4
5	Booo	\N	4
6	Moo	\N	4
7	Atata	\N	4
8	foo	\N	4
9	foo	\N	3
10	foo	\N	2
11	foo	\N	1
16	Atata		5
15	Moo		5
14	Booo		5
13	Fooo		5
12	foo	ASS	5
21	Atata		6
20	Moo		6
19	Booo		6
18	Fooo		6
17	foo	MOOOO	6
\.


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY requests (id, project_id, cluster_id, hours, created_at, updated_at, user_id, state, size, comment) FROM stdin;
1	1	1	8	2012-08-21 11:45:49.672558	2012-08-21 12:22:14.278712	1	closed	80	\N
3	1	1	8	2012-08-29 07:34:21.087434	2012-08-29 11:56:00.64267	1	closed	8	\N
2	1	1	80	2012-08-21 12:28:42.405202	2012-08-29 11:56:00.662704	1	closed	20	\N
4	2	1	1	2012-08-29 11:58:27.15138	2012-08-29 12:00:16.441663	1	closed	1	\N
5	2	1	9	2012-08-29 12:01:47.011765	2012-08-29 12:20:45.42991	1	closed	9	\N
6	2	1	40	2012-08-29 12:22:27.792239	2012-08-29 12:22:44.127437	1	active	40	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY schema_migrations (version) FROM stdin;
20120625091607
20120625091702
20120625093054
20120625102409
20120702122615
20120702122620
20120702122743
20120702123456
20120702130155
20120705082712
20120705090302
20120705131126
20120705131902
20120706124017
20120706124026
20120709094812
20120709130827
20120709131414
20120710150558
20120711091210
20120711130431
20120712142445
20120712152419
20120712153438
20120714091500
20120714091825
20120716122113
20120716150356
20120716171340
20120716173112
20120716173428
20120717133613
20120717140217
20120717161737
20120717163714
20120718053342
20120718090150
20120719154306
20120720045505
20120725130726
20120725160758
20120726071300
20120726074929
20120727084256
20120730081216
20120730092038
20120731150244
20120731150253
20120731153033
20120731153216
20120731153241
20120802100241
20120803082355
20120803122032
20120807085105
20120807113713
20120807140657
20120808100831
20120808112712
20120808134601
20120808140622
20120808142537
20120808143448
20120810135419
20120813065136
20120813070320
20120813124920
20120814065820
20120814085711
20120814120703
20120814124240
20120814131611
20120815072909
20120815072931
20120815140147
20120816135845
20120817095402
20120817110839
20120821120903
20120821140700
20120822070948
20120822100643
20120822100727
20120822113620
20120824091450
20120827092750
20120827095938
20120827100021
20120827101312
20120827134130
20120828110623
20120828135427
20120828142248
20120829062633
20120829062910
20120829094834
\.


--
-- Data for Name: sureties; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY sureties (id, user_id, organization_id, state, created_at, updated_at, comment) FROM stdin;
1	1	1	active	2012-08-21 11:38:29.72647	2012-08-21 11:45:00.839115	\N
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY tasks (id, command, stderr, stdout, state, resource_type, resource_id, created_at, updated_at, procedure, data, event, comment, callbacks_performed, task_id) FROM stdin;
1	user=%user\r\n%host="lomonosov.parallel.ru"	bash: line 1: fg: no job control\n		failed	ClusterUser	1	2012-08-21 12:06:35.046108	2012-08-21 12:06:36.22882	add_user	\N	\N	\N	f	\N
2	user="project_1"\r\nhost="lomonosov.parallel.ru"			successed	ClusterUser	1	2012-08-21 12:10:43.163073	2012-08-21 12:10:46.752123	add_user	\N	\N	\N	t	\N
3	user="project_1"\r\nhost="lomonosov.parallel.ru"\r\npublic_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD releu@me.com\n"			successed	Access	1	2012-08-21 12:10:46.725237	2012-08-21 12:10:47.011597	add_openkey	\N	\N	\N	t	\N
4	user="project_1"\r\nhost="lomonosov.parallel.ru"\r\npublic_key="atata"			successed	Access	2	2012-08-21 12:10:46.746346	2012-08-21 12:10:47.276529	add_openkey	\N	\N	\N	t	\N
5	user="project_1"\r\nhost="lomonosov.parallel.ru"			successed	ClusterUser	1	2012-08-21 12:22:14.298482	2012-08-21 12:22:17.759967	block_user	\N	\N	\N	t	\N
6	user="project_1"\r\nhost="lomonosov.parallel.ru"			successed	ClusterUser	1	2012-08-21 12:28:45.914615	2012-08-21 12:28:48.166829	unblock_user	\N	\N	\N	t	\N
9	project="project_1"\r\nuser="account_1"\r\nhost="lomonosov.parallel.ru"\r\npublic_key="atata"			successed	Access	2	2012-08-29 11:56:00.538684	2012-08-29 11:59:35.586758	del_openkey	\N	\N	\N	t	\N
10	project="project_1"\r\nuser="account_1"\r\nhost="lomonosov.parallel.ru"\r\npublic_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD releu@me.com\n"			successed	Access	1	2012-08-29 11:56:00.573364	2012-08-29 11:59:36.173193	del_openkey	\N	\N	\N	t	\N
11	project="project_1"\r\nhost="lomonosov.parallel.ru"			successed	ClusterUser	1	2012-08-29 11:56:00.619419	2012-08-29 11:59:36.813141	del_user	\N	\N	\N	t	\N
12	project="project_2"\r\nhost="lomonosov.parallel.ru"			successed	ClusterUser	2	2012-08-29 11:58:39.351183	2012-08-29 11:59:37.709269	add_user	\N	\N	\N	t	\N
13	project="project_2"\r\nuser="account_2"\r\nhost="lomonosov.parallel.ru"\r\npublic_key="atata"			successed	Access	3	2012-08-29 11:59:37.696625	2012-08-29 11:59:38.299796	add_openkey	\N	\N	\N	t	\N
14	project="project_2"\r\nhost="lomonosov.parallel.ru"			successed	ClusterUser	2	2012-08-29 12:00:16.468379	2012-08-29 12:00:18.97705	block_user	\N	\N	\N	t	\N
15	project="project_2"\r\nhost="lomonosov.parallel.ru"\r\nfoo=""			successed	ClusterUser	2	2012-08-29 12:02:02.600023	2012-08-29 12:02:04.688955	unblock_user	\N	\N	\N	t	\N
16	project="project_2"\r\nhost="lomonosov.parallel.ru"			successed	ClusterUser	2	2012-08-29 12:20:45.512243	2012-08-29 12:21:35.431663	block_user	\N	\N	\N	t	\N
17	project="project_2"\r\nhost="lomonosov.parallel.ru"\r\nfoo="MOOOO"			successed	ClusterUser	2	2012-08-29 12:22:44.178176	2012-08-29 12:22:47.240519	unblock_user	\N	\N	\N	t	\N
18	project="project_2"\r\nuser="account_2"\r\nhost="lomonosov.parallel.ru"\r\npublic_key="iii"	\N	\N	pending	Access	4	2012-08-29 12:48:44.861548	2012-08-29 12:48:44.861548	add_openkey	\N	\N	\N	f	\N
\.


--
-- Data for Name: ticket_field_relations; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY ticket_field_relations (id, ticket_question_id, ticket_field_id, required, created_at, updated_at, use) FROM stdin;
1	1	1	f	2012-08-21 08:42:08.466381	2012-08-21 08:42:08.466381	f
2	1	2	f	2012-08-21 12:31:29.104036	2012-08-21 12:31:29.104036	f
3	2	1	f	2012-08-21 12:33:55.246161	2012-08-21 12:33:55.246161	f
4	2	2	f	2012-08-21 12:33:55.249335	2012-08-21 12:33:55.249335	f
5	3	1	f	2012-08-21 12:34:06.549188	2012-08-21 12:34:06.549188	f
6	3	2	f	2012-08-21 12:34:06.552637	2012-08-21 12:34:06.552637	f
7	4	1	f	2012-08-21 12:34:39.402913	2012-08-21 12:34:39.402913	f
8	4	2	f	2012-08-21 12:34:39.406221	2012-08-21 12:34:39.406221	f
9	5	1	f	2012-08-21 12:34:49.081617	2012-08-21 12:34:49.081617	f
10	5	2	f	2012-08-21 12:34:49.085601	2012-08-21 12:34:49.085601	f
11	6	1	f	2012-08-21 12:35:03.207416	2012-08-21 12:35:03.207416	f
12	6	2	f	2012-08-21 12:35:03.211191	2012-08-21 12:35:03.211191	f
13	7	1	t	2012-08-21 12:35:25.393172	2012-08-21 13:13:07.294824	t
14	7	2	t	2012-08-21 12:35:25.397188	2012-08-21 13:13:07.298816	t
\.


--
-- Data for Name: ticket_field_values; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY ticket_field_values (id, value, ticket_field_relation_id, ticket_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ticket_fields; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY ticket_fields (id, name, hint, created_at, updated_at, state) FROM stdin;
1	Комманда		2012-08-21 06:45:22.296371	2012-08-21 06:45:22.296371	active
2	Текущий каталог	pwd	2012-08-21 12:31:29.065315	2012-08-21 12:31:29.065315	active
\.


--
-- Data for Name: ticket_questions; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY ticket_questions (id, ticket_question_id, question, leaf, state, created_at, updated_at) FROM stdin;
1	\N	Другое	t	active	2012-08-21 08:42:08.393941	2012-08-21 12:59:51.4442
2	\N	Не могу войти!	t	active	2012-08-21 12:33:55.221747	2012-08-21 13:12:36.146109
3	\N	Не могу получить доступ	f	active	2012-08-21 12:34:06.544481	2012-08-21 12:34:39.396143
4	3	У меня есть поручительство	t	active	2012-08-21 12:34:39.398512	2012-08-21 12:34:39.398512
5	3	У меня нет поручительства	t	active	2012-08-21 12:34:49.076685	2012-08-21 12:34:49.076685
6	\N	Проблема с кириллицей	t	active	2012-08-21 12:35:03.202286	2012-08-21 12:35:03.202286
7	\N	Проблема с компиляцией	t	active	2012-08-21 12:35:25.388201	2012-08-21 12:35:25.388201
\.


--
-- Data for Name: ticket_tag_relations; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY ticket_tag_relations (id, ticket_id, ticket_tag_id, active, created_at, updated_at) FROM stdin;
1	1	1	t	2012-08-21 08:43:04.728992	2012-08-21 08:56:31.566522
2	1	2	t	2012-08-21 08:52:53.732552	2012-08-21 08:56:34.470577
3	2	2	f	2012-08-21 11:40:35.076117	2012-08-21 11:40:35.076117
4	2	1	f	2012-08-21 11:40:35.126098	2012-08-21 11:40:35.126098
\.


--
-- Data for Name: ticket_tags; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY ticket_tags (id, name, created_at, updated_at, state) FROM stdin;
1	Проблема с пользователем	2012-08-21 07:10:17.668068	2012-08-21 07:10:17.668068	active
2	Регистрация	2012-08-21 08:52:53.726471	2012-08-21 12:32:17.267791	active
\.


--
-- Data for Name: ticket_templates; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY ticket_templates (id, subject, message, created_at, updated_at, state) FROM stdin;
1	Сил больше нет	Закройте браузер и отойдите от компьютера	2012-08-21 07:12:40.242762	2012-08-21 07:12:40.242762	active
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY tickets (id, subject, message, user_id, state, url, created_at, updated_at, attachment_file_name, attachment_content_type, attachment_file_size, attachment_updated_at, ticket_question_id, project_id, cluster_id) FROM stdin;
1	Не могу скомпилиться	Не выходит ничего	1	answered		2012-08-21 08:43:04.673299	2012-08-21 14:34:54.161585	\N	\N	\N	\N	1	\N	1
2	Скан поручительства	Вот скан	1	resolved		2012-08-21 11:40:35.00096	2012-08-21 11:40:38.095689	\N	\N	\N	\N	1	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY users (id, email, crypted_password, salt, remember_me_token, remember_me_token_expires_at, reset_password_token, reset_password_token_expires_at, reset_password_email_sent_at, activation_state, activation_token, activation_token_expires_at, first_name, last_name, middle_name, deleted_at, created_at, updated_at, admin, state, token, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at) FROM stdin;
1	releu@me.com	$2a$10$GpiGlwjdNV5nF5B2TEGHP.J8VVWPpxRDgm3hrpLpfpYs5rey6Upkm	b4Pz3hVYCPqH3DvYuupf	\N	\N	\N	\N	\N	active	\N	\N	Sergey	Tolubaev		\N	2012-08-21 06:23:18.692945	2012-08-21 14:16:22.989033	f	sured	78e4c941d0c7982855626ed0caecdd92c0a9ad90	\N	\N	\N	\N
2	janbernacki@me.com	$2a$10$q3k1M2aXmkjSwpQvtF3LO.RzNqO6VzHTE4hGUn9D.GMrOPavnvDoS	4hxd6XqqGVpYpD31x4BD	\N	\N	\N	\N	\N	active	\N	\N	Jan	Bernacki		\N	2012-08-21 06:23:36.350856	2012-08-21 14:16:22.98216	t	active	88ebd48305ce47ba6395be072a3fe7b63691a83e	\N	\N	\N	\N
3	areleu@gmail.com	$2a$10$qGCJDDgbhpkcDTYMk1UmmuDhEx/sQ7BynRJa2IgwvUvs8VWrwjDd2	2Ecy97eqVzDxjqm4xJ9B	\N	\N	\N	\N	\N	active	\N	\N	John	Smith		\N	2012-08-21 14:59:18.579517	2012-08-21 15:02:56.62316	f	active	e54b65b58b2362ec7b4c7508d6f40e490528fc96	\N	\N	\N	\N
4	serg@parallel.ru	$2a$10$3fpzZ/NBjr9/fEh2wEMu9.xZoL1uVHLnFgVqwv8CSbDuVkURiP4Uu	udncVgooLxmnFy8HUsVR	\N	\N	\N	\N	\N	active	\N	\N	Sergey	Zhumatiy		\N	2012-08-28 08:03:54.45671	2012-08-28 08:05:20.895452	t	active	bf213d523c133c0c3a4b9df9da060afe45b1545a	\N	\N	\N	\N
5	dan@parallel.ru	$2a$10$VuKPTACyi/6x3qqAbkS/NuLzI34kyIfuS.rK6/FS0AM9fuLgMxToa	PY2Tyay5Ssd1sKqeyqEy	\N	\N	\N	\N	\N	active	\N	\N	Dmitry	Nikitenko		\N	2012-08-28 08:04:15.810051	2012-08-28 08:05:06.938137	t	active	d8ef06d3176fa9e8e1d7104ba1e2d8b970dce7ad	\N	\N	\N	\N
\.


--
-- Data for Name: values; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY "values" (id, field_id, model_id, model_type, value, deleted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY versions (id, item_type, item_id, event, whodunnit, object, created_at, object_changes) FROM stdin;
1	User	1	create	f	\N	2012-08-21 06:23:18.747393	\N
2	User	2	create	f	\N	2012-08-21 06:23:36.352892	\N
3	User	1	update	f	---\nemail: releu@me.com\ncrypted_password: $2a$10$GpiGlwjdNV5nF5B2TEGHP.J8VVWPpxRDgm3hrpLpfpYs5rey6Upkm\nsalt: b4Pz3hVYCPqH3DvYuupf\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: pending\nactivation_token: qrMQ2Dxsb7Q7cYTznnu2\nactivation_token_expires_at: \nfirst_name: Sergey\nlast_name: Tolubaev\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:18.692945000 Z\nupdated_at: 2012-08-21 06:23:18.692945000 Z\nadmin: false\nstate: active\nid: 1\n	2012-08-21 06:23:45.958435	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nactivation_token:\n- qrMQ2Dxsb7Q7cYTznnu2\n- \nactivation_state:\n- pending\n- active\n
4	User	2	update	1	---\nemail: janbernacki@me.com\ncrypted_password: $2a$10$q3k1M2aXmkjSwpQvtF3LO.RzNqO6VzHTE4hGUn9D.GMrOPavnvDoS\nsalt: 4hxd6XqqGVpYpD31x4BD\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: pending\nactivation_token: cRTGudYUUXS9DQuYZvzv\nactivation_token_expires_at: \nfirst_name: Jan\nlast_name: Bernacki\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:36.350856000 Z\nupdated_at: 2012-08-21 06:23:36.350856000 Z\nadmin: false\nstate: active\nid: 2\n	2012-08-21 06:23:50.119222	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nactivation_token:\n- cRTGudYUUXS9DQuYZvzv\n- \nactivation_state:\n- pending\n- active\n
5	User	2	update	\N	---\nemail: janbernacki@me.com\ncrypted_password: $2a$10$q3k1M2aXmkjSwpQvtF3LO.RzNqO6VzHTE4hGUn9D.GMrOPavnvDoS\nsalt: 4hxd6XqqGVpYpD31x4BD\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Jan\nlast_name: Bernacki\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:36.350856000 Z\nupdated_at: 2012-08-21 06:23:50.117934000 Z\nadmin: false\nstate: active\nid: 2\n	2012-08-21 06:45:01.350396	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nadmin:\n- false\n- true\n
6	TicketField	1	create	2	\N	2012-08-21 06:45:22.299547	\N
7	TicketTag	1	create	2	\N	2012-08-21 07:10:17.692427	\N
8	TicketTemplate	1	create	2	\N	2012-08-21 07:12:40.246053	\N
9	OrganizationKind	1	create	2	\N	2012-08-21 08:04:23.133702	\N
10	OrganizationKind	2	create	2	\N	2012-08-21 08:05:59.849556	\N
11	OrganizationKind	3	create	2	\N	2012-08-21 08:06:10.475399	\N
12	PositionName	1	create	2	\N	2012-08-21 08:07:17.426551	\N
13	PositionName	2	create	2	\N	2012-08-21 08:07:22.781642	\N
14	PositionName	3	create	2	\N	2012-08-21 08:07:36.273878	\N
15	PositionName	4	create	2	\N	2012-08-21 08:07:43.287003	\N
16	Organization	1	create	2	\N	2012-08-21 08:08:29.583868	\N
17	Organization	2	create	2	\N	2012-08-21 08:10:10.403731	\N
18	Membership	1	create	2	\N	2012-08-21 08:31:06.884426	\N
19	Position	1	create	2	\N	2012-08-21 08:31:06.890296	\N
20	Cluster	1	create	2	\N	2012-08-21 08:35:00.529502	\N
21	TicketQuestion	1	create	2	\N	2012-08-21 08:42:08.418586	\N
22	TicketFieldRelation	1	create	2	\N	2012-08-21 08:42:08.469592	\N
23	Ticket	1	create	2	\N	2012-08-21 08:43:04.688299	\N
24	TicketTag	2	create	2	\N	2012-08-21 08:52:53.728941	\N
25	Credential	1	create	2	\N	2012-08-21 09:00:43.746375	\N
26	Credential	2	create	2	\N	2012-08-21 10:20:30.299832	\N
27	Credential	2	update	2	---\npublic_key: ! 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD\n  releu@me.com\n\n'\nuser_id: 1\ncreated_at: 2012-08-21 10:20:30.289557000 Z\nupdated_at: 2012-08-21 10:20:30.289557000 Z\nname: iMac\nstate: active\nid: 2\n	2012-08-21 10:21:28.787389	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
28	Surety	1	create	1	\N	2012-08-21 11:38:29.787082	\N
29	Ticket	2	create	1	\N	2012-08-21 11:40:35.020262	\N
30	Ticket	2	update	1	---\nsubject: Скан поручительства\nmessage: Вот скан\nuser_id: 1\nstate: active\nurl: ''\ncreated_at: 2012-08-21 11:40:35.000960000 Z\nupdated_at: 2012-08-21 11:40:35.000960000 Z\nattachment_file_name: \nattachment_content_type: \nattachment_file_size: \nattachment_updated_at: \nticket_question_id: 1\nproject_id: \ncluster_id: \nid: 2\n	2012-08-21 11:40:38.09737	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- resolved\n
31	Surety	1	update	2	---\nuser_id: 1\norganization_id: 1\nstate: pending\ncreated_at: 2012-08-21 11:38:29.726470000 Z\nupdated_at: 2012-08-21 11:38:29.726470000 Z\ncomment: \nid: 1\n	2012-08-21 11:45:00.840367	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
32	User	1	update	2	---\nemail: releu@me.com\ncrypted_password: $2a$10$GpiGlwjdNV5nF5B2TEGHP.J8VVWPpxRDgm3hrpLpfpYs5rey6Upkm\nsalt: b4Pz3hVYCPqH3DvYuupf\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Sergey\nlast_name: Tolubaev\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:18.692945000 Z\nupdated_at: 2012-08-21 06:23:45.956831000 Z\nadmin: false\nstate: active\nid: 1\n	2012-08-21 11:45:00.92594	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- sured\n
33	Project	1	create	1	\N	2012-08-21 11:45:49.663039	\N
34	Account	1	create	1	\N	2012-08-21 11:45:49.670784	\N
35	Request	1	create	1	\N	2012-08-21 11:45:49.676376	\N
36	Account	1	update	1	---\nuser_id: 1\nproject_id: 1\ncreated_at: 2012-08-21 11:45:49.667293000 Z\nupdated_at: 2012-08-21 11:45:49.667293000 Z\nstate: pending\nid: 1\n	2012-08-21 11:45:49.686587	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
37	Request	1	update	2	---\nproject_id: 1\ncluster_id: 1\nhours: 8\ncreated_at: 2012-08-21 11:45:49.672558000 Z\nupdated_at: 2012-08-21 11:45:49.672558000 Z\nuser_id: 1\nstate: pending\nsize: 80\ncomment: \nid: 1\n	2012-08-21 12:06:34.925342	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
38	ClusterUser	1	create	2	\N	2012-08-21 12:06:34.99537	\N
39	ClusterUser	1	update	2	---\nproject_id: \nstate: pending\ncluster_id: \ncreated_at: \nupdated_at: \nid: \n	2012-08-21 12:06:35.00072	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nproject_id:\n- \n- 1\ncluster_id:\n- \n- 1\ncreated_at:\n- \n- 2012-08-21 12:06:34.938125000 Z\nupdated_at:\n- \n- 2012-08-21 12:06:34.938125000 Z\nid:\n- \n- 1\nstate:\n- pending\n- activing\n
40	Task	1	create	2	\N	2012-08-21 12:06:35.05015	\N
41	Task	1	update	\N	---\ncommand: ! "user=%user\\r\\n%host=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-21 12:06:35.046108000 Z\nupdated_at: 2012-08-21 12:06:35.046108000 Z\nprocedure: add_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 1\n	2012-08-21 12:06:36.233651	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ! 'bash: line 1: fg: no job control\n\n'\nstdout:\n- \n- ''\nstate:\n- pending\n- failed\n
42	Cluster	1	update	2	---\nname: Ломоносов\ncreated_at: 2012-08-21 08:35:00.526027000 Z\nupdated_at: 2012-08-21 08:35:00.526027000 Z\nhost: lomonosov.parallel.ru\ndescription: ''\nstate: active\nadd_user: ! "user=%user\\r\\n%host=%host%"\ndel_user: ! "user=%user%\\r\\nhost=%host%"\nadd_openkey: ! "user=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\ndel_openkey: ! "user=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\nblock_user: ! "user=%user%\\r\\nhost=%host%"\nunblock_user: ! "user=%user%\\r\\nhost=%host%"\nid: 1\n	2012-08-21 12:07:51.708173	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nadd_user:\n- ! "user=%user\\r\\n%host=%host%"\n- ! "user=%user%\\r\\nhost=%host%"\n
43	Task	2	create	2	\N	2012-08-21 12:10:43.165363	\N
44	Task	2	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-21 12:10:43.163073000 Z\nupdated_at: 2012-08-21 12:10:43.163073000 Z\nprocedure: add_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 2\n	2012-08-21 12:10:46.530644	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
45	ClusterUser	1	update	\N	---\nproject_id: 1\nstate: activing\ncluster_id: 1\ncreated_at: 2012-08-21 12:06:34.938125000 Z\nupdated_at: 2012-08-21 12:06:34.938125000 Z\nid: 1\n	2012-08-21 12:10:46.576112	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- activing\n- active\n
46	Access	1	create	\N	\N	2012-08-21 12:10:46.709185	\N
47	Access	1	update	\N	---\ncredential_id: \nstate: pending\ncreated_at: \nupdated_at: \ncluster_user_id: \nid: \n	2012-08-21 12:10:46.714405	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncluster_user_id:\n- \n- 1\ncredential_id:\n- \n- 2\ncreated_at:\n- \n- 2012-08-21 12:10:46.697631000 Z\nupdated_at:\n- \n- 2012-08-21 12:10:46.697631000 Z\nid:\n- \n- 1\nstate:\n- pending\n- activing\n
48	Task	3	create	\N	\N	2012-08-21 12:10:46.72768	\N
49	Access	2	create	\N	\N	2012-08-21 12:10:46.735279	\N
50	Access	2	update	\N	---\ncredential_id: \nstate: pending\ncreated_at: \nupdated_at: \ncluster_user_id: \nid: \n	2012-08-21 12:10:46.739127	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncluster_user_id:\n- \n- 1\ncredential_id:\n- \n- 1\ncreated_at:\n- \n- 2012-08-21 12:10:46.733585000 Z\nupdated_at:\n- \n- 2012-08-21 12:10:46.733585000 Z\nid:\n- \n- 2\nstate:\n- pending\n- activing\n
51	Task	4	create	\N	\N	2012-08-21 12:10:46.748177	\N
52	Task	2	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-21 12:10:43.163073000 Z\nupdated_at: 2012-08-21 12:10:46.525737000 Z\nprocedure: add_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 2\n	2012-08-21 12:10:46.753188	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
53	Task	3	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"ssh-rsa\n  AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD\n  releu@me.com\\n\\""\nstderr: \nstdout: \nstate: pending\nresource_type: Access\nresource_id: 1\ncreated_at: 2012-08-21 12:10:46.725237000 Z\nupdated_at: 2012-08-21 12:10:46.725237000 Z\nprocedure: add_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 3\n	2012-08-21 12:10:46.971672	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
54	Access	1	update	\N	---\ncredential_id: 2\nstate: activing\ncreated_at: 2012-08-21 12:10:46.697631000 Z\nupdated_at: 2012-08-21 12:10:46.697631000 Z\ncluster_user_id: 1\nid: 1\n	2012-08-21 12:10:47.007863	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- activing\n- active\n
55	Task	3	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"ssh-rsa\n  AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD\n  releu@me.com\\n\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: Access\nresource_id: 1\ncreated_at: 2012-08-21 12:10:46.725237000 Z\nupdated_at: 2012-08-21 12:10:46.967124000 Z\nprocedure: add_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 3\n	2012-08-21 12:10:47.012808	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
56	Task	4	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"atata\\""\nstderr: \nstdout: \nstate: pending\nresource_type: Access\nresource_id: 2\ncreated_at: 2012-08-21 12:10:46.746346000 Z\nupdated_at: 2012-08-21 12:10:46.746346000 Z\nprocedure: add_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 4\n	2012-08-21 12:10:47.237501	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
57	Access	2	update	\N	---\ncredential_id: 1\nstate: activing\ncreated_at: 2012-08-21 12:10:46.733585000 Z\nupdated_at: 2012-08-21 12:10:46.733585000 Z\ncluster_user_id: 1\nid: 2\n	2012-08-21 12:10:47.273146	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- activing\n- active\n
58	Task	4	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"atata\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: Access\nresource_id: 2\ncreated_at: 2012-08-21 12:10:46.746346000 Z\nupdated_at: 2012-08-21 12:10:47.232946000 Z\nprocedure: add_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 4\n	2012-08-21 12:10:47.277496	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
59	Request	1	update	2	---\nproject_id: 1\ncluster_id: 1\nhours: 8\ncreated_at: 2012-08-21 11:45:49.672558000 Z\nupdated_at: 2012-08-21 12:06:34.924125000 Z\nuser_id: 1\nstate: active\nsize: 80\ncomment: \nid: 1\n	2012-08-21 12:22:14.279983	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
60	ClusterUser	1	update	2	---\nproject_id: 1\nstate: active\ncluster_id: 1\ncreated_at: 2012-08-21 12:06:34.938125000 Z\nupdated_at: 2012-08-21 12:10:46.574798000 Z\nid: 1\n	2012-08-21 12:22:14.291033	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- pausing\n
61	Task	5	create	2	\N	2012-08-21 12:22:14.301274	\N
62	Task	5	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-21 12:22:14.298482000 Z\nupdated_at: 2012-08-21 12:22:14.298482000 Z\nprocedure: block_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 5\n	2012-08-21 12:22:17.710902	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
63	ClusterUser	1	update	\N	---\nproject_id: 1\nstate: pausing\ncluster_id: 1\ncreated_at: 2012-08-21 12:06:34.938125000 Z\nupdated_at: 2012-08-21 12:22:14.289712000 Z\nid: 1\n	2012-08-21 12:22:17.756842	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pausing\n- paused\n
64	Task	5	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-21 12:22:14.298482000 Z\nupdated_at: 2012-08-21 12:22:17.705482000 Z\nprocedure: block_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 5\n	2012-08-21 12:22:17.760986	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
65	Request	2	create	2	\N	2012-08-21 12:28:42.407337	\N
66	Request	2	update	2	---\nproject_id: 1\ncluster_id: 1\nhours: 80\ncreated_at: 2012-08-21 12:28:42.405202000 Z\nupdated_at: 2012-08-21 12:28:42.405202000 Z\nuser_id: 1\nstate: pending\nsize: 20\ncomment: \nid: 2\n	2012-08-21 12:28:45.90087	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
67	ClusterUser	1	update	2	---\nproject_id: 1\nstate: paused\ncluster_id: 1\ncreated_at: 2012-08-21 12:06:34.938125000 Z\nupdated_at: 2012-08-21 12:22:17.755612000 Z\nid: 1\n	2012-08-21 12:28:45.908818	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- paused\n- resuming\n
68	Task	6	create	2	\N	2012-08-21 12:28:45.916626	\N
69	Task	6	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-21 12:28:45.914615000 Z\nupdated_at: 2012-08-21 12:28:45.914615000 Z\nprocedure: unblock_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 6\n	2012-08-21 12:28:48.104954	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
70	ClusterUser	1	update	\N	---\nproject_id: 1\nstate: resuming\ncluster_id: 1\ncreated_at: 2012-08-21 12:06:34.938125000 Z\nupdated_at: 2012-08-21 12:28:45.907841000 Z\nid: 1\n	2012-08-21 12:28:48.163219	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- resuming\n- active\n
71	Task	6	update	\N	---\ncommand: ! "user=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-21 12:28:45.914615000 Z\nupdated_at: 2012-08-21 12:28:48.099911000 Z\nprocedure: unblock_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\nid: 6\n	2012-08-21 12:28:48.167945	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
72	TicketField	2	create	2	\N	2012-08-21 12:31:29.079961	\N
73	TicketFieldRelation	2	create	2	\N	2012-08-21 12:31:29.121838	\N
74	TicketTag	2	update	2	---\nname: atata\ncreated_at: 2012-08-21 08:52:53.726471000 Z\nupdated_at: 2012-08-21 08:52:53.726471000 Z\nstate: active\nid: 2\n	2012-08-21 12:32:17.269052	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nname:\n- atata\n- Регистрация\n
75	TicketQuestion	2	create	2	\N	2012-08-21 12:33:55.241842	\N
76	TicketFieldRelation	3	create	2	\N	2012-08-21 12:33:55.247339	\N
77	TicketFieldRelation	4	create	2	\N	2012-08-21 12:33:55.250545	\N
78	TicketQuestion	2	update	2	---\nticket_question_id: \nquestion: Не могу войти\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:33:55.221747000 Z\nid: 2\n	2012-08-21 12:34:06.543284	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nleaf:\n- true\n- false\n
79	TicketQuestion	3	create	2	\N	2012-08-21 12:34:06.545879	\N
80	TicketFieldRelation	5	create	2	\N	2012-08-21 12:34:06.550389	\N
81	TicketFieldRelation	6	create	2	\N	2012-08-21 12:34:06.553875	\N
82	TicketQuestion	3	update	2	---\nticket_question_id: 2\nquestion: Не могу получить доступ\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:34:06.544481000 Z\nupdated_at: 2012-08-21 12:34:06.544481000 Z\nid: 3\n	2012-08-21 12:34:21.7773	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- 2\n- \n
83	TicketQuestion	3	update	2	---\nticket_question_id: \nquestion: Не могу получить доступ\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:34:06.544481000 Z\nupdated_at: 2012-08-21 12:34:21.776215000 Z\nid: 3\n	2012-08-21 12:34:39.397339	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nleaf:\n- true\n- false\n
84	TicketQuestion	4	create	2	\N	2012-08-21 12:34:39.399744	\N
85	TicketFieldRelation	7	create	2	\N	2012-08-21 12:34:39.404129	\N
86	TicketFieldRelation	8	create	2	\N	2012-08-21 12:34:39.407385	\N
87	TicketQuestion	5	create	2	\N	2012-08-21 12:34:49.07825	\N
88	TicketFieldRelation	9	create	2	\N	2012-08-21 12:34:49.083077	\N
89	TicketFieldRelation	10	create	2	\N	2012-08-21 12:34:49.086759	\N
90	TicketQuestion	6	create	2	\N	2012-08-21 12:35:03.204006	\N
91	TicketFieldRelation	11	create	2	\N	2012-08-21 12:35:03.208732	\N
92	TicketFieldRelation	12	create	2	\N	2012-08-21 12:35:03.21254	\N
93	TicketQuestion	7	create	2	\N	2012-08-21 12:35:25.38977	\N
94	TicketFieldRelation	13	create	2	\N	2012-08-21 12:35:25.394729	\N
95	TicketFieldRelation	14	create	2	\N	2012-08-21 12:35:25.451151	\N
96	TicketQuestion	2	update	2	---\nticket_question_id: \nquestion: Не могу войти\nleaf: false\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:34:06.542092000 Z\nid: 2\n	2012-08-21 12:56:11.501018	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nquestion:\n- Не могу войти\n- Не могу войти!\n
97	TicketQuestion	2	update	2	---\nticket_question_id: \nquestion: Не могу войти!\nleaf: false\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:56:11.496882000 Z\nid: 2\n	2012-08-21 12:56:45.700301	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- \n- 1\n
98	TicketQuestion	1	update	2	---\nticket_question_id: \nquestion: Другое\nleaf: true\nstate: active\ncreated_at: 2012-08-21 08:42:08.393941000 Z\nupdated_at: 2012-08-21 08:42:08.393941000 Z\nid: 1\n	2012-08-21 12:56:45.705794	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nleaf:\n- true\n- false\n
99	TicketQuestion	2	update	2	---\nticket_question_id: 1\nquestion: Не могу войти!\nleaf: false\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:56:45.699276000 Z\nid: 2\n	2012-08-21 12:56:50.535814	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- 1\n- \n
100	TicketQuestion	1	update	2	---\nticket_question_id: \nquestion: Другое\nleaf: false\nstate: active\ncreated_at: 2012-08-21 08:42:08.393941000 Z\nupdated_at: 2012-08-21 12:56:45.704925000 Z\nid: 1\n	2012-08-21 12:56:50.541321	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nleaf:\n- false\n- true\n
101	TicketQuestion	2	update	2	---\nticket_question_id: \nquestion: Не могу войти!\nleaf: false\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:56:50.534588000 Z\nid: 2\n	2012-08-21 12:59:09.742511	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- \n- 1\nleaf:\n- false\n- true\n
102	TicketQuestion	2	update	2	---\nticket_question_id: 1\nquestion: Не могу войти!\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:59:09.741481000 Z\nid: 2\n	2012-08-21 12:59:18.362306	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- 1\n- \n
103	TicketQuestion	2	update	2	---\nticket_question_id: \nquestion: Не могу войти!\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:59:18.361049000 Z\nid: 2\n	2012-08-21 12:59:26.262247	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- \n- 1\n
104	TicketQuestion	2	update	2	---\nticket_question_id: 1\nquestion: Не могу войти!\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:59:26.261164000 Z\nid: 2\n	2012-08-21 12:59:46.155953	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- 1\n- \n
105	TicketQuestion	2	update	2	---\nticket_question_id: \nquestion: Не могу войти!\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:59:46.154766000 Z\nid: 2\n	2012-08-21 12:59:51.440471	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- \n- 1\n
106	TicketQuestion	1	update	2	---\nticket_question_id: \nquestion: Другое\nleaf: true\nstate: active\ncreated_at: 2012-08-21 08:42:08.393941000 Z\nupdated_at: 2012-08-21 12:56:50.540492000 Z\nid: 1\n	2012-08-21 12:59:51.44496	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nleaf:\n- true\n- false\n
107	TicketQuestion	2	update	2	---\nticket_question_id: 1\nquestion: Не могу войти!\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 12:59:51.439460000 Z\nid: 2\n	2012-08-21 13:12:24.96854	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- 1\n- \n
108	TicketQuestion	2	update	2	---\nticket_question_id: \nquestion: Не могу войти!\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 13:12:24.967245000 Z\nid: 2\n	2012-08-21 13:12:30.618853	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- \n- 1\n
109	TicketQuestion	2	update	2	---\nticket_question_id: 1\nquestion: Не могу войти!\nleaf: true\nstate: active\ncreated_at: 2012-08-21 12:33:55.221747000 Z\nupdated_at: 2012-08-21 13:12:30.617901000 Z\nid: 2\n	2012-08-21 13:12:36.147167	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nticket_question_id:\n- 1\n- \n
110	TicketFieldRelation	13	update	2	---\nticket_question_id: 7\nticket_field_id: 1\nrequired: false\ncreated_at: 2012-08-21 12:35:25.393172000 Z\nupdated_at: 2012-08-21 12:35:25.393172000 Z\nuse: false\nid: 13\n	2012-08-21 13:13:07.296023	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nuse:\n- false\n- true\nrequired:\n- false\n- true\n
111	TicketFieldRelation	14	update	2	---\nticket_question_id: 7\nticket_field_id: 2\nrequired: false\ncreated_at: 2012-08-21 12:35:25.397188000 Z\nupdated_at: 2012-08-21 12:35:25.397188000 Z\nuse: false\nid: 14\n	2012-08-21 13:13:07.299648	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nuse:\n- false\n- true\nrequired:\n- false\n- true\n
113	Organization	4	create	2	\N	2012-08-21 13:55:09.95737	\N
114	Organization	4	update	2	---\nname: Umbrella\napproved: false\ncreated_at: 2012-08-21 13:55:09.954994000 Z\nupdated_at: 2012-08-21 13:55:09.954994000 Z\nstate: active\nabbreviation: ''\norganization_kind_id: 3\nid: 4\n	2012-08-21 13:56:08.799215	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
115	User	2	update	\N	---\nemail: janbernacki@me.com\ncrypted_password: $2a$10$q3k1M2aXmkjSwpQvtF3LO.RzNqO6VzHTE4hGUn9D.GMrOPavnvDoS\nsalt: 4hxd6XqqGVpYpD31x4BD\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Jan\nlast_name: Bernacki\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:36.350856000 Z\nupdated_at: 2012-08-21 06:45:01.346361000 Z\nadmin: true\nstate: active\ntoken: \nid: 2\n	2012-08-21 14:08:29.99102	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ntoken:\n- \n- !binary |-\n  ZGY5ZjkwMDNjYTA2ZWIxNjgxMTUzZGRhYTFiNTg4YmFhYTlkZTYyYQ==\n
116	User	1	update	\N	---\nemail: releu@me.com\ncrypted_password: $2a$10$GpiGlwjdNV5nF5B2TEGHP.J8VVWPpxRDgm3hrpLpfpYs5rey6Upkm\nsalt: b4Pz3hVYCPqH3DvYuupf\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Sergey\nlast_name: Tolubaev\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:18.692945000 Z\nupdated_at: 2012-08-21 11:45:00.893954000 Z\nadmin: false\nstate: sured\ntoken: \nid: 1\n	2012-08-21 14:08:29.999271	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ntoken:\n- \n- !binary |-\n  ZDYwMWI0NzNlZjhlOGY1NGM1ZTA4MDQxYzkzOGU2N2JjNjRlYTdiNg==\n
117	User	2	update	\N	---\nemail: janbernacki@me.com\ncrypted_password: $2a$10$q3k1M2aXmkjSwpQvtF3LO.RzNqO6VzHTE4hGUn9D.GMrOPavnvDoS\nsalt: 4hxd6XqqGVpYpD31x4BD\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Jan\nlast_name: Bernacki\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:36.350856000 Z\nupdated_at: 2012-08-21 14:08:29.986950000 Z\nadmin: true\nstate: active\ntoken: df9f9003ca06eb1681153ddaa1b588baaa9de62a\nid: 2\n	2012-08-21 14:16:22.98332	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ntoken:\n- df9f9003ca06eb1681153ddaa1b588baaa9de62a\n- !binary |-\n  ODhlYmQ0ODMwNWNlNDdiYTYzOTViZTA3MmEzZmU3YjYzNjkxYTgzZQ==\n
118	User	1	update	\N	---\nemail: releu@me.com\ncrypted_password: $2a$10$GpiGlwjdNV5nF5B2TEGHP.J8VVWPpxRDgm3hrpLpfpYs5rey6Upkm\nsalt: b4Pz3hVYCPqH3DvYuupf\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Sergey\nlast_name: Tolubaev\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 06:23:18.692945000 Z\nupdated_at: 2012-08-21 14:08:29.998217000 Z\nadmin: false\nstate: sured\ntoken: d601b473ef8e8f54c5e08041c938e67bc64ea7b6\nid: 1\n	2012-08-21 14:16:22.989987	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ntoken:\n- d601b473ef8e8f54c5e08041c938e67bc64ea7b6\n- !binary |-\n  NzhlNGM5NDFkMGM3OTgyODU1NjI2ZWQwY2FlY2RkOTJjMGE5YWQ5MA==\n
121	Reply	2	create	2	\N	2012-08-21 14:21:29.619029	\N
122	Ticket	1	update	2	---\nsubject: Не могу скомпилиться\nmessage: Не выходит ничего\nuser_id: 1\nstate: active\nurl: ''\ncreated_at: 2012-08-21 08:43:04.673299000 Z\nupdated_at: 2012-08-21 08:43:04.673299000 Z\nattachment_file_name: \nattachment_content_type: \nattachment_file_size: \nattachment_updated_at: \nticket_question_id: 1\nproject_id: \ncluster_id: 1\nid: 1\n	2012-08-21 14:21:29.696754	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- answered\n
123	Reply	3	create	1	\N	2012-08-21 14:34:25.010652	\N
124	Ticket	1	update	1	---\nsubject: Не могу скомпилиться\nmessage: Не выходит ничего\nuser_id: 1\nstate: answered\nurl: ''\ncreated_at: 2012-08-21 08:43:04.673299000 Z\nupdated_at: 2012-08-21 14:21:29.695602000 Z\nattachment_file_name: \nattachment_content_type: \nattachment_file_size: \nattachment_updated_at: \nticket_question_id: 1\nproject_id: \ncluster_id: 1\nid: 1\n	2012-08-21 14:34:25.022034	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- answered\n- active\n
125	Reply	4	create	2	\N	2012-08-21 14:34:54.154474	\N
126	Ticket	1	update	2	---\nsubject: Не могу скомпилиться\nmessage: Не выходит ничего\nuser_id: 1\nstate: active\nurl: ''\ncreated_at: 2012-08-21 08:43:04.673299000 Z\nupdated_at: 2012-08-21 14:34:25.020653000 Z\nattachment_file_name: \nattachment_content_type: \nattachment_file_size: \nattachment_updated_at: \nticket_question_id: 1\nproject_id: \ncluster_id: 1\nid: 1\n	2012-08-21 14:34:54.162712	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- answered\n
127	User	3	create	f	\N	2012-08-21 14:59:18.613878	\N
128	User	3	update	f	---\nemail: areleu@gmail.com\ncrypted_password: $2a$10$qGCJDDgbhpkcDTYMk1UmmuDhEx/sQ7BynRJa2IgwvUvs8VWrwjDd2\nsalt: 2Ecy97eqVzDxjqm4xJ9B\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: pending\nactivation_token: keq3wxapTzTzSRH49yqp\nactivation_token_expires_at: \nfirst_name: John\nlast_name: Smith\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-21 14:59:18.579517000 Z\nupdated_at: 2012-08-21 14:59:18.579517000 Z\nadmin: false\nstate: active\ntoken: e54b65b58b2362ec7b4c7508d6f40e490528fc96\nid: 3\n	2012-08-21 15:02:56.624737	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nactivation_token:\n- keq3wxapTzTzSRH49yqp\n- \nactivation_state:\n- pending\n- active\n
129	Project	1	update	\N	---\nname: Octoshell\ncreated_at: 2012-08-21 11:45:49.654544000 Z\nupdated_at: 2012-08-21 11:45:49.654544000 Z\nuser_id: 1\nstate: active\ndescription: octoshell || octoshell\norganization_id: 1\ncluster_user_type: account\nusername: \nid: 1\n	2012-08-28 07:02:21.799652	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nusername:\n- \n- project_1\n
130	Account	1	update	\N	---\nuser_id: 1\nproject_id: 1\ncreated_at: 2012-08-21 11:45:49.667293000 Z\nupdated_at: 2012-08-21 11:45:49.685165000 Z\nstate: active\nusername: \nid: 1\n	2012-08-28 07:02:33.09769	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nusername:\n- \n- account_1\n
131	Cluster	1	update	2	---\nname: Ломоносов\ncreated_at: 2012-08-21 08:35:00.526027000 Z\nupdated_at: 2012-08-21 12:07:51.706836000 Z\nhost: lomonosov.parallel.ru\ndescription: ''\nstate: active\nadd_user: ! "user=%user%\\r\\nhost=%host%"\ndel_user: ! "user=%user%\\r\\nhost=%host%"\nadd_openkey: ! "user=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\ndel_openkey: ! "user=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\nblock_user: ! "user=%user%\\r\\nhost=%host%"\nunblock_user: ! "user=%user%\\r\\nhost=%host%"\nstatistic: \nget_statistic: host=%host%\nstatistic_updated_at: \ncluster_user_type: account\nid: 1\n	2012-08-28 08:02:38.396981	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nadd_user:\n- ! "user=%user%\\r\\nhost=%host%"\n- ! "project=%project%\\r\\nhost=%host%"\ndel_user:\n- ! "user=%user%\\r\\nhost=%host%"\n- ! "project=%project%\\r\\nhost=%host%"\nblock_user:\n- ! "user=%user%\\r\\nhost=%host%"\n- ! "project=%project%\\r\\nhost=%host%"\nunblock_user:\n- ! "user=%user%\\r\\nhost=%host%"\n- ! "project=%project%\\r\\nhost=%host%"\nadd_openkey:\n- ! "user=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\n- ! "project=%project%\\r\\nuser=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\ndel_openkey:\n- ! "user=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\n- ! "project=%project%\\r\\nuser=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\n
132	User	4	create	f	\N	2012-08-28 08:03:54.481801	\N
133	User	5	create	f	\N	2012-08-28 08:04:15.812177	\N
134	User	4	update	\N	---\nemail: serg@parallel.ru\ncrypted_password: $2a$10$3fpzZ/NBjr9/fEh2wEMu9.xZoL1uVHLnFgVqwv8CSbDuVkURiP4Uu\nsalt: udncVgooLxmnFy8HUsVR\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: pending\nactivation_token: JSuSxP8sEscr3CoSuiaE\nactivation_token_expires_at: \nfirst_name: Sergey\nlast_name: Zhumatiy\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-28 08:03:54.456710000 Z\nupdated_at: 2012-08-28 08:03:54.456710000 Z\nadmin: false\nstate: active\ntoken: bf213d523c133c0c3a4b9df9da060afe45b1545a\navatar_file_name: \navatar_content_type: \navatar_file_size: \navatar_updated_at: \nid: 4\n	2012-08-28 08:04:36.924141	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nactivation_token:\n- JSuSxP8sEscr3CoSuiaE\n- \nactivation_state:\n- pending\n- active\n
135	User	5	update	\N	---\nemail: dan@parallel.ru\ncrypted_password: $2a$10$VuKPTACyi/6x3qqAbkS/NuLzI34kyIfuS.rK6/FS0AM9fuLgMxToa\nsalt: PY2Tyay5Ssd1sKqeyqEy\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: pending\nactivation_token: g4a1scGS3Mpc7rc9fRnF\nactivation_token_expires_at: \nfirst_name: Dmitry\nlast_name: Nikitenko\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-28 08:04:15.810051000 Z\nupdated_at: 2012-08-28 08:04:15.810051000 Z\nadmin: false\nstate: active\ntoken: d8ef06d3176fa9e8e1d7104ba1e2d8b970dce7ad\navatar_file_name: \navatar_content_type: \navatar_file_size: \navatar_updated_at: \nid: 5\n	2012-08-28 08:04:36.943061	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nactivation_token:\n- g4a1scGS3Mpc7rc9fRnF\n- \nactivation_state:\n- pending\n- active\n
136	User	5	update	2	---\nemail: dan@parallel.ru\ncrypted_password: $2a$10$VuKPTACyi/6x3qqAbkS/NuLzI34kyIfuS.rK6/FS0AM9fuLgMxToa\nsalt: PY2Tyay5Ssd1sKqeyqEy\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Dmitry\nlast_name: Nikitenko\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-28 08:04:15.810051000 Z\nupdated_at: 2012-08-28 08:04:36.941902000 Z\nadmin: false\nstate: active\ntoken: d8ef06d3176fa9e8e1d7104ba1e2d8b970dce7ad\navatar_file_name: \navatar_content_type: \navatar_file_size: \navatar_updated_at: \nid: 5\n	2012-08-28 08:05:06.939938	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nadmin:\n- false\n- true\n
137	User	4	update	2	---\nemail: serg@parallel.ru\ncrypted_password: $2a$10$3fpzZ/NBjr9/fEh2wEMu9.xZoL1uVHLnFgVqwv8CSbDuVkURiP4Uu\nsalt: udncVgooLxmnFy8HUsVR\nremember_me_token: \nremember_me_token_expires_at: \nreset_password_token: \nreset_password_token_expires_at: \nreset_password_email_sent_at: \nactivation_state: active\nactivation_token: \nactivation_token_expires_at: \nfirst_name: Sergey\nlast_name: Zhumatiy\nmiddle_name: ''\ndeleted_at: \ncreated_at: 2012-08-28 08:03:54.456710000 Z\nupdated_at: 2012-08-28 08:04:36.916356000 Z\nadmin: false\nstate: active\ntoken: bf213d523c133c0c3a4b9df9da060afe45b1545a\navatar_file_name: \navatar_content_type: \navatar_file_size: \navatar_updated_at: \nid: 4\n	2012-08-28 08:05:20.896713	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nadmin:\n- false\n- true\n
138	Request	3	create	2	\N	2012-08-29 07:34:21.109555	\N
145	Project	1	update	2	---\nname: Octoshell\ncreated_at: 2012-08-21 11:45:49.654544000 Z\nupdated_at: 2012-08-28 07:02:21.792513000 Z\nuser_id: 1\nstate: active\ndescription: octoshell || octoshell\norganization_id: 1\ncluster_user_type: account\nusername: project_1\nid: 1\n	2012-08-29 11:56:00.484476	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
146	Account	1	update	2	---\nuser_id: 1\nproject_id: 1\ncreated_at: 2012-08-21 11:45:49.667293000 Z\nupdated_at: 2012-08-28 07:02:33.096415000 Z\nstate: active\nusername: account_1\nid: 1\n	2012-08-29 11:56:00.506199	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
147	Access	2	update	2	---\ncredential_id: 1\nstate: active\ncreated_at: 2012-08-21 12:10:46.733585000 Z\nupdated_at: 2012-08-21 12:10:47.271802000 Z\ncluster_user_id: 1\nid: 2\n	2012-08-29 11:56:00.521013	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closing\n
148	Task	9	create	2	\N	2012-08-29 11:56:00.541765	\N
149	Access	1	update	2	---\ncredential_id: 2\nstate: active\ncreated_at: 2012-08-21 12:10:46.697631000 Z\nupdated_at: 2012-08-21 12:10:47.006593000 Z\ncluster_user_id: 1\nid: 1\n	2012-08-29 11:56:00.556751	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closing\n
150	Task	10	create	2	\N	2012-08-29 11:56:00.576373	\N
151	ClusterUser	1	update	2	---\nproject_id: 1\nstate: active\ncluster_id: 1\ncreated_at: 2012-08-21 12:06:34.938125000 Z\nupdated_at: 2012-08-21 12:28:48.161723000 Z\nrequest_id: 3\nid: 1\n	2012-08-29 11:56:00.604637	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closing\n
152	Task	11	create	2	\N	2012-08-29 11:56:00.624443	\N
153	Request	3	update	2	---\nproject_id: 1\ncluster_id: 1\nhours: 8\ncreated_at: 2012-08-29 07:34:21.087434000 Z\nupdated_at: 2012-08-29 07:34:21.087434000 Z\nuser_id: 1\nstate: pending\nsize: 8\ncomment: \nid: 3\n	2012-08-29 11:56:00.645306	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- closed\n
154	Request	2	update	2	---\nproject_id: 1\ncluster_id: 1\nhours: 80\ncreated_at: 2012-08-21 12:28:42.405202000 Z\nupdated_at: 2012-08-21 12:28:45.899740000 Z\nuser_id: 1\nstate: active\nsize: 20\ncomment: \nid: 2\n	2012-08-29 11:56:00.664646	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
155	Project	2	create	2	\N	2012-08-29 11:58:27.130328	\N
156	Account	2	create	2	\N	2012-08-29 11:58:27.141821	\N
157	Account	2	update	2	---\nuser_id: \nproject_id: \ncreated_at: \nupdated_at: \nstate: pending\nusername: \nid: \n	2012-08-29 11:58:27.14873	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nuser_id:\n- \n- 1\nproject_id:\n- \n- 2\ncreated_at:\n- \n- 2012-08-29 11:58:27.137570000 Z\nupdated_at:\n- \n- 2012-08-29 11:58:27.137570000 Z\nid:\n- \n- 2\nusername:\n- \n- account_2\n
158	Request	4	create	2	\N	2012-08-29 11:58:27.156279	\N
159	Project	2	update	2	---\nname: \ncreated_at: \nupdated_at: \nuser_id: \nstate: active\ndescription: \norganization_id: \ncluster_user_type: account\nusername: \nid: \n	2012-08-29 11:58:27.221305	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nuser_id:\n- \n- 1\norganization_id:\n- \n- 1\nname:\n- \n- Octoshell2\nusername:\n- \n- project_2\ndescription:\n- \n- atata\ncreated_at:\n- \n- 2012-08-29 11:58:27.125575000 Z\nupdated_at:\n- \n- 2012-08-29 11:58:27.125575000 Z\nid:\n- \n- 2\n
160	Account	2	update	2	---\nuser_id: 1\nproject_id: 2\ncreated_at: 2012-08-29 11:58:27.137570000 Z\nupdated_at: 2012-08-29 11:58:27.137570000 Z\nstate: pending\nusername: account_2\nid: 2\n	2012-08-29 11:58:27.241152	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
161	Request	4	update	2	---\nproject_id: 2\ncluster_id: 1\nhours: 1\ncreated_at: 2012-08-29 11:58:27.151380000 Z\nupdated_at: 2012-08-29 11:58:27.151380000 Z\nuser_id: 1\nstate: pending\nsize: 1\ncomment: \nid: 4\n	2012-08-29 11:58:39.301788	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
162	ClusterUser	2	create	2	\N	2012-08-29 11:58:39.324881	\N
163	ClusterUser	2	update	2	---\nproject_id: \nstate: pending\ncluster_id: \ncreated_at: \nupdated_at: \nrequest_id: \nid: \n	2012-08-29 11:58:39.333619	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nproject_id:\n- \n- 2\ncluster_id:\n- \n- 1\nrequest_id:\n- \n- 4\ncreated_at:\n- \n- 2012-08-29 11:58:39.318851000 Z\nupdated_at:\n- \n- 2012-08-29 11:58:39.318851000 Z\nid:\n- \n- 2\nstate:\n- pending\n- activing\n
164	Task	12	create	2	\N	2012-08-29 11:58:39.354396	\N
165	Task	9	update	\N	---\ncommand: ! "project=\\"project_1\\"\\r\\nuser=\\"account_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"atata\\""\nstderr: \nstdout: \nstate: pending\nresource_type: Access\nresource_id: 2\ncreated_at: 2012-08-29 11:56:00.538684000 Z\nupdated_at: 2012-08-29 11:56:00.538684000 Z\nprocedure: del_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 9\n	2012-08-29 11:59:35.514136	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
166	Access	2	update	\N	---\ncredential_id: 1\nstate: closing\ncreated_at: 2012-08-21 12:10:46.733585000 Z\nupdated_at: 2012-08-29 11:56:00.518982000 Z\ncluster_user_id: 1\nid: 2\n	2012-08-29 11:59:35.580557	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- closing\n- closed\n
167	Task	9	update	\N	---\ncommand: ! "project=\\"project_1\\"\\r\\nuser=\\"account_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"atata\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: Access\nresource_id: 2\ncreated_at: 2012-08-29 11:56:00.538684000 Z\nupdated_at: 2012-08-29 11:59:35.504063000 Z\nprocedure: del_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 9\n	2012-08-29 11:59:35.588693	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
168	Task	10	update	\N	---\ncommand: ! "project=\\"project_1\\"\\r\\nuser=\\"account_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"ssh-rsa\n  AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD\n  releu@me.com\\n\\""\nstderr: \nstdout: \nstate: pending\nresource_type: Access\nresource_id: 1\ncreated_at: 2012-08-29 11:56:00.573364000 Z\nupdated_at: 2012-08-29 11:56:00.573364000 Z\nprocedure: del_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 10\n	2012-08-29 11:59:36.097421	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
169	Access	1	update	\N	---\ncredential_id: 2\nstate: closing\ncreated_at: 2012-08-21 12:10:46.697631000 Z\nupdated_at: 2012-08-29 11:56:00.555006000 Z\ncluster_user_id: 1\nid: 1\n	2012-08-29 11:59:36.167047	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- closing\n- closed\n
206	ClusterUser	2	update	2	---\nproject_id: 2\nstate: paused\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:22:44.140349000 Z\nrequest_id: 6\nid: 2\n	2012-08-29 12:22:44.162369	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- paused\n- resuming\n
170	Task	10	update	\N	---\ncommand: ! "project=\\"project_1\\"\\r\\nuser=\\"account_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"ssh-rsa\n  AAAAB3NzaC1yc2EAAAADAQABAAABAQDYgSu+9PML2L8D+eJI8zUwwnxvB42fRX7zRQINlnZDEUN2jZRb0LX9WAHjbm708T9EzFNj76atII6sHQkRn0j/SVQ4zmAyBijxmrrecJiTOD6SwFeySVF1DPgQGDvf7Jtp26CjfJ3SURapHFTpqZoD5VnqWXLpKLjpyTGeGUPnaLD8iNhL3pkn1GXubVllfTbZX7iGjQR3PZuD0mghATde/nzUHyXZcrbpBSvkBD9OzjVdoyy8cZPzqvtZw2QR6TnjYfXJct7cnLggyB4qOJjdTl9LejPOT2r5LIRsC+jL1jEcidb95sLvc+2wnceTNndbGOi0NBnkV+lrDU04I7JD\n  releu@me.com\\n\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: Access\nresource_id: 1\ncreated_at: 2012-08-29 11:56:00.573364000 Z\nupdated_at: 2012-08-29 11:59:36.086981000 Z\nprocedure: del_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 10\n	2012-08-29 11:59:36.175208	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
171	Task	11	update	\N	---\ncommand: ! "project=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-29 11:56:00.619419000 Z\nupdated_at: 2012-08-29 11:56:00.619419000 Z\nprocedure: del_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 11\n	2012-08-29 11:59:36.695098	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
172	ClusterUser	1	update	\N	---\nproject_id: 1\nstate: closing\ncluster_id: 1\ncreated_at: 2012-08-21 12:06:34.938125000 Z\nupdated_at: 2012-08-29 11:56:00.596239000 Z\nrequest_id: 3\nid: 1\n	2012-08-29 11:59:36.806985	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- closing\n- closed\n
173	Task	11	update	\N	---\ncommand: ! "project=\\"project_1\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 1\ncreated_at: 2012-08-29 11:56:00.619419000 Z\nupdated_at: 2012-08-29 11:59:36.684856000 Z\nprocedure: del_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 11\n	2012-08-29 11:59:36.815105	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
174	Task	12	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 11:58:39.351183000 Z\nupdated_at: 2012-08-29 11:58:39.351183000 Z\nprocedure: add_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 12\n	2012-08-29 11:59:37.322627	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
175	ClusterUser	2	update	\N	---\nproject_id: 2\nstate: activing\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 11:58:39.318851000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 11:59:37.437108	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- activing\n- active\n
176	Access	3	create	\N	\N	2012-08-29 11:59:37.651549	\N
177	Access	3	update	\N	---\ncredential_id: \nstate: pending\ncreated_at: \nupdated_at: \ncluster_user_id: \nid: \n	2012-08-29 11:59:37.660559	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncluster_user_id:\n- \n- 2\ncredential_id:\n- \n- 1\ncreated_at:\n- \n- 2012-08-29 11:59:37.642202000 Z\nupdated_at:\n- \n- 2012-08-29 11:59:37.642202000 Z\nid:\n- \n- 3\nstate:\n- pending\n- activing\n
178	Task	13	create	\N	\N	2012-08-29 11:59:37.700982	\N
179	Task	12	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 11:58:39.351183000 Z\nupdated_at: 2012-08-29 11:59:37.313614000 Z\nprocedure: add_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 12\n	2012-08-29 11:59:37.711342	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
180	Task	13	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nuser=\\"account_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"atata\\""\nstderr: \nstdout: \nstate: pending\nresource_type: Access\nresource_id: 3\ncreated_at: 2012-08-29 11:59:37.696625000 Z\nupdated_at: 2012-08-29 11:59:37.696625000 Z\nprocedure: add_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 13\n	2012-08-29 11:59:38.226693	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
181	Access	3	update	\N	---\ncredential_id: 1\nstate: activing\ncreated_at: 2012-08-29 11:59:37.642202000 Z\nupdated_at: 2012-08-29 11:59:37.642202000 Z\ncluster_user_id: 2\nid: 3\n	2012-08-29 11:59:38.293054	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- activing\n- active\n
182	Task	13	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nuser=\\"account_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\npublic_key=\\"atata\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: Access\nresource_id: 3\ncreated_at: 2012-08-29 11:59:37.696625000 Z\nupdated_at: 2012-08-29 11:59:38.217750000 Z\nprocedure: add_openkey\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 13\n	2012-08-29 11:59:38.301771	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
183	Request	4	update	2	---\nproject_id: 2\ncluster_id: 1\nhours: 1\ncreated_at: 2012-08-29 11:58:27.151380000 Z\nupdated_at: 2012-08-29 11:58:39.299671000 Z\nuser_id: 1\nstate: active\nsize: 1\ncomment: \nid: 4\n	2012-08-29 12:00:16.443904	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
184	ClusterUser	2	update	2	---\nproject_id: 2\nstate: active\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 11:59:37.434751000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 12:00:16.45866	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- pausing\n
185	Task	14	create	2	\N	2012-08-29 12:00:16.471331	\N
186	Task	14	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:00:16.468379000 Z\nupdated_at: 2012-08-29 12:00:16.468379000 Z\nprocedure: block_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 14\n	2012-08-29 12:00:18.85859	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
187	ClusterUser	2	update	\N	---\nproject_id: 2\nstate: pausing\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:00:16.456866000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 12:00:18.970937	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pausing\n- paused\n
188	Task	14	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:00:16.468379000 Z\nupdated_at: 2012-08-29 12:00:18.849551000 Z\nprocedure: block_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 14\n	2012-08-29 12:00:18.979058	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
189	Cluster	1	update	2	---\nname: Ломоносов\ncreated_at: 2012-08-21 08:35:00.526027000 Z\nupdated_at: 2012-08-28 08:02:38.394613000 Z\nhost: lomonosov.parallel.ru\ndescription: ''\nstate: active\nadd_user: ! "project=%project%\\r\\nhost=%host%"\ndel_user: ! "project=%project%\\r\\nhost=%host%"\nadd_openkey: ! "project=%project%\\r\\nuser=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\ndel_openkey: ! "project=%project%\\r\\nuser=%user%\\r\\nhost=%host%\\r\\npublic_key=%public_key%"\nblock_user: ! "project=%project%\\r\\nhost=%host%"\nunblock_user: ! "project=%project%\\r\\nhost=%host%"\nstatistic: \nget_statistic: host=%host%\nstatistic_updated_at: \ncluster_user_type: account\nid: 1\n	2012-08-29 12:00:43.241926	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nunblock_user:\n- ! "project=%project%\\r\\nhost=%host%"\n- ! "project=%project%\\r\\nhost=%host%\\r\\nfoo=%foo%"\n
190	Request	5	create	2	\N	2012-08-29 12:01:47.014861	\N
191	Request	5	update	2	---\nproject_id: 2\ncluster_id: 1\nhours: 9\ncreated_at: 2012-08-29 12:01:47.011765000 Z\nupdated_at: 2012-08-29 12:01:47.011765000 Z\nuser_id: 1\nstate: pending\nsize: 9\ncomment: \nid: 5\n	2012-08-29 12:02:02.569683	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
192	ClusterUser	2	update	2	---\nproject_id: 2\nstate: paused\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:00:18.968608000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 12:02:02.584718	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- paused\n- resuming\n
193	Task	15	create	2	\N	2012-08-29 12:02:02.602995	\N
194	Task	15	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\nfoo=\\"\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:02:02.600023000 Z\nupdated_at: 2012-08-29 12:02:02.600023000 Z\nprocedure: unblock_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 15\n	2012-08-29 12:02:04.550753	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
195	ClusterUser	2	update	\N	---\nproject_id: 2\nstate: resuming\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:02:02.583128000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 12:02:04.681725	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- resuming\n- active\n
196	Task	15	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\nfoo=\\"\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:02:02.600023000 Z\nupdated_at: 2012-08-29 12:02:04.540299000 Z\nprocedure: unblock_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 15\n	2012-08-29 12:02:04.692064	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
197	Request	5	update	2	---\nproject_id: 2\ncluster_id: 1\nhours: 9\ncreated_at: 2012-08-29 12:01:47.011765000 Z\nupdated_at: 2012-08-29 12:02:02.567840000 Z\nuser_id: 1\nstate: active\nsize: 9\ncomment: \nid: 5\n	2012-08-29 12:20:45.43245	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- closed\n
198	ClusterUser	2	update	2	---\nproject_id: 2\nstate: active\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:02:04.679407000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 12:20:45.460522	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- active\n- pausing\n
199	Task	16	create	2	\N	2012-08-29 12:20:45.519415	\N
200	Task	16	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:20:45.512243000 Z\nupdated_at: 2012-08-29 12:20:45.512243000 Z\nprocedure: block_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 16\n	2012-08-29 12:21:35.173289	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
201	ClusterUser	2	update	\N	---\nproject_id: 2\nstate: pausing\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:20:45.457450000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 12:21:35.42432	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pausing\n- paused\n
202	Task	16	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:20:45.512243000 Z\nupdated_at: 2012-08-29 12:21:35.161723000 Z\nprocedure: block_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 16\n	2012-08-29 12:21:35.437302	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
203	Request	6	create	2	\N	2012-08-29 12:22:27.79666	\N
204	Request	6	update	2	---\nproject_id: 2\ncluster_id: 1\nhours: 40\ncreated_at: 2012-08-29 12:22:27.792239000 Z\nupdated_at: 2012-08-29 12:22:27.792239000 Z\nuser_id: 1\nstate: pending\nsize: 40\ncomment: \nid: 6\n	2012-08-29 12:22:44.130173	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- pending\n- active\n
205	ClusterUser	2	update	2	---\nproject_id: 2\nstate: paused\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:21:35.421777000 Z\nrequest_id: 4\nid: 2\n	2012-08-29 12:22:44.142638	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nrequest_id:\n- 4\n- 6\n
207	Task	17	create	2	\N	2012-08-29 12:22:44.183381	\N
208	Task	17	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\nfoo=\\"MOOOO\\""\nstderr: \nstdout: \nstate: pending\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:22:44.178176000 Z\nupdated_at: 2012-08-29 12:22:44.178176000 Z\nprocedure: unblock_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 17\n	2012-08-29 12:22:46.837818	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstderr:\n- \n- ''\nstdout:\n- \n- ''\nstate:\n- pending\n- successed\n
209	ClusterUser	2	update	\N	---\nproject_id: 2\nstate: resuming\ncluster_id: 1\ncreated_at: 2012-08-29 11:58:39.318851000 Z\nupdated_at: 2012-08-29 12:22:44.159379000 Z\nrequest_id: 6\nid: 2\n	2012-08-29 12:22:47.233847	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nstate:\n- resuming\n- active\n
210	Task	17	update	\N	---\ncommand: ! "project=\\"project_2\\"\\r\\nhost=\\"lomonosov.parallel.ru\\"\\r\\nfoo=\\"MOOOO\\""\nstderr: ''\nstdout: ''\nstate: successed\nresource_type: ClusterUser\nresource_id: 2\ncreated_at: 2012-08-29 12:22:44.178176000 Z\nupdated_at: 2012-08-29 12:22:46.820756000 Z\nprocedure: unblock_user\ndata: \nevent: \ncomment: \ncallbacks_performed: false\ntask_id: \nid: 17\n	2012-08-29 12:22:47.242938	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncallbacks_performed:\n- false\n- true\n
211	Credential	3	create	2	\N	2012-08-29 12:48:44.625662	\N
212	Access	4	create	2	\N	2012-08-29 12:48:44.666382	\N
213	Access	4	update	2	---\ncredential_id: \nstate: pending\ncreated_at: \nupdated_at: \ncluster_user_id: \nid: \n	2012-08-29 12:48:44.680455	--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\ncredential_id:\n- \n- 3\ncluster_user_id:\n- \n- 2\ncreated_at:\n- \n- 2012-08-29 12:48:44.661547000 Z\nupdated_at:\n- \n- 2012-08-29 12:48:44.661547000 Z\nid:\n- \n- 4\nstate:\n- pending\n- activing\n
214	Task	18	create	2	\N	2012-08-29 12:48:44.86933	\N
\.


--
-- Data for Name: wiki_urls; Type: TABLE DATA; Schema: public; Owner: octoshell
--

COPY wiki_urls (id, page_id, url) FROM stdin;
\.


--
-- Name: accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY accesses
    ADD CONSTRAINT accesses_pkey PRIMARY KEY (id);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: cluster_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY cluster_fields
    ADD CONSTRAINT cluster_fields_pkey PRIMARY KEY (id);


--
-- Name: cluster_users_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY cluster_users
    ADD CONSTRAINT cluster_users_pkey PRIMARY KEY (id);


--
-- Name: clusters_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY clusters
    ADD CONSTRAINT clusters_pkey PRIMARY KEY (id);


--
-- Name: credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY credentials
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (id);


--
-- Name: fields_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: organization_kinds_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY organization_kinds
    ADD CONSTRAINT organization_kinds_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: position_names_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY position_names
    ADD CONSTRAINT position_names_pkey PRIMARY KEY (id);


--
-- Name: positions_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: replies_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY replies
    ADD CONSTRAINT replies_pkey PRIMARY KEY (id);


--
-- Name: request_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY request_properties
    ADD CONSTRAINT request_properties_pkey PRIMARY KEY (id);


--
-- Name: requests_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: sureties_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY sureties
    ADD CONSTRAINT sureties_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: ticket_field_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY ticket_field_relations
    ADD CONSTRAINT ticket_field_relations_pkey PRIMARY KEY (id);


--
-- Name: ticket_field_values_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY ticket_field_values
    ADD CONSTRAINT ticket_field_values_pkey PRIMARY KEY (id);


--
-- Name: ticket_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY ticket_fields
    ADD CONSTRAINT ticket_fields_pkey PRIMARY KEY (id);


--
-- Name: ticket_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY ticket_questions
    ADD CONSTRAINT ticket_questions_pkey PRIMARY KEY (id);


--
-- Name: ticket_tag_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY ticket_tag_relations
    ADD CONSTRAINT ticket_tag_relations_pkey PRIMARY KEY (id);


--
-- Name: ticket_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY ticket_tags
    ADD CONSTRAINT ticket_tags_pkey PRIMARY KEY (id);


--
-- Name: ticket_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY ticket_templates
    ADD CONSTRAINT ticket_templates_pkey PRIMARY KEY (id);


--
-- Name: tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: values_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY "values"
    ADD CONSTRAINT values_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: wiki_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: octoshell; Tablespace: 
--

ALTER TABLE ONLY wiki_urls
    ADD CONSTRAINT wiki_urls_pkey PRIMARY KEY (id);


--
-- Name: index_accesses_on_credential_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_accesses_on_credential_id ON accesses USING btree (credential_id);


--
-- Name: index_accesses_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_accesses_on_state ON accesses USING btree (state);


--
-- Name: index_accounts_on_project_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_accounts_on_project_id ON accounts USING btree (project_id);


--
-- Name: index_accounts_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_accounts_on_state ON accounts USING btree (state);


--
-- Name: index_accounts_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_accounts_on_user_id ON accounts USING btree (user_id);


--
-- Name: index_accounts_on_user_id_and_project_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE UNIQUE INDEX index_accounts_on_user_id_and_project_id ON accounts USING btree (user_id, project_id);


--
-- Name: index_cluster_fields_on_cluster_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_cluster_fields_on_cluster_id ON cluster_fields USING btree (cluster_id);


--
-- Name: index_cluster_users_on_cluster_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_cluster_users_on_cluster_id ON cluster_users USING btree (cluster_id);


--
-- Name: index_cluster_users_on_project_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_cluster_users_on_project_id ON cluster_users USING btree (project_id);


--
-- Name: index_cluster_users_on_request_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_cluster_users_on_request_id ON cluster_users USING btree (request_id);


--
-- Name: index_clusters_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_clusters_on_state ON clusters USING btree (state);


--
-- Name: index_credentials_on_public_key; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_credentials_on_public_key ON credentials USING btree (public_key);


--
-- Name: index_credentials_on_public_key_and_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE UNIQUE INDEX index_credentials_on_public_key_and_user_id ON credentials USING btree (public_key, user_id);


--
-- Name: index_credentials_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_credentials_on_user_id ON credentials USING btree (user_id);


--
-- Name: index_credentials_on_user_id_and_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_credentials_on_user_id_and_state ON credentials USING btree (user_id, state);


--
-- Name: index_memberships_on_organization_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_memberships_on_organization_id ON memberships USING btree (organization_id);


--
-- Name: index_memberships_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_memberships_on_user_id ON memberships USING btree (user_id);


--
-- Name: index_organization_kinds_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_organization_kinds_on_state ON organization_kinds USING btree (state);


--
-- Name: index_organizations_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_organizations_on_state ON organizations USING btree (state);


--
-- Name: index_pages_on_url; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE UNIQUE INDEX index_pages_on_url ON pages USING btree (url);


--
-- Name: index_positions_on_membership_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_positions_on_membership_id ON positions USING btree (membership_id);


--
-- Name: index_projects_on_organization_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_projects_on_organization_id ON projects USING btree (organization_id);


--
-- Name: index_projects_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_projects_on_state ON projects USING btree (state);


--
-- Name: index_projects_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_projects_on_user_id ON projects USING btree (user_id);


--
-- Name: index_replies_on_ticket_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_replies_on_ticket_id ON replies USING btree (ticket_id);


--
-- Name: index_replies_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_replies_on_user_id ON replies USING btree (user_id);


--
-- Name: index_request_properties_on_request_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_request_properties_on_request_id ON request_properties USING btree (request_id);


--
-- Name: index_requests_on_cluster_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_requests_on_cluster_id ON requests USING btree (cluster_id);


--
-- Name: index_requests_on_project_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_requests_on_project_id ON requests USING btree (project_id);


--
-- Name: index_requests_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_requests_on_state ON requests USING btree (state);


--
-- Name: index_requests_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_requests_on_user_id ON requests USING btree (user_id);


--
-- Name: index_sureties_on_organization_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_sureties_on_organization_id ON sureties USING btree (organization_id);


--
-- Name: index_sureties_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_sureties_on_state ON sureties USING btree (state);


--
-- Name: index_sureties_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_sureties_on_user_id ON sureties USING btree (user_id);


--
-- Name: index_tasks_on_resource_id_and_resource_type; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_tasks_on_resource_id_and_resource_type ON tasks USING btree (resource_id, resource_type);


--
-- Name: index_tasks_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_tasks_on_state ON tasks USING btree (state);


--
-- Name: index_tasks_on_task_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_tasks_on_task_id ON tasks USING btree (task_id);


--
-- Name: index_ticket_field_relations_on_ticket_field_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_field_relations_on_ticket_field_id ON ticket_field_relations USING btree (ticket_field_id);


--
-- Name: index_ticket_field_relations_on_ticket_question_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_field_relations_on_ticket_question_id ON ticket_field_relations USING btree (ticket_question_id);


--
-- Name: index_ticket_field_values_on_ticket_field_relation_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_field_values_on_ticket_field_relation_id ON ticket_field_values USING btree (ticket_field_relation_id);


--
-- Name: index_ticket_field_values_on_ticket_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_field_values_on_ticket_id ON ticket_field_values USING btree (ticket_id);


--
-- Name: index_ticket_fields_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_fields_on_state ON ticket_fields USING btree (state);


--
-- Name: index_ticket_questions_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_questions_on_state ON ticket_questions USING btree (state);


--
-- Name: index_ticket_questions_on_ticket_question_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_questions_on_ticket_question_id ON ticket_questions USING btree (ticket_question_id);


--
-- Name: index_ticket_tag_relations_on_ticket_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_tag_relations_on_ticket_id ON ticket_tag_relations USING btree (ticket_id);


--
-- Name: index_ticket_tag_relations_on_ticket_tag_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_tag_relations_on_ticket_tag_id ON ticket_tag_relations USING btree (ticket_tag_id);


--
-- Name: index_ticket_tags_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_tags_on_state ON ticket_tags USING btree (state);


--
-- Name: index_ticket_templates_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_ticket_templates_on_state ON ticket_templates USING btree (state);


--
-- Name: index_tickets_on_cluster_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_tickets_on_cluster_id ON tickets USING btree (cluster_id);


--
-- Name: index_tickets_on_project_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_tickets_on_project_id ON tickets USING btree (project_id);


--
-- Name: index_tickets_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_tickets_on_state ON tickets USING btree (state);


--
-- Name: index_tickets_on_user_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_tickets_on_user_id ON tickets USING btree (user_id);


--
-- Name: index_users_on_activation_token; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_users_on_activation_token ON users USING btree (activation_token);


--
-- Name: index_users_on_remember_me_token; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_users_on_remember_me_token ON users USING btree (remember_me_token);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_state; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_users_on_state ON users USING btree (state);


--
-- Name: index_users_on_token; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_token ON users USING btree (token);


--
-- Name: index_values_on_field_id_and_model_id_and_model_type; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE UNIQUE INDEX index_values_on_field_id_and_model_id_and_model_type ON "values" USING btree (field_id, model_id, model_type);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: index_wiki_urls_on_page_id; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_wiki_urls_on_page_id ON wiki_urls USING btree (page_id);


--
-- Name: index_wiki_urls_on_url; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE INDEX index_wiki_urls_on_url ON wiki_urls USING btree (url);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: octoshell; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: releu
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM releu;
GRANT ALL ON SCHEMA public TO releu;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

