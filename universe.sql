--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    galaxy_type text,
    number_of_systems integer,
    name character varying(60),
    is_real boolean NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    distance_from_planet numeric,
    is_spherical boolean,
    name character varying(60)
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    number_of_moons integer,
    has_life boolean,
    name character varying(60)
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    star_type text,
    star_color character varying(10),
    name character varying(60)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: system; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.system (
    system_id integer NOT NULL,
    number_of_planets integer,
    galaxy_id integer NOT NULL,
    name character varying(60)
);


ALTER TABLE public.system OWNER TO freecodecamp;

--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Spiral', 400, 'Milky Way', true);
INSERT INTO public.galaxy VALUES (2, 'spiral', 300, 'Andromeda', true);
INSERT INTO public.galaxy VALUES (3, 'starburst', 123, 'Cigar', true);
INSERT INTO public.galaxy VALUES (4, 'dwarf', 64, 'Large Magellanic Cloud', true);
INSERT INTO public.galaxy VALUES (5, 'ring', 156, 'Cartwheel', true);
INSERT INTO public.galaxy VALUES (6, 'spiral', 250, 'Star Wars', false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 3, 384, true, 'luna');
INSERT INTO public.moon VALUES (2, 4, 3, false, 'Phobos');
INSERT INTO public.moon VALUES (3, 4, 23, false, 'Deimos');
INSERT INTO public.moon VALUES (4, 5, 670, true, 'Europa');
INSERT INTO public.moon VALUES (5, 5, 1070, true, 'Ganymede');
INSERT INTO public.moon VALUES (6, 6, 1222, true, 'Titan');
INSERT INTO public.moon VALUES (7, 6, 3561, true, 'Iapetus');
INSERT INTO public.moon VALUES (8, 6, 294, true, 'Tethys');
INSERT INTO public.moon VALUES (9, 7, 436, true, 'Titania');
INSERT INTO public.moon VALUES (10, 7, 266, true, 'Umbriel');
INSERT INTO public.moon VALUES (11, 7, 191, true, 'Ariel');
INSERT INTO public.moon VALUES (12, 8, 355, true, 'Triton');
INSERT INTO public.moon VALUES (13, 8, 5504, NULL, 'Nereid');
INSERT INTO public.moon VALUES (14, 9, 20, true, 'Charon');
INSERT INTO public.moon VALUES (15, 9, 65, false, 'Hydra');
INSERT INTO public.moon VALUES (16, 10, NULL, NULL, 'Ghomrassan');
INSERT INTO public.moon VALUES (17, 11, 100, true, 'Yavin I');
INSERT INTO public.moon VALUES (18, 11, 200, true, 'Yavin II');
INSERT INTO public.moon VALUES (19, 11, 300, false, 'Yavin III');
INSERT INTO public.moon VALUES (20, 11, 400, true, 'Yavin IV');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 0, false, 'Mercury');
INSERT INTO public.planet VALUES (2, 1, 0, false, 'Venus');
INSERT INTO public.planet VALUES (3, 1, 1, true, 'Earth');
INSERT INTO public.planet VALUES (4, 1, 2, NULL, 'Mars');
INSERT INTO public.planet VALUES (5, 1, 95, false, 'Jupiter');
INSERT INTO public.planet VALUES (6, 1, 146, false, 'Saturn');
INSERT INTO public.planet VALUES (7, 1, 28, false, 'Uranus');
INSERT INTO public.planet VALUES (8, 1, 16, false, 'Neptune');
INSERT INTO public.planet VALUES (9, 1, 5, false, 'Pluto');
INSERT INTO public.planet VALUES (10, 5, 3, true, 'Tatooine');
INSERT INTO public.planet VALUES (11, 6, 4, false, 'Yavin');
INSERT INTO public.planet VALUES (12, 7, NULL, true, 'Coruscant');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'regular', 'yellow', 'Sol');
INSERT INTO public.star VALUES (2, 1, 'supergiant', 'red', 'Betelgeuse');
INSERT INTO public.star VALUES (3, 1, 'loop', 'blue', 'Canopus');
INSERT INTO public.star VALUES (4, 1, 'supergiant', 'red', 'Antares');
INSERT INTO public.star VALUES (5, 6, 'twin', 'yellow', 'Twin Sun');
INSERT INTO public.star VALUES (6, 6, 'giant', NULL, 'Unspecified1');
INSERT INTO public.star VALUES (7, 6, NULL, NULL, 'Unspecified2');


--
-- Data for Name: system; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.system VALUES (1, 9, 1, 'Solar');
INSERT INTO public.system VALUES (2, NULL, 1, 'Unnamed1');
INSERT INTO public.system VALUES (3, 3, 6, 'Outer Rim');


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: system system_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.system
    ADD CONSTRAINT system_name_key UNIQUE (name);


--
-- Name: system system_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.system
    ADD CONSTRAINT system_pkey PRIMARY KEY (system_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: system system_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.system
    ADD CONSTRAINT system_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

