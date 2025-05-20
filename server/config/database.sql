--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-19 17:09:47

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 236 (class 1259 OID 41004)
-- Name: anchor_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anchor_location (
    anchorrec_id integer NOT NULL,
    anchor_id integer,
    anchor_x double precision,
    anchor_y double precision,
    anchor_z double precision,
    record_time timestamp without time zone,
    room_id integer
);


ALTER TABLE public.anchor_location OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 41003)
-- Name: anchor_location_anchorrec_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.anchor_location_anchorrec_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.anchor_location_anchorrec_id_seq1 OWNER TO postgres;

--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 235
-- Name: anchor_location_anchorrec_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.anchor_location_anchorrec_id_seq1 OWNED BY public.anchor_location.anchorrec_id;


--
-- TOC entry 224 (class 1259 OID 24611)
-- Name: borrow_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.borrow_request (
    request_id integer NOT NULL,
    detail text,
    status character varying(50),
    appointment_date timestamp without time zone,
    expected_return timestamp without time zone,
    borrow_date timestamp without time zone,
    return_date timestamp without time zone,
    client_id integer,
    device_id integer
);


ALTER TABLE public.borrow_request OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24610)
-- Name: borrow_request_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.borrow_request_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.borrow_request_request_id_seq OWNER TO postgres;

--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 223
-- Name: borrow_request_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.borrow_request_request_id_seq OWNED BY public.borrow_request.request_id;


--
-- TOC entry 232 (class 1259 OID 32782)
-- Name: borrow_request_request_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.borrow_request ALTER COLUMN request_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.borrow_request_request_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 24597)
-- Name: device; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device (
    device_id integer NOT NULL,
    device_name character varying(255),
    description text,
    serial character varying(255),
    manufacturer character varying(255),
    specification text,
    type_id integer,
    image text,
    is_active boolean,
    is_available boolean,
    room_id integer
);


ALTER TABLE public.device OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24596)
-- Name: device_device_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.device_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_device_id_seq OWNER TO postgres;

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 221
-- Name: device_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.device_device_id_seq OWNED BY public.device.device_id;


--
-- TOC entry 226 (class 1259 OID 24647)
-- Name: device_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device_location (
    devicerec_id integer NOT NULL,
    device_id integer,
    tag_x double precision,
    tag_y double precision,
    tag_z double precision,
    record_time timestamp without time zone,
    record_type character varying(50)
);


ALTER TABLE public.device_location OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24646)
-- Name: device_location_devicerec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.device_location_devicerec_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_location_devicerec_id_seq OWNER TO postgres;

--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 225
-- Name: device_location_devicerec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.device_location_devicerec_id_seq OWNED BY public.device_location.devicerec_id;


--
-- TOC entry 229 (class 1259 OID 32778)
-- Name: device_location_devicerec_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.device_location ALTER COLUMN devicerec_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.device_location_devicerec_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 24590)
-- Name: device_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device_type (
    type_id integer NOT NULL,
    type_name character varying(100)
);


ALTER TABLE public.device_type OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24589)
-- Name: device_type_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.device_type_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_type_type_id_seq OWNER TO postgres;

--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 219
-- Name: device_type_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.device_type_type_id_seq OWNED BY public.device_type.type_id;


--
-- TOC entry 230 (class 1259 OID 32779)
-- Name: device_type_type_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.device_type ALTER COLUMN type_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.device_type_type_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 24679)
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    notify_id integer NOT NULL,
    description text,
    notify_time timestamp without time zone,
    type character varying(50),
    is_read boolean,
    user_id integer
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24678)
-- Name: notification_notify_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_notify_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_notify_id_seq OWNER TO postgres;

--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 227
-- Name: notification_notify_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_notify_id_seq OWNED BY public.notification.notify_id;


--
-- TOC entry 234 (class 1259 OID 40972)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    room_id integer NOT NULL,
    room_max_x double precision,
    room_max_y double precision
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 40971)
-- Name: room_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_room_id_seq OWNER TO postgres;

--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 233
-- Name: room_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_room_id_seq OWNED BY public.room.room_id;


--
-- TOC entry 218 (class 1259 OID 24581)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    user_id integer NOT NULL,
    email character varying(255),
    password character varying(255),
    full_name character varying(255),
    phone_number character varying(20),
    role character varying(50),
    status character varying(50)
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24580)
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_user_id_seq OWNER TO postgres;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- TOC entry 231 (class 1259 OID 32781)
-- Name: user_user_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."user" ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_user_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4737 (class 2604 OID 41007)
-- Name: anchor_location anchorrec_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anchor_location ALTER COLUMN anchorrec_id SET DEFAULT nextval('public.anchor_location_anchorrec_id_seq1'::regclass);


--
-- TOC entry 4734 (class 2604 OID 40964)
-- Name: device device_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device ALTER COLUMN device_id SET DEFAULT nextval('public.device_device_id_seq'::regclass);


--
-- TOC entry 4735 (class 2604 OID 24682)
-- Name: notification notify_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN notify_id SET DEFAULT nextval('public.notification_notify_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 40975)
-- Name: room room_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN room_id SET DEFAULT nextval('public.room_room_id_seq'::regclass);


--
-- TOC entry 4925 (class 0 OID 41004)
-- Dependencies: 236
-- Data for Name: anchor_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.anchor_location VALUES (1, 1, 0, 0, 1.5, '2025-04-19 13:27:21.801048', 1);
INSERT INTO public.anchor_location VALUES (2, 2, 6.51, 0, 1.5, '2025-04-19 13:27:49.507227', 1);
INSERT INTO public.anchor_location VALUES (3, 3, 6.51, 6.55, 1.5, '2025-04-19 13:27:53.099654', 1);


--
-- TOC entry 4913 (class 0 OID 24611)
-- Dependencies: 224
-- Data for Name: borrow_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (25, 'tessttt', 'pending', '2025-05-13 00:00:00', '2025-05-16 00:00:00', NULL, NULL, 3, 2);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (6, 'Mượn thiết bị đo khí CO2', 'returned', '2025-04-21 10:00:00', '2025-04-25 10:00:00', '2025-05-13 00:00:00', '2025-05-13 00:00:00', 1, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (21, 'a123', 'approved', '2025-05-04 00:00:00', '2025-05-14 00:00:00', NULL, NULL, 3, 3);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (15, 'ok bro', 'pending', '2025-04-25 00:00:00', '2025-04-26 00:00:00', NULL, NULL, 1, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (16, 'aaaaaaa', 'pending', '2025-04-25 00:00:00', '2025-04-30 00:00:00', NULL, NULL, 1, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (26, '123', 'returned', '2025-05-13 00:00:00', '2025-05-15 00:00:00', '2025-05-13 00:00:00', '2025-05-15 00:00:00', 3, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (20, 'aaa', 'declined', '2025-05-31 00:00:00', '2025-05-31 00:00:00', NULL, NULL, 3, 2);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (27, '123', 'pending', '2025-05-14 00:00:00', '2025-05-15 00:00:00', NULL, NULL, 3, 2);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (17, 'abc', 'pending', '2025-04-26 00:00:00', '2025-04-27 00:00:00', NULL, NULL, 3, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (18, 'Mượn thiết bị đo khoảng cách', 'pending', '2025-04-29 10:00:00', '2025-05-01 10:00:00', NULL, NULL, 3, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (19, 'Mượn thiết bị đo khoảng cách', 'pending', '2025-04-29 10:00:00', '2025-05-01 10:00:00', NULL, NULL, 3, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (14, 'abcd', 'returned', '2025-04-25 00:00:00', '2025-04-26 00:00:00', '2025-05-15 00:00:00', '2025-05-13 00:00:00', 1, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (5, 'Mượn thiết bị đo khí CO2', 'returned', '2025-04-21 10:00:00', '2025-04-25 10:00:00', '2025-05-14 00:00:00', '2025-05-15 00:00:00', 1, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (13, 'aaa', 'returned', '2025-04-24 00:00:00', '2025-04-26 00:00:00', '2025-05-15 00:00:00', '2025-05-13 00:00:00', 1, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (12, 'aaa', 'returned', '2025-04-24 00:00:00', '2025-04-25 00:00:00', '2025-05-13 00:00:00', '2025-05-13 00:00:00', 1, 4);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (22, 'test', 'pending', '2025-05-14 00:00:00', '2025-05-23 00:00:00', NULL, NULL, 3, 2);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (23, 'aaaaa', 'pending', '2025-05-21 00:00:00', '2025-05-24 00:00:00', NULL, NULL, 3, 3);
INSERT INTO public.borrow_request OVERRIDING SYSTEM VALUE VALUES (24, 'aaaaaa', 'pending', '2025-05-13 00:00:00', '2025-05-16 00:00:00', NULL, NULL, 3, 2);


--
-- TOC entry 4911 (class 0 OID 24597)
-- Dependencies: 222
-- Data for Name: device; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.device VALUES (3, 'STM32 Microcontroller', 'The STM32 is a family of 32-bit microcontrollers from STMicroelectronics, based on the ARM Cortex-M processor. Known for their high performance, low power consumption, and scalability, STM32 microcontrollers are ideal for a wide range of applications, including industrial automation, consumer electronics, and IoT. They provide rich peripheral interfaces and robust development support.', 'SKU:STM32F401', 'STMicroelectronics', 'Clock Speed: Up to 84 MHz', 1, 'https://res.cloudinary.com/rsc/image/upload/w_1024/F9107951-01', true, true, 1);
INSERT INTO public.device VALUES (4, 'NodeMCU-BU01', 'Node MCU is an open-source development platform based on the ESP8266, a popular Wi-Fi module known for its ability to connect to the Internet and enable remote control. It provides a simple and efficient programming environment using Lua scripts or Arduino IDE. Node MCU facilitates easy integration with IoT devices and automation applications.', 'SKU:ESP8266', 'Espressif Systems', 'Processor: Tensilica L106 32-bit RISC microprocessor', 1, 'https://exp-tech.de/cdn/shop/products/NodeMCU-BU01_1.png?vu003d1689269984', true, true, 1);
INSERT INTO public.device VALUES (2, 'UWB Tag 11', 'UWB is a Unit which integrates the UWB(Ultra Wide Band) communication protocol which uses nanosecond pulses to locate objects and define position and orientation. The design uses the Ai-ThinkerBU01 Transceiver module which is based on Decawave''s DW1000 design. The internal STM32 chip with its integrated ranging algorithm,is capable of 10cm positioning accuracy and also supports AT command control. Applications include: Indoor wireless tracking/range finding of assets,which works by triangulating the position of the base station/s and tag (the base station resolves the position information and outputs it to the tag).', 'SKU:U100', 'M5Stack', 'Data transfer rate: 10 kbit/s, 850 kbit/s and 6.8 Mbit/s', 1, 'https://static-cdn.m5stack.com/resource/docs/products/unit/uwb/uwb_02.webp', true, true, 1);


--
-- TOC entry 4915 (class 0 OID 24647)
-- Dependencies: 226
-- Data for Name: device_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (104, 2, 3.255001, 1.876648, 0, '2025-05-11 17:02:31.234', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (105, 2, 3.255, 1.803848, 0, '2025-05-11 17:02:38.653', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (106, 2, 3.255, 1.803848, 0, '2025-05-11 17:02:44.702', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (107, 2, 3.255, 1.803848, 0, '2025-05-11 17:02:49.665', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (108, 2, 3.255, 1.803848, 0, '2025-05-11 17:02:49.665', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (109, 4, 3.255001, 3.214534, 0, '2025-05-11 17:11:38.586', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (110, 4, 3.255001, 3.214534, 0, '2025-05-11 17:11:38.93', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (111, 4, 3.255001, 1.749742, 0, '2025-05-11 17:11:44.981', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (112, 4, 3.255, 1.687703, 0, '2025-05-11 17:11:50.963', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (113, 4, 3.255001, 1.666749, 0, '2025-05-11 17:11:56.899', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (114, 4, 3.255, 1.803848, 0, '2025-05-11 17:12:02.497', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (115, 4, 3.255, 1.803848, 0, '2025-05-11 17:12:02.799', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (116, 4, 3.255, 1.915581, 0, '2025-05-11 17:12:05.821', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (117, 4, 3.255, 1.915581, 0, '2025-05-11 17:12:05.821', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (118, 4, 3.255, 2.137627, 0, '2025-05-11 17:12:44.927', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (119, 4, 3.255001, 1.966634, 0, '2025-05-11 17:12:50.558', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (120, 4, 3.255001, 1.966634, 0, '2025-05-11 17:12:50.865', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (55, 4, 1, 4.5, 0, '2024-12-19 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (56, 4, 1, 3.5, 0, '2024-12-20 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (57, 4, 1.5, 3, 0, '2024-12-21 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (58, 4, 2, 2.5, 0, '2024-12-22 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (59, 4, 2.3, 3.2, 0, '2024-12-23 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (60, 4, 2.7, 3.2, 0, '2024-12-24 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (61, 4, 3, 3, 0, '2024-12-25 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (62, 4, 3.5, 2, 0, '2024-12-26 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (63, 4, 2, 1, 0, '2024-12-27 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (64, 4, 0.5, 0.5, 0, '2024-12-28 09:00:00', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (65, 4, 0.5, 0.5, 0, '2024-12-28 09:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (66, 4, 0.5, 1, 0, '2024-12-28 10:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (67, 4, 0.6, 2, 0, '2024-12-28 11:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (68, 4, 1, 2.5, 0, '2024-12-28 12:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (69, 4, 1.5, 2.5, 0, '2024-12-28 13:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (70, 4, 1.7, 2.8, 0, '2024-12-28 14:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (71, 4, 1.7, 3.5, 0, '2024-12-28 15:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (72, 4, 2.5, 3.5, 0, '2024-12-28 16:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (73, 4, 2.9, 3.7, 0, '2024-12-28 17:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (74, 4, 3.5, 4, 0, '2024-12-28 18:00:00', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (89, 2, 3.255, 1.830535, 0, '2025-05-11 17:01:20.573', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (90, 2, 3.255, 1.830535, 0, '2025-05-11 17:01:26.624', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (91, 2, 3.255, 1.830535, 0, '2025-05-11 17:01:32.647', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (92, 2, 3.255, 1.830535, 0, '2025-05-11 17:01:38.486', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (93, 2, 3.255, 1.830535, 0, '2025-05-11 17:01:38.691', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (94, 2, 3.255001, 1.823886, 0, '2025-05-11 17:01:44.692', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (95, 2, 3.255001, 1.783671, 0, '2025-05-11 17:01:50.685', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (96, 2, 3.255, 1.790413, 0, '2025-05-11 17:01:56.617', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (97, 2, 3.255, 1.797138, 0, '2025-05-11 17:02:02.504', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (98, 2, 3.255, 1.797138, 0, '2025-05-11 17:02:02.504', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (121, 4, 3.255, 1.93484, 0, '2025-05-11 17:12:56.966', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (122, 4, 3.255, 1.790413, 0, '2025-05-11 17:13:02.803', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (123, 4, 3.255, 1.742908, 0, '2025-05-11 17:13:09.046', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (124, 4, 3.255, 2.089993, 0, '2025-05-11 17:13:14.785', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (125, 4, 3.255, 2.089993, 0, '2025-05-11 17:13:15.098', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (126, 4, 3.255001, 1.922015, 0, '2025-05-11 17:13:21.078', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (127, 4, 3.255, 1.843786, 0, '2025-05-11 17:13:26.914', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (128, 4, 3.255, 1.687703, 0, '2025-05-11 17:13:32.851', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (129, 4, 3.255, 1.659733, 0, '2025-05-11 17:13:38.584', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (130, 4, 3.255, 1.659733, 0, '2025-05-11 17:13:38.895', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (131, 4, 3.254999, 1.680733, 0, '2025-05-11 17:13:44.841', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (132, 4, 3.255001, 1.776917, 0, '2025-05-11 17:13:51.145', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (133, 4, 3.255001, 1.837169, 0, '2025-05-11 17:13:56.979', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (134, 4, 3.255001, 1.234626, 0, '2025-05-11 17:14:02.651', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (135, 4, 3.255001, 1.234626, 0, '2025-05-11 17:14:02.961', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (136, 4, 3.255, 1.404581, 0, '2025-05-11 17:14:09.156', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (137, 4, 3.255001, 1.486786, 0, '2025-05-11 17:14:14.993', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (138, 4, 3.255, 1.154932, 0, '2025-05-11 17:14:20.983', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (139, 4, 3.255001, 0.96584, 0, '2025-05-11 17:14:26.817', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (140, 4, 3.255001, 0.96584, 0, '2025-05-11 17:14:27.125', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (141, 4, 3.255, 0.923664, 0, '2025-05-11 17:14:33.169', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (142, 4, 3.255001, 0.974229, 0, '2025-05-11 17:14:38.592', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (143, 4, 3.255, 1.007634, 0, '2025-05-11 17:14:45.096', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (144, 4, 3.255001, 0.940579, 0, '2025-05-11 17:14:50.82', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (145, 4, 3.255001, 0.940579, 0, '2025-05-11 17:14:51.131', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (146, 4, 3.255001, 0.990962, 0, '2025-05-11 17:14:57.23', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (147, 4, 3.255, 1.007634, 0, '2025-05-11 17:15:03.074', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (148, 4, 3.255001, 1.297282, 0, '2025-05-11 17:15:09.013', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (149, 4, 3.255001, 1.58874, 0, '2025-05-11 17:15:14.644', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (150, 4, 3.255001, 1.58874, 0, '2025-05-11 17:15:15.254', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (151, 4, 3.255, 1.624429, 0, '2025-05-11 17:15:21.09', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (152, 4, 3.255001, 1.58874, 0, '2025-05-11 17:15:27.088', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (153, 4, 3.255, 1.603061, 0, '2025-05-11 17:15:32.517', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (154, 4, 3.255, 1.559917, 0, '2025-05-11 17:15:38.701', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (155, 4, 3.255001, 1.631519, 0, '2025-05-11 17:15:39.008', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (156, 4, 3.255, 1.617322, 0, '2025-05-11 17:15:45.256', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (157, 4, 3.255001, 0.906686, 0, '2025-05-11 17:15:50.792', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (158, 4, 3.255001, 0.906686, 0, '2025-05-11 17:15:50.792', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (160, 4, 3.255, 1.736062, 0, '2025-05-11 17:18:39.449', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (161, 4, 3.255001, 1.729198, 0, '2025-05-11 17:18:45.442', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (162, 4, 3.255, 1.736062, 0, '2025-05-11 17:18:50.602', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (163, 4, 3.255, 1.742908, 0, '2025-05-11 17:18:51.427', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (164, 4, 3.255, 1.742908, 0, '2025-05-11 17:18:57.363', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (165, 4, 3.255, 1.736062, 0, '2025-05-11 17:19:03.307', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (166, 4, 3.255, 1.742908, 0, '2025-05-11 17:19:09.395', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (167, 4, 3.255, 1.742908, 0, '2025-05-11 17:19:14.79', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (168, 4, 3.255, 1.742908, 0, '2025-05-11 17:19:15.282', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (169, 4, 3.255, 1.742908, 0, '2025-05-11 17:19:21.39', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (170, 4, 3.255, 1.742908, 0, '2025-05-11 17:19:27.418', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (171, 4, 3.255001, 1.722321, 0, '2025-05-11 17:19:31.571', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (172, 4, 3.255001, 1.722321, 0, '2025-05-11 17:19:31.571', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (173, 4, 3.255001, 1.343634, 0, '2025-05-11 17:20:02.797', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (174, 4, 3.255001, 1.343634, 0, '2025-05-11 17:20:03.464', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (175, 4, 3.255001, 1.098237, 0, '2025-05-11 17:20:09.452', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (176, 4, 3.255, 1.397016, 0, '2025-05-11 17:20:15.243', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (177, 4, 3.255, 1.559917, 0, '2025-05-11 17:20:21.397', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (178, 4, 3.255001, 1.610199, 0, '2025-05-11 17:20:26.71', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (179, 4, 3.255, 1.645658, 0, '2025-05-11 17:20:27.533', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (180, 4, 3.255, 1.883177, 0, '2025-05-11 17:20:33.38', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (181, 4, 3.255001, 1.922015, 0, '2025-05-11 17:20:39.51', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (182, 4, 3.255, 1.810542, 0, '2025-05-11 17:20:45.5', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (183, 4, 3.255, 1.638597, 0, '2025-05-11 17:20:50.787', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (184, 4, 3.255, 1.638597, 0, '2025-05-11 17:20:51.554', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (185, 4, 3.255001, 1.856977, 0, '2025-05-11 17:20:57.566', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (186, 4, 3.255, 1.790413, 0, '2025-05-11 17:21:03.382', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (187, 4, 3.255, 1.419665, 0, '2025-05-11 17:21:09.573', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (188, 4, 3.255001, 1.015947, 0, '2025-05-11 17:21:14.788', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (189, 4, 3.255, 1.007634, 0, '2025-05-11 17:21:15.568', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (190, 4, 3.255001, 1.049045, 0, '2025-05-11 17:21:21.341', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (191, 4, 3.255001, 1.16297, 0, '2025-05-11 17:21:27.649', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (192, 4, 3.255, 1.494169, 0, '2025-05-11 17:21:33.545', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (193, 4, 3.255, 1.538138, 0, '2025-05-11 17:21:38.338', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (194, 4, 3.255001, 1.574359, 0, '2025-05-11 17:21:39.572', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (195, 4, 3.255001, 1.666749, 0, '2025-05-11 17:21:45.559', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (196, 4, 3.255001, 1.508885, 0, '2025-05-11 17:21:51.707', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (197, 4, 3.255, 1.538138, 0, '2025-05-11 17:21:57.528', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (198, 4, 3.255, 1.545413, 0, '2025-05-11 17:22:02.762', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (199, 4, 3.255, 1.545413, 0, '2025-05-11 17:22:03.591', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (200, 4, 3.255, 1.516222, 0, '2025-05-11 17:22:09.399', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (201, 4, 3.255, 1.552672, 0, '2025-05-11 17:22:15.383', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (202, 4, 3.255001, 1.574359, 0, '2025-05-11 17:22:21.34', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (203, 4, 3.255, 1.790413, 0, '2025-05-11 17:22:26.716', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (204, 4, 3.255, 1.843786, 0, '2025-05-11 17:22:27.729', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (205, 4, 3.255, 1.93484, 0, '2025-05-11 17:22:33.679', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (206, 4, 3.255, 1.830535, 0, '2025-05-11 17:22:39.523', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (207, 4, 3.255001, 1.722321, 0, '2025-05-11 17:22:45.765', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (208, 4, 3.255, 1.617322, 0, '2025-05-11 17:22:50.6', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (209, 4, 3.255, 1.617322, 0, '2025-05-11 17:22:51.4', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (210, 4, 3.255, 1.659733, 0, '2025-05-11 17:22:56.344', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (211, 4, 3.255001, 1.610199, 0, '2025-05-11 17:23:03.581', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (212, 4, 3.255, 1.538138, 0, '2025-05-11 17:23:09.635', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (213, 4, 3.255, 1.44965, 0, '2025-05-11 17:23:14.804', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (214, 4, 3.255001, 1.486786, 0, '2025-05-11 17:23:15.642', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (215, 4, 3.255001, 1.574359, 0, '2025-05-11 17:23:21.426', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (216, 4, 3.255, 1.638597, 0, '2025-05-11 17:23:27.657', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (217, 4, 3.255, 1.673749, 0, '2025-05-11 17:23:31.341', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (218, 4, 3.255, 1.603061, 0, '2025-05-11 17:23:38.662', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (219, 4, 3.255, 1.545413, 0, '2025-05-11 17:23:39.733', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (220, 4, 3.255, 1.645658, 0, '2025-05-11 17:23:45.704', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (221, 4, 3.255001, 1.58874, 0, '2025-05-11 17:23:51.764', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (222, 4, 3.255001, 1.694656, 0, '2025-05-11 17:23:57.56', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (223, 4, 3.255, 1.652702, 0, '2025-05-11 17:24:02.929', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (224, 4, 3.255, 1.652702, 0, '2025-05-11 17:24:03.769', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (225, 4, 3.255001, 1.574359, 0, '2025-05-11 17:24:09.752', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (226, 4, 3.255, 1.652702, 0, '2025-05-11 17:24:15.741', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (227, 4, 3.255001, 1.694656, 0, '2025-05-11 17:24:21.537', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (228, 4, 3.255, 1.659733, 0, '2025-05-11 17:24:26.854', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (229, 4, 3.255001, 1.666749, 0, '2025-05-11 17:24:27.714', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (230, 4, 3.255001, 1.722321, 0, '2025-05-11 17:24:33.68', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (231, 4, 3.255, 1.701595, 0, '2025-05-11 17:24:39.908', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (232, 4, 3.255001, 1.722321, 0, '2025-05-11 17:24:45.906', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (233, 4, 3.255001, 1.722321, 0, '2025-05-11 17:24:50.898', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (234, 4, 3.255001, 1.722321, 0, '2025-05-11 17:24:51.758', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (235, 4, 3.255001, 1.722321, 0, '2025-05-11 17:24:57.775', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (236, 4, 3.255001, 1.722321, 0, '2025-05-11 17:25:03.769', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (237, 4, 3.255001, 1.722321, 0, '2025-05-11 17:25:09.75', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (238, 4, 3.738878, 1.729199, 0, '2025-05-11 17:25:14.79', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (239, 4, 4.250393, 1.736061, 0, '2025-05-11 17:25:15.652', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (240, 4, 5.603764, 1.742908, 0, '2025-05-11 17:25:21.927', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (241, 4, 5.536297, 1.722322, 0, '2025-05-11 17:25:27.808', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (242, 4, 5.511251, 1.722322, 0, '2025-05-11 17:25:33.696', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (243, 4, 5.511251, 1.680735, 0, '2025-05-11 17:25:38.754', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (244, 4, 5.519586, 1.673748, 0, '2025-05-11 17:25:39.585', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (245, 4, 5.544678, 1.457107, 0, '2025-05-11 17:25:45.91', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (246, 4, 5.561483, 1.638596, 0, '2025-05-11 17:25:51.786', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (247, 4, 5.561481, 1.687704, 0, '2025-05-11 17:25:57.875', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (248, 4, 5.578349, 1.722321, 0, '2025-05-11 17:26:02.71', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (249, 4, 5.629316, 1.70852, 0, '2025-05-11 17:26:03.958', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (250, 4, 5.646427, 1.736063, 0, '2025-05-11 17:26:09.868', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (251, 4, 5.595276, 1.76336, 0, '2025-05-11 17:26:15.717', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (252, 4, 5.612266, 1.763359, 0, '2025-05-11 17:26:22', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (253, 4, 5.612265, 1.756558, 0, '2025-05-11 17:26:26.574', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (254, 4, 5.612265, 1.756558, 0, '2025-05-11 17:26:27.853', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (256, 2, 3.409869, 3.218543, 0, '2025-05-11 17:26:39.986', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (258, 2, 4.622772, 2.766879, 0, '2025-05-11 17:26:43.198', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (260, 2, 4.622772, 2.766879, 0, '2025-05-11 17:26:43.198', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (263, 4, 5.732911, 1.736062, 0, '2025-05-11 17:27:09.985', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (264, 4, 5.794363, 1.742908, 0, '2025-05-11 17:27:15.021', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (265, 4, 5.794363, 1.742908, 0, '2025-05-11 17:27:16.087', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (266, 4, 5.919524, 1.763358, 0, '2025-05-11 17:27:21.744', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (267, 4, 5.715491, 1.776917, 0, '2025-05-11 17:27:27.822', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (268, 4, 5.578349, 1.770145, 0, '2025-05-11 17:27:33.932', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (269, 4, 5.586804, 1.749743, 0, '2025-05-11 17:27:38.781', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (270, 4, 5.462152, 1.844687, 0, '2025-05-11 17:27:40.032', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (271, 4, 2.633365, 4.673023, 0, '2025-05-11 17:27:45.867', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (272, 4, 2.658871, 4.686733, 0, '2025-05-11 17:27:51.946', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (273, 4, 2.677919, 4.626489, 0, '2025-05-11 17:27:57.849', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (274, 4, 2.724363, 4.53287, 0, '2025-05-11 17:28:02.702', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (275, 4, 2.732911, 4.532871, 0, '2025-05-11 17:28:03.959', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (277, 2, 3.259393, 3.371145, 0, '2025-05-11 17:28:16.036', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (279, 2, 3.246298, 4.78865, 0, '2025-05-11 17:28:20.985', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (281, 2, 3.255, 5.636986, 0, '2025-05-11 17:28:26.948', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (283, 2, 3.255, 5.636986, 0, '2025-05-11 17:28:27.986', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (285, 2, 3.255, 5.658634, 0, '2025-05-11 17:28:31.575', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (287, 2, 3.309799, 5.689474, 0, '2025-05-11 17:28:40.1', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (288, 4, 2.72527, 4.565535, 0, '2025-05-11 17:28:36.829', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (289, 2, 3.320622, 5.674427, 0, '2025-05-11 17:28:42.393', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (290, 4, 2.751775, 4.625023, 0, '2025-05-11 17:28:46.215', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (291, 2, 3.71381, 5.656977, 0, '2025-05-11 17:28:50.998', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (292, 4, 2.768918, 4.611374, 0, '2025-05-11 17:28:47.891', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (293, 2, 3.736851, 5.66361, 0, '2025-05-11 17:28:52.164', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (294, 4, 2.768918, 4.611374, 0, '2025-05-11 17:28:47.891', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (295, 2, 3.841297, 5.663611, 0, '2025-05-11 17:28:53.588', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (296, 4, 2.712143, 4.633412, 0, '2025-05-11 17:28:58.181', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (297, 2, 3.64613, 5.678627, 0, '2025-05-11 17:29:04.171', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (298, 4, 2.712143, 4.633412, 0, '2025-05-11 17:28:58.826', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (299, 2, 3.544155, 5.682825, 0, '2025-05-11 17:29:10.179', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (300, 4, 2.666406, 4.513229, 0, '2025-05-11 17:29:09.689', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (301, 2, 3.331936, 5.693686, 0, '2025-05-11 17:29:14.972', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (302, 4, 2.666406, 4.513229, 0, '2025-05-11 17:29:09.689', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (303, 2, 3.331936, 5.693686, 0, '2025-05-11 17:29:15.253', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (304, 4, 2.682581, 4.522733, 0, '2025-05-11 17:29:15.946', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (305, 2, 3.37573, 5.661145, 0, '2025-05-11 17:29:22.037', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (306, 4, 3.128765, 4.51729, 0, '2025-05-11 17:29:20.343', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (307, 2, 3.298749, 5.678625, 0, '2025-05-11 17:29:25.845', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (308, 4, 3.336084, 4.50126, 0, '2025-05-11 17:29:28.096', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (309, 2, 3.353779, 5.678628, 0, '2025-05-11 17:29:34.244', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (310, 4, 2.77494, 4.764343, 0, '2025-05-11 17:29:31.233', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (311, 2, 3.498656, 5.665312, 0, '2025-05-11 17:29:36.615', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (312, 4, 2.251314, 4.889481, 0, '2025-05-11 17:29:38.963', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (313, 2, 3.498656, 5.665312, 0, '2025-05-11 17:29:36.615', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (314, 4, 2.251314, 4.889481, 0, '2025-05-11 17:29:40.007', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (315, 2, 3.39788, 5.661145, 0, '2025-05-11 17:29:46.217', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (316, 4, 2.366206, 4.771672, 0, '2025-05-11 17:29:41.886', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (317, 2, 3.320622, 5.667795, 0, '2025-05-11 17:29:47.488', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (318, 4, 2.298072, 4.852444, 0, '2025-05-11 17:29:51.899', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (319, 2, 3.331506, 5.676832, 0, '2025-05-11 17:29:58.201', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (320, 4, 2.256291, 4.902328, 0, '2025-05-11 17:29:53.141', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (321, 2, 3.331506, 5.676832, 0, '2025-05-11 17:29:58.609', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (322, 4, 2.173402, 4.978826, 0, '2025-05-11 17:30:02.768', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (323, 2, 3.331506, 5.676832, 0, '2025-05-11 17:29:58.609', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (324, 4, 2.306483, 4.831031, 0, '2025-05-11 17:30:03.817', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (325, 2, 3.211682, 5.639528, 0, '2025-05-11 17:30:09.474', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (326, 4, 2.407143, 4.672131, 0, '2025-05-11 17:30:10.271', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (327, 2, 3.190115, 5.626184, 0, '2025-05-11 17:30:16.228', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (328, 4, 2.27967, 4.790481, 0, '2025-05-11 17:30:15.095', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (329, 2, 3.211805, 5.591221, 0, '2025-05-11 17:30:20.525', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (330, 4, 2.202558, 4.864985, 0, '2025-05-11 17:30:22.162', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (331, 2, 3.200969, 5.608703, 0, '2025-05-11 17:30:27.082', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (332, 4, 1.923718, 5.20416, 0, '2025-05-11 17:30:25.956', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (333, 2, 3.136806, 5.604626, 0, '2025-05-11 17:30:28.299', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (334, 4, 1.923718, 5.20416, 0, '2025-05-11 17:30:25.956', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (335, 2, 3.018779, 5.658635, 0, '2025-05-11 17:30:31.59', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (336, 4, 1.848825, 5.219848, 0, '2025-05-11 17:30:34.087', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (337, 2, 3.060899, 5.662786, 0, '2025-05-11 17:30:40.195', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (338, 4, 1.762096, 5.017229, 0, '2025-05-11 17:30:37.004', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (339, 2, 3.125414, 5.634397, 0, '2025-05-11 17:30:42.497', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (340, 4, 1.702188, 4.932893, 0, '2025-05-11 17:30:45.976', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (341, 2, 3.167872, 5.691222, 0, '2025-05-11 17:30:50.982', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (342, 4, 1.771683, 4.99797, 0, '2025-05-11 17:30:47.653', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (343, 2, 3.134608, 5.765831, 0, '2025-05-11 17:30:52.218', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (344, 4, 1.771683, 4.99797, 0, '2025-05-11 17:30:47.653', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (345, 2, 3.2993, 5.776804, 0, '2025-05-11 17:30:53.225', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (346, 4, 2.354785, 4.798551, 0, '2025-05-11 17:30:58.305', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (347, 2, 3.401275, 5.847367, 0, '2025-05-11 17:31:04.189', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (348, 4, 2.508058, 4.649923, 0, '2025-05-11 17:30:58.738', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (349, 2, 3.378603, 5.834023, 0, '2025-05-11 17:31:10.229', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (350, 4, 2.689356, 4.286045, 0, '2025-05-11 17:31:09.184', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (351, 2, 3.377083, 5.754877, 0, '2025-05-11 17:31:14.815', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (352, 4, 2.689356, 4.286045, 0, '2025-05-11 17:31:09.184', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (353, 2, 3.377083, 5.754877, 0, '2025-05-11 17:31:14.815', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (354, 4, 2.697857, 4.286046, 0, '2025-05-11 17:31:16.234', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (355, 2, 3.309493, 5.66603, 0, '2025-05-11 17:31:22.171', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (356, 4, 2.688387, 4.363131, 0, '2025-05-11 17:31:20.21', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (357, 2, 3.287834, 5.742115, 0, '2025-05-11 17:31:25.672', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (358, 4, 2.652412, 4.24542, 0, '2025-05-11 17:31:28.363', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (359, 2, 3.342865, 5.742116, 0, '2025-05-11 17:31:34.264', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (360, 4, 2.418379, 4.489046, 0, '2025-05-11 17:31:31.063', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (361, 2, 3.331077, 5.640305, 0, '2025-05-11 17:31:37.087', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (362, 4, 2.204309, 4.876589, 0, '2025-05-11 17:31:38.927', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (363, 2, 3.331077, 5.640305, 0, '2025-05-11 17:31:37.087', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (364, 4, 2.126828, 5.022237, 0, '2025-05-11 17:31:40.217', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (365, 2, 3.374716, 5.622978, 0, '2025-05-11 17:31:46.311', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (366, 4, 2.172166, 5.016008, 0, '2025-05-11 17:31:42.288', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (367, 2, 3.331075, 5.620496, 0, '2025-05-11 17:31:47.796', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (368, 4, 2.133288, 5.032366, 0, '2025-05-11 17:31:52.279', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (369, 2, 3.2002, 5.730626, 0, '2025-05-11 17:31:58.385', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (370, 4, 2.118526, 5.001146, 0, '2025-05-11 17:31:53.317', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (371, 2, 3.189193, 5.734886, 0, '2025-05-11 17:31:58.844', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (372, 4, 2.226544, 4.811184, 0, '2025-05-11 17:32:02.925', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (373, 2, 3.189193, 5.734886, 0, '2025-05-11 17:31:58.844', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (374, 4, 2.226544, 4.811184, 0, '2025-05-11 17:32:04.159', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (375, 2, 3.344831, 5.930757, 0, '2025-05-11 17:32:09.69', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (376, 4, 2.226544, 4.804016, 0, '2025-05-11 17:32:10.218', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (377, 2, 3.425853, 6.047481, 0, '2025-05-11 17:32:16.289', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (378, 4, 2.304194, 4.720649, 0, '2025-05-11 17:32:15.035', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (379, 2, 3.667634, 6.285687, 0, '2025-05-11 17:32:20.54', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (380, 4, 2.351774, 4.674353, 0, '2025-05-11 17:32:22.142', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (381, 2, 3.644054, 6.309634, 0, '2025-05-11 17:32:27.093', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (382, 4, 2.446344, 4.705076, 0, '2025-05-11 17:32:25.693', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (383, 2, 3.644054, 6.309634, 0, '2025-05-11 17:32:28.32', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (384, 4, 2.446344, 4.705076, 0, '2025-05-11 17:32:25.693', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (385, 2, 3.668171, 6.315856, 0, '2025-05-11 17:32:31.194', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (386, 4, 2.40143, 4.818625, 0, '2025-05-11 17:32:34.267', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (387, 2, 3.681359, 6.32636, 0, '2025-05-11 17:32:40.407', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (388, 4, 2.50176, 4.804656, 0, '2025-05-11 17:32:36.55', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (389, 2, 3.477541, 6.332596, 0, '2025-05-11 17:32:42.25', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (390, 4, 2.574702, 4.739763, 0, '2025-05-11 17:32:46.149', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (391, 2, 3.442281, 6.350321, 0, '2025-05-11 17:32:51.128', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (392, 4, 2.612074, 4.711069, 0, '2025-05-11 17:32:47.612', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (393, 2, 3.430461, 6.35032, 0, '2025-05-11 17:32:52.284', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (394, 4, 2.612074, 4.711069, 0, '2025-05-11 17:32:47.612', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (395, 2, 3.465969, 6.35032, 0, '2025-05-11 17:32:53.106', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (396, 4, 2.511567, 4.822635, 0, '2025-05-11 17:32:58.269', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (397, 2, 3.50129, 6.338817, 0, '2025-05-11 17:33:03.751', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (398, 4, 2.479518, 4.87842, 0, '2025-05-11 17:33:04.302', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (399, 2, 3.406666, 6.345023, 0, '2025-05-11 17:33:10.452', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (400, 4, 2.885108, 4.803702, 0, '2025-05-11 17:33:08.883', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (401, 2, 3.277887, 6.248367, 0, '2025-05-11 17:33:14.409', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (402, 4, 3.061292, 4.758907, 0, '2025-05-11 17:33:15.012', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (403, 2, 3.277887, 6.248367, 0, '2025-05-11 17:33:14.409', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (404, 4, 3.227419, 4.695695, 0, '2025-05-11 17:33:16.444', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (405, 2, 3.392881, 6.219489, 0, '2025-05-11 17:33:22.386', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (406, 4, 3.136883, 4.573588, 0, '2025-05-11 17:33:19.727', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (407, 2, 3.208426, 6.425871, 0, '2025-05-11 17:33:25.459', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (408, 4, 3.046376, 4.576984, 0, '2025-05-11 17:33:28.326', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (409, 2, 3.373125, 6.466199, 0, '2025-05-11 17:33:34.409', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (410, 4, 3.055953, 4.611641, 0, '2025-05-11 17:33:30.569', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (411, 2, 3.645069, 6.338817, 0, '2025-05-11 17:33:36.418', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (412, 4, 3.117328, 4.709664, 0, '2025-05-11 17:33:38.876', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (413, 2, 3.645069, 6.338817, 0, '2025-05-11 17:33:36.418', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (414, 4, 3.163602, 4.644276, 0, '2025-05-11 17:33:40.125', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (415, 2, 3.467627, 6.413444, 0, '2025-05-11 17:33:46.455', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (416, 4, 3.209569, 4.570054, 0, '2025-05-11 17:33:41.796', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (417, 2, 3.408864, 6.453739, 0, '2025-05-11 17:33:47.273', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (418, 4, 0.671282, 4.424916, 0, '2025-05-11 17:33:52.458', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (419, 2, 3.290876, 6.606664, 0, '2025-05-11 17:33:58.13', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (420, 4, 0.671282, 4.424916, 0, '2025-05-11 17:33:58.488', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (421, 2, 3.290876, 6.606664, 0, '2025-05-11 17:33:58.13', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (422, 4, 0.671282, 4.424916, 0, '2025-05-11 17:34:03.078', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (423, 2, 3.483671, 6.571145, 0, '2025-05-11 17:34:04.525', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (424, 4, 0.671282, 4.424916, 0, '2025-05-11 17:34:03.631', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (425, 2, 3.590915, 6.507464, 0, '2025-05-11 17:34:09.192', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (426, 4, 0.671282, 4.424916, 0, '2025-05-11 17:34:10.49', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (427, 2, 2.91076, 6.467634, 0, '2025-05-11 17:34:24.177', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (428, 4, 0.535914, 4.424801, 0, '2025-05-11 17:34:24.335', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (429, 2, 5.782495, 6.566795, 0, '2025-05-11 17:34:30.329', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (430, 4, 0.406452, 4.469748, 0, '2025-05-11 17:34:30.085', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (431, 2, 5.65371, 6.495037, 0, '2025-05-11 17:34:35.199', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (432, 4, 0.453034, 4.458604, 0, '2025-05-11 17:34:36.059', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (433, 2, 2.921121, 6.459977, 0, '2025-05-11 17:34:42.278', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (434, 4, 0.443748, 4.474817, 0, '2025-05-11 17:34:42.305', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (435, 2, 2.921121, 6.459977, 0, '2025-05-11 17:34:42.278', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (436, 4, 0.443748, 4.474817, 0, '2025-05-11 17:34:42.305', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (437, 2, 2.771168, 6.3441, 0, '2025-05-11 17:34:47.33', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (438, 4, 0.453034, 4.458604, 0, '2025-05-11 17:34:48.319', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (439, 2, 2.643664, 6.466198, 0, '2025-05-11 17:34:54.24', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (440, 4, 0.453035, 6.059854, 0, '2025-05-11 17:34:54.165', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (441, 2, 3.124809, 6.607267, 0, '2025-05-11 17:35:00.34', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (442, 4, 0.453034, 4.465587, 0, '2025-05-11 17:35:00.203', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (443, 2, 3.433227, 6.489556, 0, '2025-05-11 17:35:06.294', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (444, 4, 0.644485, 4.275305, 0, '2025-05-11 17:35:06.221', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (445, 2, 3.433227, 6.489556, 0, '2025-05-11 17:35:06.294', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (446, 4, 0.644485, 4.275305, 0, '2025-05-11 17:35:06.221', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (447, 2, 3.456467, 6.454543, 0, '2025-05-11 17:35:12.27', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (448, 4, 0.644485, 4.275305, 0, '2025-05-11 17:35:12.274', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (449, 2, 3.572904, 6.345022, 0, '2025-05-11 17:35:18.201', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (450, 4, 3.340369, 4.672313, 0, '2025-05-11 17:35:18.194', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (451, 2, 3.834192, 6.253544, 0, '2025-05-11 17:35:24.308', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (452, 4, 3.340369, 4.672313, 0, '2025-05-11 17:35:24.338', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (453, 2, 3.89288, 6.225679, 0, '2025-05-11 17:35:29.41', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (454, 4, 3.111989, 5.34339, 0, '2025-05-11 17:35:29.97', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (455, 2, 3.89288, 6.225679, 0, '2025-05-11 17:35:29.41', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (456, 4, 3.111989, 5.34339, 0, '2025-05-11 17:35:29.97', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (457, 2, 4.246284, 6.17032, 0, '2025-05-11 17:35:36.358', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (458, 4, 3.212973, 5.533566, 0, '2025-05-11 17:35:35.984', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (459, 2, 4.28013, 6.136679, 0, '2025-05-11 17:35:41.347', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (460, 4, 3.203272, 5.416801, 0, '2025-05-11 17:35:42.106', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (461, 2, 4.204924, 6.136679, 0, '2025-05-11 17:35:48.294', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (462, 4, 3.152235, 5.376886, 0, '2025-05-11 17:35:48.197', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (463, 2, 4.171075, 6.170321, 0, '2025-05-11 17:35:53.552', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (464, 4, 3.274632, 4.970757, 0, '2025-05-11 17:35:54.054', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (465, 2, 4.171075, 6.170321, 0, '2025-05-11 17:35:54.387', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (466, 4, 3.274632, 4.970757, 0, '2025-05-11 17:35:54.054', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (467, 2, 3.990238, 6.220533, 0, '2025-05-11 17:36:00.279', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (468, 4, 3.29371, 4.874115, 0, '2025-05-11 17:36:00.32', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (469, 2, 3.727503, 6.305351, 0, '2025-05-11 17:36:05.218', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (470, 4, 3.29371, 4.874115, 0, '2025-05-11 17:36:06.072', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (471, 2, 3.407865, 6.420465, 0, '2025-05-11 17:36:12.369', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (472, 4, 3.35917, 4.713328, 0, '2025-05-11 17:36:12.27', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (473, 2, 2.817797, 6.519182, 0, '2025-05-11 17:36:18.306', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (474, 4, 3.311222, 4.299375, 0, '2025-05-11 17:36:18.247', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (475, 2, 2.817797, 6.519182, 0, '2025-05-11 17:36:18.306', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (476, 4, 3.311222, 4.299375, 0, '2025-05-11 17:36:18.247', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (477, 2, 2.508825, 6.530915, 0, '2025-05-11 17:36:23.272', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (478, 4, 3.209416, 4.227793, 0, '2025-05-11 17:36:24.24', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (479, 2, 2.510854, 6.501259, 0, '2025-05-11 17:36:30.398', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (480, 4, 3.27331, 4.355184, 0, '2025-05-11 17:36:30.437', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (481, 2, 2.770368, 6.774628, 0, '2025-05-11 17:36:36.28', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (482, 4, 3.245761, 4.5298, 0, '2025-05-11 17:36:36.429', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (483, 2, 2.919087, 6.835121, 0, '2025-05-11 17:36:41.245', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (484, 4, 3.282765, 4.500168, 0, '2025-05-11 17:36:42.026', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (485, 2, 2.919087, 6.835121, 0, '2025-05-11 17:36:41.245', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (486, 4, 3.282765, 4.500168, 0, '2025-05-11 17:36:42.434', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (487, 2, 3.11122, 6.726504, 0, '2025-05-11 17:36:48.442', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (488, 4, 3.356805, 4.497596, 0, '2025-05-11 17:36:46.762', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (489, 2, 3.231405, 6.530917, 0, '2025-05-11 17:36:54.41', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (490, 4, 3.378909, 4.721621, 0, '2025-05-11 17:36:54.427', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (491, 2, 3.231405, 6.530917, 0, '2025-05-11 17:36:59.164', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (492, 4, 3.303042, 4.813206, 0, '2025-05-11 17:36:59.856', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (493, 2, 3.410861, 6.589808, 0, '2025-05-11 17:37:06.331', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (494, 4, 3.245316, 4.902946, 0, '2025-05-11 17:37:06.331', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (495, 2, 3.410861, 6.589808, 0, '2025-05-11 17:37:06.331', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (496, 4, 3.245316, 4.902946, 0, '2025-05-11 17:37:06.331', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (497, 2, 3.716722, 6.56, 0, '2025-05-11 17:37:12.41', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (498, 4, 3.245316, 4.902946, 0, '2025-05-11 17:37:11.913', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (499, 2, 3.81463, 6.524711, 0, '2025-05-11 17:37:18.268', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (500, 4, 2.977251, 4.957596, 0, '2025-05-11 17:37:18.422', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (501, 2, 3.923703, 6.466197, 0, '2025-05-11 17:37:23.549', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (502, 4, 2.987044, 4.908015, 0, '2025-05-11 17:37:24.467', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (503, 2, 4.161105, 6.292954, 0, '2025-05-11 17:37:30.19', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (504, 4, 3.015177, 4.860833, 0, '2025-05-11 17:37:29.424', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (505, 2, 4.161105, 6.292954, 0, '2025-05-11 17:37:30.453', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (506, 4, 3.015177, 4.860833, 0, '2025-05-11 17:37:29.424', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (507, 2, 4.193156, 6.23597, 0, '2025-05-11 17:37:36.24', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (508, 4, 3.023111, 4.879405, 0, '2025-05-11 17:37:36.44', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (509, 2, 4.25887, 6.145588, 0, '2025-05-11 17:37:42.486', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (510, 4, 3.050645, 4.881351, 0, '2025-05-11 17:37:42.446', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (511, 2, 4.194869, 6.128139, 0, '2025-05-11 17:37:48.418', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (512, 4, 2.979732, 4.973526, 0, '2025-05-11 17:37:48.254', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (513, 2, 3.988334, 6.173144, 0, '2025-05-11 17:37:54.278', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (514, 4, 2.968787, 5.031093, 0, '2025-05-11 17:37:53.456', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (515, 2, 3.988334, 6.173144, 0, '2025-05-11 17:37:54.401', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (516, 4, 2.968787, 5.031093, 0, '2025-05-11 17:37:54.486', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (517, 2, 3.69804, 6.184438, 0, '2025-05-11 17:38:00.353', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (518, 4, 2.937949, 5.10542, 0, '2025-05-11 17:38:00.306', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (519, 2, 3.651406, 6.207064, 0, '2025-05-11 17:38:06.509', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (520, 4, 2.895515, 5.005267, 0, '2025-05-11 17:38:06.51', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (521, 2, 3.531867, 6.179366, 0, '2025-05-11 17:38:10.329', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (522, 4, 2.895515, 5.005267, 0, '2025-05-11 17:38:12.252', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (523, 2, 3.531867, 6.179366, 0, '2025-05-11 17:38:10.329', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (524, 4, 2.895515, 5.005267, 0, '2025-05-11 17:38:13.895', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (525, 4, 2.895515, 5.005267, 0, '2025-05-11 17:38:13.895', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (526, 4, 2.895515, 5.005267, 0, '2025-05-11 17:38:30.359', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (527, 4, 3.07828, 4.697756, 0, '2025-05-11 17:38:36.233', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (528, 4, 5.992395, 3.275001, 0, '2025-05-11 17:38:42.025', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (532, 4, 3.045669, 6.059856, 0, '2025-05-11 17:39:00.343', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (533, 4, 3.001667, 4.810878, 0, '2025-05-11 17:39:06.278', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (534, 4, 3.001667, 4.810878, 0, '2025-05-11 17:39:06.278', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (535, 4, 2.910607, 6.106153, 0, '2025-05-11 17:39:12.38', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (536, 4, 5.794363, 3.274999, 0, '2025-05-11 17:39:18.245', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (537, 4, 2.740592, 6.266419, 0, '2025-05-11 17:39:24.339', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (538, 4, 2.773442, 6.190449, 0, '2025-05-11 17:39:30.025', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (539, 4, 2.773442, 6.190449, 0, '2025-05-11 17:39:30.425', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (540, 4, 2.773442, 6.190449, 0, '2025-05-11 17:39:36.217', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (541, 4, 5.680838, 3.275001, 0, '2025-05-11 17:39:42.53', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (542, 4, 2.641089, 6.304772, 0, '2025-05-11 17:39:48.449', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (543, 4, 2.897397, 6.041443, 0, '2025-05-11 17:39:54.367', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (544, 4, 5.689477, 3.275002, 0, '2025-05-11 17:39:54.58', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (545, 4, 2.746614, 4.762061, 0, '2025-05-11 17:40:00.333', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (546, 4, 2.746613, 4.654093, 0, '2025-05-11 17:40:06.497', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (547, 4, 2.746613, 4.654093, 0, '2025-05-11 17:40:12.498', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (548, 4, 2.738847, 4.525649, 0, '2025-05-11 17:40:17.992', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (549, 4, 2.738847, 4.525649, 0, '2025-05-11 17:40:18.438', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (550, 4, 2.5103, 4.731031, 0, '2025-05-11 17:40:24.33', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (551, 4, 2.580346, 4.738291, 0, '2025-05-11 17:40:30.464', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (552, 4, 2.606866, 4.73829, 0, '2025-05-11 17:40:36.479', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (553, 4, 2.596936, 4.74816, 0, '2025-05-11 17:40:42.136', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (554, 4, 2.596936, 4.74816, 0, '2025-05-11 17:40:42.552', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (555, 4, 2.598012, 4.620305, 0, '2025-05-11 17:40:48.339', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (556, 4, 2.542865, 4.59481, 0, '2025-05-11 17:40:54.246', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (557, 4, 2.542865, 4.59481, 0, '2025-05-11 17:41:00.61', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (558, 4, 2.542865, 4.59481, 0, '2025-05-11 17:41:03.31', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (559, 4, 2.542865, 4.59481, 0, '2025-05-11 17:41:03.31', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (563, 4, 3.131567, 3.529772, 0, '2025-05-11 17:42:00.374', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (564, 4, 2.890024, 4.187916, 0, '2025-05-11 17:42:06.59', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (565, 4, 2.621536, 4.731497, 0, '2025-05-11 17:42:12.643', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (566, 4, 2.365783, 4.540168, 0, '2025-05-11 17:42:18.05', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (567, 4, 2.365783, 4.540168, 0, '2025-05-11 17:42:18.473', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (568, 2, 3.279117, 3.400039, 0, '2025-05-11 17:42:24.682', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (569, 4, 2.365783, 4.540168, 0, '2025-05-11 17:42:23.264', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (570, 2, 3.538065, 4.368191, 0, '2025-05-11 17:42:26.808', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (571, 4, 2.377235, 4.558909, 0, '2025-05-11 17:42:30.456', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (572, 2, 3.920322, 6.375794, 0, '2025-05-11 17:42:33.85', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (573, 4, 2.429939, 4.728915, 0, '2025-05-11 17:42:36.435', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (574, 2, 3.506452, 6.480842, 0, '2025-05-11 17:42:41.273', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (575, 4, 2.428572, 4.818336, 0, '2025-05-11 17:42:42.313', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (576, 2, 3.506452, 6.480842, 0, '2025-05-11 17:42:41.273', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (577, 4, 2.437182, 4.811183, 0, '2025-05-11 17:42:42.734', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (578, 2, 3.314793, 6.544365, 0, '2025-05-11 17:42:48.105', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (579, 4, 2.44447, 4.8211, 0, '2025-05-11 17:42:48.663', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (580, 2, 3.231007, 6.583703, 0, '2025-05-11 17:42:54.799', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (581, 4, 2.434477, 4.823864, 0, '2025-05-11 17:42:51.572', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (582, 2, 3.411859, 6.547956, 0, '2025-05-11 17:43:00.785', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (583, 4, 2.418594, 4.813932, 0, '2025-05-11 17:42:58.958', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (584, 2, 3.508708, 6.51878, 0, '2025-05-11 17:43:02.661', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (585, 4, 2.419977, 4.789634, 0, '2025-05-11 17:43:06.388', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (586, 2, 3.655209, 6.483306, 0, '2025-05-11 17:43:06.734', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (587, 4, 2.419977, 4.789634, 0, '2025-05-11 17:43:06.388', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (588, 2, 3.74348, 6.519763, 0, '2025-05-11 17:43:09.785', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (589, 4, 2.411399, 4.753412, 0, '2025-05-11 17:43:12.53', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (590, 2, 3.609814, 6.622085, 0, '2025-05-11 17:43:17.005', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (591, 4, 2.470937, 4.708772, 0, '2025-05-11 17:43:18.644', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (592, 2, 3.340754, 6.772795, 0, '2025-05-11 17:43:23.963', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (593, 4, 2.978042, 4.521039, 0, '2025-05-11 17:43:24.763', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (594, 2, 3.439677, 6.779122, 0, '2025-05-11 17:43:30.429', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (595, 4, 3.182005, 4.304161, 0, '2025-05-11 17:43:27.229', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (596, 2, 3.35331, 6.803397, 0, '2025-05-11 17:43:30.715', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (597, 4, 3.182005, 4.304161, 0, '2025-05-11 17:43:27.229', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (598, 2, 3.340967, 6.803397, 0, '2025-05-11 17:43:36.653', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (599, 4, 2.933711, 4.196045, 0, '2025-05-11 17:43:34.214', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (600, 2, 2.847628, 6.815557, 0, '2025-05-11 17:43:42.723', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (601, 4, 2.822927, 4.129963, 0, '2025-05-11 17:43:41.174', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (602, 2, 2.366131, 6.730754, 0, '2025-05-11 17:43:48.74', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (603, 4, 2.831567, 3.954969, 0, '2025-05-11 17:43:48.15', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (604, 2, 2.48308, 6.534238, 0, '2025-05-11 17:43:51.729', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (605, 4, 2.866282, 3.971184, 0, '2025-05-11 17:43:54.071', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (606, 2, 2.48308, 6.534238, 0, '2025-05-11 17:43:51.729', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (607, 4, 0.283542, 4.219388, 0, '2025-05-11 17:43:54.489', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (608, 2, 2.644592, 6.260529, 0, '2025-05-11 17:43:58.541', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (609, 4, 2.980814, 4.411612, 0, '2025-05-11 17:44:00.632', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (610, 2, 3.287373, 3.349566, 0, '2025-05-11 17:44:05.444', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (612, 2, 3.44129, 4.809962, 0, '2025-05-11 17:44:12.48', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (614, 2, 3.567688, 5.731069, 0, '2025-05-11 17:44:18.354', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (616, 2, 3.567688, 5.731069, 0, '2025-05-11 17:44:18.766', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (618, 2, 3.300591, 6.063329, 0, '2025-05-11 17:44:24.704', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (620, 2, 2.469201, 6.232979, 0, '2025-05-11 17:44:30.846', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (622, 2, 2.34914, 6.160612, 0, '2025-05-11 17:44:33.302', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (624, 2, 2.598617, 5.835649, 0, '2025-05-11 17:44:40.073', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (625, 4, 2.838387, 5.498167, 0, '2025-05-11 17:44:42.461', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (626, 2, 2.598617, 5.835649, 0, '2025-05-11 17:44:40.073', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (627, 4, 2.838387, 5.498167, 0, '2025-05-11 17:44:42.883', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (628, 2, 2.939385, 5.807519, 0, '2025-05-11 17:44:46.831', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (629, 4, 3.106037, 4.903605, 0, '2025-05-11 17:44:48.858', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (630, 2, 3.266082, 5.909483, 0, '2025-05-11 17:44:53.585', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (631, 4, 2.636128, 4.989627, 0, '2025-05-11 17:44:54.585', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (632, 2, 3.232973, 5.876526, 0, '2025-05-11 17:45:00.788', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (633, 4, 2.572205, 5.022627, 0, '2025-05-11 17:44:57.335', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (634, 2, 3.232912, 5.892091, 0, '2025-05-11 17:45:06.487', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (635, 4, 2.70351, 4.927695, 0, '2025-05-11 17:45:04.55', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (636, 2, 3.232635, 5.998032, 0, '2025-05-11 17:45:06.901', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (637, 4, 2.70351, 4.927695, 0, '2025-05-11 17:45:04.55', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (638, 2, 3.175484, 6.148955, 0, '2025-05-11 17:45:12.936', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (639, 4, 2.517528, 5.122291, 0, '2025-05-11 17:45:11.946', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (640, 2, 3.390853, 6.013931, 0, '2025-05-11 17:45:15.524', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (641, 4, 2.460162, 5.095481, 0, '2025-05-11 17:45:18.887', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (642, 2, 3.452419, 5.722519, 0, '2025-05-11 17:45:22.555', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (643, 4, 2.630799, 4.91713, 0, '2025-05-11 17:45:24.62', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (644, 2, 3.244301, 5.624046, 0, '2025-05-11 17:45:29.529', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (645, 4, 2.740062, 4.860832, 0, '2025-05-11 17:45:30.356', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (646, 2, 3.244301, 5.624046, 0, '2025-05-11 17:45:29.529', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (647, 4, 2.740062, 4.860832, 0, '2025-05-11 17:45:30.774', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (648, 2, 3.21242, 5.589878, 0, '2025-05-11 17:45:36.594', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (649, 4, 2.776728, 4.837498, 0, '2025-05-11 17:45:36.944', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (650, 2, 3.399079, 5.811609, 0, '2025-05-11 17:45:42.924', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (651, 4, 2.835762, 4.824008, 0, '2025-05-11 17:45:40.069', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (652, 2, 3.524493, 5.848931, 0, '2025-05-11 17:45:48.816', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (653, 4, 0.225937, 4.887213, 0, '2025-05-11 17:45:46.806', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (654, 2, 3.822589, 5.794237, 0, '2025-05-11 17:45:54.418', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (655, 4, 0.187228, 5.120916, 0, '2025-05-11 17:45:53.778', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (656, 2, 3.822589, 5.794237, 0, '2025-05-11 17:45:54.891', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (657, 4, 0.187228, 5.120916, 0, '2025-05-11 17:45:53.778', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (658, 2, 3.552142, 5.981756, 0, '2025-05-11 17:45:57.48', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (659, 4, 0.177512, 4.935342, 0, '2025-05-11 17:46:00.755', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (660, 2, 3.20947, 6.148954, 0, '2025-05-11 17:46:03.487', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (661, 2, 3.20947, 6.148954, 0, '2025-05-11 17:46:03.487', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (662, 4, 3.011774, 4.606016, 0, '2025-05-11 17:46:18.469', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (663, 4, 3.011774, 4.606016, 0, '2025-05-11 17:46:18.891', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (664, 4, 3.142926, 4.466573, 0, '2025-05-11 17:46:24.732', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (666, 4, 3.125107, 4.424138, 0, '2025-05-11 17:46:30.085', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (667, 2, 3.416129, 3.36026, 0, '2025-05-11 17:46:32.104', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (668, 2, 3.416129, 3.36026, 0, '2025-05-11 17:46:32.104', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (669, 4, 3.125107, 4.424138, 0, '2025-05-11 17:46:30.085', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (670, 4, 3.125107, 4.424138, 0, '2025-05-11 17:46:48.609', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (671, 4, 3.079447, 4.481298, 0, '2025-05-11 17:46:54.962', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (672, 2, 3.250852, 3.362329, 0, '2025-05-11 17:47:00.606', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (673, 4, 3.079447, 4.481298, 0, '2025-05-11 17:46:59.034', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (674, 2, 3.250784, 3.636839, 0, '2025-05-11 17:47:02.147', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (675, 4, 3.135484, 4.474817, 0, '2025-05-11 17:47:06.021', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (676, 2, 3.416253, 4.663954, 0, '2025-05-11 17:47:06.71', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (677, 4, 3.135484, 4.474817, 0, '2025-05-11 17:47:06.021', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (678, 2, 3.607051, 5.437474, 0, '2025-05-11 17:47:09.832', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (679, 4, 3.144586, 4.474816, 0, '2025-05-11 17:47:13.022', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (680, 2, 3.679578, 5.36539, 0, '2025-05-11 17:47:16.958', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (681, 4, 3.117328, 4.467831, 0, '2025-05-11 17:47:18.751', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (682, 2, 3.172174, 5.359428, 0, '2025-05-11 17:47:24.123', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (683, 4, 3.099233, 4.467832, 0, '2025-05-11 17:47:24.894', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (684, 2, 2.958096, 5.317077, 0, '2025-05-11 17:47:30.209', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (685, 4, 3.071897, 4.484062, 0, '2025-05-11 17:47:27.614', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (686, 2, 2.958096, 5.317077, 0, '2025-05-11 17:47:30.762', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (687, 4, 3.071897, 4.484062, 0, '2025-05-11 17:47:27.614', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (688, 2, 2.96812, 5.310307, 0, '2025-05-11 17:47:36.829', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (689, 4, 3.062582, 4.507245, 0, '2025-05-11 17:47:34.723', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (690, 2, 2.900968, 5.285504, 0, '2025-05-11 17:47:42.931', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (691, 4, 3.072203, 4.488742, 0, '2025-05-11 17:47:41.717', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (692, 2, 2.832419, 5.265282, 0, '2025-05-11 17:47:45.528', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (693, 4, 3.072203, 4.488742, 0, '2025-05-11 17:47:48.908', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (694, 2, 3.285991, 5.260839, 0, '2025-05-11 17:48:00.439', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (695, 2, 3.494363, 5.229709, 0, '2025-05-11 17:48:03.021', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (696, 4, 3.071897, 4.491032, 0, '2025-05-11 17:48:04.573', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (697, 2, 3.494363, 5.229709, 0, '2025-05-11 17:48:03.021', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (698, 4, 3.071897, 4.491032, 0, '2025-05-11 17:48:04.573', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (701, 4, 2.964493, 4.514183, 0, '2025-05-11 17:48:39.79', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (702, 2, 3.242673, 3.571733, 0, '2025-05-11 17:48:43.985', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (703, 4, 3.017766, 4.521107, 0, '2025-05-11 17:48:47.546', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (704, 2, 2.95364, 5.387803, 0, '2025-05-11 17:48:53.127', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (705, 4, 3.062581, 4.521108, 0, '2025-05-11 17:48:49.013', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (706, 2, 2.95364, 5.387803, 0, '2025-05-11 17:48:53.127', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (707, 4, 3.062581, 4.521108, 0, '2025-05-11 17:48:49.013', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (708, 2, 2.794047, 5.573741, 0, '2025-05-11 17:48:58.664', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (709, 4, 3.153026, 4.539671, 0, '2025-05-11 17:48:57.638', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (710, 2, 2.87841, 5.520191, 0, '2025-05-11 17:49:02.198', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (711, 4, 3.190001, 4.530381, 0, '2025-05-11 17:49:05.236', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (712, 2, 3.317028, 5.230565, 0, '2025-05-11 17:49:10.826', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (713, 4, 3.171705, 4.521107, 0, '2025-05-11 17:49:11.34', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (714, 2, 3.317028, 5.230565, 0, '2025-05-11 17:49:10.826', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (715, 4, 3.144032, 4.530382, 0, '2025-05-11 17:49:15.118', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (716, 4, 3.144032, 4.530382, 0, '2025-05-11 17:49:15.118', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (717, 4, 3.134685, 4.539672, 0, '2025-05-11 17:49:35.432', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (718, 2, 3.195891, 3.421543, 0, '2025-05-11 17:49:41.073', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (719, 4, 3.134685, 4.539672, 0, '2025-05-11 17:49:40.164', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (720, 2, 3.195891, 3.421543, 0, '2025-05-11 17:49:41.073', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (721, 4, 3.134685, 4.539672, 0, '2025-05-11 17:49:40.164', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (722, 2, 2.724217, 4.559848, 0, '2025-05-11 17:49:44.156', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (723, 4, 3.089101, 4.539673, 0, '2025-05-11 17:49:47.5', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (724, 2, 1.750484, 6.847244, 0, '2025-05-11 17:49:53.272', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (725, 4, 3.070975, 4.532749, 0, '2025-05-11 17:49:49.154', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (726, 2, 1.762889, 6.848014, 0, '2025-05-11 17:49:58.847', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (727, 4, 3.153703, 4.48874, 0, '2025-05-11 17:49:58.212', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (728, 2, 1.796076, 6.848741, 0, '2025-05-11 17:50:02.432', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (729, 4, 3.181022, 4.497985, 0, '2025-05-11 17:50:05.325', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (730, 2, 1.796076, 6.848741, 0, '2025-05-11 17:50:02.432', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (731, 4, 3.181022, 4.497985, 0, '2025-05-11 17:50:05.325', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (732, 2, 1.775276, 6.848742, 0, '2025-05-11 17:50:11.575', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (733, 4, 3.190215, 4.504924, 0, '2025-05-11 17:50:07.38', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (734, 2, 1.775276, 6.848742, 0, '2025-05-11 17:50:12.082', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (735, 2, 1.775276, 6.848742, 0, '2025-05-11 17:50:29.18', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (736, 4, 3.190215, 4.504924, 0, '2025-05-11 17:50:07.38', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (737, 2, 1.775276, 6.848742, 0, '2025-05-11 17:50:29.18', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (738, 2, 1.7649, 6.861718, 0, '2025-05-11 17:50:34.845', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (739, 2, 1.7649, 6.861718, 0, '2025-05-11 17:50:37.368', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (741, 2, 1.845477, 6.793131, 0, '2025-05-11 17:50:47.086', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (743, 2, 1.859678, 6.775183, 0, '2025-05-11 17:50:53.181', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (744, 4, 3.132288, 4.554024, 0, '2025-05-11 17:50:51.261', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (745, 2, 1.859678, 6.775183, 0, '2025-05-11 17:50:53.181', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (746, 4, 3.132288, 4.554024, 0, '2025-05-11 17:50:51.261', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (747, 2, 2.002526, 6.607611, 0, '2025-05-11 17:50:55.74', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (748, 4, 2.675277, 5.009779, 0, '2025-05-11 17:50:58.837', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (749, 2, 2.789348, 5.604191, 0, '2025-05-11 17:51:05.441', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (750, 4, 2.675277, 5.009779, 0, '2025-05-11 17:51:00.866', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (751, 2, 2.924747, 5.49026, 0, '2025-05-11 17:51:11.538', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (752, 4, 2.460193, 5.141861, 0, '2025-05-11 17:51:10.49', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (753, 2, 2.90527, 5.49026, 0, '2025-05-11 17:51:15.215', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (754, 4, 2.740906, 4.857902, 0, '2025-05-11 17:51:17.584', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (755, 2, 2.90527, 5.49026, 0, '2025-05-11 17:51:15.215', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (756, 4, 2.740906, 4.857902, 0, '2025-05-11 17:51:17.584', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (757, 2, 2.901506, 5.568045, 0, '2025-05-11 17:51:23.31', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (758, 4, 2.807527, 4.742115, 0, '2025-05-11 17:51:20.149', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (759, 2, 2.901506, 5.568045, 0, '2025-05-11 17:51:24.345', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (760, 4, 2.669009, 4.745962, 0, '2025-05-11 17:51:28.831', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (761, 2, 2.950853, 5.549932, 0, '2025-05-11 17:51:34.532', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (762, 4, 2.659616, 4.755298, 0, '2025-05-11 17:51:35.338', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (763, 2, 2.980645, 5.555985, 0, '2025-05-11 17:51:41.145', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (764, 4, 2.61795, 4.683, 0, '2025-05-11 17:51:39.438', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (765, 2, 2.980645, 5.555985, 0, '2025-05-11 17:51:41.145', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (766, 4, 2.61795, 4.683, 0, '2025-05-11 17:51:39.438', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (767, 2, 3.061353, 5.577352, 0, '2025-05-11 17:51:44.272', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (768, 4, 2.590829, 4.620741, 0, '2025-05-11 17:51:46.993', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (769, 2, 3.072235, 5.570229, 0, '2025-05-11 17:51:53.408', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (770, 4, 2.590829, 4.620741, 0, '2025-05-11 17:51:49.024', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (771, 2, 3.05285, 5.441526, 0, '2025-05-11 17:51:59.503', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (772, 4, 2.814909, 4.573587, 0, '2025-05-11 17:51:58.136', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (773, 2, 3.042903, 5.315421, 0, '2025-05-11 17:52:02.599', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (774, 4, 3.163296, 4.688458, 0, '2025-05-11 17:52:05.221', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (775, 2, 3.042903, 5.315421, 0, '2025-05-11 17:52:02.599', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (776, 4, 3.163296, 4.688458, 0, '2025-05-11 17:52:05.221', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (777, 2, 3.400163, 5.360251, 0, '2025-05-11 17:52:11.341', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (778, 4, 3.14348, 4.771793, 0, '2025-05-11 17:52:07.746', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (779, 2, 3.600967, 5.396429, 0, '2025-05-11 17:52:17.401', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (780, 4, 2.71894, 5.169259, 0, '2025-05-11 17:52:16.87', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (781, 2, 3.980961, 5.536802, 0, '2025-05-11 17:52:21.518', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (782, 4, 2.71894, 5.169259, 0, '2025-05-11 17:52:23.411', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (783, 2, 3.894631, 5.567145, 0, '2025-05-11 17:52:29.159', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (784, 4, 2.395093, 5.266206, 0, '2025-05-11 17:52:26.493', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (785, 2, 3.894631, 5.567145, 0, '2025-05-11 17:52:29.679', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (786, 4, 2.395093, 5.266206, 0, '2025-05-11 17:52:26.493', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (787, 2, 3.894631, 5.567145, 0, '2025-05-11 17:52:30.707', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (788, 4, 2.516936, 5.158175, 0, '2025-05-11 17:52:35.549', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (789, 2, 4.187657, 5.551281, 0, '2025-05-11 17:52:40.406', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (790, 4, 2.557058, 5.118299, 0, '2025-05-11 17:52:41.098', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (791, 2, 3.839217, 5.561413, 0, '2025-05-11 17:52:47.521', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (792, 4, 2.594786, 5.045809, 0, '2025-05-11 17:52:44.632', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (793, 2, 3.839217, 5.561413, 0, '2025-05-11 17:52:49.051', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (794, 4, 2.666129, 4.869626, 0, '2025-05-11 17:52:52.698', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (795, 2, 3.839217, 5.561413, 0, '2025-05-11 17:52:49.051', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (796, 4, 2.647435, 4.913413, 0, '2025-05-11 17:52:53.714', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (797, 2, 3.934048, 5.746359, 0, '2025-05-11 17:52:58.709', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (798, 4, 2.647435, 4.986885, 0, '2025-05-11 17:52:59.749', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (799, 2, 3.977858, 5.719817, 0, '2025-05-11 17:53:05.299', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (800, 4, 2.724839, 4.96455, 0, '2025-05-11 17:53:02.801', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (801, 2, 4.084733, 5.533992, 0, '2025-05-11 17:53:07.394', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (802, 4, 2.868549, 4.824039, 0, '2025-05-11 17:53:11.411', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (803, 2, 4.125345, 5.487833, 0, '2025-05-11 17:53:17.051', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (804, 4, 2.907105, 4.789879, 0, '2025-05-11 17:53:17.42', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (805, 2, 4.125345, 5.487833, 0, '2025-05-11 17:53:17.051', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (806, 4, 2.907105, 4.789879, 0, '2025-05-11 17:53:17.42', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (807, 2, 3.85371, 5.579, 0, '2025-05-11 17:53:23.663', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (808, 4, 2.879954, 4.786298, 0, '2025-05-11 17:53:21.487', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (809, 2, 3.465445, 5.644957, 0, '2025-05-11 17:53:26.216', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (810, 4, 2.70169, 4.754366, 0, '2025-05-11 17:53:29.545', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (811, 2, 2.827904, 5.698612, 0, '2025-05-11 17:53:35.402', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (812, 4, 2.70169, 4.754366, 0, '2025-05-11 17:53:31.079', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (813, 2, 2.795669, 5.740442, 0, '2025-05-11 17:53:41.505', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (814, 4, 2.429685, 4.731367, 0, '2025-05-11 17:53:40.223', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (815, 2, 2.795669, 5.740442, 0, '2025-05-11 17:53:41.505', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (816, 4, 2.429685, 4.731367, 0, '2025-05-11 17:53:40.223', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (817, 2, 2.805538, 5.746328, 0, '2025-05-11 17:53:45.13', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (818, 4, 2.367651, 4.633053, 0, '2025-05-11 17:53:47.769', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (819, 2, 3.013525, 5.545482, 0, '2025-05-11 17:53:53.79', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (820, 4, 2.405968, 4.497718, 0, '2025-05-11 17:53:49.797', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (821, 2, 3.013525, 5.545482, 0, '2025-05-11 17:53:54.899', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (822, 4, 2.55656, 4.46981, 0, '2025-05-11 17:53:59.412', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (823, 2, 3.013895, 5.523549, 0, '2025-05-11 17:54:04.004', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (824, 4, 2.560377, 4.515801, 0, '2025-05-11 17:54:05.511', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (825, 2, 3.013895, 5.523549, 0, '2025-05-11 17:54:04.004', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (826, 4, 2.560377, 4.515801, 0, '2025-05-11 17:54:05.511', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (827, 2, 3.004808, 5.503244, 0, '2025-05-11 17:54:11.672', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (828, 4, 2.421184, 4.749351, 0, '2025-05-11 17:54:08.017', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (829, 2, 3.004808, 5.503244, 0, '2025-05-11 17:54:12.71', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (830, 4, 2.243042, 4.882022, 0, '2025-05-11 17:54:17.628', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (831, 2, 3.004808, 5.503244, 0, '2025-05-11 17:54:21.845', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (832, 4, 2.256383, 4.838321, 0, '2025-05-11 17:54:23.687', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (833, 2, 3.024469, 5.503246, 0, '2025-05-11 17:54:29.468', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (834, 4, 2.307419, 4.77942, 0, '2025-05-11 17:54:26.214', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (835, 2, 3.024469, 5.503246, 0, '2025-05-11 17:54:29.468', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (836, 4, 2.307419, 4.77942, 0, '2025-05-11 17:54:26.214', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (837, 2, 2.994601, 5.51339, 0, '2025-05-11 17:54:31.504', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (838, 4, 2.399125, 4.735114, 0, '2025-05-11 17:54:35.323', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (839, 2, 2.934509, 5.543916, 0, '2025-05-11 17:54:40.686', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (840, 4, 2.363087, 4.761505, 0, '2025-05-11 17:54:41.379', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (841, 2, 2.935, 5.533726, 0, '2025-05-11 17:54:47.801', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (842, 4, 2.336844, 4.771221, 0, '2025-05-11 17:54:44.93', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (843, 2, 2.944762, 5.533725, 0, '2025-05-11 17:54:49.85', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (844, 4, 2.33841, 4.74749, 0, '2025-05-11 17:54:53.507', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (845, 2, 2.944762, 5.533725, 0, '2025-05-11 17:54:49.85', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (846, 4, 2.33841, 4.74749, 0, '2025-05-11 17:54:53.507', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (847, 2, 2.934508, 5.538015, 0, '2025-05-11 17:54:59.499', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (848, 4, 2.339977, 4.744802, 0, '2025-05-11 17:54:54.539', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (849, 2, 2.944762, 5.52191, 0, '2025-05-11 17:55:05.599', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (850, 4, 2.362527, 4.713145, 0, '2025-05-11 17:55:04.15', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (851, 2, 2.945239, 5.511732, 0, '2025-05-11 17:55:08.167', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (852, 4, 2.380377, 4.710504, 0, '2025-05-11 17:55:11.719', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (853, 2, 2.971129, 5.551725, 0, '2025-05-11 17:55:17.295', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (854, 4, 2.380377, 4.710504, 0, '2025-05-11 17:55:13.261', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (855, 2, 2.971129, 5.551725, 0, '2025-05-11 17:55:17.813', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (856, 4, 2.380377, 4.710504, 0, '2025-05-11 17:55:13.261', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (857, 2, 2.91917, 5.603367, 0, '2025-05-11 17:55:23.371', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (858, 4, 2.380377, 4.724427, 0, '2025-05-11 17:55:21.869', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (859, 2, 2.56596, 5.856558, 0, '2025-05-11 17:55:26.457', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (860, 4, 2.372213, 4.724426, 0, '2025-05-11 17:55:29.412', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (861, 2, 2.312143, 6.15445, 0, '2025-05-11 17:55:35.657', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (862, 4, 2.649746, 4.717474, 0, '2025-05-11 17:55:31.492', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (863, 2, 2.312143, 6.15445, 0, '2025-05-11 17:55:36.178', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (864, 4, 2.702927, 4.707862, 0, '2025-05-11 17:55:41.079', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (865, 2, 2.380162, 6.059244, 0, '2025-05-11 17:55:41.751', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (866, 4, 2.702927, 4.707862, 0, '2025-05-11 17:55:41.079', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (867, 2, 2.634225, 5.749991, 0, '2025-05-11 17:55:45.864', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (868, 4, 2.468526, 4.750634, 0, '2025-05-11 17:55:47.691', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (869, 2, 2.429194, 5.965801, 0, '2025-05-11 17:55:53.493', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (870, 4, 2.578655, 4.852887, 0, '2025-05-11 17:55:49.702', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (871, 2, 2.401414, 5.97287, 0, '2025-05-11 17:55:54.528', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (872, 4, 3.171015, 4.761778, 0, '2025-05-11 17:55:59.289', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (873, 2, 2.400806, 5.743634, 0, '2025-05-11 17:56:04.24', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (874, 4, 3.19924, 4.705038, 0, '2025-05-11 17:56:04.83', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (875, 2, 2.400806, 5.743634, 0, '2025-05-11 17:56:04.24', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (876, 4, 3.19924, 4.705038, 0, '2025-05-11 17:56:05.83', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (877, 2, 2.672328, 5.489421, 0, '2025-05-11 17:56:11.891', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (878, 4, 2.704501, 4.617046, 0, '2025-05-11 17:56:08.878', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (879, 2, 2.783195, 5.546206, 0, '2025-05-11 17:56:13.448', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (880, 4, 2.798665, 4.474565, 0, '2025-05-11 17:56:17.462', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (881, 2, 2.861706, 5.602298, 0, '2025-05-11 17:56:22.648', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (882, 4, 2.733802, 4.394054, 0, '2025-05-11 17:56:23.552', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (883, 2, 2.841537, 5.582664, 0, '2025-05-11 17:56:28.754', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (884, 4, 0.118895, 4.762611, 0, '2025-05-11 17:56:27.133', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (885, 2, 2.832419, 5.523603, 0, '2025-05-11 17:56:29.746', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (886, 4, 0.118895, 4.762611, 0, '2025-05-11 17:56:27.133', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (887, 2, 2.832419, 5.523603, 0, '2025-05-11 17:56:31.286', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (889, 2, 2.925254, 5.455824, 0, '2025-05-11 17:56:40.93', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (891, 2, 2.955921, 5.425344, 0, '2025-05-11 17:56:47.555', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (893, 2, 2.945715, 5.40484, 0, '2025-05-11 17:56:50.133', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (894, 4, 2.296989, 5.118917, 0, '2025-05-11 17:56:52.897', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (895, 2, 2.945715, 5.40484, 0, '2025-05-11 17:56:50.133', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (896, 4, 2.296989, 5.118917, 0, '2025-05-11 17:56:52.897', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (897, 2, 2.936476, 5.15603, 0, '2025-05-11 17:56:59.863', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (899, 2, 2.881875, 5.308588, 0, '2025-05-11 17:57:05.912', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (900, 4, 2.356936, 5.092169, 0, '2025-05-11 17:57:04.035', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (901, 2, 2.85811, 5.407543, 0, '2025-05-11 17:57:09.495', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (902, 4, 2.637451, 4.97803, 0, '2025-05-11 17:57:11.623', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (903, 2, 2.799569, 5.696109, 0, '2025-05-11 17:57:17.655', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (904, 4, 2.69808, 4.888245, 0, '2025-05-11 17:57:14.162', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (905, 2, 2.799569, 5.696109, 0, '2025-05-11 17:57:17.655', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (906, 4, 2.69808, 4.888245, 0, '2025-05-11 17:57:14.162', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (907, 2, 3.00822, 5.691876, 0, '2025-05-11 17:57:19.175', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (908, 4, 2.679678, 4.665169, 0, '2025-05-11 17:57:23.789', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (909, 2, 3.233617, 5.591642, 0, '2025-05-11 17:57:28.373', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (910, 4, 2.679678, 4.665169, 0, '2025-05-11 17:57:29.327', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (911, 2, 3.255001, 5.528069, 0, '2025-05-11 17:57:34.991', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (912, 4, 2.651774, 4.71216, 0, '2025-05-11 17:57:32.891', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (913, 2, 3.022497, 5.612953, 0, '2025-05-11 17:57:37.569', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (914, 4, 2.643149, 4.719084, 0, '2025-05-11 17:57:39.954', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (915, 2, 3.022497, 5.612953, 0, '2025-05-11 17:57:37.569', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (916, 4, 2.643149, 4.719084, 0, '2025-05-11 17:57:39.954', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (917, 2, 2.896721, 5.655764, 0, '2025-05-11 17:57:53.639', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (918, 2, 2.614447, 5.895581, 0, '2025-05-11 17:57:59.31', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (919, 2, 2.614447, 5.895581, 0, '2025-05-11 17:58:02.323', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (920, 4, 3.253164, 3.329772, 0, '2025-05-11 17:58:05.532', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (921, 2, 2.614447, 5.895581, 0, '2025-05-11 17:58:02.323', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (922, 4, 3.253164, 3.329772, 0, '2025-05-11 17:58:05.532', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (923, 2, 2.580967, 5.928856, 0, '2025-05-11 17:58:11.475', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (924, 4, 3.282151, 3.592191, 0, '2025-05-11 17:58:07.022', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (925, 2, 2.644286, 5.906657, 0, '2025-05-11 17:58:17.533', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (926, 4, 3.46993, 5.211832, 0, '2025-05-11 17:58:16.644', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (927, 2, 2.262926, 6.154199, 0, '2025-05-11 17:58:21.147', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (928, 4, 2.954655, 4.621564, 0, '2025-05-11 17:58:23.726', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (929, 2, 2.166653, 6.200001, 0, '2025-05-11 17:58:29.288', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (930, 4, 2.809532, 4.495679, 0, '2025-05-11 17:58:25.764', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (931, 2, 2.166653, 6.200001, 0, '2025-05-11 17:58:29.809', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (932, 4, 2.809532, 4.495679, 0, '2025-05-11 17:58:25.764', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (933, 2, 2.218695, 6.115152, 0, '2025-05-11 17:58:35.887', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (934, 4, 2.814141, 4.502297, 0, '2025-05-11 17:58:34.891', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (935, 2, 2.534056, 5.982749, 0, '2025-05-11 17:58:39.486', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (936, 4, 2.876191, 4.431679, 0, '2025-05-11 17:58:41.976', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (937, 2, 2.534171, 6.082444, 0, '2025-05-11 17:58:47.645', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (938, 4, 2.981905, 4.458794, 0, '2025-05-11 17:58:44.013', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (939, 2, 2.534171, 6.082444, 0, '2025-05-11 17:58:48.684', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (940, 4, 3.130269, 4.480688, 0, '2025-05-11 17:58:53.139', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (941, 2, 2.524033, 6.203366, 0, '2025-05-11 17:58:53.746', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (942, 4, 3.130269, 4.480688, 0, '2025-05-11 17:58:53.139', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (943, 2, 2.279556, 6.25609, 0, '2025-05-11 17:58:57.339', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (944, 4, 3.103933, 4.474084, 0, '2025-05-11 17:58:59.711', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (945, 2, 2.513372, 6.095572, 0, '2025-05-11 17:59:05.972', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (946, 4, 3.140476, 4.431489, 0, '2025-05-11 17:59:02.767', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (947, 2, 2.507104, 6.157443, 0, '2025-05-11 17:59:07.532', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (948, 4, 3.080322, 4.80739, 0, '2025-05-11 17:59:11.42', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (949, 2, 2.883686, 6.13284, 0, '2025-05-11 17:59:16.722', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (950, 4, 3.049194, 4.963428, 0, '2025-05-11 17:59:17.447', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (951, 2, 2.883686, 6.13284, 0, '2025-05-11 17:59:16.722', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (952, 4, 3.049194, 4.963428, 0, '2025-05-11 17:59:17.447', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (953, 2, 3.12265, 5.85832, 0, '2025-05-11 17:59:23.813', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (954, 4, 3.072734, 5.146298, 0, '2025-05-11 17:59:21.53', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (955, 2, 3.331613, 5.700809, 0, '2025-05-11 17:59:26.376', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (956, 4, 3.187098, 5.186023, 0, '2025-05-11 17:59:29.106', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (957, 2, 3.940646, 5.642206, 0, '2025-05-11 17:59:35.562', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (958, 4, 3.255, 5.234688, 0, '2025-05-11 17:59:31.186', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (959, 2, 4.094194, 5.803366, 0, '2025-05-11 17:59:41.659', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (960, 4, 4.189071, 5.736901, 0, '2025-05-11 17:59:40.782', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (961, 2, 4.094194, 5.803366, 0, '2025-05-11 17:59:41.659', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (962, 4, 4.189071, 5.736901, 0, '2025-05-11 17:59:40.782', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (963, 2, 4.389256, 5.893045, 0, '2025-05-11 17:59:45.28', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (964, 4, 5.321115, 6.029175, 0, '2025-05-11 17:59:47.869', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (965, 2, 5.740002, 6.16716, 0, '2025-05-11 17:59:53.952', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (966, 4, 6.062313, 6.113266, 0, '2025-05-11 17:59:49.911', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (967, 2, 5.90387, 6.13336, 0, '2025-05-11 18:00:00.046', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (968, 4, 5.966642, 6.165651, 0, '2025-05-11 17:59:59.022', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (969, 2, 5.877419, 6.149443, 0, '2025-05-11 18:00:03.664', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (970, 4, 5.926805, 6.163582, 0, '2025-05-11 18:00:05.585', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (971, 2, 5.877419, 6.149443, 0, '2025-05-11 18:00:03.664', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (972, 4, 5.926805, 6.163582, 0, '2025-05-11 18:00:05.585', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (973, 2, 5.854515, 6.156834, 0, '2025-05-11 18:00:11.771', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (974, 4, 5.926805, 6.163582, 0, '2025-05-11 18:00:08.645', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (975, 2, 5.854515, 6.156834, 0, '2025-05-11 18:00:13.339', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (976, 4, 5.953348, 6.16358, 0, '2025-05-11 18:00:17.252', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (977, 4, 5.953348, 6.16358, 0, '2025-05-11 18:00:18.275', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (978, 2, 5.854515, 6.156834, 0, '2025-05-11 18:00:13.339', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (979, 4, 5.953348, 6.16358, 0, '2025-05-11 18:00:18.275', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (980, 4, 5.953348, 6.16358, 0, '2025-05-11 18:00:35.343', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (981, 4, 5.923226, 6.151886, 0, '2025-05-11 18:00:41.426', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (982, 4, 5.923226, 6.151886, 0, '2025-05-11 18:00:47.51', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (983, 4, 5.923226, 6.151886, 0, '2025-05-11 18:00:50.581', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (984, 4, 5.923226, 6.151886, 0, '2025-05-11 18:00:50.581', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (985, 4, 3.038388, 5.763513, 0, '2025-05-11 18:02:37.404', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (986, 4, 3.027565, 5.749924, 0, '2025-05-11 18:02:44.06', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (987, 4, 2.996744, 5.777663, 0, '2025-05-11 18:02:49.239', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (988, 4, 2.997128, 5.784368, 0, '2025-05-11 18:02:55.349', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (989, 4, 2.997128, 5.784368, 0, '2025-05-11 18:02:55.349', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (990, 4, 3.069469, 5.754078, 0, '2025-05-11 18:03:01.477', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (991, 4, 3.121305, 5.71267, 0, '2025-05-11 18:03:07.677', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (992, 2, 3.251129, 3.34426, 0, '2025-05-11 18:03:13.281', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (993, 4, 3.090822, 5.707, 0, '2025-05-11 18:03:11.701', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (994, 2, 3.249139, 3.868917, 0, '2025-05-11 18:03:16.335', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (995, 4, 3.080431, 5.711641, 0, '2025-05-11 18:03:19.768', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (996, 2, 3.249139, 3.868917, 0, '2025-05-11 18:03:16.335', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (997, 4, 3.080431, 5.711641, 0, '2025-05-11 18:03:19.768', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (998, 2, 3.264793, 4.914694, 0, '2025-05-11 18:03:24.957', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (999, 4, 3.039355, 5.726641, 0, '2025-05-11 18:03:25.848', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1000, 2, 3.22576, 5.09826, 0, '2025-05-11 18:03:32.064', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1001, 4, 3.008733, 5.737016, 0, '2025-05-11 18:03:29.89', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1002, 2, 3.274601, 5.157198, 0, '2025-05-11 18:03:34.626', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1003, 4, 3.049163, 5.748405, 0, '2025-05-11 18:03:37.482', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1004, 2, 3.274479, 5.056739, 0, '2025-05-11 18:03:43.185', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1005, 4, 3.039032, 5.748405, 0, '2025-05-11 18:03:39.523', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1006, 2, 3.274479, 5.056739, 0, '2025-05-11 18:03:43.185', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1007, 4, 3.039032, 5.748405, 0, '2025-05-11 18:03:39.523', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1008, 2, 3.303272, 5.026656, 0, '2025-05-11 18:03:49.786', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1009, 4, 3.00984, 5.722999, 0, '2025-05-11 18:03:48.632', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1010, 2, 3.26427, 4.901451, 0, '2025-05-11 18:03:53.388', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1011, 4, 3.030269, 5.707001, 0, '2025-05-11 18:03:55.197', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1012, 2, 3.329224, 4.826024, 0, '2025-05-11 18:04:01.957', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1013, 4, 3.143564, 5.616993, 0, '2025-05-11 18:03:58.256', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1014, 2, 3.329224, 4.826024, 0, '2025-05-11 18:04:02.975', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1015, 4, 3.554078, 5.348552, 0, '2025-05-11 18:04:07.889', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1016, 2, 3.329224, 4.826024, 0, '2025-05-11 18:04:02.975', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1017, 4, 3.554078, 5.348552, 0, '2025-05-11 18:04:07.889', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1018, 2, 3.168526, 5.034055, 0, '2025-05-11 18:04:12.605', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1019, 4, 3.625285, 5.333358, 0, '2025-05-11 18:04:13.41', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1020, 2, 3.168111, 5.006298, 0, '2025-05-11 18:04:19.698', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1021, 4, 3.498318, 5.485558, 0, '2025-05-11 18:04:17.519', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1022, 2, 3.196475, 5.07384, 0, '2025-05-11 18:04:22.221', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1023, 4, 3.479394, 5.600251, 0, '2025-05-11 18:04:26.107', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1024, 2, 2.981452, 5.029037, 0, '2025-05-11 18:04:31.375', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1025, 4, 3.62606, 5.652772, 0, '2025-05-11 18:04:27.099', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1026, 2, 2.981452, 5.029037, 0, '2025-05-11 18:04:31.375', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1027, 4, 3.62606, 5.652772, 0, '2025-05-11 18:04:27.099', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1028, 2, 2.963757, 4.992625, 0, '2025-05-11 18:04:37.447', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1029, 4, 3.744854, 5.75852, 0, '2025-05-11 18:04:36.703', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1030, 2, 3.043787, 4.823817, 0, '2025-05-11 18:04:40.5', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1031, 4, 3.603878, 5.606795, 0, '2025-05-11 18:04:43.301', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1032, 2, 3.075554, 5.175175, 0, '2025-05-11 18:04:50.157', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1033, 4, 3.50596, 5.427671, 0, '2025-05-11 18:04:45.338', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1034, 2, 3.02235, 5.355153, 0, '2025-05-11 18:04:55.701', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1035, 4, 3.304962, 5.463389, 0, '2025-05-11 18:04:54.947', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1036, 2, 3.02235, 5.355153, 0, '2025-05-11 18:04:55.701', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1037, 4, 3.304962, 5.463389, 0, '2025-05-11 18:04:54.947', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1038, 2, 2.997128, 5.691298, 0, '2025-05-11 18:04:59.773', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1039, 4, 3.295123, 5.493136, 0, '2025-05-11 18:05:01.523', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1040, 2, 3.461759, 5.522388, 0, '2025-05-11 18:05:07.888', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1041, 4, 3.123303, 5.627152, 0, '2025-05-11 18:05:04.562', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1042, 2, 3.461759, 5.522388, 0, '2025-05-11 18:05:08.907', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1043, 4, 2.995799, 5.500611, 0, '2025-05-11 18:05:13.693', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1044, 2, 3.59539, 5.241635, 0, '2025-05-11 18:05:18.523', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1045, 4, 3.135368, 5.418512, 0, '2025-05-11 18:05:19.235', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1046, 2, 3.59539, 5.241635, 0, '2025-05-11 18:05:18.523', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1047, 4, 3.135368, 5.418512, 0, '2025-05-11 18:05:19.235', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1048, 2, 3.377212, 5.286826, 0, '2025-05-11 18:05:25.631', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1049, 4, 3.135737, 5.392658, 0, '2025-05-11 18:05:23.318', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1050, 2, 3.377212, 5.286826, 0, '2025-05-11 18:05:27.668', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1051, 4, 3.316475, 5.673167, 0, '2025-05-11 18:05:31.931', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1052, 2, 4.306428, 6.211069, 0, '2025-05-11 18:05:37.807', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1053, 4, 3.916905, 5.958168, 0, '2025-05-11 18:05:32.94', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1054, 2, 4.40781, 6.113962, 0, '2025-05-11 18:05:43.878', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1055, 4, 5.026958, 6.120764, 0, '2025-05-11 18:05:42.554', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1056, 2, 4.40781, 6.113962, 0, '2025-05-11 18:05:43.878', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1057, 4, 5.026958, 6.120764, 0, '2025-05-11 18:05:42.554', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1058, 2, 4.171804, 5.961849, 0, '2025-05-11 18:05:46.91', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1059, 4, 4.28431, 5.87142, 0, '2025-05-11 18:05:49.652', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1060, 2, 4.378072, 5.990113, 0, '2025-05-11 18:05:56.058', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1061, 4, 4.320276, 5.876963, 0, '2025-05-11 18:05:51.694', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1062, 2, 4.997121, 6.242947, 0, '2025-05-11 18:06:02.138', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1063, 4, 5.98765, 6.371281, 0, '2025-05-11 18:06:01.365', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1064, 2, 5.387833, 6.347, 0, '2025-05-11 18:06:05.69', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1065, 4, 5.933702, 6.364199, 0, '2025-05-11 18:06:07.924', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1066, 2, 5.387833, 6.347, 0, '2025-05-11 18:06:05.69', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1067, 4, 5.933702, 6.364199, 0, '2025-05-11 18:06:07.924', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1068, 2, 5.334999, 6.329697, 0, '2025-05-11 18:06:13.794', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1069, 4, 5.78, 6.367153, 0, '2025-05-11 18:06:10.987', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1070, 2, 5.334999, 6.329697, 0, '2025-05-11 18:06:15.331', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1071, 4, 5.05914, 6.248413, 0, '2025-05-11 18:06:19.624', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1072, 2, 3.442467, 5.772343, 0, '2025-05-11 18:06:25.417', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1073, 4, 3.752075, 5.9219, 0, '2025-05-11 18:06:25.68', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1074, 2, 3.285853, 5.543917, 0, '2025-05-11 18:06:31.509', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1075, 4, 3.380529, 5.828597, 0, '2025-05-11 18:06:29.768', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1076, 2, 3.285853, 5.543917, 0, '2025-05-11 18:06:31.509', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1077, 4, 3.380529, 5.828597, 0, '2025-05-11 18:06:29.768', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1078, 2, 3.379424, 5.589207, 0, '2025-05-11 18:06:34.064', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1079, 4, 3.468518, 5.867558, 0, '2025-05-11 18:06:37.888', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1080, 2, 3.38016, 5.641756, 0, '2025-05-11 18:06:44.19', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1081, 4, 3.425077, 5.851602, 0, '2025-05-11 18:06:39.427', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1082, 2, 3.255001, 5.649441, 0, '2025-05-11 18:06:49.757', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1083, 4, 3.359303, 5.697717, 0, '2025-05-11 18:06:49.03', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1084, 2, 2.951775, 5.547466, 0, '2025-05-11 18:06:53.347', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1085, 4, 3.174509, 5.47036, 0, '2025-05-11 18:06:55.603', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1086, 2, 2.951775, 5.547466, 0, '2025-05-11 18:06:53.347', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1087, 4, 3.174509, 5.47036, 0, '2025-05-11 18:06:55.603', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1088, 2, 2.877336, 5.481923, 0, '2025-05-11 18:07:01.434', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1089, 4, 3.068357, 5.323245, 0, '2025-05-11 18:06:58.64', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1090, 2, 2.877336, 5.481923, 0, '2025-05-11 18:07:03.467', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1091, 4, 3.060223, 5.249894, 0, '2025-05-11 18:07:08.301', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1092, 2, 2.954286, 5.267366, 0, '2025-05-11 18:07:13.111', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1093, 4, 3.060223, 5.249894, 0, '2025-05-11 18:07:13.838', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1094, 2, 3.157457, 5.17423, 0, '2025-05-11 18:07:19.677', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1095, 4, 2.993917, 5.227977, 0, '2025-05-11 18:07:17.904', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1096, 2, 3.157457, 5.17423, 0, '2025-05-11 18:07:19.677', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1097, 4, 2.993917, 5.227977, 0, '2025-05-11 18:07:17.904', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1098, 2, 3.304271, 5.158336, 0, '2025-05-11 18:07:22.787', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1099, 4, 2.974133, 5.247641, 0, '2025-05-11 18:07:26.052', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1100, 2, 3.384501, 5.206016, 0, '2025-05-11 18:07:31.348', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1101, 4, 2.974133, 5.247641, 0, '2025-05-11 18:07:27.595', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1102, 2, 3.393926, 5.188832, 0, '2025-05-11 18:07:37.93', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1103, 4, 3.000991, 5.299245, 0, '2025-05-11 18:07:36.741', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1104, 2, 3.435554, 5.297647, 0, '2025-05-11 18:07:41.483', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1105, 4, 3.00139, 5.301374, 0, '2025-05-11 18:07:43.487', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1106, 2, 3.435554, 5.297647, 0, '2025-05-11 18:07:41.483', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1107, 4, 3.00139, 5.301374, 0, '2025-05-11 18:07:43.487', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1108, 2, 3.854332, 5.783205, 0, '2025-05-11 18:07:50.093', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1109, 4, 3.305038, 5.49546, 0, '2025-05-11 18:07:46.55', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1110, 2, 3.936291, 5.927824, 0, '2025-05-11 18:07:51.111', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1111, 4, 4.498849, 6.288282, 0, '2025-05-11 18:07:55.754', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1112, 2, 4.414325, 6.116833, 0, '2025-05-11 18:08:00.75', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1113, 4, 5.00043, 6.449757, 0, '2025-05-11 18:08:02.273', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1114, 2, 5.673678, 6.360558, 0, '2025-05-11 18:08:07.818', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1115, 4, 5.565945, 6.53994, 0, '2025-05-11 18:08:05.359', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1116, 2, 5.673678, 6.360558, 0, '2025-05-11 18:08:07.818', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1117, 4, 5.565945, 6.53994, 0, '2025-05-11 18:08:05.359', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1118, 2, 6.038203, 6.359663, 0, '2025-05-11 18:08:09.855', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1120, 2, 5.469932, 6.385046, 0, '2025-05-11 18:08:18.98', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1121, 4, 6.361974, 6.303398, 0, '2025-05-11 18:08:19.549', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1122, 2, 4.943941, 6.271664, 0, '2025-05-11 18:08:25.573', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1123, 4, 5.61245, 6.242598, 0, '2025-05-11 18:08:23.108', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1124, 2, 3.870638, 5.914909, 0, '2025-05-11 18:08:28.11', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1125, 4, 3.689193, 5.723665, 0, '2025-05-11 18:08:31.845', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1126, 2, 3.870638, 5.914909, 0, '2025-05-11 18:08:28.11', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1127, 4, 3.689193, 5.723665, 0, '2025-05-11 18:08:31.845', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1128, 2, 3.255001, 5.633961, 0, '2025-05-11 18:08:36.733', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1129, 4, 3.224333, 5.637328, 0, '2025-05-11 18:08:37.889', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1130, 2, 3.031621, 5.500832, 0, '2025-05-11 18:08:43.81', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1131, 4, 3.031283, 5.630184, 0, '2025-05-11 18:08:41.471', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1132, 2, 2.892236, 5.376885, 0, '2025-05-11 18:08:46.359', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1133, 4, 2.870914, 5.600686, 0, '2025-05-11 18:08:49.544', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1134, 2, 2.899355, 5.428527, 0, '2025-05-11 18:08:55.422', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1135, 4, 2.703602, 5.414543, 0, '2025-05-11 18:08:51.59', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1136, 2, 2.899355, 5.428527, 0, '2025-05-11 18:08:56.429', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1137, 4, 2.703602, 5.414543, 0, '2025-05-11 18:08:51.59', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1138, 2, 2.867996, 5.453229, 0, '2025-05-11 18:09:02.002', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1139, 4, 2.707905, 5.351145, 0, '2025-05-11 18:09:00.7', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1140, 2, 2.964247, 5.588314, 0, '2025-05-11 18:09:06.091', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1141, 4, 2.728273, 5.349656, 0, '2025-05-11 18:09:07.792', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1142, 2, 3.437143, 5.683549, 0, '2025-05-11 18:09:13.675', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1143, 4, 2.987697, 5.340305, 0, '2025-05-11 18:09:10.858', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1144, 2, 3.532572, 5.646566, 0, '2025-05-11 18:09:15.712', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1145, 4, 3.563296, 5.300243, 0, '2025-05-11 18:09:19.436', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1146, 2, 3.532572, 5.646566, 0, '2025-05-11 18:09:15.712', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1147, 4, 3.563296, 5.300243, 0, '2025-05-11 18:09:20.458', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1148, 2, 3.181828, 5.63723, 0, '2025-05-11 18:09:25.324', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1149, 4, 3.636651, 5.302543, 0, '2025-05-11 18:09:26.007', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1150, 2, 3.08689, 5.715174, 0, '2025-05-11 18:09:31.919', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1151, 4, 3.48977, 5.351031, 0, '2025-05-11 18:09:29.581', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1152, 2, 3.064771, 5.780343, 0, '2025-05-11 18:09:34.973', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1153, 4, 3.366438, 5.426083, 0, '2025-05-11 18:09:37.658', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1154, 2, 3.265637, 5.941136, 0, '2025-05-11 18:09:43.596', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1155, 4, 3.386698, 5.467977, 0, '2025-05-11 18:09:39.208', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1156, 2, 3.265637, 5.941136, 0, '2025-05-11 18:09:43.596', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1157, 4, 3.386698, 5.467977, 0, '2025-05-11 18:09:39.208', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1158, 2, 3.621636, 6.07519, 0, '2025-05-11 18:09:49.678', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1159, 4, 3.793595, 5.848435, 0, '2025-05-11 18:09:49.37', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1160, 2, 4.94298, 6.240595, 0, '2025-05-11 18:09:53.212', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1161, 4, 5.429348, 6.236099, 0, '2025-05-11 18:09:56.45', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1162, 2, 4.794409, 6.237137, 0, '2025-05-11 18:10:02.293', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1163, 4, 5.427589, 6.169357, 0, '2025-05-11 18:09:58.488', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1164, 2, 4.794409, 6.237137, 0, '2025-05-11 18:10:03.32', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1165, 4, 3.2859, 5.685626, 0, '2025-05-11 18:10:08.122', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1166, 2, 4.794409, 6.237137, 0, '2025-05-11 18:10:03.32', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1167, 4, 3.2859, 5.685626, 0, '2025-05-11 18:10:08.122', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1168, 2, 3.402096, 5.570573, 0, '2025-05-11 18:10:12.983', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1169, 4, 3.234447, 5.66232, 0, '2025-05-11 18:10:13.663', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1170, 2, 3.402096, 5.570573, 0, '2025-05-11 18:10:20.042', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1171, 4, 3.275368, 5.603391, 0, '2025-05-11 18:10:17.754', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1172, 2, 2.940715, 5.810457, 0, '2025-05-11 18:10:22.598', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1173, 4, 3.183764, 5.693474, 0, '2025-05-11 18:10:26.352', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1174, 2, 2.54053, 6.007174, 0, '2025-05-11 18:10:31.246', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1175, 4, 3.183764, 5.693474, 0, '2025-05-11 18:10:27.373', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1176, 2, 2.366483, 6.068231, 0, '2025-05-11 18:10:32.271', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1177, 4, 3.183764, 5.693474, 0, '2025-05-11 18:10:27.373', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1178, 2, 2.286951, 6.138817, 0, '2025-05-11 18:10:37.847', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1179, 4, 3.265162, 5.669809, 0, '2025-05-11 18:10:37.011', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1180, 2, 2.531344, 5.793077, 0, '2025-05-11 18:10:41.93', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1181, 4, 3.387697, 5.623458, 0, '2025-05-11 18:10:43.558', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1182, 2, 2.795708, 5.159068, 0, '2025-05-11 18:10:50.544', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1183, 4, 3.655485, 5.456504, 0, '2025-05-11 18:10:46.616', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1184, 2, 2.788971, 5.033816, 0, '2025-05-11 18:10:51.562', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1185, 4, 3.643172, 5.41558, 0, '2025-05-11 18:10:55.202', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1186, 2, 2.788971, 5.033816, 0, '2025-05-11 18:10:51.562', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1187, 4, 3.662989, 5.401526, 0, '2025-05-11 18:10:56.222', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1188, 2, 2.962549, 5.110703, 0, '2025-05-11 18:11:00.635', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1189, 4, 3.693917, 5.391703, 0, '2025-05-11 18:11:02.317', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1190, 2, 3.132236, 5.196945, 0, '2025-05-11 18:11:07.706', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1191, 4, 3.726305, 5.407152, 0, '2025-05-11 18:11:05.367', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1192, 2, 3.455069, 5.325535, 0, '2025-05-11 18:11:10.76', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1193, 4, 3.705814, 5.400068, 0, '2025-05-11 18:11:14.052', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1194, 2, 3.086889, 5.499237, 0, '2025-05-11 18:11:19.862', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1195, 4, 3.705814, 5.400068, 0, '2025-05-11 18:11:15.053', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1196, 2, 3.086889, 5.499237, 0, '2025-05-11 18:11:20.377', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1197, 4, 3.705814, 5.400068, 0, '2025-05-11 18:11:15.053', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1198, 2, 3.081482, 5.755123, 0, '2025-05-11 18:11:26.455', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1199, 4, 3.716406, 5.405725, 0, '2025-05-11 18:11:24.705', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1200, 2, 3.078288, 5.956587, 0, '2025-05-11 18:11:29.512', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1201, 4, 3.766522, 5.366457, 0, '2025-05-11 18:11:32.322', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1202, 2, 3.371505, 5.823855, 0, '2025-05-11 18:11:38.166', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1203, 4, 3.795991, 5.342811, 0, '2025-05-11 18:11:34.397', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1204, 2, 3.371505, 5.823855, 0, '2025-05-11 18:11:39.153', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1205, 4, 4.026829, 5.549199, 0, '2025-05-11 18:11:43.965', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1206, 2, 3.371505, 5.823855, 0, '2025-05-11 18:11:39.153', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1207, 4, 4.026829, 5.549199, 0, '2025-05-11 18:11:43.965', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1208, 2, 4.578503, 6.079796, 0, '2025-05-11 18:11:48.838', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1209, 4, 4.339239, 5.765078, 0, '2025-05-11 18:11:50.598', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1210, 2, 4.9146, 6.200551, 0, '2025-05-11 18:11:55.902', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1211, 4, 5.22858, 6.244925, 0, '2025-05-11 18:11:53.644', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1212, 2, 5.444408, 6.29426, 0, '2025-05-11 18:11:58.956', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1213, 4, 5.290024, 6.30233, 0, '2025-05-11 18:12:01.724', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1214, 2, 5.161299, 6.299, 0, '2025-05-11 18:12:07.559', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1215, 4, 5.34938, 6.325321, 0, '2025-05-11 18:12:03.773', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1216, 2, 4.622619, 6.275664, 0, '2025-05-11 18:12:08.561', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1217, 4, 5.34938, 6.325321, 0, '2025-05-11 18:12:03.773', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1218, 2, 3.414563, 6.128008, 0, '2025-05-11 18:12:14.122', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1219, 4, 5.516844, 6.453169, 0, '2025-05-11 18:12:13.443', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1220, 2, 3.117711, 5.978718, 0, '2025-05-11 18:12:17.675', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1221, 4, 5.53, 6.453169, 0, '2025-05-11 18:12:20.004', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1222, 2, 3.031613, 5.880558, 0, '2025-05-11 18:12:25.791', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1223, 4, 5.506666, 6.463284, 0, '2025-05-11 18:12:22.576', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1224, 2, 3.074162, 5.865085, 0, '2025-05-11 18:12:27.816', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1225, 4, 5.509631, 6.473413, 0, '2025-05-11 18:12:31.687', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1226, 2, 3.074162, 5.865085, 0, '2025-05-11 18:12:27.816', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1227, 4, 5.509631, 6.473413, 0, '2025-05-11 18:12:31.687', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1228, 2, 2.839025, 5.828342, 0, '2025-05-11 18:12:37.4', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1229, 4, 5.496475, 6.473413, 0, '2025-05-11 18:12:38.244', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1230, 2, 2.809478, 5.799826, 0, '2025-05-11 18:12:44.003', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1231, 4, 5.486267, 6.481289, 0, '2025-05-11 18:12:42.343', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1232, 2, 2.798779, 5.810459, 0, '2025-05-11 18:12:47.075', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1233, 4, 5.476046, 6.491449, 0, '2025-05-11 18:12:50.522', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1234, 2, 2.859824, 5.8058, 0, '2025-05-11 18:12:56.171', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1235, 4, 5.476046, 6.491449, 0, '2025-05-11 18:12:51.543', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1236, 2, 2.859824, 5.8058, 0, '2025-05-11 18:12:56.171', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1237, 4, 5.499423, 6.483559, 0, '2025-05-11 18:12:56.6', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1238, 2, 2.839025, 5.816436, 0, '2025-05-11 18:13:01.749', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1239, 4, 5.509631, 6.473413, 0, '2025-05-11 18:13:00.184', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1240, 2, 2.849724, 5.811764, 0, '2025-05-11 18:13:04.818', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1241, 4, 5.486267, 6.481289, 0, '2025-05-11 18:13:08.283', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1242, 2, 2.817581, 5.831771, 0, '2025-05-11 18:13:13.95', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1243, 4, 5.486267, 6.481289, 0, '2025-05-11 18:13:09.337', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1244, 2, 2.92222, 5.821259, 0, '2025-05-11 18:13:19.481', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1245, 4, 5.499423, 6.483559, 0, '2025-05-11 18:13:18.969', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1246, 2, 2.92222, 5.821259, 0, '2025-05-11 18:13:20.487', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1247, 4, 5.499423, 6.483559, 0, '2025-05-11 18:13:18.969', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1248, 2, 2.985016, 5.808107, 0, '2025-05-11 18:13:23.032', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1249, 4, 5.496475, 6.473413, 0, '2025-05-11 18:13:26.046', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1250, 2, 3.048857, 5.730206, 0, '2025-05-11 18:13:32.676', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1251, 4, 5.486267, 6.481289, 0, '2025-05-11 18:13:28.091', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1252, 2, 3.080169, 5.710567, 0, '2025-05-11 18:13:37.719', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1253, 4, 5.483335, 6.473412, 0, '2025-05-11 18:13:37.205', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1254, 2, 3.357488, 3.940681, 0, '2025-05-11 18:13:41.28', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1255, 4, 5.549193, 6.473413, 0, '2025-05-11 18:13:43.268', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1256, 2, 3.357488, 3.940681, 0, '2025-05-11 18:13:41.28', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1257, 4, 5.549193, 6.473413, 0, '2025-05-11 18:13:44.287', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1258, 2, 3.445853, 0.959245, 0, '2025-05-11 18:13:49.867', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1259, 4, 5.549193, 6.473413, 0, '2025-05-11 18:13:46.325', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1260, 2, 3.346428, 0.725436, 0, '2025-05-11 18:13:56.441', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1261, 4, 5.506666, 6.463284, 0, '2025-05-11 18:13:55.512', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1262, 2, 3.277734, 0.684948, 0, '2025-05-11 18:13:59.502', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1263, 4, 5.493525, 6.461018, 0, '2025-05-11 18:14:02.498', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1264, 2, 3.338295, 0.36181, 0, '2025-05-11 18:14:08.103', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1265, 4, 5.506666, 6.461016, 0, '2025-05-11 18:14:04.538', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1266, 2, 3.338295, 0.36181, 0, '2025-05-11 18:14:08.593', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1267, 4, 5.506666, 6.461016, 0, '2025-05-11 18:14:04.538', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1268, 2, 3.316083, 0.37265, 0, '2025-05-11 18:14:14.163', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1269, 4, 5.496475, 6.471144, 0, '2025-05-11 18:14:13.634', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1270, 2, 3.451313, 1.861993, 0, '2025-05-11 18:14:18.238', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1271, 4, 5.509632, 6.471146, 0, '2025-05-11 18:14:19.767', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1272, 2, 3.592327, 3.858513, 0, '2025-05-11 18:14:26.322', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1273, 4, 5.509632, 6.471146, 0, '2025-05-11 18:14:22.787', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1274, 2, 3.815001, 4.505939, 0, '2025-05-11 18:14:27.335', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1275, 4, 5.493525, 6.461018, 0, '2025-05-11 18:14:31.425', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1276, 2, 4.01202, 4.629497, 0, '2025-05-11 18:14:32.399', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1277, 4, 5.493525, 6.461018, 0, '2025-05-11 18:14:31.425', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1278, 2, 4.124425, 4.420527, 0, '2025-05-11 18:14:35.993', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1279, 4, 5.467288, 6.461014, 0, '2025-05-11 18:14:37.982', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1280, 2, 4.460008, 5.173656, 0, '2025-05-11 18:14:44.566', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1281, 4, 5.467288, 6.461014, 0, '2025-05-11 18:14:41.071', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1282, 2, 5.181335, 5.925009, 0, '2025-05-11 18:14:50.642', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1283, 4, 5.509631, 6.45722, 0, '2025-05-11 18:14:50.136', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1284, 2, 6.254654, 4.916079, 0, '2025-05-11 18:14:54.713', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1285, 4, 5.522804, 6.457222, 0, '2025-05-11 18:14:56.203', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1286, 2, 6.254654, 4.916079, 0, '2025-05-11 18:14:54.713', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1287, 4, 5.522804, 6.457222, 0, '2025-05-11 18:14:56.203', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1289, 4, 5.557396, 6.412865, 0, '2025-05-11 18:14:59.242', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1290, 2, 6.393764, 0.620344, 0, '2025-05-11 18:15:03.833', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1291, 4, 5.597704, 6.370535, 0, '2025-05-11 18:15:08.341', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1292, 2, 6.229838, 0.536214, 0, '2025-05-11 18:15:12.948', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1293, 4, 5.617765, 6.350595, 0, '2025-05-11 18:15:14.411', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1294, 2, 6.247589, 0.509939, 0, '2025-05-11 18:15:19.535', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1295, 4, 5.600806, 6.382795, 0, '2025-05-11 18:15:17.453', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1296, 2, 6.174608, 0.533751, 0, '2025-05-11 18:15:20.588', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1297, 4, 5.600806, 6.382795, 0, '2025-05-11 18:15:17.453', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1298, 2, 6.104033, 0.452825, 0, '2025-05-11 18:15:22.561', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1299, 4, 5.657703, 6.313169, 0, '2025-05-11 18:15:26.583', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1300, 2, 6.001882, 0.431672, 0, '2025-05-11 18:15:31.698', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1301, 4, 5.587648, 6.382797, 0, '2025-05-11 18:15:32.609', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1302, 2, 6.129077, 0.427979, 0, '2025-05-11 18:15:38.271', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1303, 4, 5.540162, 6.443069, 0, '2025-05-11 18:15:36.174', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1304, 2, 6.359524, 0.69152, 0, '2025-05-11 18:15:41.328', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1305, 4, 5.386128, 6.596163, 0, '2025-05-11 18:15:43.824', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1306, 2, 6.359524, 0.69152, 0, '2025-05-11 18:15:41.328', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1307, 4, 5.386128, 6.596163, 0, '2025-05-11 18:15:44.345', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1308, 2, 6.445168, 1.622727, 0, '2025-05-11 18:15:50.458', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1309, 4, 5.331314, 6.635296, 0, '2025-05-11 18:15:45.371', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1310, 2, 6.393065, 1.890258, 0, '2025-05-11 18:15:56.003', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1311, 4, 5.4247, 6.54248, 0, '2025-05-11 18:15:54.982', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1312, 2, 6.333149, 2.178818, 0, '2025-05-11 18:15:59.568', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1313, 4, 5.476044, 6.493719, 0, '2025-05-11 18:16:02.602', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1314, 2, 6.288702, 2.858779, 0, '2025-05-11 18:16:07.207', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1315, 4, 5.476044, 6.493719, 0, '2025-05-11 18:16:03.623', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1316, 2, 6.288702, 2.858779, 0, '2025-05-11 18:16:08.23', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1317, 4, 5.476044, 6.493719, 0, '2025-05-11 18:16:03.623', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1318, 2, 6.241082, 3.297108, 0, '2025-05-11 18:16:14.785', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1319, 4, 5.547281, 6.420649, 0, '2025-05-11 18:16:13.222', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1320, 2, 6.000876, 5.177832, 0, '2025-05-11 18:16:17.828', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1321, 4, 5.630921, 6.348314, 0, '2025-05-11 18:16:20.817', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1322, 2, 5.817618, 5.992336, 0, '2025-05-11 18:16:26.46', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1323, 4, 5.634071, 6.360556, 0, '2025-05-11 18:16:21.842', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1324, 2, 5.841175, 5.992865, 0, '2025-05-11 18:16:32.009', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1325, 4, 5.667901, 6.281483, 0, '2025-05-11 18:16:31.464', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1326, 2, 5.841175, 5.992865, 0, '2025-05-11 18:16:32.517', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1327, 4, 5.667901, 6.281483, 0, '2025-05-11 18:16:31.464', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1328, 2, 5.765904, 6.123344, 0, '2025-05-11 18:16:36.097', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1329, 4, 5.835206, 6.078705, 0, '2025-05-11 18:16:38.585', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1330, 2, 5.994515, 6.127918, 0, '2025-05-11 18:16:44.207', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1331, 4, 5.920161, 6.003695, 0, '2025-05-11 18:16:40.581', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1332, 2, 6.251498, 6.133015, 0, '2025-05-11 18:16:50.296', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1333, 4, 5.609863, 6.134665, 0, '2025-05-11 18:16:49.21', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1335, 4, 5.405869, 6.074551, 0, '2025-05-11 18:16:55.753', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1337, 4, 5.405869, 6.074551, 0, '2025-05-11 18:16:56.766', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1338, 2, 6.408426, 6.133472, 0, '2025-05-11 18:17:02.493', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1339, 4, 4.489908, 4.674261, 0, '2025-05-11 18:16:58.308', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1341, 4, 4.080008, 2.819245, 0, '2025-05-11 18:17:07.948', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1342, 2, 6.491652, 6.128618, 0, '2025-05-11 18:17:12.638', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1343, 4, 3.987904, 2.126939, 0, '2025-05-11 18:17:14.036', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1344, 2, 5.858004, 6.140711, 0, '2025-05-11 18:17:19.745', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1345, 4, 3.294194, 0.698397, 0, '2025-05-11 18:17:17.097', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1346, 2, 5.606581, 6.131054, 0, '2025-05-11 18:17:20.765', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1347, 4, 3.294194, 0.698397, 0, '2025-05-11 18:17:17.097', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1348, 2, 5.671289, 6.128618, 0, '2025-05-11 18:17:26.828', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1349, 4, 2.470054, 0.379649, 0, '2025-05-11 18:17:26.202', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1350, 2, 5.772228, 6.121412, 0, '2025-05-11 18:17:30.891', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1351, 4, 1.933226, 0.170688, 0, '2025-05-11 18:17:32.775', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1352, 2, 5.733033, 6.118977, 0, '2025-05-11 18:17:38.454', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1353, 4, 0.719171, 0.070786, 0, '2025-05-11 18:17:35.881', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1354, 2, 5.749447, 6.128618, 0, '2025-05-11 18:17:40.543', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1355, 4, 0.945016, 0.039008, 0, '2025-05-11 18:17:43.96', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1356, 2, 5.749447, 6.128618, 0, '2025-05-11 18:17:40.543', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1357, 4, 0.945016, 0.039008, 0, '2025-05-11 18:17:43.96', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1358, 2, 5.897701, 6.140713, 0, '2025-05-11 18:17:50.158', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1359, 4, 0.871467, 0.362459, 0, '2025-05-11 18:17:50.523', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1360, 2, 5.948279, 6.167337, 0, '2025-05-11 18:17:56.75', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1361, 4, 0.782005, 0.95671, 0, '2025-05-11 18:17:54.601', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1362, 2, 5.944702, 6.160069, 0, '2025-05-11 18:17:58.804', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1363, 4, 0.712182, 1.216825, 0, '2025-05-11 18:18:02.733', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1364, 2, 6.025943, 6.072674, 0, '2025-05-11 18:18:07.433', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1365, 4, 0.712182, 1.216825, 0, '2025-05-11 18:18:03.256', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1366, 2, 6.025943, 6.072674, 0, '2025-05-11 18:18:08.457', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1367, 4, 0.513403, 1.063793, 0, '2025-05-11 18:18:08.818', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1368, 2, 6.071936, 6.058598, 0, '2025-05-11 18:18:14.526', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1369, 4, 0.490116, 1.132977, 0, '2025-05-11 18:18:12.899', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1370, 2, 5.800507, 6.073284, 0, '2025-05-11 18:18:17.565', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1371, 4, 0.597673, 1.521443, 0, '2025-05-11 18:18:20.492', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1372, 2, 5.997857, 6.075583, 0, '2025-05-11 18:18:26.142', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1373, 4, 0.632235, 1.509375, 0, '2025-05-11 18:18:22.531', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1374, 2, 5.961752, 6.085114, 0, '2025-05-11 18:18:32.216', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1375, 4, 0.686651, 1.844985, 0, '2025-05-11 18:18:31.661', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1376, 2, 5.961752, 6.085114, 0, '2025-05-11 18:18:32.216', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1377, 4, 0.686651, 1.844985, 0, '2025-05-11 18:18:31.661', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1378, 2, 5.712943, 6.087397, 0, '2025-05-11 18:18:36.283', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1379, 4, 0.481798, 2.271878, 0, '2025-05-11 18:18:38.852', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1380, 2, 5.751858, 6.085115, 0, '2025-05-11 18:18:44.444', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1381, 4, 0.367996, 2.667122, 0, '2025-05-11 18:18:40.897', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1382, 2, 5.813556, 6.075581, 0, '2025-05-11 18:18:50.556', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1384, 2, 5.748465, 6.075581, 0, '2025-05-11 18:18:54.111', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1386, 2, 5.748465, 6.075581, 0, '2025-05-11 18:18:54.111', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1388, 2, 5.709594, 6.077862, 0, '2025-05-11 18:19:02.723', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1390, 2, 5.709595, 6.075581, 0, '2025-05-11 18:19:08.793', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1391, 4, 0.09924, 2.342993, 0, '2025-05-11 18:19:08.383', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1392, 2, 5.709595, 6.075581, 0, '2025-05-11 18:19:12.846', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1393, 4, 0.223825, 2.281565, 0, '2025-05-11 18:19:14.898', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1394, 2, 5.751859, 6.087399, 0, '2025-05-11 18:19:19.935', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1395, 4, 0.334447, 2.361901, 0, '2025-05-11 18:19:17.461', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1396, 2, 5.751859, 6.087399, 0, '2025-05-11 18:19:20.954', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1397, 4, 0.334447, 2.361901, 0, '2025-05-11 18:19:17.461', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1398, 2, 5.761453, 6.077862, 0, '2025-05-11 18:19:27.012', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1399, 4, 0.399079, 2.588099, 0, '2025-05-11 18:19:26.621', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1400, 2, 5.725898, 6.087397, 0, '2025-05-11 18:19:30.565', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1401, 4, 0.333457, 2.748718, 0, '2025-05-11 18:19:32.735', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1402, 2, 5.687074, 6.085115, 0, '2025-05-11 18:19:38.191', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1403, 4, 0.415369, 2.734245, 0, '2025-05-11 18:19:35.743', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1404, 2, 5.722537, 6.075579, 0, '2025-05-11 18:19:40.218', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1405, 4, 0.59659, 2.598703, 0, '2025-05-11 18:19:43.364', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1406, 2, 5.722537, 6.075579, 0, '2025-05-11 18:19:40.218', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1407, 4, 0.682958, 2.522153, 0, '2025-05-11 18:19:44.385', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1408, 2, 5.764862, 6.085114, 0, '2025-05-11 18:19:49.816', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1409, 4, 0.623787, 2.515466, 0, '2025-05-11 18:19:50.437', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1410, 2, 5.790914, 6.085115, 0, '2025-05-11 18:19:56.894', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1411, 4, 1.34394, 1.77958, 0, '2025-05-11 18:19:54.499', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1412, 2, 5.790914, 6.085115, 0, '2025-05-11 18:19:58.949', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1413, 4, 3.398472, 2.441053, 0, '2025-05-11 18:20:02.575', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1414, 2, 5.925692, 6.092369, 0, '2025-05-11 18:20:07.577', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1415, 4, 3.398472, 2.441053, 0, '2025-05-11 18:20:03.597', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1416, 2, 5.925692, 6.092369, 0, '2025-05-11 18:20:07.577', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1417, 4, 4.269785, 3.434595, 0, '2025-05-11 18:20:08.657', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1418, 2, 5.976013, 6.249954, 0, '2025-05-11 18:20:14.651', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1419, 4, 5.992327, 5.223459, 0, '2025-05-11 18:20:12.726', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1420, 2, 6.468834, 4.948648, 0, '2025-05-11 18:20:16.678', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1421, 4, 6.497275, 3.209778, 0, '2025-05-11 18:20:20.902', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1423, 4, 6.528985, 2.10013, 0, '2025-05-11 18:20:21.893', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1425, 4, 6.46172, 0.399559, 0, '2025-05-11 18:20:31.551', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1427, 4, 6.46172, 0.399559, 0, '2025-05-11 18:20:31.551', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1429, 4, 6.457798, 0.411938, 0, '2025-05-11 18:20:39.11', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1430, 2, 6.081474, -0.003221, 0, '2025-05-11 18:20:45.053', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1431, 4, 6.37954, 0.353595, 0, '2025-05-11 18:20:41.146', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1450, 2, 4.545269, 0.095122, 0, '2025-05-11 18:21:32.709', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1452, 2, 4.545269, 0.095122, 0, '2025-05-11 18:21:33.724', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1454, 2, 4.352811, 0.532344, 0, '2025-05-11 18:21:42.85', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1456, 2, 4.352811, 0.532344, 0, '2025-05-11 18:21:42.85', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1458, 2, 4.419678, 0.464, 0, '2025-05-11 18:21:50.464', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1460, 2, 4.60871, 0.306085, 0, '2025-05-11 18:21:52.499', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1462, 2, 4.333771, 0.495947, 0, '2025-05-11 18:22:02.116', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1464, 2, 4.333771, 0.495947, 0, '2025-05-11 18:22:08.164', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1466, 2, 4.333771, 0.495947, 0, '2025-05-11 18:22:08.164', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1468, 2, 4.343825, 0.449504, 0, '2025-05-11 18:22:10.709', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1470, 2, 4.396874, 0.121359, 0, '2025-05-11 18:22:20.858', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1472, 2, 4.392765, 0.157253, 0, '2025-05-11 18:22:26.407', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1525, 4, 4.523549, -0.018404, 0, '2025-05-11 18:24:28.863', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1527, 4, 4.523549, -0.018404, 0, '2025-05-11 18:24:28.863', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1529, 4, 4.585868, 0.045015, 0, '2025-05-11 18:24:38.46', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1531, 4, 4.578503, 0.076688, 0, '2025-05-11 18:24:44.537', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1533, 4, 4.615369, -0.015343, 0, '2025-05-11 18:24:47.597', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1539, 4, 4.610607, -0.015388, 0, '2025-05-11 18:25:02.825', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1552, 2, 6.04186, 0.127366, 0, '2025-05-11 18:25:38.46', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1553, 4, 6.309031, 0.031705, 0, '2025-05-11 18:25:34.828', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1554, 2, 6.04186, 0.127366, 0, '2025-05-11 18:25:39.435', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1555, 4, 6.265415, 0.321566, 0, '2025-05-11 18:25:43.437', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1556, 2, 6.204156, 0.237466, 0, '2025-05-11 18:25:45.043', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1557, 4, 6.265415, 0.321566, 0, '2025-05-11 18:25:44.453', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1558, 2, 6.211798, 0.180901, 0, '2025-05-11 18:25:48.578', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1559, 4, 6.257212, 0.348832, 0, '2025-05-11 18:25:50.5', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1560, 2, 6.235584, 0.037749, 0, '2025-05-11 18:25:56.651', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1561, 4, 6.295002, 0.397953, 0, '2025-05-11 18:25:53.561', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1562, 2, 6.289464, 0.259068, 0, '2025-05-11 18:25:58.676', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1563, 4, 6.473125, 1.021565, 0, '2025-05-11 18:26:03.165', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1564, 2, 6.486828, 2.204894, 0, '2025-05-11 18:26:07.329', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1565, 4, 6.484215, 1.716612, 0, '2025-05-11 18:26:08.199', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1566, 2, 6.486828, 2.204894, 0, '2025-05-11 18:26:07.329', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1567, 4, 6.484215, 1.716612, 0, '2025-05-11 18:26:09.223', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1573, 4, 6.560069, 4.681637, 0, '2025-05-11 18:26:27.469', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1575, 4, 6.190368, 5.130444, 0, '2025-05-11 18:26:30.525', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1576, 2, 6.104401, 5.625879, 0, '2025-05-11 18:26:33.172', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1577, 4, 6.190368, 5.130444, 0, '2025-05-11 18:26:30.525', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1578, 2, 6.011723, 5.990387, 0, '2025-05-11 18:26:35.177', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1579, 4, 5.720255, 6.162489, 0, '2025-05-11 18:26:38.638', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1580, 2, 6.496452, 5.470573, 0, '2025-05-11 18:26:44.241', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1581, 4, 5.677856, 6.161596, 0, '2025-05-11 18:26:44.712', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1583, 4, 6.413564, 3.619429, 0, '2025-05-11 18:26:48.785', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1584, 2, 6.10772, 3.750487, 0, '2025-05-11 18:26:52.873', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1585, 4, 6.057579, 2.463154, 0, '2025-05-11 18:26:55.868', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1586, 2, 6.10772, 3.750487, 0, '2025-05-11 18:26:52.873', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1587, 4, 4.80166, 1.528197, 0, '2025-05-11 18:26:56.888', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1588, 2, 0.418894, 0.850916, 0, '2025-05-11 18:27:02.471', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1589, 4, 3.683733, 0.340773, 0, '2025-05-11 18:27:02.97', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1590, 2, 0.026867, 1.230718, 0, '2025-05-11 18:27:08.543', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1594, 2, 0.04785, 1.631298, 0, '2025-05-11 18:27:20.23', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1596, 2, 0.04785, 1.631298, 0, '2025-05-11 18:27:20.23', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1598, 2, 0.018894, 1.629085, 0, '2025-05-11 18:27:26.781', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1608, 2, 0.156444, 1.185473, 0, '2025-05-11 18:27:48.102', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1609, 4, 0.727189, 1.161535, 0, '2025-05-11 18:27:50.602', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1610, 2, 2.112258, -0.006701, 0, '2025-05-11 18:27:56.723', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1611, 4, 2.094209, 0.420337, 0, '2025-05-11 18:27:52.644', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1618, 2, 1.269194, 0.718397, 0, '2025-05-11 18:28:14.989', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1619, 4, 2.013832, 0.487031, 0, '2025-05-11 18:28:10.911', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1621, 4, 0.304731, 1.536871, 0, '2025-05-11 18:28:20.056', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1630, 2, 0.051337, 1.325696, 0, '2025-05-11 18:28:42.303', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1632, 2, 0.028334, 1.491908, 0, '2025-05-11 18:28:50.925', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1634, 2, 0.028334, 1.491908, 0, '2025-05-11 18:28:51.943', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1636, 2, 0.016452, 1.563206, 0, '2025-05-11 18:28:57.002', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1640, 2, 0.020346, 1.496641, 0, '2025-05-11 18:29:08.658', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1642, 2, 0.065691, 1.435176, 0, '2025-05-11 18:29:10.689', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1643, 4, 1.24689, 0.839801, 0, '2025-05-11 18:29:15.417', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1644, 2, 2.066582, 0.214291, 0, '2025-05-11 18:29:20.263', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1645, 4, 1.24689, 0.839801, 0, '2025-05-11 18:29:15.417', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1646, 2, 2.066582, 0.214291, 0, '2025-05-11 18:29:20.263', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1647, 4, 2.583111, 0.21513, 0, '2025-05-11 18:29:21.471', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1651, 4, 6.288363, 0.289177, 0, '2025-05-11 18:29:33.196', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1652, 2, 6.27484, 0.06761, 0, '2025-05-11 18:29:38.502', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1653, 4, 6.286959, 0.338626, 0, '2025-05-11 18:29:39.215', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1654, 2, 6.273617, 0.088733, 0, '2025-05-11 18:29:44.071', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1655, 4, 6.2953, 0.349602, 0, '2025-05-11 18:29:43.283', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1656, 2, 6.273617, 0.088733, 0, '2025-05-11 18:29:45.094', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1657, 4, 6.2953, 0.349602, 0, '2025-05-11 18:29:43.283', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1658, 2, 6.382189, 0.390061, 0, '2025-05-11 18:29:48.147', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1659, 4, 6.331038, 0.514259, 0, '2025-05-11 18:29:50.856', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1660, 2, 6.505354, 1.518076, 0, '2025-05-11 18:29:57.279', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1661, 4, 6.361973, 0.762077, 0, '2025-05-11 18:29:52.398', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1662, 2, 6.442812, 2.310267, 0, '2025-05-11 18:30:02.909', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1663, 4, 6.445484, 2.028191, 0, '2025-05-11 18:30:02.001', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1664, 2, 6.416597, 2.633657, 0, '2025-05-11 18:30:05.889', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1665, 4, 6.426468, 2.671061, 0, '2025-05-11 18:30:08.056', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1666, 2, 6.416597, 2.633657, 0, '2025-05-11 18:30:05.889', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1667, 4, 6.426468, 2.671061, 0, '2025-05-11 18:30:09.074', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1676, 2, 6.307957, 5.664619, 0, '2025-05-11 18:30:33.301', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1678, 2, 6.307957, 5.664619, 0, '2025-05-11 18:30:34.835', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1679, 4, 6.041827, 6.123003, 0, '2025-05-11 18:30:39.497', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1680, 2, 5.93844, 6.042938, 0, '2025-05-11 18:30:43.999', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1681, 4, 5.990483, 6.1651, 0, '2025-05-11 18:30:45.051', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1682, 2, 5.803964, 6.087397, 0, '2025-05-11 18:30:51.565', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1683, 4, 5.776043, 6.25647, 0, '2025-05-11 18:30:49.169', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1684, 2, 5.784731, 6.099619, 0, '2025-05-11 18:30:53.101', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1685, 4, 5.634601, 6.318518, 0, '2025-05-11 18:30:56.169', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1686, 2, 5.784731, 6.099619, 0, '2025-05-11 18:30:53.101', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1687, 4, 5.565293, 6.309717, 0, '2025-05-11 18:30:57.184', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1688, 2, 5.876505, 6.101931, 0, '2025-05-11 18:31:02.723', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1689, 4, 5.119171, 6.277178, 0, '2025-05-11 18:31:03.245', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1690, 2, 5.876505, 6.101931, 0, '2025-05-11 18:31:08.748', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1691, 4, 5.124092, 6.247335, 0, '2025-05-11 18:31:07.315', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1692, 2, 5.866866, 6.109198, 0, '2025-05-11 18:31:11.29', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1693, 4, 5.349379, 6.253817, 0, '2025-05-11 18:31:15.397', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1694, 2, 5.8205, 6.087725, 0, '2025-05-11 18:31:19.886', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1695, 4, 5.349379, 6.253817, 0, '2025-05-11 18:31:16.415', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1696, 2, 5.8205, 6.087725, 0, '2025-05-11 18:31:20.901', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1697, 4, 5.152026, 6.309925, 0, '2025-05-11 18:31:21.458', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1698, 2, 5.8205, 6.087725, 0, '2025-05-11 18:31:26.955', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1699, 4, 4.746703, 6.549993, 0, '2025-05-11 18:31:25.507', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1700, 2, 5.925691, 6.085384, 0, '2025-05-11 18:31:30.012', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1701, 4, 4.771683, 6.538267, 0, '2025-05-11 18:31:33.64', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1702, 2, 5.872972, 6.085382, 0, '2025-05-11 18:31:39.65', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1703, 4, 4.790484, 6.383803, 0, '2025-05-11 18:31:34.66', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1704, 2, 5.872972, 6.085382, 0, '2025-05-11 18:31:39.65', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1705, 4, 4.963319, 6.322977, 0, '2025-05-11 18:31:44.29', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1706, 2, 5.82397, 6.097292, 0, '2025-05-11 18:31:45.234', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1707, 4, 4.963319, 6.322977, 0, '2025-05-11 18:31:44.29', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1708, 2, 5.784732, 6.094946, 0, '2025-05-11 18:31:48.788', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1709, 4, 5.01914, 6.263092, 0, '2025-05-11 18:31:51.363', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1710, 2, 5.837082, 6.094946, 0, '2025-05-11 18:31:56.858', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1711, 4, 5.026737, 6.248863, 0, '2025-05-11 18:31:53.406', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1712, 2, 5.771681, 6.094946, 0, '2025-05-11 18:32:03.422', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1713, 4, 5.029164, 6.250269, 0, '2025-05-11 18:32:03.008', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1714, 2, 5.758649, 6.094946, 0, '2025-05-11 18:32:07.505', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1715, 4, 4.87417, 6.312893, 0, '2025-05-11 18:32:08.127', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1716, 2, 5.758649, 6.094946, 0, '2025-05-11 18:32:07.505', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1717, 4, 4.87417, 6.312893, 0, '2025-05-11 18:32:09.154', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1718, 2, 5.797795, 6.094948, 0, '2025-05-11 18:32:15.068', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1719, 4, 4.89666, 6.314548, 0, '2025-05-11 18:32:11.707', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1720, 2, 5.797795, 6.094948, 0, '2025-05-11 18:32:16.088', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1721, 4, 5.164361, 6.270969, 0, '2025-05-11 18:32:21.314', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1722, 2, 5.93891, 6.087727, 0, '2025-05-11 18:32:26.23', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1723, 4, 5.275613, 6.261038, 0, '2025-05-11 18:32:26.865', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1724, 2, 5.93891, 6.087727, 0, '2025-05-11 18:32:32.37', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1725, 4, 5.439324, 6.272253, 0, '2025-05-11 18:32:30.941', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1726, 2, 5.925693, 6.087727, 0, '2025-05-11 18:32:33.335', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1727, 4, 5.439324, 6.272253, 0, '2025-05-11 18:32:30.941', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1728, 2, 5.886127, 6.087727, 0, '2025-05-11 18:32:35.889', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1729, 4, 5.766521, 6.250999, 0, '2025-05-11 18:32:39.637', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1730, 2, 5.765439, 6.114122, 0, '2025-05-11 18:32:45.51', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1731, 4, 5.779725, 6.259733, 0, '2025-05-11 18:32:40.613', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1732, 2, 5.801237, 6.104528, 0, '2025-05-11 18:32:51.606', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1733, 4, 5.589563, 6.261625, 0, '2025-05-11 18:32:50.237', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1734, 2, 5.823971, 6.092588, 0, '2025-05-11 18:32:55.17', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1735, 4, 5.648387, 6.23974, 0, '2025-05-11 18:32:55.822', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1736, 2, 5.823971, 6.092588, 0, '2025-05-11 18:32:55.17', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1737, 4, 5.648387, 6.23974, 0, '2025-05-11 18:32:56.797', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1738, 2, 5.840568, 6.099794, 0, '2025-05-11 18:33:02.765', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1739, 4, 5.435513, 6.21559, 0, '2025-05-11 18:32:59.858', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1740, 2, 5.90643, 6.099796, 0, '2025-05-11 18:33:04.789', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1741, 4, 5.125969, 6.230459, 0, '2025-05-11 18:33:09.464', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1742, 2, 5.893225, 6.102169, 0, '2025-05-11 18:33:13.404', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1743, 4, 4.911683, 6.25036, 0, '2025-05-11 18:33:15.514', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1744, 2, 6.00295, 6.111765, 0, '2025-05-11 18:33:19.461', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1745, 4, 4.762841, 6.277557, 0, '2025-05-11 18:33:18.063', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1746, 2, 6.0393, 6.102167, 0, '2025-05-11 18:33:21.496', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1747, 4, 4.762841, 6.277557, 0, '2025-05-11 18:33:18.063', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1748, 2, 6.0393, 6.102167, 0, '2025-05-11 18:33:22.515', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1749, 4, 5.138872, 6.262747, 0, '2025-05-11 18:33:27.286', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1750, 2, 5.946128, 6.10453, 0, '2025-05-11 18:33:32.644', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1751, 4, 5.233987, 6.243053, 0, '2025-05-11 18:33:33.331', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1752, 2, 5.959396, 6.104525, 0, '2025-05-11 18:33:39.249', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1753, 4, 5.383356, 6.230764, 0, '2025-05-11 18:33:36.917', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1754, 2, 5.972672, 6.102169, 0, '2025-05-11 18:33:42.32', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1755, 4, 5.347972, 6.240589, 0, '2025-05-11 18:33:43.995', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1756, 2, 5.972672, 6.102169, 0, '2025-05-11 18:33:42.32', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1757, 4, 5.495001, 6.288864, 0, '2025-05-11 18:33:45.517', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1758, 2, 6.102519, 6.092588, 0, '2025-05-11 18:33:50.989', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1759, 4, 5.495001, 6.288864, 0, '2025-05-11 18:33:46.531', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1760, 2, 6.234048, 5.558001, 0, '2025-05-11 18:33:57.565', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1761, 4, 6.12431, 5.78932, 0, '2025-05-11 18:33:55.697', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1762, 2, 6.247897, 3.994452, 0, '2025-05-11 18:34:00.621', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1764, 2, 5.9353, 0.997725, 0, '2025-05-11 18:34:07.728', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1765, 4, 6.293365, 0.323001, 0, '2025-05-11 18:34:04.748', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1766, 2, 5.809201, 0.368131, 0, '2025-05-11 18:34:09.777', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1767, 4, 6.293365, 0.323001, 0, '2025-05-11 18:34:04.748', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1768, 2, 5.824162, 0.1572, 0, '2025-05-11 18:34:14.852', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1769, 4, 5.93086, 0.02923, 0, '2025-05-11 18:34:14.446', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1770, 2, 5.817274, 0.154023, 0, '2025-05-11 18:34:18.883', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1771, 4, 5.906943, -0.006709, 0, '2025-05-11 18:34:21.53', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1772, 2, 5.746867, 0.125069, 0, '2025-05-11 18:34:27.509', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1774, 2, 5.746867, 0.125069, 0, '2025-05-11 18:34:27.509', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1776, 2, 5.757312, 0.104527, 0, '2025-05-11 18:34:33.053', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1778, 2, 5.763871, 0.187956, 0, '2025-05-11 18:34:37.135', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1780, 2, 5.788333, 0.162695, 0, '2025-05-11 18:34:45.764', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1782, 2, 5.788333, 0.162695, 0, '2025-05-11 18:34:46.785', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1783, 4, 6.262803, 1.07042, 0, '2025-05-11 18:34:51.486', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1784, 2, 5.762527, 0.188344, 0, '2025-05-11 18:34:56.414', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1785, 4, 6.262803, 1.07042, 0, '2025-05-11 18:34:51.486', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1786, 2, 5.762527, 0.188344, 0, '2025-05-11 18:34:56.414', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1787, 4, 6.430915, 2.332222, 0, '2025-05-11 18:34:57.082', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1788, 2, 5.728825, 0.212732, 0, '2025-05-11 18:35:03.483', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1789, 4, 6.407687, 5.74645, 0, '2025-05-11 18:35:00.667', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1790, 2, 5.726022, 0.245633, 0, '2025-05-11 18:35:06.038', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1792, 2, 5.756013, 0.18571, 0, '2025-05-11 18:35:15.69', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1794, 2, 5.756013, 0.18571, 0, '2025-05-11 18:35:15.69', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1796, 2, 5.753364, 0.178275, 0, '2025-05-11 18:35:21.773', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1798, 2, 5.745323, 0.196336, 0, '2025-05-11 18:35:24.825', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1800, 2, 5.751774, 0.209085, 0, '2025-05-11 18:35:32.962', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1802, 2, 5.743548, 0.207207, 0, '2025-05-11 18:35:39.538', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1804, 2, 5.739885, 0.20174, 0, '2025-05-11 18:35:43.095', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1806, 2, 5.739885, 0.20174, 0, '2025-05-11 18:35:43.095', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1808, 2, 5.753363, 0.198398, 0, '2025-05-11 18:35:51.15', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1809, 4, 6.447441, 5.925756, 0, '2025-05-11 18:35:48.279', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1810, 2, 5.753363, 0.198398, 0, '2025-05-11 18:35:52.166', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1811, 4, 6.083504, 5.920351, 0, '2025-05-11 18:35:57.376', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1812, 2, 5.750699, 0.190992, 0, '2025-05-11 18:36:02.301', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1813, 4, 6.257336, 5.920351, 0, '2025-05-11 18:36:02.943', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1814, 2, 5.750699, 0.190992, 0, '2025-05-11 18:36:08.349', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1815, 4, 6.392817, 5.920351, 0, '2025-05-11 18:36:07.022', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1816, 2, 5.742611, 0.199031, 0, '2025-05-11 18:36:09.455', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1817, 4, 6.392817, 5.920351, 0, '2025-05-11 18:36:07.022', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1818, 2, 5.748018, 0.193657, 0, '2025-05-11 18:36:11.442', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1819, 4, 6.516068, 5.923059, 0, '2025-05-11 18:36:15.64', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1820, 2, 5.742611, 0.097658, 0, '2025-05-11 18:36:21.521', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1821, 4, 6.516068, 5.923059, 0, '2025-05-11 18:36:16.659', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1822, 2, 5.731613, -0.02548, 0, '2025-05-11 18:36:27.57', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1823, 4, 6.561913, 5.044428, 0, '2025-05-11 18:36:27.174', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1824, 2, 5.780899, -0.026306, 0, '2025-05-11 18:36:31.184', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1828, 2, 6.043664, 0.281618, 0, '2025-05-11 18:36:39.712', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1830, 2, 6.043664, 0.281618, 0, '2025-05-11 18:36:40.752', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1831, 4, 6.481728, 0.607459, 0, '2025-05-11 18:36:45.162', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1832, 2, 6.477027, 0.638781, 0, '2025-05-11 18:36:50.359', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1834, 2, 6.265268, 0.550291, 0, '2025-05-11 18:36:55.931', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1835, 4, 6.395914, 0.752009, 0, '2025-05-11 18:36:54.905', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1836, 2, 6.265268, 0.550291, 0, '2025-05-11 18:36:56.922', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1837, 4, 6.395914, 0.752009, 0, '2025-05-11 18:36:54.905', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1838, 2, 6.151659, 0.53836, 0, '2025-05-11 18:36:58.948', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1839, 4, 6.113548, 0.594696, 0, '2025-05-11 18:37:03.031', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1840, 2, 6.087265, 0.412589, 0, '2025-05-11 18:37:08.601', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1841, 4, 5.987072, 0.512856, 0, '2025-05-11 18:37:09.092', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1842, 2, 6.087265, 0.412589, 0, '2025-05-11 18:37:15.675', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1843, 4, 5.929677, 0.46765, 0, '2025-05-11 18:37:13.158', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1844, 2, 6.097397, 0.190061, 0, '2025-05-11 18:37:17.69', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1845, 4, 5.96818, 0.46645, 0, '2025-05-11 18:37:20.266', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1846, 2, 6.097397, 0.190061, 0, '2025-05-11 18:37:17.69', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1847, 4, 5.96818, 0.46645, 0, '2025-05-11 18:37:21.289', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1848, 2, 6.276468, 0.697596, 0, '2025-05-11 18:37:26.835', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1849, 4, 6.117096, 0.33481, 0, '2025-05-11 18:37:27.851', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1850, 2, 6.383018, 1.252405, 0, '2025-05-11 18:37:33.934', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1851, 4, 6.218141, 0.595421, 0, '2025-05-11 18:37:31.915', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1852, 2, 6.357305, 2.046237, 0, '2025-05-11 18:37:36.496', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1853, 4, 6.420592, 1.737009, 0, '2025-05-11 18:37:39.024', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1854, 2, 6.550645, 2.725283, 0, '2025-05-11 18:37:44.057', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1855, 4, 6.508725, 2.264069, 0, '2025-05-11 18:37:41.057', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1856, 2, 6.550645, 2.725283, 0, '2025-05-11 18:37:45.069', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1857, 4, 6.508725, 2.264069, 0, '2025-05-11 18:37:41.057', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1862, 2, 6.459539, 5.186022, 0, '2025-05-11 18:38:03.35', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1863, 4, 6.255736, 5.081604, 0, '2025-05-11 18:38:00.321', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1864, 2, 6.013495, 5.619724, 0, '2025-05-11 18:38:05.394', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1865, 4, 5.771008, 5.791061, 0, '2025-05-11 18:38:07.871', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1866, 2, 6.013495, 5.619724, 0, '2025-05-11 18:38:05.394', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1867, 4, 4.983849, 5.701909, 0, '2025-05-11 18:38:09.914', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1868, 2, 5.590484, 5.955307, 0, '2025-05-11 18:38:13.98', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1869, 4, 4.66175, 5.426757, 0, '2025-05-11 18:38:15.447', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1870, 2, 5.491936, 5.994482, 0, '2025-05-11 18:38:21.597', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1871, 4, 4.363327, 5.13429, 0, '2025-05-11 18:38:19.506', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1872, 2, 5.479271, 5.99448, 0, '2025-05-11 18:38:23.623', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1873, 4, 4.048064, 3.784613, 0, '2025-05-11 18:38:27.641', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1874, 2, 5.491936, 5.997252, 0, '2025-05-11 18:38:31.756', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1875, 4, 3.973932, 3.241682, 0, '2025-05-11 18:38:28.661', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1876, 2, 5.491936, 5.997252, 0, '2025-05-11 18:38:33.285', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1877, 4, 3.973932, 3.241682, 0, '2025-05-11 18:38:33.711', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1878, 2, 5.504617, 5.997252, 0, '2025-05-11 18:38:39.369', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1879, 4, 2.544678, 0.924588, 0, '2025-05-11 18:38:37.778', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1880, 2, 5.482342, 6.012285, 0, '2025-05-11 18:38:42.43', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1881, 4, 1.347412, 0.545901, 0, '2025-05-11 18:38:45.363', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1882, 2, 5.495022, 6.015009, 0, '2025-05-11 18:38:51.058', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1883, 4, 1.347412, 0.545901, 0, '2025-05-11 18:38:47.404', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1884, 2, 5.495022, 6.015009, 0, '2025-05-11 18:38:52.08', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1885, 4, 0.504271, 1.947916, 0, '2025-05-11 18:38:55.983', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1886, 2, 5.507719, 6.012281, 0, '2025-05-11 18:38:57.66', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1887, 4, 0.410146, 2.439031, 0, '2025-05-11 18:38:56.995', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1888, 2, 5.495024, 6.012281, 0, '2025-05-11 18:39:01.248', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1889, 4, 0.219179, 3.133786, 0, '2025-05-11 18:39:03.054', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1890, 2, 5.507719, 6.012281, 0, '2025-05-11 18:39:09.86', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1891, 4, 0.084686, 3.20877, 0, '2025-05-11 18:39:06.108', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1892, 2, 5.507719, 6.015009, 0, '2025-05-11 18:39:10.87', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1893, 4, 0.033095, 3.174627, 0, '2025-05-11 18:39:15.744', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1894, 2, 5.520431, 6.012283, 0, '2025-05-11 18:39:20.497', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1895, 4, 0.033095, 3.174627, 0, '2025-05-11 18:39:15.744', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1896, 2, 5.520431, 6.012283, 0, '2025-05-11 18:39:20.497', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1897, 4, 0.04828, 3.152153, 0, '2025-05-11 18:39:21.338', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1898, 2, 5.520431, 6.012283, 0, '2025-05-11 18:39:27.077', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1900, 2, 5.517315, 6.002745, 0, '2025-05-11 18:39:30.168', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1902, 2, 5.517313, 6.005472, 0, '2025-05-11 18:39:39.28', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1904, 2, 5.517313, 6.005472, 0, '2025-05-11 18:39:39.28', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1906, 2, 5.507719, 6.015009, 0, '2025-05-11 18:39:45.342', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1908, 2, 5.507719, 6.015009, 0, '2025-05-11 18:39:49.38', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1910, 2, 5.520429, 6.017717, 0, '2025-05-11 18:39:58.003', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1912, 2, 5.507719, 6.017717, 0, '2025-05-11 18:39:59.021', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1914, 2, 5.517313, 6.010878, 0, '2025-05-11 18:40:08.611', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1916, 2, 5.517313, 6.010878, 0, '2025-05-11 18:40:08.611', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1918, 2, 5.507719, 6.020412, 0, '2025-05-11 18:40:15.213', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1920, 2, 5.517313, 6.010878, 0, '2025-05-11 18:40:18.273', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1922, 2, 5.530023, 6.008181, 0, '2025-05-11 18:40:27.377', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1924, 2, 5.530023, 6.008181, 0, '2025-05-11 18:40:27.377', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1926, 2, 5.530023, 6.008181, 0, '2025-05-11 18:40:33.425', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1928, 2, 5.517313, 6.008184, 0, '2025-05-11 18:40:37.502', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1930, 4, 1.558687, 0.685131, 0, '2025-05-11 18:40:45.943', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1931, 2, 5.517313, 6.008184, 0, '2025-05-11 18:40:52.065', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1932, 4, 2.86944, 2.67439, 0, '2025-05-11 18:40:50.561', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1933, 2, 5.568239, 5.978239, 0, '2025-05-11 18:40:55.106', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1934, 4, 2.86944, 2.67439, 0, '2025-05-11 18:40:56.611', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1935, 2, 5.568239, 5.978239, 0, '2025-05-11 18:40:55.106', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1936, 4, 2.86944, 2.67439, 0, '2025-05-11 18:40:57.62', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1937, 2, 6.289838, 5.029421, 0, '2025-05-11 18:41:03.236', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1938, 4, 6.22735, 4.542665, 0, '2025-05-11 18:40:59.664', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1940, 2, 6.527742, 0.306267, 0, '2025-05-11 18:41:15.55', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1941, 2, 6.542626, 0.291918, 0, '2025-05-11 18:41:19.597', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1942, 4, 6.22735, 4.542665, 0, '2025-05-11 18:40:59.664', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1945, 2, 6.567166, 0.191298, 0, '2025-05-11 18:41:34.035', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1946, 2, 6.386183, 0.211908, 0, '2025-05-11 18:41:39.152', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1947, 2, 6.194478, 0.227543, 0, '2025-05-11 18:41:44.255', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1948, 2, 6.136206, 0.227917, 0, '2025-05-11 18:41:45.276', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1949, 2, 6.397365, 0.17149, 0, '2025-05-11 18:41:51.458', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1951, 2, 6.46311, 1.970963, 0, '2025-05-11 18:42:03.809', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1952, 2, 6.493656, 2.746847, 0, '2025-05-11 18:42:08.447', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1953, 2, 6.493656, 2.746847, 0, '2025-05-11 18:42:09.464', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1955, 2, 6.294356, 5.078627, 0, '2025-05-11 18:42:21.255', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1956, 2, 5.681965, 5.767216, 0, '2025-05-11 18:42:28.023', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1957, 2, 5.291612, 5.791336, 0, '2025-05-11 18:42:32.583', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1958, 2, 5.209194, 5.812519, 0, '2025-05-11 18:42:33.596', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1959, 2, 5.306766, 5.812521, 0, '2025-05-11 18:42:39.787', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1960, 2, 5.267188, 5.803246, 0, '2025-05-11 18:42:45.385', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1961, 2, 5.257857, 5.812521, 0, '2025-05-11 18:42:52.044', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1962, 2, 5.26719, 5.800289, 0, '2025-05-11 18:42:56.176', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1963, 2, 5.26719, 5.800289, 0, '2025-05-11 18:42:57.197', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1964, 2, 5.255, 5.803244, 0, '2025-05-11 18:43:03.414', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1965, 2, 5.255, 5.797321, 0, '2025-05-11 18:43:09.558', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1966, 2, 5.279391, 5.794336, 0, '2025-05-11 18:43:15.687', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1967, 2, 5.279391, 5.794336, 0, '2025-05-11 18:43:19.821', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1968, 2, 5.279394, 5.791334, 0, '2025-05-11 18:43:21.853', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1969, 2, 5.267189, 5.791336, 0, '2025-05-11 18:43:28.002', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1970, 2, 5.267189, 5.791336, 0, '2025-05-11 18:43:33.132', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1971, 2, 5.291612, 5.791336, 0, '2025-05-11 18:43:39.876', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1972, 2, 5.291613, 5.788322, 0, '2025-05-11 18:43:44.48', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1973, 2, 5.291613, 5.788322, 0, '2025-05-11 18:43:45.5', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1974, 2, 5.28871, 6.078327, 0, '2025-05-11 18:43:52.127', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1975, 2, 5.291613, 5.788322, 0, '2025-05-11 18:43:57.793', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1976, 2, 5.279394, 5.791334, 0, '2025-05-11 18:44:03.956', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1977, 2, 5.276505, 5.779062, 0, '2025-05-11 18:44:08.056', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1978, 2, 5.288709, 5.779062, 0, '2025-05-11 18:44:10.122', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1979, 2, 5.300928, 5.776031, 0, '2025-05-11 18:44:15.253', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1980, 2, 5.28871, 5.772985, 0, '2025-05-11 18:44:21.907', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1981, 2, 5.300929, 5.772985, 0, '2025-05-11 18:44:27.62', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1982, 2, 5.313163, 5.772985, 0, '2025-05-11 18:44:32.673', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1983, 2, 5.313163, 5.772985, 0, '2025-05-11 18:44:33.725', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1984, 2, 5.300928, 5.769926, 0, '2025-05-11 18:44:39.869', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1985, 2, 5.31023, 5.760681, 0, '2025-05-11 18:44:46.041', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1986, 2, 5.322465, 5.760679, 0, '2025-05-11 18:44:52.179', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1987, 2, 5.356267, 5.748375, 0, '2025-05-11 18:44:56.291', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1988, 2, 5.356267, 5.748375, 0, '2025-05-11 18:44:57.826', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1989, 2, 5.29801, 5.754509, 0, '2025-05-11 18:45:03.98', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1990, 2, 5.298011, 5.757605, 0, '2025-05-11 18:45:10.156', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1991, 2, 5.285807, 5.757603, 0, '2025-05-11 18:45:15.814', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1992, 2, 5.29801, 5.754509, 0, '2025-05-11 18:45:20.416', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1993, 2, 5.298011, 5.748283, 0, '2025-05-11 18:45:21.973', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1994, 2, 5.285807, 5.751406, 0, '2025-05-11 18:45:28.105', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1995, 2, 5.29801, 5.754509, 0, '2025-05-11 18:45:34.242', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1996, 2, 5.29801, 5.751406, 0, '2025-05-11 18:45:39.381', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1997, 2, 5.310232, 5.754511, 0, '2025-05-11 18:45:44.532', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1998, 2, 5.310232, 5.754511, 0, '2025-05-11 18:45:45.546', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (1999, 2, 5.322464, 5.748283, 0, '2025-05-11 18:45:51.693', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2000, 2, 5.29801, 5.751406, 0, '2025-05-11 18:45:57.886', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2001, 2, 5.298012, 5.745146, 0, '2025-05-11 18:46:04.077', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2002, 2, 5.334716, 5.748281, 0, '2025-05-11 18:46:08.15', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2003, 2, 5.356268, 5.742174, 0, '2025-05-11 18:46:10.192', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2007, 4, 3.491936, 5.84513, 0, '2025-05-11 18:46:27.112', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2008, 2, 5.319516, 5.739054, 0, '2025-05-11 18:46:32.074', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2009, 4, 3.423318, 5.834085, 0, '2025-05-11 18:46:32.655', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2010, 2, 5.319516, 5.739054, 0, '2025-05-11 18:46:32.074', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2011, 4, 3.423318, 5.834085, 0, '2025-05-11 18:46:33.686', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2012, 2, 5.298011, 5.748283, 0, '2025-05-11 18:46:40.185', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2013, 4, 3.604494, 5.759091, 0, '2025-05-11 18:46:36.794', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2014, 2, 5.307296, 5.739054, 0, '2025-05-11 18:46:41.715', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2015, 4, 3.825699, 5.608283, 0, '2025-05-11 18:46:45.868', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2016, 2, 5.356267, 5.735916, 0, '2025-05-11 18:46:51.349', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2017, 4, 3.887958, 5.619467, 0, '2025-05-11 18:46:51.931', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2018, 2, 5.356267, 5.735916, 0, '2025-05-11 18:46:56.4', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2019, 4, 4.16977, 5.673167, 0, '2025-05-11 18:46:55.995', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2020, 2, 5.356267, 5.735916, 0, '2025-05-11 18:46:57.941', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2021, 4, 4.16977, 5.673167, 0, '2025-05-11 18:46:55.995', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2022, 2, 5.368547, 5.735918, 0, '2025-05-11 18:47:00.5', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2023, 4, 4.296597, 5.34974, 0, '2025-05-11 18:47:03.609', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2024, 2, 5.383871, 5.757603, 0, '2025-05-11 18:47:09.117', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2025, 4, 4.348271, 5.47913, 0, '2025-05-11 18:47:10.163', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2026, 2, 4.36222, 5.739917, 0, '2025-05-11 18:47:16.204', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2027, 4, 4.142741, 5.66639, 0, '2025-05-11 18:47:14.266', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2028, 2, 4.175714, 5.308587, 0, '2025-05-11 18:47:18.706', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2029, 4, 4.054171, 5.634694, 0, '2025-05-11 18:47:20.345', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2030, 2, 4.175714, 5.308587, 0, '2025-05-11 18:47:18.706', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2031, 4, 4.047626, 4.648498, 0, '2025-05-11 18:47:21.87', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2032, 2, 4.050831, 4.628091, 0, '2025-05-11 18:47:25.79', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2033, 4, 4.047626, 4.648498, 0, '2025-05-11 18:47:23.407', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2034, 4, 4.120323, 3.544771, 0, '2025-05-11 18:47:40.043', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2035, 2, 4.050831, 4.628091, 0, '2025-05-11 18:47:25.79', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2040, 4, 6.518632, 0.532246, 0, '2025-05-11 18:48:04.118', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2043, 4, 6.498503, 1.460505, 0, '2025-05-11 18:48:15.399', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2044, 4, 6.317787, 2.603163, 0, '2025-05-11 18:48:22.028', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2048, 4, 5.532904, 6.23333, 0, '2025-05-11 18:48:39.928', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2049, 4, 5.545378, 6.208626, 0, '2025-05-11 18:48:46.08', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2050, 4, 4.464071, 5.396183, 0, '2025-05-11 18:48:52.244', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2051, 4, 3.93629, 3.562871, 0, '2025-05-11 18:48:56.354', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2052, 4, 3.835669, 2.456535, 0, '2025-05-11 18:48:58.439', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2053, 4, 2.507104, 0.536459, 0, '2025-05-11 18:49:03.465', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2054, 4, 1.084647, 0.346412, 0, '2025-05-11 18:49:10.132', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2055, 4, 0.421782, 3.210694, 0, '2025-05-11 18:49:15.772', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2056, 4, 0.404287, 4.31561, 0, '2025-05-11 18:49:20.401', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2057, 4, 0.360254, 4.35897, 0, '2025-05-11 18:49:22.464', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2058, 4, 0.330907, 4.387558, 0, '2025-05-11 18:49:28.092', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2059, 4, 0.327159, 4.414298, 0, '2025-05-11 18:49:34.228', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2060, 4, 0.347842, 4.121084, 0, '2025-05-11 18:49:40.372', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2061, 4, 0.336291, 3.491794, 0, '2025-05-11 18:49:43.982', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2062, 4, 0.336291, 3.491794, 0, '2025-05-11 18:49:46.065', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2063, 4, 0.291929, 3.275, 0, '2025-05-11 18:49:51.167', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2064, 4, 0.163756, 2.155916, 0, '2025-05-11 18:49:57.839', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2065, 4, 1.655162, 0.000946, 0, '2025-05-11 18:50:04.473', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2066, 4, 3.727258, 1.582916, 0, '2025-05-11 18:50:08.579', 'daily');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2067, 4, 4.042289, 3.717923, 0, '2025-05-11 18:50:09.596', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2068, 4, 3.616559, 5.763427, 0, '2025-05-11 18:50:16.223', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2069, 4, 3.512103, 5.650878, 0, '2025-05-11 18:50:22.351', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2070, 4, 0.273979, 5.18145, 0, '2025-05-11 18:50:27.452', 'hourly');
INSERT INTO public.device_location OVERRIDING SYSTEM VALUE VALUES (2071, 4, 0.273979, 5.18145, 0, '2025-05-11 18:50:27.452', 'daily');


--
-- TOC entry 4909 (class 0 OID 24590)
-- Dependencies: 220
-- Data for Name: device_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.device_type OVERRIDING SYSTEM VALUE VALUES (1, 'uwb unit');


--
-- TOC entry 4917 (class 0 OID 24679)
-- Dependencies: 228
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.notification VALUES (1, 'Bạn có yêu cầu mượn thiết bị mới', '2024-05-13 15:00:00', 'warning', false, 2);
INSERT INTO public.notification VALUES (2, 'Bạn có yêu cầu mượn thiết bị mới', '2024-05-13 15:00:00', 'warning', false, 2);
INSERT INTO public.notification VALUES (3, 'Cập nhật yêu cầu mượn', '2025-05-13 10:34:38.643', 'update', false, 2);
INSERT INTO public.notification VALUES (4, 'Cập nhật yêu cầu mượn', '2025-05-13 10:35:05.929', 'update', false, 2);
INSERT INTO public.notification VALUES (5, 'Cập nhật yêu cầu mượn', '2025-05-13 10:35:26.6', 'update', false, 2);
INSERT INTO public.notification VALUES (6, 'Cập nhật yêu cầu mượn', '2025-05-13 10:35:44.242', 'update', false, 2);
INSERT INTO public.notification VALUES (7, 'Cập nhật yêu cầu mượn', '2025-05-13 10:37:48.775', 'update', false, 2);
INSERT INTO public.notification VALUES (8, 'Cập nhật yêu cầu mượn', '2025-05-13 10:40:21.911', 'update', false, 2);
INSERT INTO public.notification VALUES (9, 'Cập nhật yêu cầu ngày mượn (Request ID: 5)', '2025-05-13 10:49:32.063', 'update', false, 2);
INSERT INTO public.notification VALUES (10, 'Cập nhật yêu cầu ngày mượn (Request ID: 5)', '2025-05-13 10:49:32.065', 'update', false, 1);
INSERT INTO public.notification VALUES (11, 'Cập nhật yêu cầu ngày mượn (Request ID: 22)', '2025-05-13 10:51:16.55', 'update', false, 2);
INSERT INTO public.notification VALUES (12, 'Cập nhật yêu cầu ngày mượn (Request ID: 22)', '2025-05-13 10:51:16.552', 'update', false, 3);
INSERT INTO public.notification VALUES (13, 'Duyệt yêu cầu mượn (Request ID: 23)', '2025-05-13 11:09:52.308', 'update', false, 2);
INSERT INTO public.notification VALUES (14, 'Yêu cầu đã được duyệt (Request ID: 23)', '2025-05-13 11:09:52.31', 'update', false, 3);
INSERT INTO public.notification VALUES (15, 'Từ chối yêu cầu mượn (Request ID: 24)', '2025-05-13 11:11:21.098', 'update', false, 2);
INSERT INTO public.notification VALUES (16, 'Yêu cầu bị từ chối (Request ID: 24)', '2025-05-13 11:11:21.099', 'update', false, 3);
INSERT INTO public.notification VALUES (17, 'Duyệt yêu cầu mượn (Request ID: 23)', '2025-05-13 11:11:50.542', 'update', false, 2);
INSERT INTO public.notification VALUES (18, 'Yêu cầu đã được duyệt (Request ID: 23)', '2025-05-13 11:11:50.544', 'update', false, 3);
INSERT INTO public.notification VALUES (19, 'Cập nhật ngày mượn (Request ID: 23)', '2025-05-13 11:11:56.687', 'update', false, 2);
INSERT INTO public.notification VALUES (20, 'Cập nhật ngày mượn (Request ID: 23)', '2025-05-13 11:11:56.687', 'update', false, 3);
INSERT INTO public.notification VALUES (21, 'Cập nhật ngày trả (Request ID: 23)', '2025-05-13 11:12:04.302', 'update', false, NULL);
INSERT INTO public.notification VALUES (22, 'Cập nhật ngày trả (Request ID: 23)', '2025-05-13 11:12:04.303', 'update', false, 3);
INSERT INTO public.notification VALUES (23, 'Cập nhật ngày trả (Request ID: 5)', '2025-05-13 11:13:27.529', 'update', false, NULL);
INSERT INTO public.notification VALUES (24, 'Cập nhật ngày trả (Request ID: 5)', '2025-05-13 11:13:27.53', 'update', false, 1);
INSERT INTO public.notification VALUES (25, 'Duyệt yêu cầu mượn (Request ID: 22)', '2025-05-13 11:15:22.244', 'update', false, 2);
INSERT INTO public.notification VALUES (26, 'Yêu cầu đã được duyệt (Request ID: 22)', '2025-05-13 11:15:22.246', 'update', false, 3);
INSERT INTO public.notification VALUES (27, 'Cập nhật ngày mượn (Request ID: 22)', '2025-05-13 11:15:27.447', 'update', false, 2);
INSERT INTO public.notification VALUES (28, 'Cập nhật ngày mượn (Request ID: 22)', '2025-05-13 11:15:27.447', 'update', false, 3);
INSERT INTO public.notification VALUES (29, 'Cập nhật ngày trả (Request ID: 22)', '2025-05-13 11:15:31.996', 'update', false, NULL);
INSERT INTO public.notification VALUES (30, 'Cập nhật ngày trả (Request ID: 22)', '2025-05-13 11:15:31.996', 'update', false, 3);
INSERT INTO public.notification VALUES (31, 'Duyệt yêu cầu mượn (Request ID: 21)', '2025-05-13 11:18:50.82', 'update', false, 2);
INSERT INTO public.notification VALUES (32, 'Yêu cầu đã được duyệt (Request ID: 21)', '2025-05-13 11:18:50.822', 'update', false, 3);
INSERT INTO public.notification VALUES (33, 'Cập nhật ngày mượn (Request ID: 21)', '2025-05-13 11:18:55.046', 'update', false, 2);
INSERT INTO public.notification VALUES (34, 'Cập nhật ngày mượn (Request ID: 21)', '2025-05-13 11:18:55.046', 'update', false, 3);
INSERT INTO public.notification VALUES (35, 'Cập nhật ngày trả (Request ID: 21)', '2025-05-13 11:18:59.332', 'update', false, 2);
INSERT INTO public.notification VALUES (36, 'Cập nhật ngày trả (Request ID: 21)', '2025-05-13 11:18:59.332', 'update', false, 3);
INSERT INTO public.notification VALUES (37, 'Duyệt yêu cầu mượn (Request ID: 21)', '2025-05-13 13:33:47.172', 'update', false, 2);
INSERT INTO public.notification VALUES (38, 'Yêu cầu đã được duyệt (Request ID: 21)', '2025-05-13 13:33:47.174', 'update', false, 3);
INSERT INTO public.notification VALUES (39, 'Duyệt yêu cầu mượn (Request ID: 26)', '2025-05-13 16:31:12.509', 'update', false, 2);
INSERT INTO public.notification VALUES (40, 'Yêu cầu đã được duyệt (Request ID: 26)', '2025-05-13 16:31:12.513', 'update', false, 3);
INSERT INTO public.notification VALUES (41, 'Cập nhật ngày mượn (Request ID: 26)', '2025-05-13 16:31:28.328', 'update', false, 2);
INSERT INTO public.notification VALUES (42, 'Cập nhật ngày mượn (Request ID: 26)', '2025-05-13 16:31:28.33', 'update', false, 3);
INSERT INTO public.notification VALUES (43, 'Cập nhật ngày trả (Request ID: 26)', '2025-05-13 16:32:06.746', 'update', false, 2);
INSERT INTO public.notification VALUES (44, 'Cập nhật ngày trả (Request ID: 26)', '2025-05-13 16:32:06.748', 'update', false, 3);
INSERT INTO public.notification VALUES (45, 'Từ chối yêu cầu mượn (Request ID: 20)', '2025-05-13 16:32:31.68', 'update', false, 2);
INSERT INTO public.notification VALUES (46, 'Yêu cầu bị từ chối (Request ID: 20)', '2025-05-13 16:32:31.683', 'update', false, 3);


--
-- TOC entry 4923 (class 0 OID 40972)
-- Dependencies: 234
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.room VALUES (1, 50, 50);


--
-- TOC entry 4907 (class 0 OID 24581)
-- Dependencies: 218
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" OVERRIDING SYSTEM VALUE VALUES (2, 'user@example.com', '$2b$10$vLJWndRrgEOiXZy8dq0VKeW.XG7xfq68uvPFwxE3vwe5O5i5khEkW', 'Nguyễn Văn A', '0901234565', 'admin', 'active');
INSERT INTO public."user" OVERRIDING SYSTEM VALUE VALUES (4, 'duyen.le@gmail.com', '$2b$10$JwzexNHfqhsUJktDb31lbuO3CXBUPbIfQ7oA2DG/FlPfrEW9HIlc2', 'Lê Thị Kỳ Duyên', '0912312312', 'client', 'active');
INSERT INTO public."user" OVERRIDING SYSTEM VALUE VALUES (5, 'user3@ex.com', '$2b$10$Nr0lhSwq48j4vibbnDn8b.ZvXFcRn50rQE5DMNxGTnyqgLHFBureO', 'Nguyễn Văn C', '0939999999', 'client', 'active');
INSERT INTO public."user" OVERRIDING SYSTEM VALUE VALUES (1, 'hochianhkhoi2003@gmail.com', '$2b$10$PkROnr0Ot8zqtgI/Y/3gPeqUVfH6PoqQ6M7kiEffgbjypMYoU/uy2', 'Hồ Chí Anh Khô', '0939406884', 'admin', 'active');
INSERT INTO public."user" OVERRIDING SYSTEM VALUE VALUES (6, 'khoi@gmail.com', '$2b$10$ErwgsIk.ACheiUlDOyLoAu3Sdblr5ss2u4vKKmsB5G.0CQQ9Dl/vq', 'khoio', '0939406884', 'client', 'active');
INSERT INTO public."user" OVERRIDING SYSTEM VALUE VALUES (3, 'user2@example.com', '$2b$10$OQfklzvIe5nRjsRvp3BRLOapQCbsY2WTnfJKOINiV.QJAkgAtt3ey', 'Nguyễn Văn B', '0901234567', 'client', 'active');


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 235
-- Name: anchor_location_anchorrec_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.anchor_location_anchorrec_id_seq1', 4, true);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 223
-- Name: borrow_request_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.borrow_request_request_id_seq', 1, false);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 232
-- Name: borrow_request_request_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.borrow_request_request_id_seq1', 27, true);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 221
-- Name: device_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.device_device_id_seq', 1, true);


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 225
-- Name: device_location_devicerec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.device_location_devicerec_id_seq', 1, false);


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 229
-- Name: device_location_devicerec_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.device_location_devicerec_id_seq1', 2071, true);


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 219
-- Name: device_type_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.device_type_type_id_seq', 1, false);


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 230
-- Name: device_type_type_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.device_type_type_id_seq1', 1, false);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 227
-- Name: notification_notify_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_notify_id_seq', 46, true);


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 233
-- Name: room_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_room_id_seq', 1, false);


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_user_id_seq', 1, false);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 231
-- Name: user_user_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_user_id_seq1', 6, true);


--
-- TOC entry 4753 (class 2606 OID 41009)
-- Name: anchor_location anchor_location_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anchor_location
    ADD CONSTRAINT anchor_location_pkey1 PRIMARY KEY (anchorrec_id);


--
-- TOC entry 4745 (class 2606 OID 24618)
-- Name: borrow_request borrow_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_request
    ADD CONSTRAINT borrow_request_pkey PRIMARY KEY (request_id);


--
-- TOC entry 4747 (class 2606 OID 24652)
-- Name: device_location device_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_location
    ADD CONSTRAINT device_location_pkey PRIMARY KEY (devicerec_id);


--
-- TOC entry 4743 (class 2606 OID 24604)
-- Name: device device_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (device_id);


--
-- TOC entry 4741 (class 2606 OID 24595)
-- Name: device_type device_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_type
    ADD CONSTRAINT device_type_pkey PRIMARY KEY (type_id);


--
-- TOC entry 4749 (class 2606 OID 24686)
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (notify_id);


--
-- TOC entry 4751 (class 2606 OID 40977)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);


--
-- TOC entry 4739 (class 2606 OID 24588)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4760 (class 2606 OID 41010)
-- Name: anchor_location anchor_location_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anchor_location
    ADD CONSTRAINT anchor_location_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id);


--
-- TOC entry 4756 (class 2606 OID 24619)
-- Name: borrow_request borrow_request_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_request
    ADD CONSTRAINT borrow_request_client_id_fkey FOREIGN KEY (client_id) REFERENCES public."user"(user_id);


--
-- TOC entry 4757 (class 2606 OID 40966)
-- Name: borrow_request borrow_request_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_request
    ADD CONSTRAINT borrow_request_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.device(device_id);


--
-- TOC entry 4758 (class 2606 OID 24653)
-- Name: device_location device_location_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_location
    ADD CONSTRAINT device_location_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.device(device_id);


--
-- TOC entry 4754 (class 2606 OID 41020)
-- Name: device device_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id);


--
-- TOC entry 4755 (class 2606 OID 24605)
-- Name: device device_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.device_type(type_id);


--
-- TOC entry 4759 (class 2606 OID 24687)
-- Name: notification notification_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


-- Completed on 2025-05-19 17:09:48

--
-- PostgreSQL database dump complete
--

