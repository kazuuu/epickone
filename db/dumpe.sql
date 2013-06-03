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
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


ALTER TABLE public.active_admin_comments OWNER TO kazuuu;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_admin_comments_id_seq OWNER TO kazuuu;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: answer_translations; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE answer_translations (
    id integer NOT NULL,
    answer_id integer,
    locale character varying(255),
    answer_text character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.answer_translations OWNER TO kazuuu;

--
-- Name: answer_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE answer_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_translations_id_seq OWNER TO kazuuu;

--
-- Name: answer_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE answer_translations_id_seq OWNED BY answer_translations.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    answer_text character varying(255),
    description text,
    sort_order integer,
    iscorrect integer,
    question_id integer,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.answers OWNER TO kazuuu;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_seq OWNER TO kazuuu;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE carts (
    id integer NOT NULL,
    user_id integer,
    purchased_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.carts OWNER TO kazuuu;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_id_seq OWNER TO kazuuu;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE carts_id_seq OWNED BY carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    parent_id integer,
    title character varying(255),
    description text,
    sort_order integer,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO kazuuu;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO kazuuu;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: category_translations; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE category_translations (
    id integer NOT NULL,
    category_id integer,
    locale character varying(255),
    title character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.category_translations OWNER TO kazuuu;

--
-- Name: category_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE category_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_translations_id_seq OWNER TO kazuuu;

--
-- Name: category_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE category_translations_id_seq OWNED BY category_translations.id;


--
-- Name: event_translations; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE event_translations (
    id integer NOT NULL,
    event_id integer,
    locale character varying(255),
    title character varying(255),
    headline character varying(255),
    prize character varying(255),
    description text,
    instruction text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.event_translations OWNER TO kazuuu;

--
-- Name: event_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE event_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_translations_id_seq OWNER TO kazuuu;

--
-- Name: event_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE event_translations_id_seq OWNED BY event_translations.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    category_id integer,
    quiz_id integer,
    title character varying(255),
    headline character varying(255),
    prize character varying(255),
    site_position character varying(255),
    description text,
    instruction text,
    join_min integer,
    join_max integer,
    enable boolean,
    covering_area character varying(255),
    join_type character varying(255),
    price_ticket numeric,
    date_due timestamp without time zone,
    date_start timestamp without time zone,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.events OWNER TO kazuuu;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO kazuuu;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: payment_notifications; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE payment_notifications (
    id integer NOT NULL,
    params text,
    cart_id integer,
    status character varying(255),
    transaction_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.payment_notifications OWNER TO kazuuu;

--
-- Name: payment_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE payment_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_notifications_id_seq OWNER TO kazuuu;

--
-- Name: payment_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE payment_notifications_id_seq OWNED BY payment_notifications.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE photos (
    id integer NOT NULL,
    image_type character varying(255),
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone,
    photable_id integer,
    photable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.photos OWNER TO kazuuu;

--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photos_id_seq OWNER TO kazuuu;

--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- Name: question_translations; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE question_translations (
    id integer NOT NULL,
    question_id integer,
    locale character varying(255),
    title character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.question_translations OWNER TO kazuuu;

--
-- Name: question_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE question_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_translations_id_seq OWNER TO kazuuu;

--
-- Name: question_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE question_translations_id_seq OWNED BY question_translations.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    quiz_id integer,
    title character varying(255),
    description text,
    sort_order integer,
    style character varying(255),
    question_type character varying(255),
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.questions OWNER TO kazuuu;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO kazuuu;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE quizzes (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.quizzes OWNER TO kazuuu;

--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quizzes_id_seq OWNER TO kazuuu;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE quizzes_id_seq OWNED BY quizzes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO kazuuu;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE tickets (
    id integer NOT NULL,
    event_id integer,
    unit_price numeric,
    quantity integer,
    origin character varying(255),
    cart_id integer,
    user_id integer,
    picked_number integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.tickets OWNER TO kazuuu;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO kazuuu;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE tickets_id_seq OWNED BY tickets.id;


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE user_sessions (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_sessions OWNER TO kazuuu;

--
-- Name: user_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE user_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_sessions_id_seq OWNER TO kazuuu;

--
-- Name: user_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE user_sessions_id_seq OWNED BY user_sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    crypted_password character varying(255),
    password_salt character varying(255),
    persistence_token character varying(255),
    perishable_token character varying(255) DEFAULT ''::character varying NOT NULL,
    active boolean DEFAULT false NOT NULL,
    current_login_ip character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    document character varying(255),
    gender character varying(255),
    title character varying(255),
    birthday timestamp without time zone,
    city character varying(255),
    state character varying(255),
    country character varying(255),
    address1 character varying(255),
    address2 character varying(255),
    zipcode character varying(255),
    phone_mobile character varying(255),
    admin_flag boolean DEFAULT false,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    locale character varying(255),
    facebook_uid character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    provider character varying(255),
    avatar_url character varying(255),
    twitter_uid character varying(255),
    twitter_oauth_token character varying(255),
    twitter_oauth_secret character varying(255),
    twitter_oauth_expires_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    newsletter boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO kazuuu;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: kazuuu
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO kazuuu;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kazuuu
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY answer_translations ALTER COLUMN id SET DEFAULT nextval('answer_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY carts ALTER COLUMN id SET DEFAULT nextval('carts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY category_translations ALTER COLUMN id SET DEFAULT nextval('category_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY event_translations ALTER COLUMN id SET DEFAULT nextval('event_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY payment_notifications ALTER COLUMN id SET DEFAULT nextval('payment_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY question_translations ALTER COLUMN id SET DEFAULT nextval('question_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY quizzes ALTER COLUMN id SET DEFAULT nextval('quizzes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY tickets ALTER COLUMN id SET DEFAULT nextval('tickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY user_sessions ALTER COLUMN id SET DEFAULT nextval('user_sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kazuuu
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY active_admin_comments (id, resource_id, resource_type, author_id, author_type, body, created_at, updated_at, namespace) FROM stdin;
\.


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('active_admin_comments_id_seq', 1, false);


--
-- Data for Name: answer_translations; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY answer_translations (id, answer_id, locale, answer_text, description, created_at, updated_at) FROM stdin;
2	1	en-US			2013-06-03 10:33:15.047735	2013-06-03 10:33:15.077925
3	1	pt-br	\N	\N	2013-06-03 10:33:15.078558	2013-06-03 10:33:15.078558
4	1	pt	\N	\N	2013-06-03 10:33:15.079397	2013-06-03 10:33:15.079397
5	2	pt-br	\N	\N	2013-06-03 10:33:15.08829	2013-06-03 10:33:15.08829
6	2	pt	\N	\N	2013-06-03 10:33:15.089126	2013-06-03 10:33:15.089126
8	3	pt-br	\N	\N	2013-06-03 10:33:15.097711	2013-06-03 10:33:15.097711
9	3	pt	\N	\N	2013-06-03 10:33:15.098523	2013-06-03 10:33:15.098523
1	1	pt-BR	aaaa		2013-06-03 10:33:15.043633	2013-06-03 10:33:44.971641
7	2	pt-BR	bbbb		2013-06-03 10:33:15.089912	2013-06-03 10:33:44.982679
11	2	en-US			2013-06-03 10:33:44.985786	2013-06-03 10:33:44.985786
10	3	pt-BR	cccc		2013-06-03 10:33:15.099261	2013-06-03 10:33:44.988923
12	3	en-US			2013-06-03 10:33:44.991758	2013-06-03 10:33:44.991758
\.


--
-- Name: answer_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('answer_translations_id_seq', 12, true);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY answers (id, answer_text, description, sort_order, iscorrect, question_id, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at, created_at, updated_at) FROM stdin;
1			2	1	1	\N	\N	\N	\N	2013-06-03 10:33:15.07247	2013-06-03 10:33:44.998068
2	\N	\N	1	\N	1	\N	\N	\N	\N	2013-06-03 10:33:15.083143	2013-06-03 10:33:45.002147
3	\N	\N	3	\N	1	\N	\N	\N	\N	2013-06-03 10:33:15.093099	2013-06-03 10:33:45.00615
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('answers_id_seq', 3, true);


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY carts (id, user_id, purchased_at, created_at, updated_at) FROM stdin;
1	1	\N	2013-06-03 10:30:27.731667	2013-06-03 10:30:27.731667
\.


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('carts_id_seq', 1, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY categories (id, parent_id, title, description, sort_order, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at, created_at, updated_at) FROM stdin;
1	\N	1		\N	\N	\N	\N	\N	2013-06-03 10:32:16.070984	2013-06-03 10:32:16.070984
2	\N	2		\N	\N	\N	\N	\N	2013-06-03 10:32:32.967797	2013-06-03 10:32:32.967797
3	\N	Promocionais		\N	\N	\N	\N	\N	2013-06-03 10:32:41.904679	2013-06-03 10:32:41.904679
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('categories_id_seq', 3, true);


--
-- Data for Name: category_translations; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY category_translations (id, category_id, locale, title, description, created_at, updated_at) FROM stdin;
1	1	pt-BR	1		2013-06-03 10:32:16.057004	2013-06-03 10:32:16.078538
2	1	en-US			2013-06-03 10:32:16.068152	2013-06-03 10:32:16.079574
3	1	pt-br	\N	\N	2013-06-03 10:32:16.08021	2013-06-03 10:32:16.08021
4	1	pt	\N	\N	2013-06-03 10:32:16.081081	2013-06-03 10:32:16.081081
5	2	pt-BR	2		2013-06-03 10:32:32.962758	2013-06-03 10:32:32.971596
6	2	en-US			2013-06-03 10:32:32.965919	2013-06-03 10:32:32.972344
7	2	pt-br	\N	\N	2013-06-03 10:32:32.972938	2013-06-03 10:32:32.972938
8	2	pt	\N	\N	2013-06-03 10:32:32.973772	2013-06-03 10:32:32.973772
9	3	pt-BR	Promocionais		2013-06-03 10:32:41.89285	2013-06-03 10:32:41.909094
10	3	en-US			2013-06-03 10:32:41.902711	2013-06-03 10:32:41.910074
11	3	pt-br	\N	\N	2013-06-03 10:32:41.910866	2013-06-03 10:32:41.910866
12	3	pt	\N	\N	2013-06-03 10:32:41.911793	2013-06-03 10:32:41.911793
\.


--
-- Name: category_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('category_translations_id_seq', 12, true);


--
-- Data for Name: event_translations; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY event_translations (id, event_id, locale, title, headline, prize, description, instruction, created_at, updated_at) FROM stdin;
3	1	pt-br	\N	\N	\N	\N	\N	2013-06-03 10:34:38.216505	2013-06-03 10:34:38.216505
4	1	pt	\N	\N	\N	\N	\N	2013-06-03 10:34:38.217937	2013-06-03 10:34:38.217937
1	1	pt-BR	Evento Épico	ePick One	iPhone			2013-06-03 10:34:38.202687	2013-06-03 10:34:38.219508
2	1	en-US						2013-06-03 10:34:38.209144	2013-06-03 10:34:38.22098
\.


--
-- Name: event_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('event_translations_id_seq', 4, true);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY events (id, category_id, quiz_id, title, headline, prize, site_position, description, instruction, join_min, join_max, enable, covering_area, join_type, price_ticket, date_due, date_start, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at, created_at, updated_at) FROM stdin;
1	3	1	Evento Épico	ePick One	iPhone				\N	\N	t		promo	\N	2013-07-24 03:00:00	2013-06-02 03:00:00	Ipad.jpg	image/jpeg	5742	2013-06-03 10:34:37.992356	2013-06-03 10:34:38.212991	2013-06-03 10:34:38.212991
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('events_id_seq', 1, true);


--
-- Data for Name: payment_notifications; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY payment_notifications (id, params, cart_id, status, transaction_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: payment_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('payment_notifications_id_seq', 1, false);


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY photos (id, image_type, image_file_name, image_content_type, image_file_size, image_updated_at, photable_id, photable_type, created_at, updated_at) FROM stdin;
1	banner_bg	epic_bg_banner.png	image/png	84800	2013-06-03 12:39:38.26816	1	Event	2013-06-03 12:39:38.406466	2013-06-03 12:39:38.406466
2	banner_image	epick_iphone_banner.png	image/png	286224	2013-06-03 12:40:05.923174	1	Event	2013-06-03 12:40:06.061001	2013-06-03 12:40:06.061001
\.


--
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('photos_id_seq', 2, true);


--
-- Data for Name: question_translations; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY question_translations (id, question_id, locale, title, description, created_at, updated_at) FROM stdin;
1	1	pt-BR	Oque é oque é?		2013-06-03 10:33:15.028902	2013-06-03 10:33:15.0651
2	1	en-US			2013-06-03 10:33:15.039269	2013-06-03 10:33:15.066189
3	1	pt-br	\N	\N	2013-06-03 10:33:15.066806	2013-06-03 10:33:15.066806
4	1	pt	\N	\N	2013-06-03 10:33:15.067659	2013-06-03 10:33:15.067659
\.


--
-- Name: question_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('question_translations_id_seq', 4, true);


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY questions (id, quiz_id, title, description, sort_order, style, question_type, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at, created_at, updated_at) FROM stdin;
1	1	Oque é oque é?		\N		\N	\N	\N	\N	\N	2013-06-03 10:33:15.060275	2013-06-03 10:33:15.060275
\.


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('questions_id_seq', 1, true);


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY quizzes (id, title, created_at, updated_at) FROM stdin;
1	ePickOne	2013-06-03 10:32:53.967799	2013-06-03 10:32:53.967799
\.


--
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('quizzes_id_seq', 1, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY schema_migrations (version) FROM stdin;
20130520180100
20121019161818
20121019163246
20121020021433
20121021200719
20121021201034
20121025165412
20121025165413
20121028131701
20121029023147
20121029144441
20121118032014
20121122014512
20121122032019
20121122032037
20121128182137
20121128183831
20130519114456
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY tickets (id, event_id, unit_price, quantity, origin, cart_id, user_id, picked_number, created_at, updated_at) FROM stdin;
\.


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('tickets_id_seq', 1, false);


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY user_sessions (id, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('user_sessions_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: kazuuu
--

COPY users (id, email, crypted_password, password_salt, persistence_token, perishable_token, active, current_login_ip, first_name, last_name, document, gender, title, birthday, city, state, country, address1, address2, zipcode, phone_mobile, admin_flag, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at, locale, facebook_uid, oauth_token, oauth_expires_at, provider, avatar_url, twitter_uid, twitter_oauth_token, twitter_oauth_secret, twitter_oauth_expires_at, created_at, updated_at, newsletter) FROM stdin;
1	marcello@gmail.com	8279aa659457f33245312017da30bfc97b5ff65bcb21214fe390eec48c74f56bc75d1365bd465a273ae25ebdd46d17fb8174a4168605e32a87027a442e3f1135	RBUfNjnmqZsxc1EYkjJa	84aae3ca8f0b4b81db89a1de2487561e4111680a622d6aeda498ac19312cd9fe009a0f5438f1587aeda0859afc1417177f46fb205faf1779d4e2225399576fc7	5ESqqeSNdsbbd0sgcBx	t	127.0.0.1	Marcello	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0864472499	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2013-06-03 10:29:14.111361	2013-06-03 10:31:47.603173	t
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kazuuu
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: answer_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY answer_translations
    ADD CONSTRAINT answer_translations_pkey PRIMARY KEY (id);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: carts_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: category_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY category_translations
    ADD CONSTRAINT category_translations_pkey PRIMARY KEY (id);


--
-- Name: event_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY event_translations
    ADD CONSTRAINT event_translations_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: payment_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY payment_notifications
    ADD CONSTRAINT payment_notifications_pkey PRIMARY KEY (id);


--
-- Name: photos_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: question_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY question_translations
    ADD CONSTRAINT question_translations_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: kazuuu; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_answer_translations_on_answer_id; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_answer_translations_on_answer_id ON answer_translations USING btree (answer_id);


--
-- Name: index_answer_translations_on_locale; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_answer_translations_on_locale ON answer_translations USING btree (locale);


--
-- Name: index_category_translations_on_category_id; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_category_translations_on_category_id ON category_translations USING btree (category_id);


--
-- Name: index_category_translations_on_locale; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_category_translations_on_locale ON category_translations USING btree (locale);


--
-- Name: index_event_translations_on_event_id; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_event_translations_on_event_id ON event_translations USING btree (event_id);


--
-- Name: index_event_translations_on_locale; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_event_translations_on_locale ON event_translations USING btree (locale);


--
-- Name: index_events_on_category_id_and_created_at; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_events_on_category_id_and_created_at ON events USING btree (category_id, created_at);


--
-- Name: index_photos_on_photable_id_and_photable_type; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_photos_on_photable_id_and_photable_type ON photos USING btree (photable_id, photable_type);


--
-- Name: index_question_translations_on_locale; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_question_translations_on_locale ON question_translations USING btree (locale);


--
-- Name: index_question_translations_on_question_id; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_question_translations_on_question_id ON question_translations USING btree (question_id);


--
-- Name: index_users_on_perishable_token_and_email; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE INDEX index_users_on_perishable_token_and_email ON users USING btree (perishable_token, email);


--
-- Name: index_users_on_phone_mobile; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_phone_mobile ON users USING btree (phone_mobile);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: kazuuu; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: kazuuu
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM kazuuu;
GRANT ALL ON SCHEMA public TO kazuuu;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

