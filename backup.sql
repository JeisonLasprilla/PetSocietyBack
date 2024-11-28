--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    appointment_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    appointment_date timestamp without time zone NOT NULL,
    reason text,
    status character varying(50) DEFAULT 'scheduled'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    "petId" uuid,
    "veterinarianId" uuid
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: medical_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medical_records (
    record_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    diagnosis text,
    treatment text,
    medication text,
    notes text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    "petId" uuid,
    "veterinarianId" uuid,
    "appointmentAppointmentId" uuid
);


ALTER TABLE public.medical_records OWNER TO postgres;

--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    address character varying(255) NOT NULL,
    phone_number character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    "userId" uuid
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: pets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    species character varying(50),
    breed character varying(50),
    birth_date date,
    gender character varying(10),
    weight numeric(5,2),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    "userId" uuid
);


ALTER TABLE public.pets OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    price integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role text DEFAULT 'owner'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (appointment_id, appointment_date, reason, status, created_at, updated_at, "petId", "veterinarianId") FROM stdin;
\.


--
-- Data for Name: medical_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medical_records (record_id, diagnosis, treatment, medication, notes, created_at, updated_at, "petId", "veterinarianId", "appointmentAppointmentId") FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (id, address, phone_number, created_at, updated_at, "userId") FROM stdin;
9ba188b3-06f0-487f-a9f2-387f58cedb59	Calle 45#121A-39	304452462	2024-11-28 03:07:06.222996	2024-11-28 03:07:06.222996	24da11a9-4248-4a68-a257-9b022d8e1e0c
91854c9e-bdb6-4909-a12b-9fd44e467cb7	ginebra	124568925	2024-11-28 05:42:35.529098	2024-11-28 05:42:35.529098	3cb19a67-6c80-43c9-ae41-d48b1731bfde
8e7ebacf-b27d-4feb-b352-a448eb34503a	pr	12345679	2024-11-28 05:50:51.623061	2024-11-28 05:50:51.623061	676f24c6-d6e2-4e0a-a8bb-cda813fae665
68675481-b943-4cfb-b070-5dcceb09966a	Calle 45#121A-39	98877	2024-11-28 05:53:26.559914	2024-11-28 05:53:26.559914	921ecc9e-4c4f-477f-8a56-8cd8e9a0681c
c2103406-3a18-413b-b17b-7131f2070ecc	Calle 45#121A-39	12345	2024-11-28 05:58:04.833989	2024-11-28 05:58:04.833989	f01260ef-e9ae-40ee-926b-ae927c646aa3
57eb450f-7cd2-43aa-87d2-8c69b1afed2b	jhayyy@gmail.com	1235	2024-11-28 06:04:15.17653	2024-11-28 06:04:15.17653	73c28e5b-d332-4257-8597-5f22f615ff23
c80a1464-09c0-4152-a992-5c89a00d312e	MX	7582356	2024-11-28 06:10:01.049387	2024-11-28 06:10:01.049387	1d14a654-2296-4079-8bf1-04ceb96e4e84
0ee3a4f4-3ebc-44d8-86b5-f67d7e6d9544	Calle 45#121A-39	123516	2024-11-28 06:15:57.078702	2024-11-28 06:15:57.078702	a4638a0d-f3a8-45f8-adcf-d0e0836be7fa
05ebd3f5-460f-467a-b543-334915059e4d	Calle 45#121A-39	12351	2024-11-28 06:19:36.012472	2024-11-28 06:19:36.012472	4a551e27-a265-4ced-b163-6ea302bb7111
b61ff2bb-b89f-482c-898a-ee0f85e5d33c	Calle 45#121A-39	2351	2024-11-28 06:21:12.130785	2024-11-28 06:21:12.130785	a603f22b-8c8e-4035-89f9-f8cfff026f0a
14abc7de-4c4f-4aac-8f4d-0e1e5cf2adce	Calle 45#121A-39	1255	2024-11-28 06:24:24.724943	2024-11-28 06:24:24.724943	609713a7-f58b-4443-b1d1-4fb5b5072c89
6e08e058-72a4-4f0f-9f91-2a3c256d5720	Calle 45#121A-39	3535	2024-11-28 06:26:04.115481	2024-11-28 06:26:04.115481	7a420887-1a5e-4bf9-ace7-f68ab570eaff
a3520daf-b059-4273-a9cc-1420c5797aac	Calle 45#121A-39	3256	2024-11-28 06:32:36.361668	2024-11-28 06:32:36.361668	cd7d652c-4889-460a-917a-7abf06a860d6
579aa390-fbc1-4d34-bf50-043f4c0e2127	Calle 45#121A-39	1255	2024-11-28 06:38:36.814817	2024-11-28 06:38:36.814817	5aadba6f-c161-4bfa-8dd0-4a462e107e8d
\.


--
-- Data for Name: pets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pets (id, name, species, breed, birth_date, gender, weight, created_at, updated_at, "userId") FROM stdin;
8409ed2b-6e13-4439-bf82-fc362587f480	Canelo	Dog	Golden retriever	2020-01-15	Male	25.50	2024-11-28 05:13:48.705973	2024-11-28 05:13:48.705973	24da11a9-4248-4a68-a257-9b022d8e1e0c
3568a0c1-8963-4ab6-aa37-007c94f658c5	jeisoo	monkey	monkey	2024-11-05	male	30.00	2024-11-28 06:39:18.75016	2024-11-28 06:39:18.75016	1d14a654-2296-4079-8bf1-04ceb96e4e84
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, name, description, price, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, role, created_at, updated_at) FROM stdin;
24da11a9-4248-4a68-a257-9b022d8e1e0c	Jeison Fabian Lasprilla Pantoja	jeisonlasprilla124@gmail.com	$2b$10$MCMda32Qg0xzA/aUefh6P.MPS.of.5qxAqdXOSjtCJud9Zb1Her0S	owner	2024-11-28 03:07:06.185735	2024-11-28 03:07:06.185735
3cb19a67-6c80-43c9-ae41-d48b1731bfde	Fabian Pantoja	fabian@gmail.com	$2b$10$AWYOCnxIKRo/HhVEEZsOXO8aOlVXfqVHdmQRw1oJEwcNbefM594.K	owner	2024-11-28 05:42:35.45717	2024-11-28 05:42:35.45717
676f24c6-d6e2-4e0a-a8bb-cda813fae665	bad bunny	badbunny@gmail.com	$2b$10$KXbw5KFQ16Si7ZrPQvA54..uz3GH2ptW7Paf08pxvw1QbWxIk2sMK	owner	2024-11-28 05:50:51.543645	2024-11-28 05:50:51.543645
921ecc9e-4c4f-477f-8a56-8cd8e9a0681c	Miguel Lopez	miguel@gmail.com	$2b$10$TEO.EKZpSaP3alKhJYkM.uIbRtRP8GUxZmoMoiVD0FGdfpdz1y0sC	owner	2024-11-28 05:53:26.527548	2024-11-28 05:53:26.527548
f01260ef-e9ae-40ee-926b-ae927c646aa3	jhay lasprilla	lasprilla124@gmail.com	$2b$10$l6Hup0Vo.GVDm1DLUSxkM.HwM9jSpqf4HJQY8XwWjSNMYXcZNLvQq	owner	2024-11-28 05:58:04.800516	2024-11-28 05:58:04.800516
73c28e5b-d332-4257-8597-5f22f615ff23	Jhay Lasprilla Pantoja	jhayyy@gmail.com	$2b$10$4ObC3SwsdYNHFGwp0cZzPuh5x90H/HORqdnyg2YhWpHYZCH3xYrvi	owner	2024-11-28 06:04:15.101359	2024-11-28 06:04:15.101359
1d14a654-2296-4079-8bf1-04ceb96e4e84	Luis Miguel	luis@gmail.com	$2b$10$z5dqVl.PVcOJ/XJIhgcDj.i0CLq9mqTKqozf7v0sxOevJhbifVHDS	owner	2024-11-28 06:10:01.015226	2024-11-28 06:10:01.015226
a4638a0d-f3a8-45f8-adcf-d0e0836be7fa	Jeison Fabian Lasprilla Pantoja	laspri@gmail.com	$2b$10$nYH6GquOyqmfQuYkzZnSeOsECs90BbXoO9SL00W.iLWYvcklwAlyi	owner	2024-11-28 06:15:57.040361	2024-11-28 06:15:57.040361
4a551e27-a265-4ced-b163-6ea302bb7111	Jeison Fabian Lasprilla Pantoja	laspriii@gmail.com	$2b$10$ZFpc4v9hoOlCFKwsoyOiU.Q4dnUQv43nZmSy/sMGAhHiUzmG9PRNa	owner	2024-11-28 06:19:35.808566	2024-11-28 06:19:35.808566
a603f22b-8c8e-4035-89f9-f8cfff026f0a	juan p	juanp@gmail.com	$2b$10$2re2s8Lq0YCyBvEcDc0uk.O2c7e7UmliE41RnrkLRnYKaMg69Gz1G	owner	2024-11-28 06:21:12.0945	2024-11-28 06:21:12.0945
609713a7-f58b-4443-b1d1-4fb5b5072c89	jei p	jei@gmail.com	$2b$10$BcxtVtZyOAWrgSAZU/Win.9nij3Wg15MO0e4r49lZ8Ri8gCriiPZq	owner	2024-11-28 06:24:24.542025	2024-11-28 06:24:24.542025
7a420887-1a5e-4bf9-ace7-f68ab570eaff	jjj aa	jjj@gmail.com	$2b$10$Kl0q7JVWtHl/0j8i41ZtOuAQ20aTYTHLGDf.jxkyGPnB3MtsbA7Ka	owner	2024-11-28 06:26:03.987209	2024-11-28 06:26:03.987209
411f32f3-759b-44dd-8a4c-d8f382b799d6	Admin	admin@example.com	$2b$10$j94HPlOsMX7sTdTJM9Zg2O4SY2vUx9iHochgqFqxPrElZ.YOdJFgy	admin	2024-11-28 06:32:09.152967	2024-11-28 06:32:09.152967
cd7d652c-4889-460a-917a-7abf06a860d6	juan santos	santos@gmail.com	$2b$10$kSI2KsWbGWUTrlYFjWRekO5oQgCu1r8JcPja3HTLRjSZHowJjLbYe	owner	2024-11-28 06:32:36.323945	2024-11-28 06:32:36.323945
5aadba6f-c161-4bfa-8dd0-4a462e107e8d	Jeison Fabian Lasprilla Pantoja	jeiso@gmail.com	$2b$10$56jf0p1Yev.fSiIj0KSTW.fPDXNIN795GSXN6vNfFtSKUdKVGDZU.	owner	2024-11-28 06:38:36.738887	2024-11-28 06:38:36.738887
\.


--
-- Name: medical_records PK_9022f23b7a54a91b9693c027511; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_records
    ADD CONSTRAINT "PK_9022f23b7a54a91b9693c027511" PRIMARY KEY (record_id);


--
-- Name: users PK_a3ffb1c0c8416b9fc6f907b7433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id);


--
-- Name: patients PK_a7f0b9fcbb3469d5ec0b0aceaa7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT "PK_a7f0b9fcbb3469d5ec0b0aceaa7" PRIMARY KEY (id);


--
-- Name: services PK_ba2d347a3168a296416c6c5ccb2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT "PK_ba2d347a3168a296416c6c5ccb2" PRIMARY KEY (id);


--
-- Name: pets PK_d01e9e7b4ada753c826720bee8b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT "PK_d01e9e7b4ada753c826720bee8b" PRIMARY KEY (id);


--
-- Name: appointments PK_dde485d1b7ca51845c075befb6b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "PK_dde485d1b7ca51845c075befb6b" PRIMARY KEY (appointment_id);


--
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- Name: patients FK_2c24c3490a26d04b0d70f92057a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT "FK_2c24c3490a26d04b0d70f92057a" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: appointments FK_96e11d40768b1eea9dddc38a124; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "FK_96e11d40768b1eea9dddc38a124" FOREIGN KEY ("petId") REFERENCES public.pets(id) ON DELETE CASCADE;


--
-- Name: medical_records FK_a24988e473c968c7bc8de186a90; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_records
    ADD CONSTRAINT "FK_a24988e473c968c7bc8de186a90" FOREIGN KEY ("appointmentAppointmentId") REFERENCES public.appointments(appointment_id) ON DELETE SET NULL;


--
-- Name: pets FK_a9f39dd54113410cdd3a04e80eb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT "FK_a9f39dd54113410cdd3a04e80eb" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: appointments FK_b9e492c0dd1bc7ed427bdd2aa93; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "FK_b9e492c0dd1bc7ed427bdd2aa93" FOREIGN KEY ("veterinarianId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: medical_records FK_e5a90668d638f333ad8cb7cdfdc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_records
    ADD CONSTRAINT "FK_e5a90668d638f333ad8cb7cdfdc" FOREIGN KEY ("petId") REFERENCES public.pets(id) ON DELETE CASCADE;


--
-- Name: medical_records FK_fbea53deac705aa960eb26a2804; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_records
    ADD CONSTRAINT "FK_fbea53deac705aa960eb26a2804" FOREIGN KEY ("veterinarianId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

