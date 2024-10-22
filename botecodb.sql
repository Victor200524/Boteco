--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10
-- Dumped by pg_dump version 16.2

-- Started on 2024-10-14 09:53:33

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
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

--
-- TOC entry 196 (class 1259 OID 17787)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    cat_id integer NOT NULL,
    cat_nome character varying(15) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 17790)
-- Name: categoria_cat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_cat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_cat_id_seq OWNER TO postgres;

--
-- TOC entry 2883 (class 0 OID 0)
-- Dependencies: 197
-- Name: categoria_cat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_cat_id_seq OWNED BY public.categoria.cat_id;


--
-- TOC entry 198 (class 1259 OID 17792)
-- Name: comanda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comanda (
    com_id integer NOT NULL,
    gar_id integer NOT NULL,
    com_numero numeric(15,0) NOT NULL,
    com_data date,
    com_desc character varying(255) NOT NULL,
    com_valor numeric(8,2),
    com_status character(1)
);


ALTER TABLE public.comanda OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 17795)
-- Name: comanda_com_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comanda_com_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comanda_com_id_seq OWNER TO postgres;

--
-- TOC entry 2884 (class 0 OID 0)
-- Dependencies: 199
-- Name: comanda_com_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comanda_com_id_seq OWNED BY public.comanda.com_id;


--
-- TOC entry 200 (class 1259 OID 17797)
-- Name: garcon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.garcon (
    gar_id integer NOT NULL,
    gar_nome character varying(40) NOT NULL,
    gar_cpf character varying(14) NOT NULL,
    gar_cep character varying(10),
    gar_endereco character varying(50),
    gar_cidade character varying(20),
    gar_uf character varying(2),
    gar_fone character varying(15),
    gar_foto bytea,
    gar_numero character varying(10)
);


ALTER TABLE public.garcon OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 17803)
-- Name: garcon_gar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.garcon_gar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.garcon_gar_id_seq OWNER TO postgres;

--
-- TOC entry 2885 (class 0 OID 0)
-- Dependencies: 201
-- Name: garcon_gar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.garcon_gar_id_seq OWNED BY public.garcon.gar_id;


--
-- TOC entry 202 (class 1259 OID 17805)
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    com_id integer NOT NULL,
    prod_id integer NOT NULL,
    it_quantidade integer NOT NULL
);


ALTER TABLE public.item OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17808)
-- Name: pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamento (
    pag_id integer NOT NULL,
    com_id integer,
    pag_valor numeric(8,2),
    tpg_id integer
);


ALTER TABLE public.pagamento OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17811)
-- Name: pagamento_pag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagamento_pag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagamento_pag_id_seq OWNER TO postgres;

--
-- TOC entry 2886 (class 0 OID 0)
-- Dependencies: 204
-- Name: pagamento_pag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagamento_pag_id_seq OWNED BY public.pagamento.pag_id;


--
-- TOC entry 205 (class 1259 OID 17813)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    prod_id integer NOT NULL,
    cat_id integer NOT NULL,
    uni_id integer NOT NULL,
    prod_nome character varying(30) NOT NULL,
    prod_preco numeric(8,2) NOT NULL,
    prod_descr character varying(100)
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 17816)
-- Name: produto_prod_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_prod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produto_prod_id_seq OWNER TO postgres;

--
-- TOC entry 2887 (class 0 OID 0)
-- Dependencies: 206
-- Name: produto_prod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_prod_id_seq OWNED BY public.produto.prod_id;


--
-- TOC entry 207 (class 1259 OID 17818)
-- Name: tipopgto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipopgto (
    tpg_id integer NOT NULL,
    tpg_nome character varying(15)
);


ALTER TABLE public.tipopgto OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17821)
-- Name: tipopgto_tpg_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipopgto_tpg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipopgto_tpg_id_seq OWNER TO postgres;

--
-- TOC entry 2888 (class 0 OID 0)
-- Dependencies: 208
-- Name: tipopgto_tpg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipopgto_tpg_id_seq OWNED BY public.tipopgto.tpg_id;


--
-- TOC entry 209 (class 1259 OID 17823)
-- Name: unidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unidade (
    uni_id integer NOT NULL,
    uni_nome character varying(15) NOT NULL
);


ALTER TABLE public.unidade OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17826)
-- Name: unidade_uni_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unidade_uni_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unidade_uni_id_seq OWNER TO postgres;

--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 210
-- Name: unidade_uni_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unidade_uni_id_seq OWNED BY public.unidade.uni_id;


--
-- TOC entry 2711 (class 2604 OID 17828)
-- Name: categoria cat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN cat_id SET DEFAULT nextval('public.categoria_cat_id_seq'::regclass);


--
-- TOC entry 2712 (class 2604 OID 17829)
-- Name: comanda com_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comanda ALTER COLUMN com_id SET DEFAULT nextval('public.comanda_com_id_seq'::regclass);


--
-- TOC entry 2713 (class 2604 OID 17830)
-- Name: garcon gar_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garcon ALTER COLUMN gar_id SET DEFAULT nextval('public.garcon_gar_id_seq'::regclass);


--
-- TOC entry 2714 (class 2604 OID 17831)
-- Name: pagamento pag_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento ALTER COLUMN pag_id SET DEFAULT nextval('public.pagamento_pag_id_seq'::regclass);


--
-- TOC entry 2715 (class 2604 OID 17832)
-- Name: produto prod_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN prod_id SET DEFAULT nextval('public.produto_prod_id_seq'::regclass);


--
-- TOC entry 2716 (class 2604 OID 17833)
-- Name: tipopgto tpg_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipopgto ALTER COLUMN tpg_id SET DEFAULT nextval('public.tipopgto_tpg_id_seq'::regclass);


--
-- TOC entry 2717 (class 2604 OID 17834)
-- Name: unidade uni_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidade ALTER COLUMN uni_id SET DEFAULT nextval('public.unidade_uni_id_seq'::regclass);


--
-- TOC entry 2862 (class 0 OID 17787)
-- Dependencies: 196
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categoria VALUES (1, 'Bebida');
INSERT INTO public.categoria VALUES (3, 'Sobremesa');
INSERT INTO public.categoria VALUES (2, 'Prato');


--
-- TOC entry 2864 (class 0 OID 17792)
-- Dependencies: 198
-- Data for Name: comanda; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.comanda VALUES (1, 1, 123, '2019-11-11', 'mesa do salao 2', 100.00, 'F');
INSERT INTO public.comanda VALUES (2, 2, 12, '2020-12-11', 'asas', 0.00, 'F');
INSERT INTO public.comanda VALUES (3, 1, 1, '2024-05-24', 'mesa com familia', 0.00, 'A');
INSERT INTO public.comanda VALUES (4, 1, 1, '2024-05-24', 'mesa com familia', 0.00, 'A');
INSERT INTO public.comanda VALUES (5, 1, 1, '2024-05-24', 'mesa com familia', 0.00, 'A');
INSERT INTO public.comanda VALUES (6, 1, 1, '2024-05-24', 'mesa com familia', 0.00, 'A');


--
-- TOC entry 2866 (class 0 OID 17797)
-- Dependencies: 200
-- Data for Name: garcon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.garcon VALUES (1, 'Fábio', '666.111.222-12', '14154-96', 'Rua Tupinambás nº:32', 'Epitácio', 'SP', '(18)99885-6332', NULL, NULL);
INSERT INTO public.garcon VALUES (2, 'Boris', '112121212', '19053694', 'Rua José Vieira', 'Presidente Prudente', 'SP', '', NULL, NULL);


--
-- TOC entry 2868 (class 0 OID 17805)
-- Dependencies: 202
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.item VALUES (2, 1, 1);
INSERT INTO public.item VALUES (2, 2, 22);
INSERT INTO public.item VALUES (4, 1, 1);
INSERT INTO public.item VALUES (4, 2, 3);
INSERT INTO public.item VALUES (6, 1, 5);
INSERT INTO public.item VALUES (6, 2, 6);


--
-- TOC entry 2869 (class 0 OID 17808)
-- Dependencies: 203
-- Data for Name: pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pagamento VALUES (1, 2, 50.00, 1);
INSERT INTO public.pagamento VALUES (2, 2, 80.00, 3);
INSERT INTO public.pagamento VALUES (3, 2, 7.59, 2);


--
-- TOC entry 2871 (class 0 OID 17813)
-- Dependencies: 205
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produto VALUES (2, 1, 1, 'Chopp', 5.80, 'chopp artesanal');
INSERT INTO public.produto VALUES (1, 1, 1, 'Vinho', 9.99, 'Importado');
INSERT INTO public.produto VALUES (3, 1, 1, 'vodka', 8.00, 'importada');
INSERT INTO public.produto VALUES (5, 1, 1, 'suco de uva', 4.50, 'natural');
INSERT INTO public.produto VALUES (6, 1, 3, 'cerveja heineken', 12.00, 'super gelada');
INSERT INTO public.produto VALUES (4, 1, 1, 'suco de laranja', 5.60, 'natural');
INSERT INTO public.produto VALUES (7, 2, 4, 'Batata frita', 18.00, 'porção grande, acompanha molho');


--
-- TOC entry 2873 (class 0 OID 17818)
-- Dependencies: 207
-- Data for Name: tipopgto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipopgto VALUES (1, 'Dinheiro');
INSERT INTO public.tipopgto VALUES (2, ' cartão débito
');
INSERT INTO public.tipopgto VALUES (3, 'cartão crédito');


--
-- TOC entry 2875 (class 0 OID 17823)
-- Dependencies: 209
-- Data for Name: unidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unidade VALUES (1, 'copo');
INSERT INTO public.unidade VALUES (2, 'garrafa 600ml');
INSERT INTO public.unidade VALUES (3, 'garrafa long ne');
INSERT INTO public.unidade VALUES (5, 'meia porção');
INSERT INTO public.unidade VALUES (4, 'porção');
INSERT INTO public.unidade VALUES (6, 'kit');


--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 197
-- Name: categoria_cat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_cat_id_seq', 3, true);


--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 199
-- Name: comanda_com_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comanda_com_id_seq', 6, true);


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 201
-- Name: garcon_gar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.garcon_gar_id_seq', 2, true);


--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 204
-- Name: pagamento_pag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagamento_pag_id_seq', 3, true);


--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 206
-- Name: produto_prod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_prod_id_seq', 7, true);


--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 208
-- Name: tipopgto_tpg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipopgto_tpg_id_seq', 3, true);


--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 210
-- Name: unidade_uni_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unidade_uni_id_seq', 6, true);


--
-- TOC entry 2725 (class 2606 OID 17885)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (com_id, prod_id);


--
-- TOC entry 2719 (class 2606 OID 17836)
-- Name: categoria pk_categoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT pk_categoria PRIMARY KEY (cat_id);


--
-- TOC entry 2721 (class 2606 OID 17838)
-- Name: comanda pk_comanda; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comanda
    ADD CONSTRAINT pk_comanda PRIMARY KEY (com_id);


--
-- TOC entry 2723 (class 2606 OID 17840)
-- Name: garcon pk_garcon; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garcon
    ADD CONSTRAINT pk_garcon PRIMARY KEY (gar_id);


--
-- TOC entry 2727 (class 2606 OID 17842)
-- Name: pagamento pk_pagamento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pk_pagamento PRIMARY KEY (pag_id);


--
-- TOC entry 2729 (class 2606 OID 17844)
-- Name: produto pk_produto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT pk_produto PRIMARY KEY (prod_id);


--
-- TOC entry 2731 (class 2606 OID 17846)
-- Name: tipopgto pk_tipopgto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipopgto
    ADD CONSTRAINT pk_tipopgto PRIMARY KEY (tpg_id);


--
-- TOC entry 2733 (class 2606 OID 17848)
-- Name: unidade pk_unidade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT pk_unidade PRIMARY KEY (uni_id);


--
-- TOC entry 2734 (class 2606 OID 17849)
-- Name: comanda fk_comanda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comanda
    ADD CONSTRAINT fk_comanda FOREIGN KEY (gar_id) REFERENCES public.garcon(gar_id);


--
-- TOC entry 2735 (class 2606 OID 17854)
-- Name: item fk_itemcomd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT fk_itemcomd FOREIGN KEY (com_id) REFERENCES public.comanda(com_id);


--
-- TOC entry 2736 (class 2606 OID 17859)
-- Name: item fk_itemprod; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT fk_itemprod FOREIGN KEY (prod_id) REFERENCES public.produto(prod_id);


--
-- TOC entry 2737 (class 2606 OID 17864)
-- Name: pagamento fk_pgtogarcon; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT fk_pgtogarcon FOREIGN KEY (com_id) REFERENCES public.garcon(gar_id);


--
-- TOC entry 2738 (class 2606 OID 17869)
-- Name: pagamento fk_pgtotipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT fk_pgtotipo FOREIGN KEY (tpg_id) REFERENCES public.tipopgto(tpg_id);


--
-- TOC entry 2739 (class 2606 OID 17874)
-- Name: produto fk_prodcat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_prodcat FOREIGN KEY (cat_id) REFERENCES public.categoria(cat_id);


--
-- TOC entry 2740 (class 2606 OID 17879)
-- Name: produto fk_produni; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_produni FOREIGN KEY (uni_id) REFERENCES public.unidade(uni_id);


--
-- TOC entry 2882 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-10-14 09:53:34

--
-- PostgreSQL database dump complete
--

