-- SQL Manager for PostgreSQL 5.9.4.51539
-- ---------------------------------------
-- Host      : 172.16.0.203
-- Database  : dvg_sso_global
-- Version   : PostgreSQL 10.5 on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, 64-bit



SET check_function_bodies = false;
--
-- Definition for function userclient_getbyusername (OID = 91850) :
--
SET search_path = public, pg_catalog;
CREATE FUNCTION public.userclient_getbyusername (
  _username character varying
)
RETURNS TABLE (
  id integer,
  username character varying,
  useridclient character varying,
  clientid integer,
  islogin boolean
)
AS
$body$
BEGIN
  RETURN QUERY
  SELECT uc.id,
  		 uc.username,
         uc.useridclient,
         uc.clientid,
         uc.islogin
  FROM  public.userclient uc
  WHERE uc.username = _username;
END;
$body$
LANGUAGE plpgsql;
--
-- Definition for function userclientid_getbyusernameanddomain (OID = 91862) :
--
CREATE FUNCTION public.userclientid_getbyusernameanddomain (
  _username character varying,
  _domain character varying
)
RETURNS TABLE (
  userid integer,
  username character varying,
  useridclient character varying,
  domain character varying,
  token character varying
)
AS
$body$
BEGIN
  RETURN QUERY
  SELECT uc.userid,
  		 uc.username,
         uc.useridclient,
         uc.domain,
         uc.token
  FROM  public.userclientid uc
  WHERE uc.username = _username AND uc.domain = _domain;
END;
$body$
LANGUAGE plpgsql;
--
-- Definition for function userclient_getbyusernameandclientid (OID = 91864) :
--
CREATE FUNCTION public.userclient_getbyusernameandclientid (
  _username character varying,
  _clientid integer
)
RETURNS TABLE (
  id integer,
  username character varying,
  useridclient character varying,
  clientid integer,
  islogin boolean
)
AS
$body$
BEGIN
  RETURN QUERY
  SELECT uc.id,
  		 uc.username,
         uc.useridclient,
         uc.clientid,
         uc.islogin
  FROM  public.userclient uc
  WHERE uc.username = _username AND uc.clientid = _clientid;
END;
$body$
LANGUAGE plpgsql;
--
-- Definition for function membership_getlistbysecurity (OID = 91885) :
--
CREATE FUNCTION public.membership_getlistbysecurity (
  _username character varying,
  _password character varying
)
RETURNS TABLE (
  id integer,
  username character varying,
  displayname character varying,
  loweredusername character varying,
  password character varying,
  hashcode character varying,
  email character varying,
  location integer,
  isapproved boolean,
  islockedout boolean
)
AS
$body$
BEGIN
  RETURN QUERY
  SELECT m.id,
  		 m.username,
         m.displayname,
         m.loweredusername,
         m.password,
         m.hashcode,
         m.email,
         m.location,
         m.isapproved,
         m.islockedout
  FROM  public.membership m
  WHERE m.username = _username and m.password = _password;
END;
$body$
LANGUAGE plpgsql;
--
-- Definition for function membership_getlistbyusername (OID = 91887) :
--
CREATE FUNCTION public.membership_getlistbyusername (
  _username character varying
)
RETURNS TABLE (
  id integer,
  username character varying,
  displayname character varying,
  loweredusername character varying,
  password character varying,
  hashcode character varying,
  email character varying,
  location integer,
  isapproved boolean,
  islockedout boolean
)
AS
$body$
BEGIN
  RETURN QUERY
  SELECT m.id,
  		 m.username,
         m.displayname,
         m.loweredusername,
         m.password,
         m.hashcode,
         m.email,
         m.location,
         m.isapproved,
         m.islockedout
  FROM  public.membership m
  WHERE m.username = _username;
END;
$body$
LANGUAGE plpgsql;
--
-- Structure for table client (OID = 91380) :
--
CREATE TABLE public.client (
    id integer NOT NULL,
    name varchar(256) NOT NULL,
    title varchar(256) NOT NULL,
    domain varchar,
    active boolean,
    type varchar(10),
    token varchar(50)
)
WITH (oids = false);
--
-- Structure for table membership (OID = 91388) :
--
CREATE TABLE public.membership (
    id integer NOT NULL,
    username varchar(256) NOT NULL,
    displayname varchar(256),
    password varchar(256) NOT NULL,
    hashcode varchar(256) NOT NULL,
    email varchar(256) NOT NULL,
    location integer NOT NULL,
    isapproved boolean,
    islockedout boolean,
    loweredusername varchar(256)
)
WITH (oids = false);
--
-- Structure for table userclient (OID = 91396) :
--
CREATE TABLE public.userclient (
    id integer NOT NULL,
    username varchar(256) NOT NULL,
    useridclient varchar(256) NOT NULL,
    clientid integer NOT NULL,
    islogin boolean
)
WITH (oids = false);
--
-- Definition for view userclientid (OID = 91857) :
--
CREATE VIEW public.userclientid
AS
SELECT b.id AS userid,
    a.username,
    a.useridclient,
    c.domain,
    c.token
FROM ((userclient a
     LEFT JOIN membership b ON (((a.username)::text = (b.username)::text)))
     LEFT JOIN client c ON ((a.clientid = c.id)));

--
-- Data for table public.client (OID = 91380) (LIMIT 0,6)
--
INSERT INTO client (id, name, title, domain, active, type, token)
VALUES (44, 'BCRM CĐT BĐS', 'BCRM CĐT BĐS', 'cdt.daivietgroup.net:8668', true, NULL, 'tnLjwPNzfF');

INSERT INTO client (id, name, title, domain, active, type, token)
VALUES (8, 'BCRM BĐS - Phần mềm BCRM của batdongsan.com.vn', 'BCRM BĐS - Phần mềm BCRM của batdongsan.com.vn', 'bcrm.daivietgroup.net', true, NULL, 'xA34vpoLmc');

INSERT INTO client (id, name, title, domain, active, type, token)
VALUES (1, 'HRM - Phần mềm quản lý nhân sự', 'HRM - Phần mềm quản lý nhân sự', NULL, true, NULL, NULL);

INSERT INTO client (id, name, title, domain, active, type, token)
VALUES (15, 'Candidate Management - Phần mềm quản lý ứng viên', 'Candidate Management - Phần mềm quản lý ứng viên', '172.16.0.68:1368', true, NULL, '332NJFDS!@#65');

INSERT INTO client (id, name, title, domain, active, type, token)
VALUES (5, 'Email', 'Email', NULL, true, NULL, NULL);

INSERT INTO client (id, name, title, domain, active, type, token)
VALUES (3, 'Information Checking System', 'Information Checking System', NULL, true, NULL, 'x7FOrpASlR');

--
-- Data for table public.membership (OID = 91388) (LIMIT 0,2)
--
INSERT INTO membership (id, username, displayname, password, hashcode, email, location, isapproved, islockedout, loweredusername)
VALUES (1, 'admin', 'admin', '14e1b600b1fd579f47433b88e8d85291', 'e3e14cd9a386d7461a5209073a5b7811', 'quantri@mvc.com', 1, true, NULL, NULL);

INSERT INTO membership (id, username, displayname, password, hashcode, email, location, isapproved, islockedout, loweredusername)
VALUES (2, 'anhnq', 'anhnq', '14e1b600b1fd579f47433b88e8d85291', '6ac0a2ff13b99201d9b75c1e7b98a0ed', 'anhnq@gmail.com', 1, true, NULL, NULL);

--
-- Data for table public.userclient (OID = 91396) (LIMIT 0,7)
--
INSERT INTO userclient (id, username, useridclient, clientid, islogin)
VALUES (1, 'admin', 'admin', 1, true);

INSERT INTO userclient (id, username, useridclient, clientid, islogin)
VALUES (7, 'anhnq', 'AnhNQ', 44, true);

INSERT INTO userclient (id, username, useridclient, clientid, islogin)
VALUES (6, 'anhnq', 'AnhNQ', 8, true);

INSERT INTO userclient (id, username, useridclient, clientid, islogin)
VALUES (5, 'anhnq', 'AnhNQ', 1, true);

INSERT INTO userclient (id, username, useridclient, clientid, islogin)
VALUES (4, 'anhnq', 'AnhNQ', 15, true);

INSERT INTO userclient (id, username, useridclient, clientid, islogin)
VALUES (3, 'anhnq', 'AnhNQ@daivietgroup.net.vn', 5, true);

INSERT INTO userclient (id, username, useridclient, clientid, islogin)
VALUES (2, 'anhnq', 'AnhNQ', 3, true);

--
-- Definition for index client_pkey (OID = 91386) :
--
ALTER TABLE ONLY client
    ADD CONSTRAINT client_pkey
    PRIMARY KEY (id);
--
-- Definition for index membership_pkey (OID = 91394) :
--
ALTER TABLE ONLY membership
    ADD CONSTRAINT membership_pkey
    PRIMARY KEY (id);
--
-- Definition for index userclient_pkey (OID = 91402) :
--
ALTER TABLE ONLY userclient
    ADD CONSTRAINT userclient_pkey
    PRIMARY KEY (id);
--
-- Comments
--
COMMENT ON SCHEMA public IS 'standard public schema';
