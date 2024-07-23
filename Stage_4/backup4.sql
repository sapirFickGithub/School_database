prompt PL/SQL Developer import file
prompt Created on Tuesday, July 23, 2024 by dasst
set feedback off
set define off
prompt Creating AGE_GROUP...
create table AGE_GROUP
(
  age_id   NUMBER(5) not null,
  minage   NUMBER(5),
  maxage   NUMBER(5),
  descript VARCHAR2(15)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AGE_GROUP
  add primary key (AGE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CITY...
create table CITY
(
  city_num  NUMBER(5) not null,
  city_name VARCHAR2(15)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CITY
  add primary key (CITY_NUM)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CITY
  add unique (CITY_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TEACHERS...
create table TEACHERS
(
  teacher_id        NUMBER(5) not null,
  teacher_fname     VARCHAR2(15),
  teacher_lname     VARCHAR2(15),
  teacher_addr      NUMBER(5),
  teacher_tel       NUMBER(5),
  teacher_salary    NUMBER(5) default 0,
  teacher_join_date DATE,
  bonus             NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TEACHERS
  add primary key (TEACHER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TEACHERS
  add foreign key (TEACHER_ADDR)
  references CITY (CITY_NUM);

prompt Creating CLASS_...
create table CLASS_
(
  class_id   NUMBER(3) not null,
  grade      NUMBER(2) not null,
  teacher_id NUMBER(3) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLASS_
  add primary key (CLASS_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLASS_
  add foreign key (TEACHER_ID)
  references TEACHERS (TEACHER_ID);

prompt Creating CLIENTS...
create table CLIENTS
(
  client_id      NUMBER(5) not null,
  client_fname   VARCHAR2(15),
  client_lname   VARCHAR2(15),
  client_addr    NUMBER(5),
  client_tel     NUMBER not null,
  client_payment NUMBER(5),
  birthday       DATE,
  father_name    VARCHAR2(15),
  mother_name    VARCHAR2(15),
  class_id       NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLIENTS
  add primary key (CLIENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLIENTS
  add foreign key (CLIENT_ADDR)
  references CITY (CITY_NUM);

prompt Creating GROUPS_...
create table GROUPS_
(
  group_id NUMBER(5) not null,
  amount   NUMBER(5),
  age_id   NUMBER(5)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GROUPS_
  add primary key (GROUP_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GROUPS_
  add foreign key (AGE_ID)
  references AGE_GROUP (AGE_ID);

prompt Creating PARTICIPATE...
create table PARTICIPATE
(
  group_id  NUMBER(5) not null,
  client_id NUMBER(5) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PARTICIPATE
  add primary key (GROUP_ID, CLIENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PARTICIPATE
  add foreign key (GROUP_ID)
  references GROUPS_ (GROUP_ID);
alter table PARTICIPATE
  add foreign key (CLIENT_ID)
  references CLIENTS (CLIENT_ID);

prompt Creating ROOMS...
create table ROOMS
(
  room_id                NUMBER(5) not null,
  room_floor             NUMBER(5),
  isstudio               CHAR(1),
  room_capacity          NUMBER(5),
  is_lab                 NUMBER(1),
  last_maintenance_check DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOMS
  add primary key (ROOM_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOMS
  add constraint BOOLEAN_ISSTUDIO
  check (isStudio IN ('T', 'F'));
alter table ROOMS
  add check (isStudio IN ('T', 'F'));

prompt Creating WORKSHOPS...
create table WORKSHOPS
(
  workshop_id       NUMBER(5) not null,
  workshop_name     VARCHAR2(30),
  workshop_price    NUMBER(5),
  workshop_hours    NUMBER(5),
  workshop_capacity NUMBER(5),
  mandatory         NUMBER(1) default 0
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WORKSHOPS
  add primary key (WORKSHOP_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SCHEDULER...
create table SCHEDULER
(
  sc_time      NUMBER(5),
  sc_day       NUMBER(5),
  scheduler_id NUMBER(5) not null,
  group_id     NUMBER(5),
  workshop_id  NUMBER(5),
  room_id      NUMBER(5),
  teacher_id   NUMBER(5),
  class_id     NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index UNIQUE_DAY_HOUR_ROOM on SCHEDULER (SC_DAY, SC_TIME, NVL(ROOM_ID,TO_NUMBER(TO_CHAR(SCHEDULER_ID))))
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCHEDULER
  add unique (SC_DAY, SC_TIME, TEACHER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCHEDULER
  add constraint FK_CLASS_ foreign key (CLASS_ID)
  references CLASS_ (CLASS_ID);
alter table SCHEDULER
  add foreign key (GROUP_ID)
  references GROUPS_ (GROUP_ID);
alter table SCHEDULER
  add foreign key (WORKSHOP_ID)
  references WORKSHOPS (WORKSHOP_ID);
alter table SCHEDULER
  add foreign key (ROOM_ID)
  references ROOMS (ROOM_ID);
alter table SCHEDULER
  add foreign key (TEACHER_ID)
  references TEACHERS (TEACHER_ID);
alter table SCHEDULER
  add check (sc_time BETWEEN 6 AND 24);
alter table SCHEDULER
  add check (sc_day BETWEEN 1 AND 7);

prompt Disabling triggers for AGE_GROUP...
alter table AGE_GROUP disable all triggers;
prompt Disabling triggers for CITY...
alter table CITY disable all triggers;
prompt Disabling triggers for TEACHERS...
alter table TEACHERS disable all triggers;
prompt Disabling triggers for CLASS_...
alter table CLASS_ disable all triggers;
prompt Disabling triggers for CLIENTS...
alter table CLIENTS disable all triggers;
prompt Disabling triggers for GROUPS_...
alter table GROUPS_ disable all triggers;
prompt Disabling triggers for PARTICIPATE...
alter table PARTICIPATE disable all triggers;
prompt Disabling triggers for ROOMS...
alter table ROOMS disable all triggers;
prompt Disabling triggers for WORKSHOPS...
alter table WORKSHOPS disable all triggers;
prompt Disabling triggers for SCHEDULER...
alter table SCHEDULER disable all triggers;
prompt Disabling foreign key constraints for TEACHERS...
alter table TEACHERS disable constraint SYS_C007695;
prompt Disabling foreign key constraints for CLASS_...
alter table CLASS_ disable constraint SYS_C007538;
prompt Disabling foreign key constraints for CLIENTS...
alter table CLIENTS disable constraint SYS_C007680;
prompt Disabling foreign key constraints for GROUPS_...
alter table GROUPS_ disable constraint SYS_C007683;
prompt Disabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE disable constraint SYS_C007687;
alter table PARTICIPATE disable constraint SYS_C007688;
prompt Disabling foreign key constraints for SCHEDULER...
alter table SCHEDULER disable constraint FK_CLASS_;
alter table SCHEDULER disable constraint SYS_C007701;
alter table SCHEDULER disable constraint SYS_C007702;
alter table SCHEDULER disable constraint SYS_C007703;
alter table SCHEDULER disable constraint SYS_C007704;
prompt Deleting SCHEDULER...
delete from SCHEDULER;
commit;
prompt Deleting WORKSHOPS...
delete from WORKSHOPS;
commit;
prompt Deleting ROOMS...
delete from ROOMS;
commit;
prompt Deleting PARTICIPATE...
delete from PARTICIPATE;
commit;
prompt Deleting GROUPS_...
delete from GROUPS_;
commit;
prompt Deleting CLIENTS...
delete from CLIENTS;
commit;
prompt Deleting CLASS_...
delete from CLASS_;
commit;
prompt Deleting TEACHERS...
delete from TEACHERS;
commit;
prompt Deleting CITY...
delete from CITY;
commit;
prompt Deleting AGE_GROUP...
delete from AGE_GROUP;
commit;
prompt Loading AGE_GROUP...
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (1, 3, 5, 'Toddlers');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (2, 6, 12, 'Kids');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (3, 13, 17, 'Teens');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (4, 18, 60, 'Adults');
insert into AGE_GROUP (age_id, minage, maxage, descript)
values (5, 60, 120, 'Pensioners');
commit;
prompt 5 records loaded
prompt Loading CITY...
insert into CITY (city_num, city_name)
values (1, 'Archbold');
insert into CITY (city_num, city_name)
values (2, 'Framingaham');
insert into CITY (city_num, city_name)
values (3, 'Highton');
insert into CITY (city_num, city_name)
values (4, 'Douala');
insert into CITY (city_num, city_name)
values (5, 'Kejae City');
insert into CITY (city_num, city_name)
values (6, 'Burgess Hill');
insert into CITY (city_num, city_name)
values (7, 'Allen');
insert into CITY (city_num, city_name)
values (8, 'Natanya');
insert into CITY (city_num, city_name)
values (9, 'Bad Camberg');
insert into CITY (city_num, city_name)
values (10, 'South Hadley');
insert into CITY (city_num, city_name)
values (11, 'Belgrad');
insert into CITY (city_num, city_name)
values (12, 'Blacksburg');
insert into CITY (city_num, city_name)
values (13, 'Vallauris');
insert into CITY (city_num, city_name)
values (14, 'Chur');
insert into CITY (city_num, city_name)
values (16, 'San Dimas');
insert into CITY (city_num, city_name)
values (17, 'Tours');
insert into CITY (city_num, city_name)
values (18, 'Reisterstown');
insert into CITY (city_num, city_name)
values (19, 'Pandrup');
insert into CITY (city_num, city_name)
values (20, 'Redhill');
insert into CITY (city_num, city_name)
values (21, 'Leawood');
insert into CITY (city_num, city_name)
values (22, 'Antwerpen');
insert into CITY (city_num, city_name)
values (23, 'Sendai');
insert into CITY (city_num, city_name)
values (24, 'Sundsvall');
insert into CITY (city_num, city_name)
values (25, 'Horsham');
insert into CITY (city_num, city_name)
values (26, 'Mechanicsburg');
insert into CITY (city_num, city_name)
values (27, 'Southampton');
insert into CITY (city_num, city_name)
values (28, 'Maserada sul Pi');
insert into CITY (city_num, city_name)
values (29, 'Gdansk');
insert into CITY (city_num, city_name)
values (30, 'Guadalajara');
insert into CITY (city_num, city_name)
values (31, 'South Weber');
insert into CITY (city_num, city_name)
values (32, 'Rancho Palos Ve');
insert into CITY (city_num, city_name)
values (33, 'Gaza');
insert into CITY (city_num, city_name)
values (34, 'Neustadt');
insert into CITY (city_num, city_name)
values (35, 'Kyoto');
insert into CITY (city_num, city_name)
values (36, 'Delafield');
insert into CITY (city_num, city_name)
values (37, 'Houston');
insert into CITY (city_num, city_name)
values (38, 'East Providence');
insert into CITY (city_num, city_name)
values (39, 'Szazhalombatta');
insert into CITY (city_num, city_name)
values (40, 'Barcelona');
insert into CITY (city_num, city_name)
values (41, 'Butner');
insert into CITY (city_num, city_name)
values (42, 'Burr Ridge');
insert into CITY (city_num, city_name)
values (43, 'Winnipeg');
insert into CITY (city_num, city_name)
values (44, 'Duesseldorf');
insert into CITY (city_num, city_name)
values (45, 'Chinnor');
insert into CITY (city_num, city_name)
values (46, 'Tulsa');
insert into CITY (city_num, city_name)
values (47, 'New York');
insert into CITY (city_num, city_name)
values (48, 'West Point');
insert into CITY (city_num, city_name)
values (49, 'Bad Oeynhausen');
insert into CITY (city_num, city_name)
values (50, 'Schlieren');
insert into CITY (city_num, city_name)
values (52, 'Yomgok-dong');
insert into CITY (city_num, city_name)
values (53, 'Kuopio');
insert into CITY (city_num, city_name)
values (54, 'S. Bernardo do ');
insert into CITY (city_num, city_name)
values (55, 'Berlin-Adlersho');
insert into CITY (city_num, city_name)
values (56, 'Charlotte');
insert into CITY (city_num, city_name)
values (57, 'Ohtsu');
insert into CITY (city_num, city_name)
values (58, 'Bangalore');
insert into CITY (city_num, city_name)
values (60, 'Kaysville');
insert into CITY (city_num, city_name)
values (61, 'Koeln');
insert into CITY (city_num, city_name)
values (62, 'Woodbridge');
insert into CITY (city_num, city_name)
values (63, 'Ashland');
insert into CITY (city_num, city_name)
values (65, 'Storrington');
insert into CITY (city_num, city_name)
values (66, 'Sapporo');
insert into CITY (city_num, city_name)
values (67, 'Lyngby');
insert into CITY (city_num, city_name)
values (68, 'Guelph');
insert into CITY (city_num, city_name)
values (69, 'Barnegat');
insert into CITY (city_num, city_name)
values (70, 'Helsinki');
insert into CITY (city_num, city_name)
values (71, 'Hunt Valley');
insert into CITY (city_num, city_name)
values (72, 'Osaka');
insert into CITY (city_num, city_name)
values (73, 'O''fallon');
insert into CITY (city_num, city_name)
values (74, 'Sutton');
insert into CITY (city_num, city_name)
values (75, 'Maarssen');
insert into CITY (city_num, city_name)
values (76, 'Forest Park');
insert into CITY (city_num, city_name)
values (77, 'Dreieich');
insert into CITY (city_num, city_name)
values (78, 'Hamburg');
insert into CITY (city_num, city_name)
values (79, 'Rorschach');
insert into CITY (city_num, city_name)
values (80, 'Bingham Farms');
insert into CITY (city_num, city_name)
values (82, 'Stocksbridge');
insert into CITY (city_num, city_name)
values (83, 'Araras');
insert into CITY (city_num, city_name)
values (84, 'Alexandria');
insert into CITY (city_num, city_name)
values (85, 'Waldbronn');
insert into CITY (city_num, city_name)
values (86, 'Maebashi');
insert into CITY (city_num, city_name)
values (88, 'Brisbane');
insert into CITY (city_num, city_name)
values (90, 'Kuraby');
insert into CITY (city_num, city_name)
values (91, 'Lefkosa');
insert into CITY (city_num, city_name)
values (92, 'Potsdam');
insert into CITY (city_num, city_name)
values (93, 'Cheshire');
insert into CITY (city_num, city_name)
values (94, 'Amsterdam');
insert into CITY (city_num, city_name)
values (95, 'St. Petersburg');
insert into CITY (city_num, city_name)
values (96, 'Milford');
insert into CITY (city_num, city_name)
values (97, 'Derwood');
insert into CITY (city_num, city_name)
values (98, 'Tyne & Wear');
insert into CITY (city_num, city_name)
values (100, 'Ringwood');
insert into CITY (city_num, city_name)
values (101, 'Bartlett');
insert into CITY (city_num, city_name)
values (102, 'Bozeman');
insert into CITY (city_num, city_name)
values (103, 'Pusan');
insert into CITY (city_num, city_name)
values (104, 'West Launceston');
insert into CITY (city_num, city_name)
values (105, 'Calgary');
insert into CITY (city_num, city_name)
values (106, 'Deerfield');
insert into CITY (city_num, city_name)
values (107, 'New boston');
insert into CITY (city_num, city_name)
values (108, 'Peine');
commit;
prompt 100 records committed...
insert into CITY (city_num, city_name)
values (109, 'Pomona');
insert into CITY (city_num, city_name)
values (110, 'Brookfield');
insert into CITY (city_num, city_name)
values (112, 'Silverdale');
insert into CITY (city_num, city_name)
values (113, 'Bekescsaba');
insert into CITY (city_num, city_name)
values (114, 'Soest');
insert into CITY (city_num, city_name)
values (115, 'Hartmannsdorf');
insert into CITY (city_num, city_name)
values (116, 'Foster City');
insert into CITY (city_num, city_name)
values (117, 'Eschborn');
insert into CITY (city_num, city_name)
values (118, 'Ft. Lauderdale');
insert into CITY (city_num, city_name)
values (119, 'Hanover');
insert into CITY (city_num, city_name)
values (120, 'Rockville');
insert into CITY (city_num, city_name)
values (121, 'Billerica');
insert into CITY (city_num, city_name)
values (122, 'Immenstaad');
insert into CITY (city_num, city_name)
values (123, 'New orleans');
insert into CITY (city_num, city_name)
values (125, 'Saudarkrokur');
insert into CITY (city_num, city_name)
values (126, 'Paisley');
insert into CITY (city_num, city_name)
values (127, 'Vantaa');
insert into CITY (city_num, city_name)
values (128, 'Ipswich');
insert into CITY (city_num, city_name)
values (129, 'Battle Creek');
insert into CITY (city_num, city_name)
values (130, 'Roanoke');
insert into CITY (city_num, city_name)
values (131, 'Fort gordon');
insert into CITY (city_num, city_name)
values (132, 'Slmea');
insert into CITY (city_num, city_name)
values (133, 'Ettlingen');
insert into CITY (city_num, city_name)
values (134, 'Tualatin');
insert into CITY (city_num, city_name)
values (135, 'Anyang-si');
insert into CITY (city_num, city_name)
values (137, 'San Antonio');
insert into CITY (city_num, city_name)
values (138, 'Hackensack');
insert into CITY (city_num, city_name)
values (139, 'Orlando');
insert into CITY (city_num, city_name)
values (141, 'Hearst');
insert into CITY (city_num, city_name)
values (142, 'Paris');
insert into CITY (city_num, city_name)
values (143, 'Londrina');
insert into CITY (city_num, city_name)
values (144, 'Bristol');
insert into CITY (city_num, city_name)
values (145, 'Itu');
insert into CITY (city_num, city_name)
values (146, 'Warrenton');
insert into CITY (city_num, city_name)
values (147, 'Ilmenau');
insert into CITY (city_num, city_name)
values (151, 'Kobe');
insert into CITY (city_num, city_name)
values (152, 'Matsuyama');
insert into CITY (city_num, city_name)
values (154, 'Huntsville');
insert into CITY (city_num, city_name)
values (155, 'Paal Beringen');
insert into CITY (city_num, city_name)
values (156, 'Biella');
insert into CITY (city_num, city_name)
values (157, 'Fort Lee');
insert into CITY (city_num, city_name)
values (158, 'Kingston');
insert into CITY (city_num, city_name)
values (159, 'Silver Spring');
insert into CITY (city_num, city_name)
values (160, 'Holts Summit');
insert into CITY (city_num, city_name)
values (161, 'Suberg');
insert into CITY (city_num, city_name)
values (162, 'durham');
insert into CITY (city_num, city_name)
values (163, 'Moreno Valley');
insert into CITY (city_num, city_name)
values (164, 'Nantes');
insert into CITY (city_num, city_name)
values (165, 'Salzburg');
insert into CITY (city_num, city_name)
values (166, 'Shizuoka');
insert into CITY (city_num, city_name)
values (167, 'Doncaster');
insert into CITY (city_num, city_name)
values (168, 'Yokohama');
insert into CITY (city_num, city_name)
values (169, 'Brussel');
insert into CITY (city_num, city_name)
values (170, 'Melrose park');
insert into CITY (city_num, city_name)
values (171, 'Drogenbos');
insert into CITY (city_num, city_name)
values (172, 'Morioka');
insert into CITY (city_num, city_name)
values (173, 'Ternitz');
insert into CITY (city_num, city_name)
values (174, 'Naestved');
insert into CITY (city_num, city_name)
values (175, 'Corona');
insert into CITY (city_num, city_name)
values (176, 'Annandale');
insert into CITY (city_num, city_name)
values (177, 'Gainesville');
insert into CITY (city_num, city_name)
values (178, 'Olsztyn');
insert into CITY (city_num, city_name)
values (179, 'Waldorf');
insert into CITY (city_num, city_name)
values (180, 'San Ramon');
insert into CITY (city_num, city_name)
values (182, 'Gelsenkirchen');
insert into CITY (city_num, city_name)
values (183, 'Redwood Shores');
insert into CITY (city_num, city_name)
values (184, 'Kozani');
insert into CITY (city_num, city_name)
values (185, 'Daejeon');
insert into CITY (city_num, city_name)
values (187, 'New York City');
insert into CITY (city_num, city_name)
values (188, 'Saint-vincent-d');
insert into CITY (city_num, city_name)
values (189, 'Dearborn');
insert into CITY (city_num, city_name)
values (190, 'Tokyo');
insert into CITY (city_num, city_name)
values (191, 'Eden prairie');
insert into CITY (city_num, city_name)
values (194, 'Valladolid');
insert into CITY (city_num, city_name)
values (195, 'Ohita');
insert into CITY (city_num, city_name)
values (196, 'Knoxville');
insert into CITY (city_num, city_name)
values (198, 'Stellenbosch');
insert into CITY (city_num, city_name)
values (200, 'Bham');
insert into CITY (city_num, city_name)
values (201, 'Rosemead');
insert into CITY (city_num, city_name)
values (202, 'Fort Lewis');
insert into CITY (city_num, city_name)
values (203, 'Philadelphia');
insert into CITY (city_num, city_name)
values (204, 'Gummersbach');
insert into CITY (city_num, city_name)
values (205, 'Joinville');
insert into CITY (city_num, city_name)
values (206, 'Coppell');
insert into CITY (city_num, city_name)
values (207, 'Venice');
insert into CITY (city_num, city_name)
values (208, 'Campana');
insert into CITY (city_num, city_name)
values (210, 'Pottendorf');
insert into CITY (city_num, city_name)
values (211, 'Canal Wincheste');
insert into CITY (city_num, city_name)
values (212, 'Bologna');
insert into CITY (city_num, city_name)
values (214, 'Algermissen');
insert into CITY (city_num, city_name)
values (215, 'Fornacette');
insert into CITY (city_num, city_name)
values (216, 'Toulouse');
insert into CITY (city_num, city_name)
values (217, 'East sussex');
insert into CITY (city_num, city_name)
values (218, 'Suwon');
insert into CITY (city_num, city_name)
values (220, 'Bedford');
insert into CITY (city_num, city_name)
values (221, 'Budapest');
insert into CITY (city_num, city_name)
values (222, 'Cobham');
insert into CITY (city_num, city_name)
values (223, 'Juneau');
insert into CITY (city_num, city_name)
values (224, 'Harsum');
insert into CITY (city_num, city_name)
values (226, 'Schenectady');
commit;
prompt 200 records committed...
insert into CITY (city_num, city_name)
values (228, 'Karachi');
insert into CITY (city_num, city_name)
values (229, 'Tokushima');
insert into CITY (city_num, city_name)
values (230, 'Claymont');
insert into CITY (city_num, city_name)
values (231, 'High Wycombe');
insert into CITY (city_num, city_name)
values (232, 'Long Island Cit');
insert into CITY (city_num, city_name)
values (233, 'Takamatsu');
insert into CITY (city_num, city_name)
values (234, 'Bretzfeld-Waldb');
insert into CITY (city_num, city_name)
values (235, 'Rueil-Malmaison');
insert into CITY (city_num, city_name)
values (236, 'Billund');
insert into CITY (city_num, city_name)
values (237, 'West Windsor');
insert into CITY (city_num, city_name)
values (239, 'Chiba');
insert into CITY (city_num, city_name)
values (240, 'Tsu');
insert into CITY (city_num, city_name)
values (241, 'Golden');
insert into CITY (city_num, city_name)
values (242, 'Lathrop');
insert into CITY (city_num, city_name)
values (243, 'Yamaguchi');
insert into CITY (city_num, city_name)
values (244, 'Raleigh');
insert into CITY (city_num, city_name)
values (245, 'Luzern');
insert into CITY (city_num, city_name)
values (247, 'Wehrheim');
insert into CITY (city_num, city_name)
values (248, 'Lahr');
insert into CITY (city_num, city_name)
values (249, 'Colorado Spring');
insert into CITY (city_num, city_name)
values (250, 'Debary');
insert into CITY (city_num, city_name)
values (251, 'Rua eteno');
insert into CITY (city_num, city_name)
values (252, 'Fambach');
insert into CITY (city_num, city_name)
values (253, 'Ankara');
insert into CITY (city_num, city_name)
values (256, 'Reading');
insert into CITY (city_num, city_name)
values (257, 'Purley');
insert into CITY (city_num, city_name)
values (258, 'Dartmouth');
insert into CITY (city_num, city_name)
values (259, 'Athens');
insert into CITY (city_num, city_name)
values (260, 'Westport');
insert into CITY (city_num, city_name)
values (261, 'Buenos Aires');
insert into CITY (city_num, city_name)
values (262, 'Houma');
insert into CITY (city_num, city_name)
values (264, 'Bruxelles');
insert into CITY (city_num, city_name)
values (265, 'London');
insert into CITY (city_num, city_name)
values (266, 'Adelaide');
insert into CITY (city_num, city_name)
values (267, 'Fairborn');
insert into CITY (city_num, city_name)
values (268, 'Burlington');
insert into CITY (city_num, city_name)
values (269, 'Fleet');
insert into CITY (city_num, city_name)
values (270, 'Porto alegre');
insert into CITY (city_num, city_name)
values (271, 'Carlingford');
insert into CITY (city_num, city_name)
values (272, 'Vienna');
insert into CITY (city_num, city_name)
values (274, 'Kaunas');
insert into CITY (city_num, city_name)
values (275, 'Bay Shore');
insert into CITY (city_num, city_name)
values (277, 'Victoria');
insert into CITY (city_num, city_name)
values (279, 'Trenton');
insert into CITY (city_num, city_name)
values (281, 'Glasgow');
insert into CITY (city_num, city_name)
values (282, 'Livermore');
insert into CITY (city_num, city_name)
values (283, 'Istanbul');
insert into CITY (city_num, city_name)
values (285, 'Chambery');
insert into CITY (city_num, city_name)
values (286, 'Tucson');
insert into CITY (city_num, city_name)
values (288, 'Cincinnati');
insert into CITY (city_num, city_name)
values (289, 'Erpe-Mere');
insert into CITY (city_num, city_name)
values (290, 'Reston');
insert into CITY (city_num, city_name)
values (291, 'Edison');
insert into CITY (city_num, city_name)
values (292, 'Mclean');
insert into CITY (city_num, city_name)
values (293, 'North Point');
insert into CITY (city_num, city_name)
values (294, 'Buffalo');
insert into CITY (city_num, city_name)
values (295, 'Brampton');
insert into CITY (city_num, city_name)
values (296, 'Benbrook');
insert into CITY (city_num, city_name)
values (297, 'Lund');
insert into CITY (city_num, city_name)
values (298, 'Germantown');
insert into CITY (city_num, city_name)
values (299, 'Dubai');
insert into CITY (city_num, city_name)
values (301, 'Alpharetta');
insert into CITY (city_num, city_name)
values (304, 'Vancouver');
insert into CITY (city_num, city_name)
values (305, 'Arlington');
insert into CITY (city_num, city_name)
values (306, 'Michendorf');
insert into CITY (city_num, city_name)
values (307, 'Regensburg');
insert into CITY (city_num, city_name)
values (308, 'Wilmington');
insert into CITY (city_num, city_name)
values (310, 'Netanya');
insert into CITY (city_num, city_name)
values (312, 'Dublin');
insert into CITY (city_num, city_name)
values (313, 'Regina');
insert into CITY (city_num, city_name)
values (314, 'Barbengo');
insert into CITY (city_num, city_name)
values (315, 'Los Alamos');
insert into CITY (city_num, city_name)
values (316, 'Redondo beach');
insert into CITY (city_num, city_name)
values (317, 'Irving');
insert into CITY (city_num, city_name)
values (318, 'Schaumburg');
insert into CITY (city_num, city_name)
values (319, 'Guamo');
insert into CITY (city_num, city_name)
values (320, 'Cleveland');
insert into CITY (city_num, city_name)
values (324, 'Madrid');
insert into CITY (city_num, city_name)
values (325, 'Dietikon');
insert into CITY (city_num, city_name)
values (326, 'Coventry');
insert into CITY (city_num, city_name)
values (327, 'Scottsdale');
insert into CITY (city_num, city_name)
values (330, 'Abbotsford');
insert into CITY (city_num, city_name)
values (331, 'Anchorage');
insert into CITY (city_num, city_name)
values (333, 'Woking');
insert into CITY (city_num, city_name)
values (334, 'Bellevue');
insert into CITY (city_num, city_name)
values (335, 'Pecs');
insert into CITY (city_num, city_name)
values (336, 'Hannover');
insert into CITY (city_num, city_name)
values (337, 'Milton');
insert into CITY (city_num, city_name)
values (340, 'Monterey');
insert into CITY (city_num, city_name)
values (344, 'Farnham');
insert into CITY (city_num, city_name)
values (345, 'Olympia');
insert into CITY (city_num, city_name)
values (347, 'Alcobendas');
insert into CITY (city_num, city_name)
values (348, 'Fredericia');
insert into CITY (city_num, city_name)
values (350, 'Durban');
insert into CITY (city_num, city_name)
values (351, 'Boucherville');
insert into CITY (city_num, city_name)
values (352, 'Groton');
insert into CITY (city_num, city_name)
values (354, 'Richardson');
insert into CITY (city_num, city_name)
values (355, 'Braintree');
insert into CITY (city_num, city_name)
values (356, 'Spring Valley');
insert into CITY (city_num, city_name)
values (357, 'West Drayton');
commit;
prompt 300 records committed...
insert into CITY (city_num, city_name)
values (361, 'Birmingham');
insert into CITY (city_num, city_name)
values (363, 'Nagoya');
insert into CITY (city_num, city_name)
values (364, 'Brossard');
insert into CITY (city_num, city_name)
values (365, 'Edinburgh');
insert into CITY (city_num, city_name)
values (366, 'North Sydney');
insert into CITY (city_num, city_name)
values (367, 'Los Angeles');
insert into CITY (city_num, city_name)
values (368, 'Fuerth');
insert into CITY (city_num, city_name)
values (369, 'Hampton');
insert into CITY (city_num, city_name)
values (370, 'Milano');
insert into CITY (city_num, city_name)
values (371, 'Zagreb');
insert into CITY (city_num, city_name)
values (372, 'Exeter');
insert into CITY (city_num, city_name)
values (375, 'Princeton');
insert into CITY (city_num, city_name)
values (376, 'Kerava');
insert into CITY (city_num, city_name)
values (377, 'Kwun Tong');
insert into CITY (city_num, city_name)
values (379, 'Pusan-city');
insert into CITY (city_num, city_name)
values (380, 'Batavia');
insert into CITY (city_num, city_name)
values (382, 'Durham');
insert into CITY (city_num, city_name)
values (383, 'North Wales');
insert into CITY (city_num, city_name)
values (384, 'Heubach');
insert into CITY (city_num, city_name)
values (385, 'Unionville');
insert into CITY (city_num, city_name)
values (386, 'Peachtree City');
insert into CITY (city_num, city_name)
values (387, 'Pretoria');
insert into CITY (city_num, city_name)
values (389, 'Giessen');
insert into CITY (city_num, city_name)
values (390, 'Gaithersburg');
insert into CITY (city_num, city_name)
values (391, 'Aiken');
insert into CITY (city_num, city_name)
values (392, 'Stafford');
insert into CITY (city_num, city_name)
values (393, 'North bethesda');
insert into CITY (city_num, city_name)
values (394, 'Newbury');
insert into CITY (city_num, city_name)
values (395, 'Jakarta');
insert into CITY (city_num, city_name)
values (396, 'Bonn');
insert into CITY (city_num, city_name)
values (397, 'Warsaw');
insert into CITY (city_num, city_name)
values (398, 'Sevilla');
insert into CITY (city_num, city_name)
values (399, 'Saint Ouen');
insert into CITY (city_num, city_name)
values (400, 'Zuerich');
insert into CITY (city_num, city_name)
values (401, 'Kista');
insert into CITY (city_num, city_name)
values (403, 'Munich');
insert into CITY (city_num, city_name)
values (405, 'Tartu');
insert into CITY (city_num, city_name)
values (406, 'Cottbus');
insert into CITY (city_num, city_name)
values (408, 'Amherst');
insert into CITY (city_num, city_name)
values (411, 'Luedenscheid');
insert into CITY (city_num, city_name)
values (412, 'Walnut Creek');
insert into CITY (city_num, city_name)
values (413, 'Chennai');
insert into CITY (city_num, city_name)
values (414, 'St-bruno');
insert into CITY (city_num, city_name)
values (415, 'Coburg');
insert into CITY (city_num, city_name)
values (416, 'Sugar Land');
insert into CITY (city_num, city_name)
values (419, 'Herndon');
insert into CITY (city_num, city_name)
values (420, 'Dardilly');
insert into CITY (city_num, city_name)
values (421, 'Augsburg');
insert into CITY (city_num, city_name)
values (424, 'El Segundo');
insert into CITY (city_num, city_name)
values (425, 'Wuerzburg');
insert into CITY (city_num, city_name)
values (428, 'Syracuse');
insert into CITY (city_num, city_name)
values (430, 'St-laurent');
insert into CITY (city_num, city_name)
values (431, 'Waite Park');
insert into CITY (city_num, city_name)
values (432, 'Steyr');
insert into CITY (city_num, city_name)
values (433, 'Hyderabad');
insert into CITY (city_num, city_name)
values (434, 'Boulogne');
insert into CITY (city_num, city_name)
values (435, 'Nepean');
insert into CITY (city_num, city_name)
values (436, 'Kloten');
insert into CITY (city_num, city_name)
values (437, 'Ravensburg');
insert into CITY (city_num, city_name)
values (439, 'Fukui');
insert into CITY (city_num, city_name)
values (440, 'Bradenton');
insert into CITY (city_num, city_name)
values (441, 'Edenbridge');
insert into CITY (city_num, city_name)
values (442, 'Gauteng');
insert into CITY (city_num, city_name)
values (443, 'Kansas City');
insert into CITY (city_num, city_name)
values (445, 'Ismaning');
insert into CITY (city_num, city_name)
values (447, 'Hilversum');
insert into CITY (city_num, city_name)
values (450, 'Concordville');
insert into CITY (city_num, city_name)
values (455, 'New Haven');
insert into CITY (city_num, city_name)
values (456, 'Waco');
insert into CITY (city_num, city_name)
values (458, 'Parma');
insert into CITY (city_num, city_name)
values (459, 'Virginia Beach');
insert into CITY (city_num, city_name)
values (461, 'Marietta');
insert into CITY (city_num, city_name)
values (463, 'Park Ridge');
insert into CITY (city_num, city_name)
values (464, 'Fremont');
insert into CITY (city_num, city_name)
values (466, 'Herne');
insert into CITY (city_num, city_name)
values (467, 'Kungki');
insert into CITY (city_num, city_name)
values (468, 'Roma');
insert into CITY (city_num, city_name)
values (469, 'Greenwood Villa');
insert into CITY (city_num, city_name)
values (472, 'Richmond');
insert into CITY (city_num, city_name)
values (473, 'Pompton Plains');
insert into CITY (city_num, city_name)
values (474, 'Warren');
insert into CITY (city_num, city_name)
values (476, 'Enschede');
insert into CITY (city_num, city_name)
values (478, 'Enfield');
insert into CITY (city_num, city_name)
values (479, 'Turku');
insert into CITY (city_num, city_name)
values (480, 'Clark');
insert into CITY (city_num, city_name)
values (482, 'Canberra');
insert into CITY (city_num, city_name)
values (483, 'Gattico');
insert into CITY (city_num, city_name)
values (484, 'Somerset');
insert into CITY (city_num, city_name)
values (485, 'Hayward');
insert into CITY (city_num, city_name)
values (486, 'Huntington');
insert into CITY (city_num, city_name)
values (487, 'Bracknell');
insert into CITY (city_num, city_name)
values (488, 'Bielefeld');
insert into CITY (city_num, city_name)
values (493, 'Cape town');
insert into CITY (city_num, city_name)
values (494, 'Rockford');
insert into CITY (city_num, city_name)
values (495, 'Grand Rapids');
insert into CITY (city_num, city_name)
values (496, 'Vista');
insert into CITY (city_num, city_name)
values (497, 'Beaverton');
insert into CITY (city_num, city_name)
values (499, 'Koufu');
insert into CITY (city_num, city_name)
values (500, 'Melbourne');
insert into CITY (city_num, city_name)
values (503, 'Chicago');
commit;
prompt 400 records committed...
insert into CITY (city_num, city_name)
values (504, 'Manchester');
insert into CITY (city_num, city_name)
values (505, 'Media');
insert into CITY (city_num, city_name)
values (508, 'Cannock');
insert into CITY (city_num, city_name)
values (509, 'Verdun');
insert into CITY (city_num, city_name)
values (510, 'Summerside');
commit;
prompt 405 records loaded
prompt Loading TEACHERS...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (401, 'Isabella', 'Jay', 1, 68611, 0, to_date('16-04-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (402, 'Shirley', 'Ermey', 2, 84533, 0, to_date('15-06-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (403, 'Whoopi', 'Dafoe', 3, 18453, 0, to_date('03-12-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (404, 'Chris', 'Hoskins', 4, 74083, 0, to_date('19-09-1982', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (405, 'Kate', 'Feore', 5, 42328, 0, to_date('09-07-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (406, 'Nicole', 'Hackman', 6, 96996, 0, to_date('14-10-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (407, 'Mika', 'Aiken', 7, 57321, 370, to_date('01-08-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (408, 'Hilton', 'Salonga', 8, 70912, 0, to_date('24-05-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (409, 'Aaron', 'Todd', 9, 50162, 151, to_date('04-05-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (410, 'Eddie', 'Jackman', 10, 84571, 0, to_date('06-10-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (411, 'Tcheky', 'Sartain', 105, 37587, 0, to_date('26-12-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (412, 'Madeleine', 'Mandrell', 366, 42958, 0, to_date('21-08-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (413, 'Shirley', 'Mahood', 11, 18621, 0, to_date('04-12-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (414, 'Nancy', 'Cartlidge', 312, 51064, 0, to_date('09-02-1955', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (415, 'Manu', 'Bergen', 96, 89284, 0, to_date('15-08-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (416, 'Corey', 'Bruce', 12, 91867, 0, to_date('03-07-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (417, 'Delroy', 'Akins', 245, 89543, 0, to_date('12-08-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (418, 'Azucar', 'Getty', 70, 28757, 0, to_date('29-08-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (419, 'Kylie', 'Streep', 371, 90146, 0, to_date('23-02-1965', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (420, 'Nanci', 'Schiff', 185, 23674, 0, to_date('10-12-1964', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (421, 'Dylan', 'Kirkwood', 151, 95046, 0, to_date('13-07-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (424, 'Saul', 'Penders', 42, 57489, 0, to_date('24-10-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (425, 'Jeffrey', 'Dorn', 134, 50348, 0, to_date('29-04-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (426, 'Machine', 'Blades', 226, 57119, 0, to_date('18-02-1963', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (427, 'Oded', 'Snipes', 336, 84523, 0, to_date('02-10-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (429, 'Peabo', 'Kline', 170, 10314, 0, to_date('02-07-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (430, 'Liam', 'Beck', 20, 61518, 0, to_date('22-04-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (431, 'Sylvester', 'May', 314, 70916, 0, to_date('01-12-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (432, 'Fisher', 'Burton', 5, 11255, 0, to_date('06-03-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (433, 'Marianne', 'Swayze', 1, 18298, 0, to_date('22-12-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (434, 'Hookah', 'Caan', 5, 84558, 0, to_date('11-04-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (435, 'Kiefer', 'Tate', 142, 24922, 0, to_date('31-03-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (437, 'Nancy', 'Leto', 251, 15622, 0, to_date('04-10-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (438, 'Larenz', 'Rodgers', 101, 64689, 0, to_date('25-03-1982', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (439, 'Cheryl', 'Houston', 215, 47937, 0, to_date('11-08-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (440, 'Leon', 'Weber', 131, 20574, 0, to_date('19-05-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (441, 'Grant', 'May', 75, 71668, 0, to_date('01-10-1990', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (442, 'Alan', 'Browne', 195, 19950, 0, to_date('12-01-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (443, 'Bryan', 'Rippy', 275, 30948, 0, to_date('09-11-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (444, 'Lili', 'Smurfit', 221, 15821, 0, to_date('16-02-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (446, 'Dom', 'Damon', 266, 99474, 0, to_date('17-07-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (447, 'Trey', 'Carrington', 345, 73075, 0, to_date('10-10-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (448, 'Nathan', 'Carlton', 43, 13020, 0, to_date('25-01-1973', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (449, 'Bette', 'Vance', 45, 42723, 0, to_date('07-02-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (450, 'Gladys', 'Ermey', 35, 10617, 0, to_date('07-02-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (453, 'Debbie', 'O''Neill', 95, 96438, 0, to_date('02-09-1991', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (454, 'Lloyd', 'Capshaw', 141, 71714, 0, to_date('28-01-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (455, 'Olympia', 'Hayes', 77, 47394, 0, to_date('11-05-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (456, 'Isabella', 'Mortensen', 386, 74456, 0, to_date('17-05-1990', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (457, 'Aaron', 'Sampson', 88, 40852, 0, to_date('08-05-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (458, 'Curt', 'Gooding', 43, 20455, 0, to_date('06-08-1966', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (459, 'Emmylou', 'Quinn', 122, 24045, 0, to_date('05-01-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (460, 'Alice', 'Brooke', 68, 23513, 0, to_date('20-08-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (461, 'LeVar', 'Savage', 66, 48999, 0, to_date('17-11-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (462, 'Madeline', 'Briscoe', 241, 77889, 0, to_date('13-05-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (463, 'Omar', 'Rhodes', 85, 80172, 0, to_date('01-03-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (464, 'Loretta', 'Hauser', 53, 27165, 0, to_date('17-07-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (465, 'Emerson', 'Matarazzo', 290, 75685, 0, to_date('27-04-1966', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (466, 'Ricardo', 'Downey', 36, 38055, 0, to_date('17-08-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (467, 'Goldie', 'Zevon', 145, 45451, 0, to_date('23-07-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (468, 'Hope', 'Biggs', 63, 78659, 0, to_date('23-09-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (469, 'Wes', 'Nelson', 165, 81961, 0, to_date('24-09-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (470, 'Campbell', 'Gyllenhaal', 395, 73234, 0, to_date('06-04-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (471, 'Albert', 'Vannelli', 176, 22022, 0, to_date('16-06-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (472, 'Scarlett', 'Bogguss', 203, 87969, 0, to_date('19-07-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (473, 'Annette', 'Lopez', 76, 40222, 0, to_date('18-12-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (476, 'Vondie', 'Collette', 220, 42991, 0, to_date('26-10-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (477, 'Dionne', 'Carrey', 168, 79930, 377, to_date('07-08-1991', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (478, 'Danny', 'Palin', 171, 79873, 0, to_date('04-08-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (480, 'Cherry', 'Tilly', 294, 86355, 0, to_date('26-09-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (481, 'Joe', 'Carrington', 30, 53958, 0, to_date('26-12-1970', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (482, 'Rebeka', 'Karyo', 314, 73145, 0, to_date('18-08-1974', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (483, 'Rebeka', 'Davis', 340, 23383, 0, to_date('13-04-1963', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (484, 'Freddie', 'Crimson', 152, 57875, 0, to_date('25-11-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (485, 'Clay', 'Mahood', 125, 55568, 0, to_date('04-06-1996', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (486, 'Rosario', 'Ali', 101, 34938, 404, to_date('01-10-1961', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (487, 'Don', 'Eat World', 31, 70840, 0, to_date('06-09-1955', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (488, 'Faye', 'Isaak', 104, 32603, 0, to_date('08-06-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (490, 'Vertical', 'Davies', 170, 84431, 0, to_date('19-07-1963', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (491, 'Whoopi', 'Damon', 152, 71021, 0, to_date('11-01-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (492, 'Mary', 'Crudup', 8, 54533, 0, to_date('13-04-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (493, 'Ozzy', 'Sobieski', 185, 42721, 0, to_date('03-05-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (494, 'Geggy', 'Keaton', 109, 88696, 0, to_date('04-05-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (495, 'Armand', 'Langella', 283, 53852, 0, to_date('14-02-1973', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (496, 'Kristin', 'Ingram', 157, 55908, 0, to_date('01-08-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (497, 'Jeffrey', 'Shawn', 340, 28221, 0, to_date('27-06-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (498, 'Liquid', 'Gilley', 6, 57321, 0, to_date('27-02-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (499, 'Mel', 'Lynne', 177, 45224, 0, to_date('06-12-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (500, 'Geggy', 'Gano', 94, 52166, 0, to_date('14-03-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (501, 'Azucar', 'Tierney', 20, 79540, 0, to_date('11-04-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (502, 'Betty', 'Barnett', 330, 92672, 0, to_date('17-10-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (503, 'Warren', 'Faithfull', 41, 24274, 0, to_date('02-05-1995', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (504, 'Brenda', 'Morrison', 147, 72506, 0, to_date('10-05-1966', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (505, 'Barry', 'Lucas', 97, 38333, 0, to_date('04-10-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (506, 'Lenny', 'Day-Lewis', 125, 75767, 0, to_date('14-01-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (507, 'Ben', 'Rucker', 142, 21299, 0, to_date('26-12-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (508, 'Max', 'McNarland', 98, 96077, 0, to_date('02-06-1973', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (509, 'Lois', 'Tanon', 253, 11607, 0, to_date('17-08-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (511, 'Curtis', 'Stevens', 139, 86287, 0, to_date('22-04-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (512, 'Rick', 'Logue', 164, 83798, 0, to_date('14-10-1974', 'dd-mm-yyyy'), null);
commit;
prompt 100 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (513, 'Madeline', 'Reno', 76, 73062, 0, to_date('31-03-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (514, 'Meryl', 'Gryner', 283, 57170, 0, to_date('19-07-1973', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (516, 'Bette', 'Rhys-Davies', 317, 15798, 0, to_date('25-11-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (518, 'Victor', 'Allen', 384, 12439, 0, to_date('02-12-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (519, 'Bo', 'Langella', 286, 74157, 0, to_date('03-04-1999', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (520, 'Lennie', 'Feuerstein', 318, 24479, 0, to_date('26-05-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (521, 'Gena', 'Leigh', 43, 51246, 0, to_date('12-10-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (523, 'Balthazar', 'Leary', 57, 81048, 0, to_date('09-03-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (524, 'Buddy', 'Banderas', 83, 83214, 0, to_date('23-05-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (525, 'Jennifer', 'McIntosh', 90, 39730, 0, to_date('14-01-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (526, 'Rachael', 'Dillane', 188, 10706, 0, to_date('27-03-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (527, 'Emily', 'Sartain', 101, 75364, 0, to_date('31-03-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (528, 'Wendy', 'Krabbe', 367, 60657, 0, to_date('31-10-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (529, 'Toshiro', 'Tomlin', 275, 16971, 0, to_date('15-09-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (530, 'Minnie', 'Abraham', 345, 84437, 0, to_date('01-06-1995', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (531, 'Tom', 'Flanery', 196, 65462, 0, to_date('13-11-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (532, 'Melba', 'Bailey', 183, 50689, 0, to_date('24-01-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (533, 'Jean', 'Sisto', 106, 62235, 0, to_date('08-09-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (535, 'Randall', 'Belle', 129, 53726, 0, to_date('24-10-1963', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (537, 'Louise', 'Holliday', 188, 32690, 0, to_date('29-06-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (538, 'Emm', 'Jordan', 44, 15464, 100, to_date('10-12-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (540, 'Marianne', 'Kahn', 90, 79192, 200, to_date('23-02-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (541, 'Amanda', 'Payton', 194, 69137, 0, to_date('03-03-1999', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (542, 'Cathy', 'Shannon', 395, 21211, 0, to_date('02-01-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (543, 'Terry', 'Lipnicki', 72, 12525, 0, to_date('01-08-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (544, 'Bo', 'Griffin', 350, 69772, 0, to_date('28-12-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (545, 'Will', 'Connery', 157, 72349, 0, to_date('09-05-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (546, 'Kazem', 'Ramis', 222, 96023, 0, to_date('30-08-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (548, 'Leon', 'Wood', 383, 46417, 0, to_date('14-07-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (549, 'Samuel', 'Hannah', 294, 40052, 0, to_date('11-06-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (551, 'Lili', 'Ricci', 211, 67627, 0, to_date('27-11-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (552, 'Joe', 'Meniketti', 251, 75132, 0, to_date('02-03-1982', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (553, 'Jean-Claude', 'Gatlin', 144, 94516, 0, to_date('22-11-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (554, 'Mike', 'Coleman', 270, 12627, 0, to_date('22-02-1970', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (555, 'Albert', 'Boothe', 369, 22221, 0, to_date('16-05-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (556, 'Christian', 'Benet', 376, 24916, 0, to_date('02-06-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (557, 'Cesar', 'Ermey', 245, 20780, 0, to_date('25-08-1996', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (558, 'Chrissie', 'Rodgers', 345, 53187, 200, to_date('16-07-1979', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (559, 'Avril', 'Tomlin', 35, 70616, 0, to_date('23-06-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (560, 'Ani', 'Aaron', 28, 27086, 0, to_date('24-04-1970', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (562, 'Dick', 'Botti', 379, 83984, 0, to_date('19-06-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (563, 'Anita', 'Frakes', 258, 79886, 0, to_date('20-05-1990', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (565, 'Sam', 'Dillon', 11, 16423, 0, to_date('01-10-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (566, 'Ossie', 'Joli', 386, 56299, 0, to_date('01-05-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (567, 'Gilbert', 'Baranski', 58, 41911, 0, to_date('19-12-1957', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (568, 'Ernie', 'Hewitt', 42, 50698, 0, to_date('27-12-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (569, 'Amy', 'DiBiasio', 100, 12482, 0, to_date('05-01-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (570, 'Larry', 'Morales', 369, 29127, 0, to_date('06-11-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (571, 'Cheech', 'Bugnon', 25, 81295, 0, to_date('12-09-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (572, 'Debra', 'Fogerty', 130, 98946, 0, to_date('18-09-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (574, 'Maxine', 'Condition', 48, 40684, 0, to_date('10-05-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (575, 'Wesley', 'Judd', 54, 63894, 0, to_date('19-08-1995', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (576, 'Paul', 'Yankovic', 48, 41199, 0, to_date('18-08-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (577, 'Geoffrey', 'Barnett', 350, 46635, 0, to_date('18-04-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (578, 'Cheryl', 'Manning', 110, 75534, 0, to_date('13-04-1982', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (579, 'Allan', 'Pride', 4, 65983, 0, to_date('30-06-1965', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (580, 'Stellan', 'Levert', 9, 36970, 0, to_date('19-08-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (581, 'Bo', 'Thewlis', 9, 38160, 0, to_date('15-04-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (583, 'Emm', 'Woods', 75, 84035, 0, to_date('15-12-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (584, 'Lauren', 'Atkins', 23, 52110, 0, to_date('21-02-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (585, 'Caroline', 'Woodward', 29, 36253, 0, to_date('28-11-1986', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (586, 'Lin', 'Bruce', 350, 87256, 377, to_date('26-02-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (587, 'Lionel', 'Newman', 121, 65136, 0, to_date('19-12-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (588, 'Olympia', 'Walker', 272, 87501, 0, to_date('30-04-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (589, 'King', 'Hatfield', 12, 79121, 0, to_date('05-05-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (590, 'Anthony', 'Morrison', 146, 87907, 0, to_date('31-03-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (591, 'Ewan', 'Frost', 277, 78017, 0, to_date('08-04-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (592, 'Anjelica', 'Place', 189, 53369, 0, to_date('20-07-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (593, 'Matt', 'Steenburgen', 5, 59872, 0, to_date('16-09-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (595, 'Alfie', 'Sorvino', 120, 84716, 167, to_date('24-12-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (596, 'Maury', 'Berenger', 274, 99229, 0, to_date('07-11-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (597, 'Fred', 'Colin Young', 221, 40982, 0, to_date('05-10-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (598, 'Rosanne', 'DeGraw', 189, 92772, 0, to_date('27-01-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (600, 'Franco', 'Weller', 237, 49452, 0, to_date('14-08-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (601, 'Anthony', 'Gatlin', 83, 79399, 0, to_date('04-09-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (603, 'Tracy', 'Cervine', 189, 88585, 351, to_date('04-09-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (604, 'Andre', 'Whitmore', 253, 14452, 0, to_date('01-05-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (606, 'Mac', 'Diaz', 314, 19217, 0, to_date('18-04-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (607, 'Terry', 'Evett', 131, 20053, 0, to_date('23-02-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (608, 'Patrick', 'Eastwood', 157, 17505, 0, to_date('21-06-1990', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (609, 'Mary-Louise', 'Diehl', 29, 13234, 0, to_date('19-07-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (610, 'Mekhi', 'Boorem', 24, 84032, 0, to_date('19-03-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (612, 'Jason', 'Davison', 154, 77193, 304, to_date('18-07-1991', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (613, 'Gladys', 'Ferrell', 161, 29515, 0, to_date('30-11-1999', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (614, 'Kurtwood', 'Overstreet', 286, 19529, 0, to_date('05-08-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (615, 'Belinda', 'Gyllenhaal', 247, 88663, 0, to_date('23-03-1986', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (616, 'Lynette', 'Kier', 259, 25464, 0, to_date('19-03-1961', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (618, 'Loretta', 'Garfunkel', 154, 53345, 0, to_date('17-05-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (619, 'Paula', 'Collie', 43, 42889, 0, to_date('10-11-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (620, 'Warren', 'Neville', 57, 51330, 0, to_date('31-07-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (621, 'Larry', 'Neil', 53, 60506, 0, to_date('09-10-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (622, 'Colm', 'Neil', 57, 99132, 0, to_date('09-11-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (623, 'Caroline', 'Ruiz', 324, 68475, 0, to_date('24-07-1970', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (624, 'Loren', 'McCabe', 395, 80179, 0, to_date('27-07-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (626, 'Remy', 'Diddley', 152, 61188, 0, to_date('26-08-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (627, 'Clarence', 'Idle', 39, 98674, 0, to_date('04-09-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (629, 'Breckin', 'Thorton', 125, 77289, 0, to_date('06-07-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (631, 'Tori', 'Coleman', 19, 93112, 0, to_date('01-02-1982', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (632, 'Hugh', 'McDormand', 394, 65543, 0, to_date('28-06-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (635, 'Fionnula', 'Kahn', 177, 45699, 0, to_date('30-01-1951', 'dd-mm-yyyy'), null);
commit;
prompt 200 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (636, 'Sander', 'Law', 195, 67320, 0, to_date('17-09-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (639, 'Karen', 'Swayze', 45, 43161, 0, to_date('30-04-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (640, 'Etta', 'Fender', 74, 40614, 0, to_date('18-10-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (641, 'Boyd', 'Tolkan', 271, 11959, 0, to_date('01-02-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (642, 'Donald', 'Rowlands', 143, 52348, 0, to_date('05-10-1996', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (643, 'Jonatha', 'Skaggs', 231, 14203, 0, to_date('03-01-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (645, 'Kirk', 'Zahn', 389, 56743, 0, to_date('12-05-1963', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (646, 'Ethan', 'Glenn', 274, 65564, 0, to_date('10-06-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (647, 'Albertina', 'Giamatti', 396, 69294, 0, to_date('15-01-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (648, 'Meredith', 'Bruce', 79, 87741, 0, to_date('17-10-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (649, 'Nickel', 'Short', 49, 89387, 0, to_date('27-07-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (650, 'Ronnie', 'Heron', 386, 72351, 0, to_date('01-04-1973', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (651, 'Rachael', 'Stiller', 167, 81075, 0, to_date('07-06-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (652, 'Harold', 'Gleeson', 114, 79265, 0, to_date('22-02-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (653, 'Hilton', 'Arthur', 333, 13187, 0, to_date('11-02-1998', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (654, 'Mac', 'Thomson', 245, 93632, 0, to_date('11-05-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (655, 'Vern', 'Ferrer', 167, 35397, 0, to_date('21-10-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (656, 'Kenny', 'Skerritt', 296, 70691, 0, to_date('23-11-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (658, 'Giancarlo', 'Ferrer', 247, 80506, 0, to_date('28-05-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (659, 'Art', 'Spacek', 371, 72980, 0, to_date('22-12-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (660, 'Heather', 'Costner', 16, 42170, 0, to_date('19-10-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (661, 'Nicholas', 'Witherspoon', 10, 89220, 0, to_date('17-04-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (663, 'Cate', 'Colton', 188, 41695, 0, to_date('12-09-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (664, 'Debbie', 'Maxwell', 283, 22769, 0, to_date('02-04-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (665, 'Penelope', 'Tennison', 162, 93864, 0, to_date('07-05-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (667, 'Brian', 'Hewitt', 270, 89482, 0, to_date('17-07-1964', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (668, 'Patricia', 'Deschanel', 189, 71662, 0, to_date('26-01-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (669, 'Bonnie', 'Church', 269, 25307, 0, to_date('25-04-1966', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (670, 'Patricia', 'McDormand', 55, 38033, 0, to_date('03-06-1974', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (671, 'Pelvic', 'Hagar', 42, 47875, 0, to_date('15-11-1961', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (672, 'Sinead', 'Holeman', 95, 84948, 237, to_date('19-05-1990', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (673, 'Cyndi', 'Hughes', 249, 15126, 0, to_date('23-05-1970', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (675, 'Lily', 'Sample', 159, 36172, 0, to_date('16-12-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (677, 'Peter', 'Oldman', 29, 94971, 377, to_date('02-03-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (678, 'Nikki', 'Yorn', 290, 64089, 0, to_date('16-08-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (679, 'Jimmy', 'McCracken', 291, 36212, 0, to_date('19-03-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (680, 'Vince', 'Garfunkel', 307, 83991, 0, to_date('12-10-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (681, 'Terence', 'Oszajca', 285, 44163, 0, to_date('02-12-1995', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (682, 'Marty', 'Calle', 249, 58228, 0, to_date('13-09-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (684, 'Loren', 'Langella', 129, 86666, 0, to_date('23-06-1997', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (685, 'Keanu', 'Robinson', 114, 97916, 0, to_date('11-01-1979', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (686, 'Laura', 'Quinones', 174, 10673, 0, to_date('30-03-1996', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (688, 'Tim', 'Whitman', 37, 10578, 0, to_date('21-07-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (689, 'Tim', 'Keaton', 25, 86189, 0, to_date('22-07-1961', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (693, 'Steven', 'Damon', 266, 63153, 0, to_date('21-11-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (694, 'Stockard', 'Garr', 90, 97044, 0, to_date('17-02-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (695, 'Jody', 'Cattrall', 76, 80144, 0, to_date('09-04-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (696, 'Morris', 'Judd', 179, 47429, 0, to_date('22-01-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (697, 'Adrien', 'Duchovny', 60, 87291, 0, to_date('24-07-1957', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (698, 'Halle', 'Tripplehorn', 306, 25038, 0, to_date('31-08-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (700, 'Alana', 'Pullman', 171, 44089, 0, to_date('13-02-1998', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (701, 'Cherry', 'Langella', 179, 52123, 0, to_date('04-03-1964', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (702, 'Jeroen', 'Lowe', 62, 46851, 0, to_date('05-08-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (703, 'Tom', 'Campbell', 65, 61354, 0, to_date('23-12-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (705, 'Nastassja', 'Irving', 41, 17550, 0, to_date('11-06-1957', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (706, 'Gaby', 'von Sydow', 211, 64254, 0, to_date('09-06-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (707, 'Bernie', 'Karyo', 73, 32507, 0, to_date('20-03-1973', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (708, 'Stanley', 'Weber', 10, 20741, 0, to_date('31-12-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (709, 'Ice', 'Daniels', 121, 51827, 0, to_date('18-05-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (710, 'Kathleen', 'Carr', 177, 16246, 370, to_date('08-01-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (711, 'Vonda', 'Bacon', 201, 22199, 0, to_date('30-01-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (712, 'Bridget', 'Sellers', 264, 61762, 0, to_date('26-07-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (713, 'Hector', 'Neil', 107, 34164, 0, to_date('02-08-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (714, 'Marina', 'Love', 248, 37431, 0, to_date('01-03-1999', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (715, 'Lin', 'Torn', 48, 53631, 0, to_date('29-08-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (718, 'Laura', 'Pryce', 211, 82022, 0, to_date('06-07-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (720, 'Christmas', 'Parker', 267, 88015, 0, to_date('27-01-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (721, 'Holly', 'Ball', 308, 14577, 0, to_date('16-11-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (722, 'Sylvester', 'Palmieri', 297, 93472, 0, to_date('08-07-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (723, 'Juliana', 'Lunch', 201, 90017, 0, to_date('05-12-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (724, 'Steven', 'Jamal', 286, 57402, 0, to_date('09-08-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (725, 'Millie', 'Myers', 179, 97963, 517, to_date('06-08-1991', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (726, 'Rascal', 'Mifune', 58, 89728, 0, to_date('28-06-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (727, 'Cary', 'Cale', 202, 72492, 0, to_date('20-05-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (728, 'Tommy', 'Arquette', 53, 18323, 0, to_date('22-07-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (729, 'Adam', 'Perez', 30, 79601, 0, to_date('01-05-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (730, 'Rosario', 'Herrmann', 367, 74105, 0, to_date('28-10-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (731, 'Peabo', 'Sanders', 400, 16936, 0, to_date('10-09-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (732, 'Denzel', 'Sarsgaard', 176, 23712, 0, to_date('27-01-1963', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (733, 'Kazem', 'Robards', 123, 44302, 0, to_date('18-07-1998', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (734, 'Molly', 'Lopez', 147, 41798, 0, to_date('30-04-1996', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (735, 'Lorraine', 'Rhymes', 158, 43256, 0, to_date('05-05-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (736, 'Domingo', 'McCracken', 142, 67489, 0, to_date('03-12-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (737, 'Kirsten', 'Sinatra', 220, 36543, 0, to_date('19-09-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (738, 'Marley', 'Morrison', 217, 82004, 0, to_date('05-09-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (739, 'Mira', 'Dooley', 380, 10679, 0, to_date('16-07-1991', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (740, 'Avril', 'Coltrane', 234, 77005, 0, to_date('09-07-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (741, 'Carla', 'Shaye', 202, 37437, 0, to_date('13-07-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (742, 'Mark', 'Lipnicki', 274, 35679, 0, to_date('31-12-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (743, 'Isabella', 'Strathairn', 96, 82540, 0, to_date('15-06-1965', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (744, 'Rosie', 'Kenoly', 173, 91103, 0, to_date('23-01-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (745, 'Holland', 'Coward', 13, 82330, 0, to_date('04-03-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (746, 'Mickey', 'Washington', 185, 58915, 0, to_date('27-07-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (747, 'Brendan', 'Vassar', 369, 81691, 0, to_date('01-08-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (748, 'Judy', 'Clarkson', 71, 83815, 0, to_date('23-10-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (749, 'Marc', 'Liotta', 129, 69025, 0, to_date('01-10-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (750, 'Greg', 'Pollack', 23, 21948, 0, to_date('29-08-1955', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (751, 'Connie', 'Sizemore', 325, 66536, 0, to_date('22-03-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (752, 'Roscoe', 'Webb', 132, 63674, 0, to_date('22-06-1986', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (754, 'Xander', 'Klugh', 9, 83782, 0, to_date('27-06-1971', 'dd-mm-yyyy'), null);
commit;
prompt 300 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (755, 'Humberto', 'Molina', 113, 57691, 0, to_date('06-02-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (757, 'Etta', 'Lucien', 337, 45029, 0, to_date('17-03-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (758, 'Mint', 'Carradine', 394, 12445, 0, to_date('20-04-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (759, 'Maggie', 'Humphrey', 383, 85271, 0, to_date('06-02-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (761, 'Miguel', 'Rourke', 23, 14983, 150, to_date('07-07-1991', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (762, 'Vondie', 'Myers', 56, 40870, 0, to_date('01-08-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (764, 'Debby', 'Levy', 337, 72143, 0, to_date('22-08-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (765, 'Olympia', 'Shannon', 212, 38847, 0, to_date('06-05-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (766, 'Russell', 'Loggins', 226, 18394, 0, to_date('18-05-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (767, 'Judge', 'Chaykin', 65, 65739, 0, to_date('27-02-1963', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (768, 'Denise', 'McConaughey', 61, 67044, 0, to_date('06-12-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (770, 'Paula', 'Watley', 143, 97893, 0, to_date('08-10-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (771, 'Emmylou', 'Secada', 385, 90659, 0, to_date('10-03-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (772, 'Boz', 'Portman', 77, 69120, 0, to_date('13-01-1965', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (773, 'Rene', 'Travers', 310, 94428, 0, to_date('02-09-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (774, 'Dylan', 'Cruz', 222, 78529, 0, to_date('04-06-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (775, 'Sarah', 'Lynch', 45, 25017, 0, to_date('30-08-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (776, 'Clint', 'Johnson', 355, 84564, 0, to_date('30-08-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (777, 'Jude', 'Apple', 205, 54100, 0, to_date('15-10-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (778, 'Sander', 'Turturro', 364, 14136, 237, to_date('06-05-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (779, 'Trini', 'Kutcher', 18, 87568, 0, to_date('22-09-1964', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (780, 'Rip', 'Savage', 268, 16786, 0, to_date('27-03-1986', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (781, 'Parker', 'Diggs', 189, 29409, 0, to_date('22-05-1995', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (782, 'Alfred', 'Ronstadt', 175, 17218, 0, to_date('02-09-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (783, 'Albert', 'Lerner', 100, 53400, 0, to_date('29-09-1977', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (784, 'Peter', 'Anderson', 80, 80730, 0, to_date('14-04-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (785, 'Bridgette', 'Keaton', 88, 23413, 0, to_date('12-09-1997', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (786, 'Remy', 'Ripley', 318, 68582, 0, to_date('22-08-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (788, 'Christine', 'Studi', 361, 52817, 0, to_date('22-12-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (789, 'Ellen', 'Kilmer', 229, 48228, 0, to_date('04-01-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (790, 'James', 'Badalucco', 191, 12589, 0, to_date('06-09-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (791, 'Mac', 'Moreno', 141, 27517, 0, to_date('01-01-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (792, 'Nicole', 'McGovern', 125, 56506, 0, to_date('24-09-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (794, 'Leelee', 'Evett', 326, 98035, 0, to_date('13-08-1986', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (795, 'Ron', 'Avital', 31, 65713, 0, to_date('14-03-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (796, 'Andrew', 'Crouse', 91, 93493, 0, to_date('14-01-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (797, 'Marisa', 'Robards', 259, 95258, 0, to_date('26-12-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (798, 'Lennie', 'Rawls', 317, 84655, 0, to_date('24-12-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (799, 'Merle', 'Holliday', 32, 43461, 0, to_date('14-02-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (800, 'Marley', 'Marx', 274, 30520, 0, to_date('19-04-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (801, 'Jay', 'Marshall', 145, 36000, 0, to_date('09-05-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (802, 'Desmond', 'O''Donnell', 266, 65249, 0, to_date('03-07-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (803, 'Bridget', 'Bedelia', 296, 54918, 0, to_date('04-12-1957', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (804, 'Sammy', 'Wiedlin', 299, 41823, 0, to_date('20-11-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (805, 'Kris', 'Chan', 183, 17928, 0, to_date('02-05-1989', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (806, 'Stellan', 'Hutton', 164, 33439, 0, to_date('02-09-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (807, 'Meg', 'Postlethwaite', 216, 39914, 0, to_date('10-07-1998', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (808, 'Jeffery', 'Connick', 35, 67192, 0, to_date('08-04-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (809, 'Jet', 'Blanchett', 183, 17413, 0, to_date('11-01-1961', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (810, 'Leonardo', 'Diaz', 389, 87047, 100, to_date('06-06-1997', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (811, 'Marc', 'Bell', 327, 39357, 0, to_date('21-12-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (812, 'Connie', 'Coburn', 162, 85668, 0, to_date('13-04-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (813, 'James', 'Reynolds', 202, 89848, 0, to_date('07-04-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (814, 'Rebecca', 'Diggs', 133, 97099, 0, to_date('17-01-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (815, 'Lois', 'Wilder', 344, 51270, 0, to_date('16-12-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (816, 'Andrew', 'Garfunkel', 258, 34857, 0, to_date('13-07-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (817, 'Franco', 'Bracco', 336, 48489, 0, to_date('27-02-1992', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (820, 'Harry', 'Garcia', 13, 95870, 0, to_date('25-11-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (821, 'Heath', 'DeGraw', 242, 93935, 0, to_date('18-10-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (823, 'Benjamin', 'Levy', 294, 10760, 0, to_date('26-02-1999', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (824, 'Rhona', 'Horizon', 367, 83893, 0, to_date('18-03-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (826, 'Laurence', 'Faithfull', 231, 80807, 0, to_date('08-02-1998', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (827, 'Louise', 'Williamson', 376, 53025, 0, to_date('27-12-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (828, 'Will', 'Holbrook', 170, 14373, 0, to_date('22-12-1988', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (829, 'Eddie', 'Weller', 178, 25538, 0, to_date('21-05-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (830, 'Ozzy', 'Molina', 134, 11099, 0, to_date('18-11-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (831, 'Giovanni', 'Vince', 1, 93580, 237, to_date('10-06-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (834, 'Tanya', 'Quinones', 165, 49904, 0, to_date('13-03-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (835, 'Laurence', 'Capshaw', 19, 68426, 0, to_date('03-01-1976', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (836, 'Jim', 'Mandrell', 159, 62349, 0, to_date('30-11-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (837, 'Patti', 'Hynde', 58, 75563, 0, to_date('25-07-1980', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (839, 'Glen', 'Gibson', 79, 70013, 0, to_date('11-05-1952', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (840, 'Cate', 'Flack', 132, 86537, 0, to_date('13-04-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (841, 'Gates', 'Manning', 347, 62710, 0, to_date('02-01-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (842, 'Hugh', 'Wheel', 363, 34106, 0, to_date('02-04-1973', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (844, 'Lydia', 'Vaughan', 337, 48324, 0, to_date('30-11-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (845, 'Gordie', 'Lonsdale', 330, 73595, 0, to_date('19-07-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (847, 'Rickie', 'Pleasure', 49, 98554, 0, to_date('21-04-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (848, 'Alice', 'Morton', 113, 24229, 0, to_date('25-09-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (849, 'Cary', 'Torres', 25, 57925, 0, to_date('14-06-1999', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (851, 'Gavin', 'Swank', 12, 89479, 0, to_date('08-01-1991', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (855, 'Dermot', 'Cole', 160, 79036, 0, to_date('18-02-1995', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (858, 'Crispin', 'Secada', 125, 26891, 0, to_date('28-09-1995', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (859, 'Eddie', 'Skaggs', 217, 70580, 0, to_date('23-02-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (860, 'Meredith', 'Williamson', 212, 53895, 0, to_date('01-09-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (862, 'Kasey', 'Stormare', 293, 40743, 0, to_date('28-04-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (863, 'Burton', 'Garber', 17, 85756, 0, to_date('21-10-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (864, 'Percy', 'Cleary', 71, 39431, 0, to_date('19-09-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (865, 'Orlando', 'Pride', 228, 62012, 0, to_date('13-02-1993', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (866, 'Rhett', 'Holiday', 320, 50187, 0, to_date('28-08-1971', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (867, 'Frances', 'Humphrey', 361, 48654, 0, to_date('12-03-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (868, 'Emm', 'Griggs', 217, 40436, 150, to_date('14-06-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (869, 'Anthony', 'Weiss', 274, 17459, 0, to_date('26-11-1956', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (870, 'Cevin', 'Suchet', 289, 66511, 0, to_date('02-08-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (871, 'Roy', 'McGriff', 4, 80598, 0, to_date('30-12-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (872, 'April', 'Redgrave', 71, 32647, 0, to_date('08-08-1964', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (873, 'Isaiah', 'Van Der Beek', 398, 32929, 0, to_date('25-04-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (875, 'Maria', 'Folds', 354, 35553, 0, to_date('28-10-1957', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (877, 'Karen', 'Ford', 36, 96401, 0, to_date('24-11-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (878, 'Terri', 'Yulin', 231, 20267, 0, to_date('14-05-1986', 'dd-mm-yyyy'), null);
commit;
prompt 400 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (879, 'Robert', 'King', 312, 76160, 0, to_date('25-09-1959', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (880, 'Fred', 'Supernaw', 393, 79518, 0, to_date('04-12-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (882, 'Ellen', 'Hanley', 204, 18226, 0, to_date('12-04-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (883, 'Steven', 'Tomlin', 22, 40400, 0, to_date('30-10-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (884, 'Nelly', 'King', 95, 35103, 0, to_date('06-09-1979', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (885, 'Davy', 'Murphy', 283, 10886, 0, to_date('25-12-1966', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (886, 'Rich', 'Duschel', 348, 39005, 0, to_date('12-12-1987', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (888, 'Cate', 'Briscoe', 324, 89250, 0, to_date('15-03-1969', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (889, 'Swoosie', 'Spall', 330, 28518, 0, to_date('02-12-1966', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (890, 'Walter', 'Farris', 60, 86491, 0, to_date('11-09-1965', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (891, 'Joan', 'Posener', 135, 52723, 0, to_date('22-10-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (894, 'Earl', 'Kattan', 312, 79105, 0, to_date('19-01-1982', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (895, 'Norm', 'Keitel', 224, 92145, 0, to_date('29-05-1984', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (896, 'Mitchell', 'Playboys', 350, 56214, 0, to_date('25-10-1967', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (897, 'Penelope', 'Brando', 79, 41075, 0, to_date('11-03-1986', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (898, 'Collective', 'Crewson', 107, 86929, 0, to_date('09-03-1951', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (899, 'Frances', 'Molina', 229, 25573, 0, to_date('02-10-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (900, 'Vincent', 'Lewin', 333, 88319, 0, to_date('02-05-1965', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (901, 'Giancarlo', 'Cassel', 68, 66245, 0, to_date('23-05-1960', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (902, 'Tom', 'Taha', 55, 34458, 0, to_date('01-07-1996', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (904, 'Debi', 'Oldman', 173, 88071, 0, to_date('18-08-1968', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (906, 'Charlie', 'Branch', 272, 38982, 0, to_date('02-05-1950', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (907, 'Coley', 'Cooper', 35, 38651, 0, to_date('10-09-1978', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (908, 'Jodie', 'Portman', 370, 58902, 0, to_date('15-04-1994', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (909, 'Ani', 'Blanchett', 83, 26519, 0, to_date('27-06-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (910, 'Bo', 'Coward', 203, 34588, 0, to_date('19-10-1981', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1000, 'Kalvin', 'Kleine', 1, 55121, 0, to_date('04-01-1962', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1001, 'Rickie', 'Stembridge', 2, 12927, 100, to_date('23-09-1974', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1002, 'Delora', 'De Paoli', 3, 38602, 0, to_date('22-02-1953', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1003, 'Malvina', 'Bouts', 4, 35225, 0, to_date('12-05-1983', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1004, 'Tracie', 'Hopkyns', 5, 39920, 0, to_date('04-05-1954', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1005, 'Maitilde', 'Renoden', 6, 75971, 0, to_date('24-12-1972', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1006, 'Ainsley', 'Merrydew', 7, 30226, 0, to_date('04-06-1958', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1007, 'Darrell', 'Lawles', 8, 27046, 0, to_date('09-12-1985', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1008, 'Steward', 'Rubra', 9, 65288, 0, to_date('25-08-1975', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1009, 'Patrica', 'Morshead', 10, 48871, 0, to_date('13-12-1961', 'dd-mm-yyyy'), null);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (1, 'Neneh', 'Price', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (2, 'Treat', 'Dorff', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (4, 'Henry', 'Rosas', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (5, 'Beverley', 'Goldwyn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (6, 'Ernie', 'Makeba', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (7, 'Gilberto', 'Satriani', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (8, 'Jeffrey', 'Albright', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (9, 'Emm', 'Craven', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (10, 'Hex', 'Folds', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (12, 'Nigel', 'Wincott', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (13, 'Taye', 'Parm', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (14, 'Chuck', 'McKean', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (15, 'Clarence', 'Dickinson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (16, 'Tara', 'Harmon', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (17, 'Philip', 'Ruffalo', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (18, 'Shirley', 'Gough', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (19, 'Nathan', 'Prinze', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (21, 'Colin', 'O''Neal', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (22, 'Pierce', 'Butler', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (23, 'Isaiah', 'Cobbs', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (24, 'Jose', 'Berenger', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (25, 'Emerson', 'Trejo', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (26, 'Coley', 'Sawa', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (28, 'Ashton', 'Dafoe', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (29, 'Roddy', 'Gordon', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (30, 'Vin', 'Navarro', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (31, 'Paul', 'Garfunkel', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (32, 'Debra', 'Rodriguez', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (33, 'Andrea', 'Hawn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (35, 'Chuck', 'Mueller-Stahl', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (36, 'Christine', 'Orbit', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (37, 'Ellen', 'Vanian', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (38, 'Julianna', 'O''Neal', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (39, 'Cameron', 'Griffin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (40, 'Rita', 'Lynne', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (41, 'Hal', 'Stevens', null, null, 39, null, 50);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (42, 'Rhys', 'Hershey', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (44, 'Adrien', 'Navarro', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (45, 'Sammy', 'Cantrell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (46, 'Joseph', 'Mattea', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (47, 'Tilda', 'Cohn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (48, 'Bridgette', 'O''Donnell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (49, 'Alan', 'Dunst', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (50, 'Anthony', 'Benet', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (51, 'Kate', 'Paymer', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (53, 'Phoebe', 'Oates', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (54, 'David', 'McAnally', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (55, 'Daryle', 'Hanley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (56, 'Wade', 'McDowell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (57, 'Dionne', 'Daniels', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (58, 'Jessica', 'Wood', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (59, 'Austin', 'Leachman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (61, 'Hex', 'Paymer', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (62, 'Russell', 'Oakenfold', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (63, 'Rueben', 'Sanchez', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (64, 'Steven', 'Vassar', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (65, 'Bryan', 'Lemmon', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (66, 'Emilio', 'Tillis', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (68, 'Meg', 'Diddley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (69, 'Jonatha', 'Diaz', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (70, 'Wang', 'Kurtz', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (71, 'Miguel', 'Shand', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (72, 'Maura', 'Gold', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (73, 'Lila', 'Lewis', null, null, 35, null, 0);
commit;
prompt 500 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (74, 'Dean', 'Cozier', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (76, 'Frankie', 'Thorton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (77, 'Dylan', 'Negbaur', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (78, 'Kathleen', 'Hershey', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (79, 'Rachael', 'Thurman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (80, 'Adina', 'Lauper', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (81, 'Nik', 'Nakai', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (82, 'Wallace', 'Sobieski', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (84, 'Doug', 'Crouse', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (85, 'Ossie', 'Wen', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (86, 'Chet', 'Finn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (87, 'Mae', 'Watley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (88, 'Judi', 'Yorn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (89, 'Tori', 'Postlethwaite', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (90, 'Aida', 'Holmes', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (91, 'Gates', 'Berkeley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (93, 'Pete', 'Kahn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (94, 'Eliza', 'McLachlan', null, null, 39, null, 50);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (95, 'Delbert', 'Scott', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (96, 'Tzi', 'Ferrell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (97, 'ChantÃ©', 'Lloyd', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (98, 'Connie', 'Vannelli', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (99, 'Lindsey', 'Heche', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (101, 'Eric', 'Adler', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (102, 'Joan', 'Conley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (103, 'Janeane', 'Orton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (104, 'Geena', 'Pierce', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (105, 'Terence', 'Clarkson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (106, 'Kirsten', 'Sizemore', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (107, 'Chubby', 'Moore', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (109, 'Loretta', 'Lewis', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (110, 'Ed', 'Fehr', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (111, 'Tracy', 'Lang', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (112, 'Freda', 'Doucette', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (113, 'Nick', 'Kilmer', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (114, 'Rolando', 'Webb', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (115, 'Remy', 'Heche', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (117, 'Gordon', 'Hunt', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (118, 'Tamala', 'MacDonald', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (119, 'Minnie', 'Law', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (120, 'Andrew', 'Palminteri', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (121, 'Albertina', 'Makeba', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (122, 'Giancarlo', 'Hawkins', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (123, 'Frederic', 'Silverman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (124, 'Catherine', 'Jeter', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (126, 'Teri', 'Santa Rosa', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (127, 'Rory', 'Margolyes', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (128, 'Phil', 'Garofalo', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (129, 'Marina', 'Cervine', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (130, 'Liev', 'Kudrow', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (131, 'Boyd', 'Underwood', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (132, 'Stevie', 'Pierce', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (133, 'Mae', 'Cross', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (134, 'Shannyn', 'Burstyn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (136, 'Lauren', 'Cartlidge', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (137, 'Neve', 'Balaban', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (138, 'Rosanna', 'Rodgers', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (139, 'Andrae', 'Willis', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (140, 'Jeffrey', 'Preston', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (141, 'Kevn', 'Fiennes', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (142, 'Alana', 'Penders', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (143, 'Wes', 'Duchovny', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (145, 'Bill', 'McGinley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (146, 'Whoopi', 'Stevenson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (147, 'Scarlett', 'Berry', null, null, 39, null, 50);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (148, 'Peter', 'Tomei', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (149, 'Charlie', 'Clayton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (150, 'Allan', 'Shepard', null, null, 39, null, 50);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (151, 'Pat', 'Thurman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (153, 'Hikaru', 'Burmester', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (154, 'Cloris', 'Jeter', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (155, 'Edward', 'Kattan', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (156, 'Geggy', 'Margulies', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (157, 'Gina', 'Davidson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (158, 'Mia', 'Sharp', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (159, 'Powers', 'King', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (161, 'Diamond', 'Everett', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (162, 'Jill', 'Coughlan', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (163, 'Cathy', 'Birch', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (164, 'Taylor', 'Singh', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (165, 'Lennie', 'Bates', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (166, 'Ike', 'Vaughan', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (167, 'Neve', 'Rankin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (168, 'Collective', 'Horton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (169, 'Jim', 'Orton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (170, 'Joan', 'O''Hara', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (171, 'Natacha', 'Spears', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (173, 'Xander', 'Rock', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (174, 'Edgar', 'Fiorentino', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (175, 'Miles', 'Rauhofer', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (176, 'Emm', 'Brody', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (177, 'Crispin', 'Berkley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (178, 'Cheryl', 'Fox', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (179, 'Nelly', 'Flanagan', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (180, 'David', 'Paquin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (182, 'Giovanni', 'Trejo', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (183, 'Herbie', 'Dreyfuss', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (184, 'Lynn', 'Ripley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (185, 'Dave', 'Aiken', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (186, 'Katrin', 'Head', null, null, 35, null, 0);
commit;
prompt 600 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (187, 'Miles', 'Sossamon', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (189, 'Joey', 'Rubinek', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (190, 'Marc', 'Leachman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (191, 'Jean', 'Dean', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (192, 'Clive', 'Luongo', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (193, 'Woody', 'Cochran', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (194, 'Catherine', 'Summer', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (195, 'Aidan', 'Fichtner', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (197, 'Keith', 'Azaria', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (198, 'Kirsten', 'Logue', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (199, 'Harrison', 'Cromwell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (200, 'Howard', 'McLean', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (201, 'Vanessa', 'Sawa', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (202, 'Andrae', 'Hornsby', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (203, 'Drew', 'Evanswood', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (205, 'Danni', 'Whitmore', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (206, 'Red', 'Boone', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (207, 'Winona', 'Redgrave', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (208, 'Marlon', 'Cara', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (209, 'Melanie', 'Curry', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (210, 'Devon', 'Epps', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (211, 'Denzel', 'Pigott-Smith', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (212, 'Lin', 'Klein', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (214, 'Trick', 'Sedaka', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (215, 'Jill', 'Visnjic', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (216, 'Terrence', 'Dean', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (217, 'Tanya', 'Carradine', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (218, 'Lauren', 'Easton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (220, 'Nicholas', 'Borden', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (221, 'Carrie-Anne', 'Vince', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (222, 'Colin', 'Utada', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (223, 'Judge', 'Reeves', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (224, 'Pamela', 'Thorton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (225, 'Bradley', 'Daniels', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (227, 'Dorry', 'Furay', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (228, 'Darren', 'Heron', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (229, 'Brooke', 'Stone', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (230, 'Timothy', 'Bean', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (231, 'Lynette', 'Lawrence', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (232, 'Lois', 'Warden', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (233, 'Dick', 'Jeter', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (235, 'Brenda', 'Lowe', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (236, 'Rebeka', 'Harris', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (237, 'Luis', 'Cooper', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (238, 'Lily', 'Davis', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (239, 'Diane', 'Gandolfini', null, null, 39, null, 50);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (240, 'Oro', 'Vannelli', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (242, 'Irene', 'Adkins', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (243, 'Melba', 'Bright', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (244, 'Coley', 'Conroy', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (245, 'Drew', 'Paige', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (246, 'Celia', 'Sandoval', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (247, 'Al', 'Mantegna', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (248, 'Spike', 'Bridges', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (249, 'Cameron', 'Mirren', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (251, 'Woody', 'Ramirez', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (252, 'Willem', 'Burrows', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (253, 'Isaiah', 'Briscoe', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (254, 'Aidan', 'Hershey', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (255, 'Rod', 'David', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (256, 'Stellan', 'Finn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (257, 'Albertina', 'Cazale', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (258, 'Gaby', 'Wainwright', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (260, 'Dennis', 'McCoy', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (261, 'Daryl', 'MacDonald', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (262, 'Leon', 'Strathairn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (263, 'Bernie', 'Himmelman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (264, 'Holland', 'Zane', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (265, 'Mae', 'Stiers', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (266, 'Murray', 'Leary', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (268, 'Burt', 'Baranski', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (269, 'Sammy', 'Wariner', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (270, 'Suzanne', 'Coolidge', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (271, 'Todd', 'Sainte-Marie', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (272, 'Liev', 'Burns', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (274, 'Benicio', 'Weisberg', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (275, 'Gilberto', 'Mandrell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (277, 'Nils', 'Kane', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (279, 'Hope', 'Young', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (280, 'Rachel', 'Andrews', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (281, 'Quentin', 'Slater', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (282, 'Trace', 'DiBiasio', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (284, 'Katrin', 'Koteas', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (285, 'Marlon', 'Turner', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (287, 'Lena', 'Bergen', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (289, 'Joseph', 'Stowe', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (290, 'Mika', 'Ellis', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (291, 'Gary', 'Sirtis', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (293, 'Vickie', 'Emmett', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (294, 'Marianne', 'Nicholas', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (295, 'Rade', 'Thomson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (297, 'Lindsay', 'Margulies', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (299, 'Ernest', 'Sorvino', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (301, 'Taryn', 'Belushi', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (302, 'Edgar', 'Olin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (303, 'Rosie', 'Payne', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (304, 'Glenn', 'Lapointe', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (306, 'Tamala', 'Sweet', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (307, 'Alec', 'Iglesias', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (308, 'Teri', 'Atlas', null, null, 35, null, 0);
commit;
prompt 700 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (311, 'Collin', 'Gold', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (312, 'Boyd', 'Ticotin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (313, 'Woody', 'Jackman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (314, 'Adam', 'Palminteri', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (316, 'Jeffery', 'Navarro', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (317, 'Gary', 'Frost', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (320, 'Linda', 'Gough', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (321, 'Jimmie', 'Mohr', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (322, 'Joely', 'LuPone', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (323, 'Kate', 'Adams', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (324, 'Dick', 'Woodard', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (325, 'Ossie', 'MacDonald', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (326, 'Larnelle', 'Downey', null, null, 39, null, 50);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (327, 'Sigourney', 'Dalton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (328, 'Patty', 'Makowicz', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (329, 'Tim', 'Farris', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (330, 'Manu', 'Haysbert', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (331, 'Marisa', 'Pitney', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (332, 'Lloyd', 'Lithgow', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (333, 'Victoria', 'MacDowell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (334, 'Jennifer', 'Mitra', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (335, 'Udo', 'Shatner', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (336, 'Laurie', 'Cronin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (337, 'James', 'Nash', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (338, 'Ronnie', 'Rispoli', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (339, 'Lois', 'Forrest', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (340, 'Amy', 'Conlee', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (341, 'Taye', 'Conley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (342, 'Emma', 'Moriarty', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (343, 'Dean', 'Zappacosta', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (344, 'Melanie', 'Tobolowsky', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (345, 'Demi', 'Fiennes', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (346, 'Courtney', 'Purefoy', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (347, 'Talvin', 'Belle', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (348, 'Daryl', 'Duncan', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (349, 'Gilberto', 'Keith', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (350, 'Barbara', 'DeLuise', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (351, 'Campbell', 'Sobieski', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (352, 'Angie', 'Crimson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (353, 'Christian', 'Sedgwick', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (354, 'Elvis', 'Snider', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (355, 'Philip', 'Ferry', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (356, 'Joseph', 'Judd', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (357, 'Chaka', 'Blige', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (358, 'Ann', 'Sizemore', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (359, 'Sander', 'Snipes', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (360, 'Rupert', 'Harrison', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (361, 'Nicole', 'Belushi', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (362, 'Oliver', 'Brooks', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (363, 'Christmas', 'Wiedlin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (364, 'Lizzy', 'Posener', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (365, 'Joaquim', 'Pitney', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (366, 'Jean-Luc', 'Dillon', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (367, 'Lily', 'Dorff', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (368, 'Sigourney', 'Lynn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (369, 'Debbie', 'Paquin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (370, 'Wayman', 'Shorter', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (371, 'Davis', 'Arjona', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (372, 'Hazel', 'Davidtz', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (373, 'Sydney', 'Malkovich', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (374, 'Bret', 'McBride', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (375, 'Linda', 'MacNeil', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (376, 'Jena', 'Idle', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (377, 'Carlos', 'Lynn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (378, 'Aaron', 'Payton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (379, 'Daryle', 'Shue', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (380, 'Kelli', 'Farrell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (381, 'Patricia', 'Roberts', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (382, 'Derrick', 'Deejay', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (383, 'Jonny Lee', 'Teng', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (384, 'Vendetta', 'Janssen', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (385, 'Beverley', 'Clayton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (386, 'Suzi', 'Mac', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (387, 'Sophie', 'Patton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (388, 'Brian', 'Gough', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (389, 'Bo', 'Singletary', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (390, 'Azucar', 'Ryder', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (391, 'Illeana', 'Lovitz', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (392, 'Miguel', 'Lloyd', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (393, 'Cornell', 'Candy', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (394, 'Mickey', 'Johansson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (395, 'Laurence', 'Collins', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (396, 'Jake', 'Stuermer', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (397, 'Bette', 'Biehn', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (398, 'Kathy', 'Affleck', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (399, 'Curtis', 'Elizabeth', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (400, 'Emilio', 'Carrere', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (273, 'Chrissie', 'Bale', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (278, 'Kathleen', 'Hall', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (283, 'Cherry', 'Emmett', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (288, 'David', 'Keen', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (292, 'Jack', 'Walken', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (296, 'Oro', 'Lillard', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (300, 'Buddy', 'DeVito', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (305, 'Mos', 'Milsap', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (309, 'Lydia', 'Richardson', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (315, 'Daryl', 'Osmond', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (319, 'Bryan', 'Westerberg', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (3, 'Tommy', 'Portman', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (11, 'Woody', 'Doucette', null, null, 35, null, 0);
commit;
prompt 800 records committed...
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (20, 'Carol', 'Green', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (27, 'Kitty', 'Ripley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (34, 'Annette', 'Barnett', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (43, 'Mekhi', 'O''Connor', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (52, 'Parker', 'Ripley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (60, 'Robby', 'Gayle', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (67, 'Kurt', 'Faithfull', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (75, 'Diane', 'Arthur', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (83, 'Robert', 'Whitford', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (92, 'Tori', 'Iglesias', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (100, 'Lauren', 'Dourif', null, null, 39, null, 50);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (108, 'Nancy', 'Matthau', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (116, 'Armand', 'Lucien', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (125, 'Victoria', 'Borgnine', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (135, 'Campbell', 'Ness', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (144, 'Adrien', 'Laurie', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (152, 'Suzy', 'Fiennes', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (160, 'Stanley', 'Rhys-Davies', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (172, 'Carol', 'O''Connor', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (181, 'Sara', 'Larter', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (188, 'Night', 'Dafoe', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (196, 'Brian', 'Chilton', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (204, 'Lee', 'von Sydow', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (213, 'Jon', 'Bell', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (219, 'Diane', 'Chan', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (226, 'Chris', 'Paquin', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (234, 'Ike', 'DeLuise', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (241, 'Edgar', 'McGoohan', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (250, 'Reese', 'Guinness', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (259, 'Molly', 'Brooks', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (267, 'Ronny', 'Cassel', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (276, 'Moe', 'Tinsley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (286, 'Victor', 'Lindley', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (298, 'David', 'Underwood', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (310, 'Seth', 'Ford', null, null, 35, null, 0);
insert into TEACHERS (teacher_id, teacher_fname, teacher_lname, teacher_addr, teacher_tel, teacher_salary, teacher_join_date, bonus)
values (318, 'Collective', 'Buffalo', null, null, 35, null, 0);
commit;
prompt 836 records loaded
prompt Loading CLASS_...
insert into CLASS_ (class_id, grade, teacher_id)
values (1, 2, 177);
insert into CLASS_ (class_id, grade, teacher_id)
values (2, 2, 207);
insert into CLASS_ (class_id, grade, teacher_id)
values (3, 1, 387);
insert into CLASS_ (class_id, grade, teacher_id)
values (4, 11, 315);
insert into CLASS_ (class_id, grade, teacher_id)
values (5, 11, 27);
insert into CLASS_ (class_id, grade, teacher_id)
values (6, 1, 272);
insert into CLASS_ (class_id, grade, teacher_id)
values (7, 12, 384);
insert into CLASS_ (class_id, grade, teacher_id)
values (8, 11, 353);
insert into CLASS_ (class_id, grade, teacher_id)
values (9, 2, 397);
insert into CLASS_ (class_id, grade, teacher_id)
values (10, 10, 103);
insert into CLASS_ (class_id, grade, teacher_id)
values (11, 12, 146);
insert into CLASS_ (class_id, grade, teacher_id)
values (12, 8, 63);
insert into CLASS_ (class_id, grade, teacher_id)
values (13, 9, 249);
insert into CLASS_ (class_id, grade, teacher_id)
values (14, 11, 269);
insert into CLASS_ (class_id, grade, teacher_id)
values (15, 1, 160);
insert into CLASS_ (class_id, grade, teacher_id)
values (16, 11, 181);
insert into CLASS_ (class_id, grade, teacher_id)
values (17, 12, 234);
insert into CLASS_ (class_id, grade, teacher_id)
values (18, 2, 5);
insert into CLASS_ (class_id, grade, teacher_id)
values (19, 8, 381);
insert into CLASS_ (class_id, grade, teacher_id)
values (20, 8, 364);
insert into CLASS_ (class_id, grade, teacher_id)
values (21, 1, 309);
insert into CLASS_ (class_id, grade, teacher_id)
values (22, 5, 365);
insert into CLASS_ (class_id, grade, teacher_id)
values (23, 5, 328);
insert into CLASS_ (class_id, grade, teacher_id)
values (24, 10, 242);
insert into CLASS_ (class_id, grade, teacher_id)
values (25, 5, 162);
insert into CLASS_ (class_id, grade, teacher_id)
values (26, 1, 212);
insert into CLASS_ (class_id, grade, teacher_id)
values (27, 7, 120);
insert into CLASS_ (class_id, grade, teacher_id)
values (28, 3, 89);
insert into CLASS_ (class_id, grade, teacher_id)
values (29, 12, 208);
insert into CLASS_ (class_id, grade, teacher_id)
values (30, 4, 144);
insert into CLASS_ (class_id, grade, teacher_id)
values (31, 10, 338);
insert into CLASS_ (class_id, grade, teacher_id)
values (32, 6, 290);
insert into CLASS_ (class_id, grade, teacher_id)
values (33, 2, 80);
insert into CLASS_ (class_id, grade, teacher_id)
values (34, 2, 383);
insert into CLASS_ (class_id, grade, teacher_id)
values (35, 4, 288);
insert into CLASS_ (class_id, grade, teacher_id)
values (36, 2, 39);
insert into CLASS_ (class_id, grade, teacher_id)
values (37, 5, 60);
insert into CLASS_ (class_id, grade, teacher_id)
values (38, 11, 302);
insert into CLASS_ (class_id, grade, teacher_id)
values (39, 10, 348);
insert into CLASS_ (class_id, grade, teacher_id)
values (40, 4, 237);
insert into CLASS_ (class_id, grade, teacher_id)
values (42, 6, 2);
insert into CLASS_ (class_id, grade, teacher_id)
values (43, 7, 3);
insert into CLASS_ (class_id, grade, teacher_id)
values (44, 9, 4);
insert into CLASS_ (class_id, grade, teacher_id)
values (45, 3, 6);
insert into CLASS_ (class_id, grade, teacher_id)
values (46, 6, 7);
commit;
prompt 45 records loaded
prompt Loading CLIENTS...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1, 'Andre', 'Burton', 1, 91284, 0, to_date('10-02-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2, 'Glen', 'Meyer', 2, 69755, 0, to_date('23-02-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (3, 'Davis', 'Posener', 3, 16955, 0, to_date('11-01-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (4, 'Fairuza', 'Gibbons', 4, 69060, 0, to_date('16-02-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (5, 'Jackie', 'Vance', 5, 87283, 0, to_date('31-08-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (6, 'Chad', 'Sawa', 6, 36592, 0, to_date('11-12-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (7, 'Natasha', 'Cassidy', 7, 61826, 0, to_date('30-09-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (8, 'Kyra', 'Worrell', 8, 10109, 0, to_date('13-11-1989', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (9, 'Raul', 'Mazzello', 9, 23367, 151, to_date('27-02-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (10, 'Wade', 'Clinton', 10, 88313, 521, to_date('24-05-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (11, 'Seann', 'Pleasure', 383, 23724, 0, to_date('18-03-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (13, 'Tzi', 'Dickinson', 178, 14932, 0, to_date('14-04-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (14, 'Dick', 'Andrews', 325, 78976, 0, to_date('02-08-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (15, 'Mae', 'Mohr', 295, 19379, 0, to_date('16-09-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (16, 'Vin', 'Lipnicki', 146, 95435, 0, to_date('20-03-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (17, 'Dennis', 'Chambers', 371, 13246, 0, to_date('18-09-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (18, 'Amanda', 'Galecki', 253, 73631, 0, to_date('17-04-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (19, 'Nik', 'Peet', 26, 55925, 0, to_date('22-02-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (20, 'Warren', 'Rodgers', 272, 97220, 0, to_date('19-06-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (21, 'Jonny Lee', 'Peet', 296, 21980, 0, to_date('29-05-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (22, 'Allan', 'Heron', 32, 38091, 0, to_date('02-07-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (23, 'Anjelica', 'Flatts', 372, 77805, 0, to_date('29-11-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (24, 'Jose', 'Fiennes', 39, 56454, 0, to_date('29-10-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (25, 'Kazem', 'Kudrow', 397, 53761, 0, to_date('01-10-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (26, 'Christian', 'Craig', 182, 92722, 0, to_date('01-11-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (27, 'Ray', 'O''Keefe', 379, 25072, 0, to_date('10-10-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (28, 'Mitchell', 'Phifer', 368, 90739, 0, to_date('20-09-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (29, 'Kelly', 'Cheadle', 170, 27265, 0, to_date('02-05-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (31, 'Christine', 'Pacino', 377, 94427, 0, to_date('19-04-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (32, 'Trick', 'Bonham', 37, 92020, 0, to_date('28-01-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (33, 'Jeroen', 'Krieger', 155, 31070, 0, to_date('07-03-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (34, 'Andie', 'Bloch', 162, 36013, 0, to_date('21-12-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (35, 'Charlie', 'Willis', 335, 60877, 0, to_date('20-05-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (36, 'Mia', 'Grant', 292, 56531, 0, to_date('04-06-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (37, 'Emilio', 'Saucedo', 58, 98120, 0, to_date('13-01-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (38, 'Phil', 'Shorter', 306, 31971, 0, to_date('03-11-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (39, 'Peabo', 'Waits', 347, 90018, 0, to_date('24-10-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (40, 'Gene', 'Cobbs', 183, 60360, 0, to_date('17-07-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (41, 'Burt', 'Colon', 198, 30829, 0, to_date('27-09-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (43, 'Emma', 'Schwimmer', 32, 70950, 0, to_date('28-11-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (44, 'Cuba', 'Dean', 232, 60641, 0, to_date('04-09-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (45, 'William', 'Starr', 269, 86805, 0, to_date('09-08-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (46, 'Paula', 'Moreno', 232, 91908, 0, to_date('31-07-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (47, 'Jeremy', 'Shatner', 74, 79810, 0, to_date('18-03-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (48, 'Taye', 'Himmelman', 16, 62370, 0, to_date('20-04-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (49, 'Maury', 'Richards', 243, 95190, 0, to_date('06-12-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (50, 'Rutger', 'Gooding', 137, 37426, 0, to_date('06-05-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (52, 'Nicholas', 'Devine', 85, 20844, 0, to_date('22-06-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (53, 'Thin', 'Suvari', 183, 63641, 0, to_date('12-07-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (54, 'Liev', 'Def', 382, 20224, 0, to_date('06-09-1989', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (55, 'Sonny', 'Schreiber', 131, 56626, 0, to_date('08-05-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (56, 'Robert', 'Aykroyd', 195, 19734, 0, to_date('24-09-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (58, 'Noah', 'Witt', 65, 47156, 0, to_date('28-09-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (59, 'Sophie', 'Rankin', 355, 52604, 0, to_date('25-07-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (62, 'Millie', 'Carradine', 260, 36093, 0, to_date('04-09-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (63, 'Nathan', 'Langella', 94, 64000, 0, to_date('18-07-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (66, 'Geoffrey', 'Puckett', 364, 30551, 0, to_date('12-09-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (67, 'Max', 'Buffalo', 293, 17035, 0, to_date('14-08-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (69, 'Fairuza', 'Malone', 166, 82076, 0, to_date('27-05-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (70, 'Johnny', 'Pride', 382, 59947, 0, to_date('14-09-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (72, 'Sophie', 'Venora', 379, 19970, 0, to_date('08-08-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (73, 'Frank', 'Hauer', 97, 90421, 0, to_date('07-04-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (74, 'Crispin', 'Stamp', 318, 95472, 0, to_date('15-06-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (75, 'Sona', 'Cole', 243, 87687, 0, to_date('24-01-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (76, 'Ty', 'Foley', 218, 62302, 0, to_date('09-11-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (77, 'Curt', 'Scott', 391, 32722, 0, to_date('26-03-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (78, 'Tracy', 'Cantrell', 307, 11604, 0, to_date('26-04-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (79, 'Kelli', 'Rispoli', 29, 46876, 0, to_date('17-04-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (81, 'Faye', 'Foster', 14, 93949, 0, to_date('11-02-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (82, 'Marlon', 'Rudd', 264, 93226, 0, to_date('03-08-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (83, 'Rosanne', 'Theron', 330, 68548, 0, to_date('10-10-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (84, 'Mandy', 'Puckett', 114, 13562, 0, to_date('15-06-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (85, 'Harvey', 'Slater', 283, 25863, 0, to_date('23-10-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (86, 'Chrissie', 'Willard', 258, 18391, 0, to_date('01-05-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (87, 'Joey', 'Stevens', 204, 31138, 0, to_date('02-06-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (88, 'Joy', 'Orbit', 174, 69124, 0, to_date('24-05-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (91, 'Jarvis', 'Weiss', 71, 70257, 0, to_date('21-02-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (92, 'Corey', 'Cronin', 298, 70088, 0, to_date('30-08-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (93, 'Hex', 'Mattea', 367, 68976, 0, to_date('27-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (94, 'Solomon', 'Dunn', 344, 83271, 0, to_date('29-07-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (95, 'Rolando', 'Gere', 347, 29725, 0, to_date('05-05-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (96, 'Aaron', 'Stanton', 143, 84975, 0, to_date('31-10-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (97, 'Hookah', 'Walken', 91, 44165, 0, to_date('20-10-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (98, 'Whoopi', 'Callow', 86, 68447, 0, to_date('03-11-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (99, 'Jessica', 'Badalucco', 201, 43229, 0, to_date('23-05-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (100, 'Jeffrey', 'Idol', 241, 30651, 0, to_date('26-12-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (101, 'Deborah', 'Cazale', 392, 16345, 0, to_date('21-07-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (103, 'Donald', 'Winstone', 36, 86612, 0, to_date('19-03-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (104, 'Junior', 'Ruiz', 147, 97903, 0, to_date('08-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (105, 'Ed', 'Redgrave', 206, 32704, 0, to_date('26-10-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (106, 'Randall', 'Epps', 120, 68888, 0, to_date('25-01-1989', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (107, 'Kathleen', 'Cale', 97, 30780, 0, to_date('27-11-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (108, 'Busta', 'Flanery', 95, 12624, 0, to_date('12-07-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (109, 'Horace', 'Crimson', 357, 92186, 0, to_date('02-06-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (110, 'Joy', 'Postlethwaite', 167, 36082, 0, to_date('11-04-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (111, 'Sammy', 'Marshall', 3, 15237, 0, to_date('20-06-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (112, 'Vin', 'Uggams', 190, 12632, 0, to_date('09-04-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (113, 'Nicole', 'Creek', 60, 71837, 0, to_date('17-04-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (114, 'Tobey', 'Gore', 112, 14362, 0, to_date('15-07-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (117, 'Vivica', 'DiBiasio', 333, 63773, 0, to_date('24-01-2014', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 100 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (119, 'Ceili', 'Coe', 361, 11624, 0, to_date('06-03-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (120, 'Raul', 'Mitchell', 397, 49674, 0, to_date('27-09-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (121, 'Walter', 'Crewson', 347, 42785, 0, to_date('15-08-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (122, 'Gran', 'Mann', 33, 65288, 0, to_date('27-08-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (123, 'Tea', 'Sainte-Marie', 58, 46126, 0, to_date('13-11-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (124, 'Gord', 'Wilder', 114, 22064, 0, to_date('15-07-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (125, 'Mia', 'Tucci', 292, 34558, 0, to_date('15-10-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (126, 'Johnette', 'Coward', 207, 95179, 0, to_date('10-01-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (127, 'Clive', 'Jackson', 29, 97510, 0, to_date('02-05-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (128, 'Davis', 'Tarantino', 240, 53459, 0, to_date('11-07-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (129, 'Willie', 'Weiss', 372, 64517, 0, to_date('25-01-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (130, 'Chely', 'Caldwell', 256, 24280, 0, to_date('12-01-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (131, 'Hilary', 'Salt', 116, 23179, 0, to_date('17-08-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (133, 'Rowan', 'Garr', 326, 67303, 0, to_date('04-06-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (134, 'Machine', 'Khan', 125, 90922, 0, to_date('11-09-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (135, 'Marc', 'Wolf', 154, 13473, 0, to_date('06-03-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (136, 'Brent', 'Donovan', 157, 60458, 0, to_date('02-11-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (137, 'Hex', 'Fraser', 274, 26868, 0, to_date('13-02-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (139, 'Emilio', 'Driver', 375, 59574, 0, to_date('30-11-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (140, 'Alana', 'Ruffalo', 196, 18219, 0, to_date('12-04-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (142, 'Don', 'Stoltz', 326, 25861, 0, to_date('06-03-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (145, 'Loreena', 'Badalucco', 57, 23668, 0, to_date('01-10-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (146, 'Leslie', 'Belles', 60, 46663, 0, to_date('10-12-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (147, 'Jonatha', 'Kleinenberg', 400, 50003, 0, to_date('17-07-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (148, 'Percy', 'Malone', 365, 47724, 0, to_date('28-02-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (149, 'Bonnie', 'Yankovic', 173, 84997, 0, to_date('07-05-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (150, 'Loreena', 'MacDowell', 48, 89901, 0, to_date('31-05-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (151, 'Juice', 'Neil', 71, 30867, 0, to_date('17-12-1989', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (152, 'Debbie', 'Lynn', 188, 98933, 0, to_date('11-12-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (153, 'Seann', 'Burmester', 208, 65866, 0, to_date('05-10-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (154, 'Janice', 'Crosby', 224, 69397, 0, to_date('14-01-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (156, 'Mary', 'Melvin', 310, 68555, 0, to_date('14-11-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (157, 'Wayman', 'Matarazzo', 17, 20127, 0, to_date('26-10-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (158, 'Udo', 'Lachey', 217, 33583, 0, to_date('15-11-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (159, 'Naomi', 'Fogerty', 134, 35765, 0, to_date('29-05-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (160, 'Madeline', 'De Niro', 262, 66681, 0, to_date('28-08-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (163, 'Kenny', 'Nunn', 196, 43107, 0, to_date('30-06-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (164, 'Graham', 'Lineback', 68, 65813, 0, to_date('06-06-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (165, 'Candice', 'Costner', 55, 63826, 0, to_date('12-03-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (166, 'Jean', 'Griggs', 274, 96207, 0, to_date('24-05-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (167, 'Tcheky', 'Wills', 48, 93920, 0, to_date('03-03-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (168, 'Ruth', 'Cagle', 384, 56434, 0, to_date('14-05-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (169, 'Gin', 'Idle', 152, 84601, 0, to_date('16-02-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (170, 'Maggie', 'Harrelson', 253, 89345, 0, to_date('08-02-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (172, 'Cyndi', 'Mandrell', 157, 28197, 0, to_date('11-12-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (173, 'Eugene', 'Viterelli', 375, 92263, 0, to_date('12-09-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (174, 'Hope', 'Faithfull', 202, 43957, 0, to_date('31-12-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (175, 'Merrilee', 'Kramer', 286, 86972, 0, to_date('25-05-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (176, 'Mel', 'Garza', 222, 46743, 0, to_date('30-08-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (177, 'Taylor', 'Pride', 179, 56757, 0, to_date('02-01-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (178, 'LeVar', 'Carnes', 187, 98460, 0, to_date('21-10-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (179, 'Joshua', 'Cube', 326, 39283, 0, to_date('11-02-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (180, 'Joy', 'Himmelman', 5, 66140, 0, to_date('06-06-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (181, 'Greg', 'Eastwood', 138, 19664, 0, to_date('20-12-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (182, 'Bebe', 'Osbourne', 145, 98029, 0, to_date('02-09-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (183, 'Giovanni', 'Kingsley', 103, 54151, 0, to_date('04-05-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (184, 'Madeleine', 'Graham', 168, 16950, 0, to_date('09-06-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (185, 'Harrison', 'Black', 291, 31799, 0, to_date('09-12-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (186, 'Harrison', 'Beckham', 390, 67974, 0, to_date('18-01-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (188, 'Collin', 'Baldwin', 371, 79924, 0, to_date('19-08-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (189, 'Garland', 'Eat World', 207, 51436, 0, to_date('15-05-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (190, 'Bridget', 'Allan', 38, 62751, 0, to_date('19-03-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (191, 'Judge', 'Parsons', 157, 85396, 0, to_date('11-09-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (192, 'Powers', 'Skaggs', 158, 65313, 0, to_date('23-09-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (193, 'Cuba', 'Hamilton', 385, 73149, 0, to_date('11-07-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (195, 'CeCe', 'Choice', 296, 31731, 0, to_date('30-05-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (196, 'Kurtwood', 'Kudrow', 173, 57812, 0, to_date('24-10-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (197, 'Glen', 'Yorn', 167, 37292, 0, to_date('22-04-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (198, 'Carlos', 'Portman', 30, 73713, 0, to_date('12-01-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (199, 'Mae', 'Dunst', 336, 34486, 0, to_date('22-11-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (200, 'Carlos', 'Hong', 98, 77129, 0, to_date('30-06-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (201, 'Arnold', 'Osborne', 191, 60094, 0, to_date('23-01-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (202, 'Lucinda', 'Olin', 190, 54296, 0, to_date('29-08-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (203, 'Alessandro', 'Pleasence', 232, 44153, 0, to_date('13-08-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (204, 'Julio', 'Pfeiffer', 113, 14171, 0, to_date('06-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (205, 'Stephen', 'Rickman', 152, 84379, 0, to_date('16-07-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (206, 'Fisher', 'Vai', 110, 85888, 0, to_date('14-12-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (207, 'Jack', 'Brody', 384, 42164, 0, to_date('03-06-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (208, 'Eric', 'Loggia', 291, 22864, 0, to_date('16-06-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (210, 'Denny', 'Benet', 270, 10582, 0, to_date('23-05-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (211, 'Bret', 'Oszajca', 289, 60058, 0, to_date('16-10-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (213, 'Mos', 'Kweller', 268, 90399, 0, to_date('27-06-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (214, 'Thomas', 'Farris', 131, 81761, 0, to_date('15-01-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (215, 'Roberta', 'Buffalo', 126, 69259, 0, to_date('21-02-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (216, 'Vendetta', 'Davison', 260, 76273, 0, to_date('24-11-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (217, 'Bebe', 'Roundtree', 397, 76024, 0, to_date('30-06-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (218, 'Garth', 'Palminteri', 37, 42476, 0, to_date('01-01-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (220, 'Judge', 'Keen', 281, 39031, 0, to_date('07-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (221, 'Simon', 'Zane', 24, 86735, 0, to_date('22-07-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (222, 'Todd', 'Sewell', 236, 99450, 0, to_date('28-05-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (223, 'Vondie', 'Mantegna', 91, 59812, 0, to_date('03-08-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (225, 'Earl', 'Beck', 268, 51058, 0, to_date('11-04-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (228, 'Jay', 'Oldman', 252, 69906, 0, to_date('01-12-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (230, 'Katie', 'Palin', 82, 80833, 0, to_date('07-01-1948', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (231, 'Jackie', 'Hewett', 137, 14206, 0, to_date('18-04-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (232, 'Marc', 'Jane', 272, 46343, 0, to_date('06-01-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (233, 'Morris', 'Slater', 40, 10036, 0, to_date('22-05-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (235, 'Joe', 'Johansen', 275, 71128, 0, to_date('07-07-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (236, 'Victoria', 'Lindo', 299, 60251, 0, to_date('30-07-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (237, 'Donald', 'Walken', 24, 23050, 0, to_date('02-06-1929', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 200 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (238, 'Marlon', 'Yankovic', 66, 79672, 0, to_date('10-07-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (239, 'Angela', 'Maguire', 78, 62282, 0, to_date('03-02-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (240, 'Nancy', 'Ifans', 90, 50094, 0, to_date('22-05-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (241, 'Ashton', 'Jones', 1, 98467, 0, to_date('15-04-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (242, 'Candice', 'McDonnell', 188, 96361, 0, to_date('11-03-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (243, 'Kelly', 'Rudd', 95, 74798, 0, to_date('14-05-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (245, 'Clarence', 'Gambon', 301, 92330, 0, to_date('19-09-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (247, 'Daniel', 'Dalton', 310, 86473, 0, to_date('10-06-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (248, 'Leo', 'Lynne', 85, 31952, 0, to_date('31-03-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (249, 'Ozzy', 'Coughlan', 27, 86480, 0, to_date('07-01-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (250, 'Meg', 'Streep', 366, 86856, 0, to_date('22-06-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (251, 'Rowan', 'Emmett', 53, 41184, 0, to_date('06-02-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (252, 'Curtis', 'Gallant', 125, 41237, 0, to_date('28-06-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (253, 'Benjamin', 'Wilson', 331, 16778, 0, to_date('05-10-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (255, 'Rita', 'Craig', 31, 64922, 0, to_date('22-09-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (256, 'Wayne', 'Beck', 257, 74003, 0, to_date('13-11-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (257, 'Mykelti', 'Neil', 203, 71949, 0, to_date('28-06-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (259, 'Garry', 'Holly', 84, 12456, 0, to_date('26-04-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (260, 'Lea', 'Lynch', 114, 68081, 0, to_date('07-04-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (261, 'Timothy', 'Tate', 391, 63061, 0, to_date('11-07-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (262, 'Miki', 'Murphy', 23, 17459, 0, to_date('03-01-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (263, 'Ewan', 'Danes', 270, 54611, 0, to_date('29-07-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (264, 'Daryl', 'Quinlan', 379, 90374, 0, to_date('26-12-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (265, 'Meg', 'Bacon', 250, 13616, 0, to_date('26-10-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (266, 'Hal', 'Blackwell', 175, 37171, 0, to_date('18-01-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (267, 'Andie', 'DiFranco', 68, 56187, 0, to_date('04-01-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (268, 'Teena', 'McGowan', 248, 93049, 0, to_date('21-06-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (269, 'Joey', 'Smurfit', 306, 80278, 0, to_date('06-11-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (271, 'Richie', 'Dench', 113, 84486, 0, to_date('02-03-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (272, 'Leelee', 'Niven', 19, 35356, 0, to_date('27-07-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (274, 'Alessandro', 'Pierce', 320, 61625, 0, to_date('23-12-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (276, 'Loren', 'Albright', 3, 11065, 0, to_date('21-05-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (277, 'Debby', 'Peniston', 73, 23084, 0, to_date('18-09-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (278, 'Rolando', 'Gryner', 35, 93113, 0, to_date('02-07-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (279, 'Carol', 'Randal', 123, 48578, 0, to_date('26-07-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (280, 'Treat', 'Woodard', 166, 21535, 0, to_date('30-08-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (282, 'Terry', 'Pesci', 282, 47571, 0, to_date('08-04-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (284, 'Elizabeth', 'Fox', 88, 24405, 0, to_date('03-10-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (285, 'Mary', 'Perlman', 91, 24816, 0, to_date('06-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (286, 'Ty', 'Tisdale', 130, 65013, 0, to_date('18-12-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (287, 'Sigourney', 'Blaine', 170, 49134, 0, to_date('29-12-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (288, 'Juliette', 'Snipes', 55, 77909, 0, to_date('04-03-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (289, 'Ronny', 'Tinsley', 115, 51886, 0, to_date('29-07-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (290, 'Famke', 'Tyson', 122, 77819, 0, to_date('03-04-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (291, 'Philip', 'Kristofferson', 386, 64497, 0, to_date('25-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (292, 'Meryl', 'Tah', 69, 40822, 0, to_date('16-08-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (293, 'Ann', 'Shandling', 179, 20617, 0, to_date('04-10-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (295, 'Jody', 'Reeves', 55, 19736, 0, to_date('09-03-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (296, 'Bette', 'Bentley', 390, 88020, 0, to_date('14-09-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (297, 'Lou', 'Martinez', 272, 82524, 0, to_date('27-04-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (298, 'Heath', 'Finn', 29, 18004, 0, to_date('10-07-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (299, 'Boyd', 'Van Helden', 94, 91177, 0, to_date('30-10-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (300, 'Tcheky', 'Ramirez', 396, 61676, 0, to_date('07-02-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (302, 'Etta', 'Lang', 286, 17369, 0, to_date('26-08-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (303, 'Daryl', 'Reinhold', 131, 68432, 0, to_date('31-08-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (304, 'Shannon', 'Arkenstone', 173, 88075, 0, to_date('14-05-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (305, 'Warren', 'Kravitz', 132, 65482, 0, to_date('16-05-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (306, 'Wally', 'Newman', 345, 84704, 0, to_date('26-09-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (307, 'Neve', 'Schreiber', 162, 48562, 0, to_date('16-08-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (308, 'Gin', 'Freeman', 28, 30054, 0, to_date('28-03-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (309, 'John', 'Richardson', 324, 82787, 0, to_date('15-10-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (310, 'Kay', 'Buscemi', 135, 55516, 0, to_date('01-06-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (311, 'Humberto', 'Springfield', 334, 10856, 0, to_date('01-02-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (312, 'Susan', 'Keen', 326, 25071, 0, to_date('28-07-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (315, 'Maggie', 'Collie', 50, 72250, 0, to_date('26-09-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (316, 'Swoosie', 'Haggard', 55, 38894, 0, to_date('11-10-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (317, 'Jose', 'Swayze', 366, 46600, 0, to_date('09-12-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (318, 'Jake', 'McGriff', 258, 29912, 0, to_date('12-04-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (319, 'Gavin', 'Ward', 4, 73355, 0, to_date('14-07-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (320, 'Michelle', 'Fox', 115, 54922, 0, to_date('12-11-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (321, 'Eileen', 'Spector', 29, 19434, 0, to_date('09-03-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (322, 'Crystal', 'Pepper', 78, 57462, 0, to_date('17-12-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (323, 'Howard', 'Schock', 335, 25119, 0, to_date('13-09-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (324, 'Orlando', 'Pigott-Smith', 128, 89117, 0, to_date('04-01-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (325, 'Max', 'Harper', 102, 35624, 0, to_date('26-07-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (326, 'Sander', 'Hannah', 33, 21303, 0, to_date('29-11-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (327, 'Harriet', 'Frakes', 110, 66114, 0, to_date('27-10-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (328, 'Marley', 'Kimball', 379, 30582, 0, to_date('22-09-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (329, 'Jimmie', 'Arkin', 56, 70949, 0, to_date('12-02-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (331, 'Eddie', 'McGoohan', 135, 20443, 0, to_date('16-12-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (332, 'Ralph', 'Allison', 78, 27744, 0, to_date('25-07-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (333, 'Vickie', 'Keith', 247, 90910, 0, to_date('25-07-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (334, 'Clint', 'McKennitt', 282, 19817, 0, to_date('27-05-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (336, 'Rosie', 'Ness', 351, 70174, 0, to_date('23-05-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (338, 'Famke', 'Tilly', 40, 96430, 0, to_date('25-09-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (339, 'Beverley', 'Roth', 137, 45025, 0, to_date('25-02-2017', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (340, 'Fiona', 'Phillippe', 348, 26026, 0, to_date('24-03-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (341, 'Remy', 'Walsh', 290, 44067, 0, to_date('01-07-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (343, 'Caroline', 'Ammons', 214, 51091, 0, to_date('31-10-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (344, 'Jennifer', 'Cartlidge', 86, 45108, 0, to_date('27-08-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (345, 'Christine', 'Speaks', 161, 32130, 0, to_date('19-01-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (346, 'Bonnie', 'Osbourne', 187, 26321, 0, to_date('16-05-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (347, 'Joaquin', 'Forrest', 23, 32315, 0, to_date('17-06-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (348, 'Katie', 'Perez', 11, 67568, 0, to_date('05-10-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (349, 'Rolando', 'Linney', 320, 40384, 0, to_date('29-11-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (350, 'Cate', 'Holeman', 27, 74413, 0, to_date('03-05-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (351, 'Lindsey', 'Serbedzija', 326, 40994, 0, to_date('21-09-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (352, 'Faye', 'Parish', 84, 58213, 0, to_date('08-09-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (353, 'Stephen', 'Ribisi', 71, 25657, 0, to_date('21-03-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (354, 'Rosanne', 'Campbell', 182, 67104, 0, to_date('15-02-1961', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 300 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (356, 'Andie', 'Diesel', 399, 66452, 0, to_date('13-09-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (357, 'Dave', 'Bush', 47, 71958, 0, to_date('19-08-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (358, 'Ethan', 'Cummings', 185, 90804, 0, to_date('23-05-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (359, 'Paula', 'Kirshner', 356, 12777, 0, to_date('10-06-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (360, 'Julie', 'Douglas', 116, 21858, 0, to_date('06-11-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (361, 'Holland', 'Danger', 52, 35581, 0, to_date('31-08-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (362, 'Beverley', 'Warwick', 129, 79488, 0, to_date('23-12-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (363, 'Jackson', 'McCann', 71, 70832, 0, to_date('15-08-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (365, 'Meg', 'Choice', 232, 50819, 0, to_date('06-02-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (366, 'Lara', 'Keen', 191, 91188, 0, to_date('01-03-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (367, 'Guy', 'Beck', 398, 52688, 0, to_date('18-03-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (368, 'Thora', 'Stiles', 49, 46077, 0, to_date('04-07-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (369, 'Julianna', 'Tyler', 372, 96318, 0, to_date('26-06-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (370, 'Kim', 'Darren', 85, 50132, 0, to_date('22-06-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (371, 'Josh', 'Leary', 182, 20337, 0, to_date('02-04-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (372, 'Gavin', 'Lithgow', 123, 43719, 0, to_date('01-10-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (374, 'Jack', 'Caine', 37, 34493, 0, to_date('17-01-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (375, 'Maury', 'Sweeney', 330, 89566, 0, to_date('15-11-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (376, 'Shelby', 'Hiatt', 269, 16697, 0, to_date('01-11-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (377, 'Luke', 'Malkovich', 88, 46905, 0, to_date('10-05-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (378, 'Jessica', 'Colon', 84, 29768, 0, to_date('24-07-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (379, 'Connie', 'Salt', 119, 55363, 0, to_date('09-03-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (380, 'Rhett', 'Postlethwaite', 40, 25787, 167, to_date('27-02-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (382, 'Gran', 'Peet', 104, 47784, 0, to_date('25-09-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (383, 'Dwight', 'Van Der Beek', 30, 57960, 0, to_date('18-03-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (384, 'Kirk', 'Holmes', 110, 73459, 0, to_date('16-08-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (385, 'Raul', 'Capshaw', 66, 54119, 0, to_date('01-11-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (386, 'Giovanni', 'Birch', 162, 71323, 0, to_date('19-05-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (388, 'Azucar', 'Alston', 293, 28812, 0, to_date('18-03-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (389, 'Lance', 'Scorsese', 2, 25997, 0, to_date('23-11-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (390, 'Gaby', 'Caine', 389, 94383, 0, to_date('10-01-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (391, 'Kyle', 'Baranski', 10, 61259, 0, to_date('29-03-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (393, 'Rosanna', 'Def', 11, 55609, 0, to_date('06-09-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (394, 'Juliana', 'Wilkinson', 382, 78048, 0, to_date('05-02-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (395, 'Milla', 'Klugh', 286, 41687, 0, to_date('21-04-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (396, 'Lili', 'Krabbe', 282, 41147, 0, to_date('17-07-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (397, 'Trey', 'Klugh', 78, 52292, 0, to_date('30-08-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (398, 'Edie', 'MacLachlan', 128, 92000, 0, to_date('27-08-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (399, 'Ice', 'Gandolfini', 35, 84813, 0, to_date('14-07-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (400, 'Sigourney', 'Fichtner', 65, 12708, 0, to_date('31-10-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (401, 'Frederic', 'Holbrook', 285, 13018, 0, to_date('24-02-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (402, 'Joan', 'Matthau', 58, 11640, 0, to_date('16-09-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (403, 'Garland', 'Cheadle', 203, 49469, 0, to_date('19-12-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (404, 'Lennie', 'Hughes', 214, 60369, 0, to_date('12-06-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (405, 'Jeanne', 'Meniketti', 23, 44364, 0, to_date('27-04-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (406, 'Reese', 'Collins', 220, 30851, 0, to_date('30-01-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (407, 'Keith', 'Himmelman', 152, 69063, 0, to_date('17-07-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (408, 'Nicole', 'Warburton', 198, 77384, 0, to_date('15-04-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (409, 'Natascha', 'Karyo', 141, 75108, 0, to_date('01-05-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (411, 'Laurence', 'Gaines', 172, 41988, 0, to_date('06-07-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (412, 'Nanci', 'Channing', 327, 31412, 0, to_date('09-09-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (414, 'Marley', 'Allison', 55, 91791, 0, to_date('25-04-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (416, 'Murray', 'Donovan', 40, 18831, 0, to_date('04-12-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (417, 'Emily', 'Pony', 340, 20884, 0, to_date('08-06-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (418, 'Cuba', 'Nicholson', 247, 57202, 0, to_date('06-08-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (419, 'Jane', 'Everett', 131, 63174, 0, to_date('25-11-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (420, 'Lisa', 'Rippy', 120, 54685, 0, to_date('26-04-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (421, 'Marisa', 'Lillard', 56, 86618, 0, to_date('15-07-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (422, 'Edward', 'Rhames', 337, 44431, 0, to_date('22-09-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (423, 'Veruca', 'Blair', 392, 75593, 0, to_date('01-09-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (424, 'Cameron', 'Foley', 29, 48245, 0, to_date('12-11-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (425, 'Irene', 'Hart', 182, 52723, 0, to_date('18-02-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (426, 'Russell', 'Waits', 274, 97928, 0, to_date('27-04-2017', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (427, 'Heath', 'Cassidy', 60, 24856, 0, to_date('27-09-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (431, 'Neil', 'Hutch', 33, 52315, 0, to_date('30-10-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (432, 'Max', 'Rossellini', 95, 79490, 0, to_date('23-09-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (433, 'Ivan', 'Spine', 127, 59491, 0, to_date('05-11-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (434, 'Celia', 'Daniels', 37, 69285, 0, to_date('12-06-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (435, 'Fairuza', 'Buffalo', 207, 49892, 0, to_date('03-08-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (436, 'Gordie', 'Esposito', 379, 75712, 0, to_date('19-03-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (437, 'Rene', 'Cocker', 365, 11135, 0, to_date('19-10-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (438, 'Tyrone', 'Stevenson', 179, 55813, 0, to_date('25-03-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (439, 'Lydia', 'Robinson', 49, 44867, 0, to_date('28-05-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (440, 'Patrick', 'O''Neal', 93, 27220, 0, to_date('11-06-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (441, 'Pelvic', 'Andrews', 19, 49679, 0, to_date('25-01-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (442, 'Praga', 'Kilmer', 283, 17080, 0, to_date('20-04-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (443, 'King', 'Stormare', 112, 95287, 0, to_date('19-04-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (444, 'Hector', 'Tippe', 356, 44804, 0, to_date('19-04-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (446, 'Miriam', 'Cube', 345, 10703, 0, to_date('08-03-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (447, 'Rhett', 'Bullock', 62, 56002, 0, to_date('13-11-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (448, 'Grace', 'Chestnut', 221, 15005, 0, to_date('26-01-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (449, 'Alex', 'MacDonald', 118, 44519, 0, to_date('03-09-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (450, 'Anjelica', 'Dayne', 365, 34319, 0, to_date('01-12-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (451, 'Walter', 'Summer', 35, 25324, 0, to_date('17-04-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (452, 'Lindsey', 'Leachman', 288, 65057, 0, to_date('13-01-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (453, 'Nik', 'Loring', 395, 15197, 0, to_date('30-12-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (454, 'Nigel', 'Aniston', 218, 65841, 0, to_date('25-08-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (455, 'Josh', 'Strathairn', 122, 32312, 0, to_date('05-06-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (456, 'Javon', 'Hingle', 248, 43455, 0, to_date('11-08-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (457, 'Azucar', 'Dukakis', 118, 61111, 0, to_date('28-03-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (458, 'Maceo', 'Feliciano', 260, 19333, 0, to_date('01-11-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (462, 'Mary-Louise', 'Kahn', 250, 66515, 0, to_date('24-12-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (465, 'Adam', 'Hauser', 172, 95553, 0, to_date('07-05-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (466, 'Sissy', 'Mraz', 200, 63895, 0, to_date('09-12-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (468, 'Grace', 'de Lancie', 78, 21984, 0, to_date('14-03-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (470, 'Carlene', 'Deejay', 356, 65520, 0, to_date('12-10-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (471, 'Wally', 'Herrmann', 91, 94760, 0, to_date('19-04-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (472, 'Yolanda', 'Porter', 279, 48753, 0, to_date('23-12-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (473, 'Famke', 'Tucker', 324, 16058, 0, to_date('28-11-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (474, 'Mykelti', 'Cantrell', 292, 31354, 0, to_date('28-03-1954', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 400 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (475, 'Grant', 'Oates', 372, 70855, 0, to_date('27-08-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (476, 'Gabrielle', 'Crouch', 114, 48826, 0, to_date('16-03-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (477, 'Reese', 'Wilder', 78, 48047, 0, to_date('10-04-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (479, 'Cole', 'Twilley', 277, 91395, 0, to_date('25-07-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (481, 'Roy', 'Studi', 326, 86086, 0, to_date('14-06-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (482, 'Rob', 'Hobson', 144, 34756, 0, to_date('16-09-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (483, 'Amy', 'Byrd', 369, 57158, 0, to_date('04-10-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (484, 'Fionnula', 'Lachey', 109, 93413, 0, to_date('20-08-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (485, 'Garry', 'Hector', 109, 45611, 0, to_date('14-12-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (486, 'Jonny Lee', 'Barkin', 325, 36006, 0, to_date('16-03-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (487, 'Rita', 'Allan', 318, 20450, 0, to_date('19-06-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (488, 'Dan', 'Lillard', 305, 97574, 0, to_date('01-03-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (489, 'Vern', 'Palmieri', 267, 47464, 0, to_date('18-06-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (490, 'King', 'Perrineau', 94, 14967, 0, to_date('01-02-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (491, 'Timothy', 'Fraser', 312, 58017, 0, to_date('14-01-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (492, 'Toni', 'Duvall', 10, 41088, 0, to_date('25-08-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (493, 'Burton', 'Murdock', 207, 23617, 0, to_date('05-04-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (494, 'Faye', 'Jessee', 368, 53754, 0, to_date('05-07-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (495, 'Howie', 'Stiller', 188, 14579, 0, to_date('18-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (496, 'Pete', 'Loggins', 291, 73706, 0, to_date('08-12-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (497, 'Leslie', 'Hector', 397, 93516, 0, to_date('09-09-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (498, 'Danny', 'Makowicz', 28, 38802, 0, to_date('08-09-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (499, 'Lynette', 'Shepard', 289, 16990, 0, to_date('29-12-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (500, 'Jeffrey', 'Mulroney', 72, 33921, 0, to_date('18-10-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (501, 'Val', 'Sizemore', 188, 91058, 0, to_date('11-09-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (502, 'Phil', 'Lindo', 91, 38615, 0, to_date('05-04-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (503, 'Whoopi', 'Wright', 46, 49026, 0, to_date('14-04-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (504, 'Rachid', 'Lightfoot', 376, 77032, 0, to_date('25-10-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (505, 'Cathy', 'Calle', 155, 42183, 0, to_date('11-06-1978', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (506, 'Sara', 'Richter', 212, 57149, 0, to_date('24-03-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (507, 'Lenny', 'Chambers', 283, 26789, 0, to_date('06-12-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (508, 'Colin', 'Keitel', 84, 48838, 0, to_date('10-11-1934', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (509, 'Embeth', 'Geldof', 168, 63104, 0, to_date('20-12-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1400, 'Ethan', 'Garcia', 7, 94999, 0, to_date('26-04-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1401, 'Ethan', 'Anderson', 1, 27387, 0, to_date('30-05-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1402, 'Michael', 'Miller', 2, 36293, 0, to_date('21-10-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1403, 'Alexander', 'Gonzalez', 6, 32432, 0, to_date('21-09-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1404, 'Elijah', 'Williams', 2, 34216, 0, to_date('14-04-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1405, 'William', 'Martinez', 5, 23234, 0, to_date('23-02-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1406, 'Amelia', 'Rodriguez', 2, 95451, 0, to_date('16-01-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1407, 'Lucas', 'Taylor', 7, 23986, 0, to_date('22-09-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1408, 'Ava', 'Gonzalez', 6, 95771, 0, to_date('23-09-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1409, 'Alexander', 'Martin', 2, 57827, 0, to_date('30-10-2017', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1410, 'Elijah', 'Garcia', 4, 85379, 0, to_date('03-12-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1411, 'Evelyn', 'Taylor', 10, 70376, 0, to_date('16-04-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1412, 'Benjamin', 'Martinez', 2, 55099, 0, to_date('05-11-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1413, 'Amelia', 'Johnson', 3, 80868, 0, to_date('23-07-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1414, 'Alexander', 'Brown', 10, 64795, 0, to_date('02-04-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1415, 'James', 'Smith', 4, 39146, 0, to_date('06-02-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1416, 'Sophia', 'Hernandez', 1, 71947, 0, to_date('27-03-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1417, 'Lucas', 'Jones', 9, 89405, 0, to_date('23-01-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1418, 'Abigail', 'Martinez', 4, 63133, 0, to_date('30-12-1948', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1419, 'James', 'Wilson', 4, 53876, 0, to_date('16-06-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1420, 'Ava', 'Jackson', 4, 67600, 0, to_date('06-05-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1421, 'Mia', 'Miller', 7, 52493, 0, to_date('05-06-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1422, 'Isabella', 'Hernandez', 10, 56587, 0, to_date('14-03-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1423, 'Mia', 'Wilson', 9, 23214, 0, to_date('06-05-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1424, 'Olivia', 'Martinez', 7, 81361, 0, to_date('11-04-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1425, 'Emma', 'Hernandez', 1, 94975, 0, to_date('12-12-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1426, 'John', 'Martinez', 9, 65292, 0, to_date('13-12-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1427, 'James', 'Taylor', 5, 69736, 0, to_date('15-04-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1428, 'John', 'Hernandez', 5, 29268, 0, to_date('01-02-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1429, 'Lucas', 'Anderson', 10, 97274, 0, to_date('19-04-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1430, 'Alexander', 'Moore', 3, 70929, 0, to_date('07-09-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1431, 'Evelyn', 'Martinez', 6, 84553, 0, to_date('25-12-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1432, 'Michael', 'Lopez', 10, 28652, 0, to_date('27-12-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1433, 'James', 'Rodriguez', 4, 86463, 0, to_date('01-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1434, 'Evelyn', 'Miller', 3, 21243, 0, to_date('25-03-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1435, 'Amelia', 'Rodriguez', 9, 38002, 0, to_date('07-06-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1436, 'Emma', 'Rodriguez', 9, 98077, 0, to_date('16-02-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1437, 'Benjamin', 'Lopez', 4, 82813, 0, to_date('15-03-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1438, 'Michael', 'Rodriguez', 7, 11934, 0, to_date('02-03-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1439, 'Michael', 'Hernandez', 6, 78829, 0, to_date('08-08-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1440, 'Olivia', 'Anderson', 3, 73015, 0, to_date('21-09-1948', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1441, 'Lucas', 'Johnson', 8, 25215, 0, to_date('14-07-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1442, 'Mia', 'Brown', 4, 95279, 0, to_date('04-11-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1443, 'John', 'Martin', 9, 80911, 0, to_date('18-05-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1444, 'James', 'Hernandez', 2, 18108, 0, to_date('09-04-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1445, 'Ava', 'Smith', 6, 11588, 0, to_date('27-11-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1446, 'Mason', 'Smith', 2, 96164, 0, to_date('06-10-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1447, 'Elijah', 'Anderson', 8, 28809, 0, to_date('16-11-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1448, 'James', 'Jackson', 6, 92733, 0, to_date('30-07-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1449, 'Alexander', 'Gonzalez', 6, 51344, 0, to_date('04-01-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1450, 'Mason', 'Miller', 1, 47558, 0, to_date('18-04-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1451, 'Benjamin', 'Miller', 6, 20320, 0, to_date('25-11-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1452, 'William', 'Miller', 4, 42503, 0, to_date('01-11-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1453, 'John', 'Garcia', 3, 77132, 0, to_date('11-04-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1454, 'Sophia', 'Moore', 6, 80153, 0, to_date('06-01-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1455, 'Olivia', 'Wilson', 9, 53443, 0, to_date('17-10-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1456, 'Elijah', 'Williams', 3, 65280, 0, to_date('17-04-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1457, 'Benjamin', 'Miller', 3, 73750, 0, to_date('09-11-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1458, 'Isabella', 'Martin', 10, 21115, 0, to_date('08-08-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1459, 'Mason', 'Gonzalez', 6, 73899, 0, to_date('13-03-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1460, 'Ethan', 'Moore', 6, 92686, 0, to_date('01-10-1990', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1461, 'Evelyn', 'Johnson', 4, 66192, 0, to_date('27-01-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1462, 'James', 'Smith', 4, 31297, 0, to_date('13-08-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1463, 'Emma', 'Johnson', 3, 11827, 0, to_date('27-01-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1464, 'Olivia', 'Rodriguez', 7, 69571, 0, to_date('06-02-1988', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1465, 'Benjamin', 'Smith', 9, 86395, 0, to_date('17-11-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1466, 'William', 'Jones', 2, 14226, 0, to_date('08-08-1956', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 500 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1467, 'John', 'Taylor', 8, 95831, 0, to_date('23-05-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1468, 'Ethan', 'Johnson', 9, 34183, 0, to_date('28-04-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1469, 'Michael', 'Hernandez', 10, 15124, 0, to_date('23-02-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1470, 'Benjamin', 'Miller', 10, 49111, 0, to_date('21-08-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1471, 'Abigail', 'Taylor', 6, 27735, 0, to_date('24-01-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1472, 'Olivia', 'Moore', 7, 93467, 0, to_date('14-10-2014', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1473, 'Amelia', 'Davis', 4, 53548, 0, to_date('14-01-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1474, 'Evelyn', 'Davis', 3, 35492, 0, to_date('18-12-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1475, 'Elijah', 'Jones', 2, 91616, 0, to_date('26-10-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1476, 'Ava', 'Rodriguez', 3, 71285, 0, to_date('11-04-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1477, 'Abigail', 'Johnson', 10, 89826, 0, to_date('18-04-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1478, 'Elijah', 'Brown', 10, 52759, 0, to_date('05-09-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1479, 'Michael', 'Rodriguez', 7, 14722, 0, to_date('21-12-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1480, 'James', 'Taylor', 1, 26266, 0, to_date('11-11-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1481, 'Lucas', 'Jackson', 6, 85688, 0, to_date('30-05-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1482, 'Sophia', 'Miller', 1, 61271, 0, to_date('01-03-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1483, 'Olivia', 'Lopez', 9, 48553, 0, to_date('10-10-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1484, 'Mia', 'Davis', 1, 39795, 0, to_date('29-04-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1485, 'Lucas', 'Miller', 4, 37327, 0, to_date('13-06-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1486, 'William', 'Garcia', 9, 56604, 0, to_date('27-07-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1487, 'Evelyn', 'Williams', 7, 28554, 0, to_date('15-06-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1488, 'Elijah', 'Lopez', 8, 84532, 0, to_date('15-04-1938', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1489, 'Harper', 'Miller', 6, 33225, 0, to_date('13-12-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1490, 'Amelia', 'Martinez', 9, 38090, 0, to_date('15-05-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1491, 'Lucas', 'Garcia', 1, 15059, 0, to_date('07-04-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1492, 'Abigail', 'Williams', 9, 13327, 0, to_date('15-12-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1493, 'Evelyn', 'Smith', 6, 85565, 0, to_date('28-03-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1494, 'Abigail', 'Johnson', 2, 58513, 0, to_date('11-11-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1495, 'Sophia', 'Brown', 6, 67038, 0, to_date('08-12-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1496, 'Evelyn', 'Williams', 10, 28735, 0, to_date('05-12-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1497, 'Mason', 'Williams', 5, 79728, 0, to_date('25-07-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1498, 'James', 'Hernandez', 5, 27593, 0, to_date('16-03-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1499, 'Alexander', 'Jackson', 7, 94223, 0, to_date('08-04-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1100, 'Elijah', 'Martinez', 6, 87441, 0, to_date('04-08-1940', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1101, 'Isabella', 'Miller', 8, 89405, 0, to_date('19-01-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1102, 'Abigail', 'Wilson', 6, 33097, 0, to_date('26-07-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1103, 'John', 'Johnson', 7, 59002, 0, to_date('23-08-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1104, 'Lucas', 'Thomas', 3, 85122, 0, to_date('28-10-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1105, 'Michael', 'Johnson', 5, 95150, 0, to_date('03-08-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1106, 'Isabella', 'Davis', 7, 64095, 0, to_date('13-05-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1107, 'Olivia', 'Jackson', 9, 68907, 0, to_date('25-01-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1108, 'Isabella', 'Thomas', 8, 90409, 0, to_date('25-06-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1109, 'Mia', 'Thomas', 9, 42856, 0, to_date('14-07-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1110, 'Mia', 'Jackson', 2, 55209, 0, to_date('02-04-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1111, 'Isabella', 'Brown', 1, 71705, 0, to_date('29-11-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1112, 'John', 'Smith', 3, 69505, 0, to_date('02-01-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1113, 'John', 'Williams', 9, 53260, 0, to_date('27-12-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1114, 'Lucas', 'Jones', 5, 35967, 0, to_date('07-07-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1115, 'William', 'Gonzalez', 8, 36759, 0, to_date('25-04-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1116, 'Isabella', 'Miller', 9, 98608, 0, to_date('25-11-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1117, 'Emma', 'Martinez', 5, 99909, 0, to_date('06-03-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1118, 'Evelyn', 'Taylor', 9, 45447, 0, to_date('03-10-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1119, 'Evelyn', 'Taylor', 10, 56223, 0, to_date('08-10-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1120, 'Benjamin', 'Davis', 8, 38120, 0, to_date('25-08-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1121, 'Sophia', 'Smith', 4, 16532, 0, to_date('07-05-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1122, 'Isabella', 'Rodriguez', 8, 45264, 0, to_date('29-07-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1123, 'Olivia', 'Taylor', 4, 61553, 0, to_date('01-11-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1124, 'Mia', 'Garcia', 1, 35033, 0, to_date('20-08-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1125, 'Evelyn', 'Garcia', 9, 10004, 0, to_date('02-08-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1126, 'Sophia', 'Anderson', 4, 52594, 0, to_date('04-06-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1127, 'Ethan', 'Moore', 8, 61999, 0, to_date('18-05-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1128, 'James', 'Johnson', 7, 91519, 0, to_date('29-04-1935', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1129, 'Elijah', 'Moore', 7, 29008, 0, to_date('16-07-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1130, 'Sophia', 'Smith', 6, 96294, 0, to_date('22-10-2005', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1131, 'Michael', 'Martin', 4, 71265, 0, to_date('29-12-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1132, 'Harper', 'Miller', 1, 73174, 0, to_date('02-01-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1133, 'James', 'Garcia', 3, 79068, 0, to_date('24-11-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1134, 'Harper', 'Rodriguez', 9, 51933, 0, to_date('14-06-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1135, 'Amelia', 'Johnson', 10, 59274, 0, to_date('07-05-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1136, 'Elijah', 'Thomas', 7, 88682, 0, to_date('05-08-1943', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1137, 'Sophia', 'Williams', 9, 84674, 0, to_date('06-05-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1138, 'Abigail', 'Garcia', 10, 69508, 0, to_date('15-05-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1139, 'Elijah', 'Wilson', 2, 37653, 0, to_date('15-07-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1140, 'Ava', 'Anderson', 3, 55122, 0, to_date('25-09-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1141, 'Michael', 'Brown', 7, 24355, 0, to_date('20-03-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1142, 'Abigail', 'Johnson', 1, 53350, 0, to_date('21-08-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1143, 'Lucas', 'Wilson', 9, 23036, 0, to_date('14-10-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1144, 'Olivia', 'Moore', 1, 62597, 0, to_date('01-12-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1145, 'Benjamin', 'Hernandez', 4, 23498, 0, to_date('28-08-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1146, 'Olivia', 'Jones', 9, 68588, 0, to_date('04-04-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1147, 'Abigail', 'Taylor', 4, 28612, 0, to_date('27-03-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1148, 'Emma', 'Wilson', 7, 30784, 0, to_date('26-11-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1149, 'Elijah', 'Lopez', 3, 73748, 0, to_date('20-02-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1150, 'Lucas', 'Rodriguez', 6, 38421, 0, to_date('03-03-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1151, 'John', 'Williams', 9, 11231, 0, to_date('09-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1152, 'Mason', 'Lopez', 9, 77319, 0, to_date('02-11-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1153, 'James', 'Johnson', 4, 23841, 0, to_date('26-12-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1154, 'Olivia', 'Miller', 6, 84865, 0, to_date('23-04-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1155, 'Evelyn', 'Taylor', 10, 40706, 0, to_date('24-07-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1156, 'Michael', 'Thomas', 9, 39566, 0, to_date('24-03-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1157, 'Mia', 'Martinez', 5, 12407, 0, to_date('03-09-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1158, 'Abigail', 'Lopez', 5, 34613, 0, to_date('21-04-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1159, 'Olivia', 'Gonzalez', 10, 72518, 0, to_date('23-10-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1160, 'Sophia', 'Anderson', 10, 74677, 0, to_date('01-04-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1161, 'Alexander', 'Williams', 1, 30795, 0, to_date('13-03-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1162, 'John', 'Rodriguez', 5, 59577, 0, to_date('07-11-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1163, 'Benjamin', 'Williams', 1, 35753, 0, to_date('10-09-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1164, 'Abigail', 'Lopez', 2, 73591, 0, to_date('08-02-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1165, 'James', 'Jones', 4, 12376, 0, to_date('29-03-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1166, 'Harper', 'Johnson', 2, 53627, 0, to_date('27-07-1930', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 600 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1167, 'Elijah', 'Johnson', 3, 31031, 0, to_date('05-08-2013', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1168, 'William', 'Miller', 6, 46297, 0, to_date('01-07-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1169, 'Harper', 'Brown', 6, 97419, 0, to_date('12-03-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1170, 'Elijah', 'Taylor', 10, 36943, 0, to_date('17-06-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1171, 'William', 'Miller', 4, 84793, 0, to_date('09-05-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1172, 'Benjamin', 'Wilson', 3, 91204, 0, to_date('27-08-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1173, 'Abigail', 'Miller', 6, 63002, 0, to_date('09-05-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1174, 'Ava', 'Anderson', 4, 96875, 0, to_date('03-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1175, 'Olivia', 'Jackson', 1, 96301, 0, to_date('26-06-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1176, 'Alexander', 'Brown', 3, 94111, 0, to_date('25-10-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1177, 'Harper', 'Johnson', 7, 52619, 0, to_date('30-01-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1178, 'Mason', 'Jackson', 4, 41559, 0, to_date('17-10-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1179, 'Amelia', 'Jones', 3, 48919, 0, to_date('29-10-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1180, 'Mason', 'Jackson', 4, 40120, 0, to_date('03-03-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1181, 'Lucas', 'Miller', 3, 26973, 0, to_date('03-04-2017', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1182, 'Abigail', 'Brown', 2, 33035, 0, to_date('13-05-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1183, 'Harper', 'Johnson', 6, 50628, 0, to_date('28-06-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1184, 'Mia', 'Davis', 9, 91456, 0, to_date('02-04-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1185, 'Olivia', 'Moore', 9, 66501, 0, to_date('28-12-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1186, 'Mia', 'Taylor', 3, 46731, 0, to_date('27-03-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1187, 'Ava', 'Miller', 6, 79308, 0, to_date('11-04-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1188, 'Sophia', 'Lopez', 9, 37531, 0, to_date('27-04-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1189, 'Ethan', 'Thomas', 3, 52102, 0, to_date('08-09-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1190, 'James', 'Wilson', 1, 13382, 0, to_date('24-08-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1191, 'Abigail', 'Wilson', 3, 11042, 0, to_date('23-10-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1192, 'Sophia', 'Martin', 8, 81083, 0, to_date('01-08-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1193, 'Michael', 'Martin', 9, 31520, 0, to_date('11-10-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1194, 'John', 'Johnson', 2, 30803, 0, to_date('29-10-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1195, 'Ava', 'Garcia', 2, 83217, 0, to_date('16-11-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1196, 'John', 'Jones', 5, 23009, 0, to_date('20-02-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1197, 'Sophia', 'Hernandez', 2, 88887, 0, to_date('15-04-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1198, 'Sophia', 'Miller', 1, 24757, 0, to_date('20-11-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1199, 'Emma', 'Jackson', 4, 13978, 0, to_date('20-05-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1200, 'Evelyn', 'Moore', 1, 54934, 0, to_date('12-01-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1201, 'John', 'Miller', 2, 24686, 0, to_date('28-09-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1202, 'Emma', 'Smith', 5, 71666, 0, to_date('08-11-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1203, 'Mia', 'Lopez', 4, 60010, 0, to_date('15-09-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1204, 'Michael', 'Davis', 3, 82083, 0, to_date('17-11-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1205, 'Benjamin', 'Rodriguez', 8, 37745, 0, to_date('30-10-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1206, 'Evelyn', 'Miller', 3, 50003, 0, to_date('14-07-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1207, 'Ethan', 'Williams', 10, 46360, 0, to_date('07-01-1941', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1208, 'Elijah', 'Martinez', 4, 65952, 0, to_date('07-12-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1209, 'Lucas', 'Hernandez', 10, 79204, 0, to_date('07-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1210, 'Sophia', 'Martin', 3, 26509, 0, to_date('04-03-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1211, 'James', 'Jones', 6, 62471, 0, to_date('20-11-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1212, 'John', 'Jackson', 3, 74617, 0, to_date('25-03-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1213, 'Elijah', 'Smith', 4, 96682, 0, to_date('26-10-1950', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1214, 'Evelyn', 'Rodriguez', 2, 96006, 0, to_date('13-12-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1215, 'Emma', 'Garcia', 10, 94833, 0, to_date('17-09-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1216, 'Lucas', 'Anderson', 9, 86835, 0, to_date('13-09-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1217, 'Ethan', 'Taylor', 5, 73923, 0, to_date('09-12-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1218, 'Harper', 'Martin', 3, 95295, 0, to_date('28-09-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1219, 'Sophia', 'Taylor', 9, 52528, 0, to_date('04-07-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1220, 'Sophia', 'Brown', 8, 57352, 0, to_date('14-10-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1221, 'Evelyn', 'Davis', 1, 62718, 0, to_date('20-12-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1222, 'John', 'Davis', 9, 96856, 0, to_date('06-03-1989', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1223, 'Alexander', 'Smith', 9, 39859, 0, to_date('20-08-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1224, 'Harper', 'Brown', 5, 47275, 0, to_date('14-06-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1225, 'Michael', 'Gonzalez', 7, 38371, 0, to_date('02-08-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1226, 'James', 'Miller', 6, 57436, 0, to_date('15-05-1963', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1227, 'Amelia', 'Anderson', 10, 55542, 0, to_date('18-08-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1228, 'William', 'Jones', 2, 31772, 0, to_date('07-01-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1229, 'Michael', 'Jones', 2, 25585, 0, to_date('12-02-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1230, 'Elijah', 'Wilson', 6, 51375, 0, to_date('15-07-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1231, 'Olivia', 'Rodriguez', 10, 37954, 0, to_date('20-08-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1232, 'Abigail', 'Smith', 8, 14853, 0, to_date('01-04-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1233, 'Abigail', 'Rodriguez', 9, 48225, 0, to_date('27-05-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1234, 'James', 'Jackson', 9, 36642, 0, to_date('03-04-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1235, 'Sophia', 'Jackson', 9, 21911, 0, to_date('19-06-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1236, 'Amelia', 'Davis', 5, 22720, 0, to_date('26-02-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1237, 'Mason', 'Brown', 1, 98590, 0, to_date('17-11-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1238, 'Mia', 'Davis', 6, 84926, 0, to_date('20-09-1930', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1239, 'Olivia', 'Garcia', 6, 97369, 0, to_date('01-08-1946', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1240, 'Lucas', 'Brown', 8, 37392, 0, to_date('13-01-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1241, 'Benjamin', 'Miller', 8, 53373, 0, to_date('17-11-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1242, 'Alexander', 'Johnson', 3, 26879, 0, to_date('10-11-2000', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1243, 'Ethan', 'Johnson', 1, 92006, 0, to_date('26-06-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1244, 'Abigail', 'Anderson', 5, 14793, 0, to_date('24-06-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1245, 'Harper', 'Jackson', 5, 90248, 0, to_date('06-07-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1246, 'Sophia', 'Miller', 6, 93673, 0, to_date('20-07-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1247, 'Sophia', 'Moore', 6, 55087, 0, to_date('26-06-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1248, 'Olivia', 'Garcia', 1, 98938, 0, to_date('08-10-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1249, 'Sophia', 'Lopez', 4, 76779, 0, to_date('18-10-1991', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1250, 'Emma', 'Wilson', 10, 61530, 0, to_date('10-09-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1251, 'Abigail', 'Rodriguez', 4, 78836, 0, to_date('25-10-1977', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1252, 'William', 'Brown', 6, 17186, 0, to_date('24-08-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1253, 'Evelyn', 'Taylor', 10, 63293, 0, to_date('25-03-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1254, 'William', 'Johnson', 8, 53395, 0, to_date('15-12-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1255, 'Amelia', 'Taylor', 1, 50654, 0, to_date('22-04-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1256, 'Sophia', 'Jones', 4, 54758, 0, to_date('28-03-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1257, 'Ava', 'Brown', 2, 66619, 0, to_date('04-04-1979', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1258, 'Benjamin', 'Williams', 4, 94986, 0, to_date('02-03-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1259, 'Harper', 'Brown', 3, 75919, 0, to_date('07-10-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1260, 'Lucas', 'Taylor', 7, 57172, 0, to_date('27-03-1931', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1261, 'Elijah', 'Brown', 10, 69687, 0, to_date('25-05-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1262, 'Lucas', 'Brown', 10, 32184, 0, to_date('24-03-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1263, 'Abigail', 'Brown', 2, 68188, 0, to_date('12-10-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1264, 'James', 'Taylor', 10, 65947, 0, to_date('22-09-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1265, 'Evelyn', 'Miller', 5, 74204, 0, to_date('05-12-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1266, 'Michael', 'Moore', 4, 68776, 0, to_date('18-08-1942', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 700 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1267, 'Lucas', 'Taylor', 4, 36601, 0, to_date('28-09-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1268, 'Mia', 'Jackson', 2, 82605, 0, to_date('26-03-1969', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1269, 'Harper', 'Jackson', 10, 85607, 0, to_date('10-08-1999', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1270, 'Ava', 'Thomas', 7, 35084, 0, to_date('14-11-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1271, 'Elijah', 'Hernandez', 10, 10465, 0, to_date('10-02-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1272, 'Elijah', 'Martinez', 1, 72278, 0, to_date('25-01-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1273, 'William', 'Martin', 2, 99439, 0, to_date('11-11-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1274, 'Ava', 'Garcia', 5, 50005, 0, to_date('29-12-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1275, 'Olivia', 'Martin', 1, 95166, 0, to_date('19-03-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1276, 'Harper', 'Anderson', 6, 77230, 0, to_date('18-10-1957', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1277, 'Mason', 'Taylor', 6, 76588, 0, to_date('21-02-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1278, 'Sophia', 'Smith', 2, 70846, 0, to_date('22-01-2015', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1279, 'Benjamin', 'Williams', 2, 36301, 0, to_date('04-11-2002', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1280, 'Mia', 'Miller', 2, 66815, 0, to_date('19-06-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1281, 'Benjamin', 'Brown', 2, 26036, 0, to_date('17-05-1936', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1282, 'Elijah', 'Taylor', 4, 30009, 0, to_date('07-01-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1283, 'Elijah', 'Smith', 8, 18877, 0, to_date('16-09-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1284, 'Abigail', 'Davis', 6, 76894, 0, to_date('07-09-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1285, 'Isabella', 'Wilson', 5, 50148, 0, to_date('01-05-1959', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1286, 'Mia', 'Martin', 9, 78098, 0, to_date('10-01-2016', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1287, 'Sophia', 'Hernandez', 9, 29770, 0, to_date('11-09-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1288, 'Amelia', 'Smith', 4, 41292, 0, to_date('14-02-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1289, 'Mason', 'Garcia', 2, 95022, 0, to_date('04-05-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1290, 'Amelia', 'Martin', 3, 61660, 0, to_date('05-11-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1291, 'Alexander', 'Williams', 1, 93316, 0, to_date('27-09-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1292, 'Elijah', 'Martin', 10, 58261, 0, to_date('17-12-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1293, 'Lucas', 'Anderson', 9, 42008, 0, to_date('10-01-1964', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1294, 'Harper', 'Rodriguez', 5, 22004, 0, to_date('12-02-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1295, 'Harper', 'Thomas', 9, 43666, 0, to_date('29-03-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1296, 'Harper', 'Davis', 1, 68978, 0, to_date('26-07-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1297, 'James', 'Johnson', 4, 82060, 0, to_date('15-04-1956', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1298, 'Sophia', 'Wilson', 2, 41832, 0, to_date('17-04-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1299, 'Mason', 'Williams', 2, 15040, 0, to_date('05-03-1951', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1300, 'Alexander', 'Thomas', 5, 29233, 0, to_date('27-04-1982', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1301, 'William', 'Martinez', 1, 59849, 0, to_date('31-10-1966', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1302, 'Elijah', 'Jones', 8, 86425, 0, to_date('19-02-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1303, 'Abigail', 'Jones', 9, 79038, 0, to_date('22-04-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1304, 'Ava', 'Anderson', 9, 47972, 0, to_date('21-01-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1305, 'Emma', 'Wilson', 6, 66740, 0, to_date('13-10-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1306, 'Lucas', 'Davis', 1, 28770, 0, to_date('25-03-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1307, 'Mason', 'Davis', 1, 45726, 0, to_date('03-01-2020', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1308, 'Mason', 'Gonzalez', 3, 89063, 0, to_date('01-02-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1309, 'William', 'Williams', 10, 75604, 0, to_date('15-08-1929', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1310, 'Harper', 'Wilson', 4, 22510, 0, to_date('09-03-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1311, 'Emma', 'Williams', 4, 92702, 0, to_date('28-07-1976', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1312, 'Emma', 'Davis', 5, 15889, 0, to_date('26-01-2004', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1313, 'Alexander', 'Anderson', 1, 85136, 0, to_date('23-01-1958', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1314, 'James', 'Martin', 7, 38009, 0, to_date('10-01-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1315, 'Michael', 'Martin', 9, 34992, 0, to_date('09-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1316, 'James', 'Wilson', 9, 98054, 0, to_date('06-03-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1317, 'Lucas', 'Smith', 10, 73854, 0, to_date('07-01-1943', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1318, 'Benjamin', 'Miller', 2, 13261, 0, to_date('11-06-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1319, 'Isabella', 'Wilson', 8, 35212, 0, to_date('22-08-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1320, 'William', 'Martin', 9, 64196, 0, to_date('13-04-2011', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1321, 'Emma', 'Lopez', 3, 93219, 0, to_date('10-06-1995', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1322, 'Elijah', 'Brown', 10, 37492, 0, to_date('18-10-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1323, 'Sophia', 'Lopez', 1, 43937, 0, to_date('09-04-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1324, 'Ava', 'Brown', 9, 45647, 0, to_date('21-08-1984', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1325, 'Harper', 'Smith', 3, 94043, 0, to_date('20-02-1962', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1326, 'Lucas', 'Miller', 7, 82100, 0, to_date('29-08-2017', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1327, 'Isabella', 'Brown', 9, 85836, 0, to_date('23-11-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1328, 'Evelyn', 'Smith', 3, 93644, 0, to_date('23-08-1987', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1329, 'Ethan', 'Miller', 5, 26625, 0, to_date('01-11-1973', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1330, 'Evelyn', 'Miller', 5, 73435, 0, to_date('05-06-1965', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1331, 'Olivia', 'Taylor', 10, 93596, 0, to_date('10-03-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1332, 'Harper', 'Smith', 1, 43873, 0, to_date('16-05-1932', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1333, 'John', 'Johnson', 5, 60085, 0, to_date('15-06-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1334, 'Mia', 'Rodriguez', 9, 66446, 0, to_date('16-08-1985', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1335, 'Alexander', 'Brown', 9, 88740, 0, to_date('09-04-1939', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1336, 'Ethan', 'Lopez', 3, 48657, 0, to_date('08-07-1970', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1337, 'Harper', 'Taylor', 6, 31453, 0, to_date('19-11-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1338, 'Isabella', 'Brown', 4, 20696, 0, to_date('21-02-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1339, 'Evelyn', 'Miller', 1, 69219, 0, to_date('02-05-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1340, 'Evelyn', 'Anderson', 1, 77209, 0, to_date('25-02-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1341, 'Emma', 'Miller', 6, 25576, 0, to_date('17-04-2019', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1342, 'Mason', 'Gonzalez', 5, 24107, 0, to_date('08-11-1993', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1343, 'Amelia', 'Smith', 9, 62135, 0, to_date('22-02-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1344, 'Amelia', 'Smith', 7, 96660, 0, to_date('27-09-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1345, 'Lucas', 'Jackson', 5, 63139, 0, to_date('05-08-2010', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1346, 'Elijah', 'Miller', 4, 16770, 0, to_date('28-05-1998', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1347, 'Evelyn', 'Anderson', 2, 39086, 0, to_date('31-07-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1348, 'John', 'Williams', 5, 71043, 0, to_date('11-07-1942', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1349, 'Isabella', 'Martin', 8, 25234, 0, to_date('24-05-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1350, 'William', 'Miller', 7, 63983, 0, to_date('28-03-1926', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1351, 'Harper', 'Martinez', 10, 51375, 0, to_date('25-07-1943', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1352, 'Ava', 'Brown', 6, 28269, 0, to_date('15-08-2001', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1353, 'Evelyn', 'Miller', 6, 75246, 0, to_date('26-12-1967', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1354, 'Isabella', 'Moore', 3, 74469, 351, to_date('13-12-1924', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1355, 'Sophia', 'Williams', 5, 72814, 0, to_date('12-12-1960', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1356, 'Alexander', 'Jackson', 4, 94311, 0, to_date('11-04-1981', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1357, 'Alexander', 'Williams', 1, 46848, 0, to_date('11-02-1954', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1358, 'Ethan', 'Johnson', 6, 40678, 0, to_date('01-10-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1359, 'John', 'Martin', 1, 42726, 0, to_date('28-01-1961', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1360, 'Alexander', 'Williams', 10, 90478, 0, to_date('05-03-1983', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1361, 'Isabella', 'Martin', 4, 94820, 0, to_date('22-03-1944', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1362, 'Ethan', 'Davis', 8, 92556, 0, to_date('27-09-2008', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1363, 'William', 'Gonzalez', 2, 39369, 0, to_date('18-06-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1364, 'James', 'Wilson', 5, 73890, 0, to_date('04-12-1975', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1365, 'Sophia', 'Wilson', 10, 68676, 0, to_date('17-03-1933', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1366, 'Olivia', 'Rodriguez', 3, 22327, 0, to_date('29-12-1936', 'dd-mm-yyyy'), null, null, null);
commit;
prompt 800 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1367, 'Ethan', 'Williams', 5, 81660, 0, to_date('24-03-2007', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1368, 'Olivia', 'Martin', 7, 58602, 0, to_date('02-02-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1369, 'Benjamin', 'Brown', 1, 91136, 0, to_date('03-02-1927', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1370, 'Sophia', 'Martin', 2, 23834, 0, to_date('22-01-1997', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1371, 'James', 'Brown', 1, 59950, 0, to_date('26-05-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1372, 'Abigail', 'Miller', 9, 36903, 0, to_date('06-10-1992', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1373, 'John', 'Anderson', 7, 20548, 0, to_date('08-12-1925', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1374, 'Ethan', 'Jones', 9, 99160, 0, to_date('04-08-1937', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1375, 'James', 'Martinez', 9, 86491, 0, to_date('24-01-1955', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1376, 'John', 'Williams', 7, 64396, 0, to_date('18-06-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1377, 'Ava', 'Miller', 4, 54015, 0, to_date('18-06-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1378, 'Olivia', 'Martin', 1, 88601, 0, to_date('24-02-1947', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1379, 'Lucas', 'Smith', 7, 94383, 0, to_date('15-01-2018', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1380, 'Ethan', 'Anderson', 6, 92925, 0, to_date('08-02-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1381, 'Ava', 'Gonzalez', 2, 81899, 0, to_date('12-09-2009', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1382, 'Abigail', 'Gonzalez', 8, 82384, 0, to_date('08-09-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1383, 'William', 'Brown', 10, 31880, 0, to_date('20-12-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1384, 'Evelyn', 'Moore', 6, 91318, 0, to_date('21-04-1980', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1385, 'Evelyn', 'Wilson', 3, 33125, 0, to_date('13-05-1945', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1386, 'Alexander', 'Wilson', 5, 23562, 0, to_date('05-12-1996', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1387, 'Mia', 'Gonzalez', 8, 47339, 0, to_date('16-05-1968', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1388, 'Harper', 'Garcia', 7, 95196, 0, to_date('28-12-1928', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1389, 'Harper', 'Miller', 10, 15001, 0, to_date('10-08-2006', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1390, 'Michael', 'Johnson', 1, 28054, 0, to_date('26-09-2012', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1391, 'John', 'Smith', 5, 69997, 0, to_date('21-11-1952', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1392, 'Evelyn', 'Anderson', 3, 28356, 0, to_date('02-05-1971', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1393, 'John', 'Taylor', 7, 25186, 0, to_date('16-01-1974', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1394, 'Emma', 'Rodriguez', 9, 80336, 0, to_date('23-08-1986', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1395, 'Alexander', 'Jones', 2, 21907, 0, to_date('10-07-1994', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1396, 'Ethan', 'Thomas', 10, 68355, 0, to_date('19-11-1949', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1397, 'James', 'Anderson', 5, 35742, 0, to_date('02-05-1972', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1398, 'Mason', 'Thomas', 10, 35503, 0, to_date('26-02-2003', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1399, 'Benjamin', 'Wilson', 10, 98272, 0, to_date('20-12-1953', 'dd-mm-yyyy'), null, null, null);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1500, 'Alexandra', 'Wright', null, 541868000, null, to_date('11-10-2011', 'dd-mm-yyyy'), 'Derek', 'Deborah', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1502, 'Cameron', 'Diaz', null, 540884427, null, to_date('08-05-2008', 'dd-mm-yyyy'), 'Lucas', 'Samantha', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1503, 'Karen', 'Clark', null, 543497247, null, to_date('03-04-2017', 'dd-mm-yyyy'), 'Charles', 'Cheryl', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1504, 'Sarah', 'Harris', null, 575968929, null, to_date('30-12-2017', 'dd-mm-yyyy'), 'Douglas', 'Brenda', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1506, 'Theodore', 'Evans', null, 581154956, null, to_date('09-10-2011', 'dd-mm-yyyy'), 'Henry', 'Jennifer', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1509, 'Susan', 'Anderson', null, 556407681, null, to_date('13-04-2014', 'dd-mm-yyyy'), 'Adam', 'Lucia', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1511, 'Keith', 'Roberts', null, 580489883, null, to_date('16-04-2012', 'dd-mm-yyyy'), 'Patrick', 'Janet', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1512, 'David', 'Rodriguez', null, 551793120, null, to_date('16-05-2018', 'dd-mm-yyyy'), 'George', 'Angela', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1513, 'Victoria', 'Smith', null, 583976968, null, to_date('22-09-2006', 'dd-mm-yyyy'), 'Travis', 'Pamela', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1514, 'Charlene', 'Hernandez', null, 593016420, null, to_date('10-01-2015', 'dd-mm-yyyy'), 'Justin', 'Helena', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1515, 'Roy', 'Moore', null, 544552372, null, to_date('02-11-2014', 'dd-mm-yyyy'), 'Ethan', 'Mia', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1516, 'Abigail', 'Hernandez', null, 546531441, null, to_date('23-12-2012', 'dd-mm-yyyy'), 'Eric', 'Stephanie', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1519, 'Isaiah', 'Nelson', null, 519345594, null, to_date('11-11-2017', 'dd-mm-yyyy'), 'Ronald', 'Lisa', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1524, 'Sebastian', 'Rogers', null, 535170706, null, to_date('09-02-2011', 'dd-mm-yyyy'), 'Paul', 'Brenda', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1527, 'Philip', 'Wright', null, 579950551, null, to_date('11-10-2015', 'dd-mm-yyyy'), 'Richard', 'Agnes', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1528, 'Stephanie', 'Garcia', null, 590374515, null, to_date('10-01-2008', 'dd-mm-yyyy'), 'Austin', 'Abigail', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1529, 'Luna', 'Cruz', null, 527902077, null, to_date('25-04-2015', 'dd-mm-yyyy'), 'Eric', 'Natalie', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1530, 'Sebastian', 'Moore', null, 526383220, null, to_date('11-02-2007', 'dd-mm-yyyy'), 'Walter', 'Alicia', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1533, 'Teresa', 'Jones', null, 520755116, null, to_date('27-07-2008', 'dd-mm-yyyy'), 'Derek', 'Helena', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1534, 'Evelyn', 'Jones', null, 564431584, null, to_date('06-09-2009', 'dd-mm-yyyy'), 'Zachary', 'Penelope', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1535, 'Stephanie', 'Hernandez', null, 560034458, null, to_date('04-07-2013', 'dd-mm-yyyy'), 'Shannon', 'Alexandra', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1536, 'Shirley', 'Nguyen', null, 511851887, null, to_date('15-01-2008', 'dd-mm-yyyy'), 'Gregory', 'Danielle', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1538, 'Timothy', 'Young', null, 556653152, null, to_date('06-07-2014', 'dd-mm-yyyy'), 'Christopher', 'Maria', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1539, 'Jacob', 'Nguyen', null, 551354560, null, to_date('05-01-2007', 'dd-mm-yyyy'), 'Richard', 'Linda', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1541, 'Heather', 'Robinson', null, 565140285, null, to_date('06-08-2008', 'dd-mm-yyyy'), 'Eric', 'Tiffany', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1544, 'Vincent', 'Lee', null, 543636551, null, to_date('03-04-2011', 'dd-mm-yyyy'), 'Sebastian', 'Monica', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1546, 'Margaret', 'Young', null, 535175866, null, to_date('21-10-2016', 'dd-mm-yyyy'), 'Andrew', 'Lydia', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1549, 'Sebastian', 'Scott', null, 595869513, null, to_date('01-07-2014', 'dd-mm-yyyy'), 'Dylan', 'Brittany', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1551, 'Brian', 'Taylor', null, 550109206, null, to_date('15-03-2011', 'dd-mm-yyyy'), 'Cole', 'Rachel', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1552, 'Courtney', 'Clark', null, 539075311, null, to_date('21-03-2009', 'dd-mm-yyyy'), 'George', 'Audrey', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1553, 'Cody', 'Campbell', null, 589785335, null, to_date('21-09-2010', 'dd-mm-yyyy'), 'Albert', 'Stephanie', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1554, 'Leslie', 'Miller', null, 561934338, null, to_date('07-07-2013', 'dd-mm-yyyy'), 'Isaac', 'Danielle', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1556, 'Zachary', 'Garcia', null, 597518023, null, to_date('13-12-2014', 'dd-mm-yyyy'), 'Cody', 'Kelly', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1557, 'Jennifer', 'Lopez', null, 562958849, null, to_date('19-10-2011', 'dd-mm-yyyy'), 'Jayden', 'Sarah', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1559, 'Jayden', 'Hernandez', null, 578572076, null, to_date('16-01-2016', 'dd-mm-yyyy'), 'Harold', 'Claudia', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1560, 'Scott', 'Hall', null, 549987298, null, to_date('13-12-2011', 'dd-mm-yyyy'), 'Gabriel', 'Hannah', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1562, 'Julian', 'Nguyen', null, 547002676, null, to_date('04-10-2014', 'dd-mm-yyyy'), 'Ezekiel', 'Amanda', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1564, 'Anthony', 'Moore', null, 580891495, null, to_date('12-10-2017', 'dd-mm-yyyy'), 'William', 'Penelope', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1565, 'Shirley', 'Nelson', null, 534178182, null, to_date('14-03-2011', 'dd-mm-yyyy'), 'Abraham', 'Jasmine', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1566, 'Laura', 'Wilson', null, 537788912, null, to_date('02-12-2011', 'dd-mm-yyyy'), 'Adam', 'Charlotte', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1570, 'Nathan', 'Anderson', null, 556710704, null, to_date('13-09-2009', 'dd-mm-yyyy'), 'Vincent', 'Jennifer', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1571, 'Edward', 'Robinson', null, 551852535, null, to_date('28-03-2014', 'dd-mm-yyyy'), 'Antonio', 'Maya', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1572, 'Gregory', 'Rodriguez', null, 553872224, null, to_date('08-09-2008', 'dd-mm-yyyy'), 'Adam', 'Lucy', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1573, 'Nicole', 'Moore', null, 583140414, null, to_date('19-04-2008', 'dd-mm-yyyy'), 'Felipe', 'Claire', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1575, 'Xavier', 'Scott', null, 594596575, null, to_date('06-08-2011', 'dd-mm-yyyy'), 'John', 'Leslie', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1576, 'Martha', 'Hernandez', null, 595223556, null, to_date('29-04-2011', 'dd-mm-yyyy'), 'Eric', 'Reagan', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1577, 'Susan', 'Brown', null, 528048939, null, to_date('03-12-2016', 'dd-mm-yyyy'), 'Thomas', 'Agnes', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1578, 'Derek', 'Walker', null, 576353114, null, to_date('24-08-2013', 'dd-mm-yyyy'), 'Samuel', 'Mia', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1584, 'Lisa', 'Wright', null, 597321822, null, to_date('17-10-2006', 'dd-mm-yyyy'), 'Albert', 'Alice', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1585, 'Derek', 'Miller', null, 525424277, null, to_date('25-12-2013', 'dd-mm-yyyy'), 'Joshua', 'Jasmine', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1586, 'Linda', 'Lewis', null, 566196455, null, to_date('20-09-2012', 'dd-mm-yyyy'), 'Owen', 'Victoria', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1587, 'Kelly', 'Roberts', null, 581748972, null, to_date('04-10-2006', 'dd-mm-yyyy'), 'Edward', 'Diana', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1588, 'Ava', 'Williams', null, 596273809, null, to_date('02-08-2013', 'dd-mm-yyyy'), 'Nicholas', 'Abigail', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1589, 'Louise', 'Robinson', null, 542101305, null, to_date('16-10-2011', 'dd-mm-yyyy'), 'Ronald', 'Heather', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1590, 'Gabriel', 'Hernandez', null, 519866412, null, to_date('29-06-2007', 'dd-mm-yyyy'), 'Dennis', 'Caroline', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1591, 'Claire', 'Jones', null, 549141214, null, to_date('09-12-2011', 'dd-mm-yyyy'), 'Cameron', 'Louise', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1592, 'Victoria', 'Evans', null, 557330759, null, to_date('01-11-2017', 'dd-mm-yyyy'), 'Owen', 'Rose', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1593, 'Margaret', 'Clark', null, 571413868, null, to_date('17-09-2012', 'dd-mm-yyyy'), 'Walter', 'Jade', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1596, 'Lisa', 'Green', null, 557527598, null, to_date('28-04-2008', 'dd-mm-yyyy'), 'Ezekiel', 'Jacqueline', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1597, 'Derek', 'Nelson', null, 538919598, null, to_date('15-03-2011', 'dd-mm-yyyy'), 'Cameron', 'Charlotte', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1598, 'Julia', 'Jones', null, 535976064, null, to_date('28-10-2012', 'dd-mm-yyyy'), 'Gabriel', 'Samantha', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1599, 'Ruby', 'Allen', null, 518985766, null, to_date('02-01-2016', 'dd-mm-yyyy'), 'Jonathan', 'Nancy', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1601, 'Nicholas', 'Garcia', null, 527767652, null, to_date('29-01-2009', 'dd-mm-yyyy'), 'Derek', 'Linda', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1603, 'Heather', 'Roberts', null, 585481271, null, to_date('17-03-2008', 'dd-mm-yyyy'), 'Jesse', 'Madison', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1604, 'Thomas', 'Robinson', null, 560259224, null, to_date('26-01-2018', 'dd-mm-yyyy'), 'Theodore', 'Hayley', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1605, 'Anthony', 'Hernandez', null, 578863284, null, to_date('24-10-2008', 'dd-mm-yyyy'), 'Christopher', 'Sandra', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1606, 'Laura', 'Taylor', null, 527134416, null, to_date('03-04-2012', 'dd-mm-yyyy'), 'Zachary', 'Alana', 27);
commit;
prompt 900 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1607, 'Stephanie', 'Cruz', null, 560920589, null, to_date('03-01-2007', 'dd-mm-yyyy'), 'Luke', 'Peyton', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1608, 'Rebecca', 'Evans', null, 591609320, null, to_date('23-02-2009', 'dd-mm-yyyy'), 'Jacob', 'Audrey', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1609, 'Carlos', 'Robinson', null, 592407738, null, to_date('23-03-2013', 'dd-mm-yyyy'), 'Douglas', 'Sarah', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1612, 'Rose', 'Green', null, 547970151, null, to_date('10-11-2014', 'dd-mm-yyyy'), 'Jacob', 'Jasmine', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1613, 'Cole', 'Mitchell', null, 560826081, null, to_date('18-04-2014', 'dd-mm-yyyy'), 'Brandon', 'Carla', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1614, 'Lillian', 'Lewis', null, 585744067, null, to_date('27-06-2010', 'dd-mm-yyyy'), 'Sebastian', 'Tiffany', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1617, 'Aaron', 'Lee', null, 515240356, null, to_date('11-10-2015', 'dd-mm-yyyy'), 'Julian', 'Cheryl', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1618, 'Amelia', 'Allen', null, 590409951, null, to_date('03-01-2007', 'dd-mm-yyyy'), 'Wesley', 'Nancy', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1619, 'Julian', 'Young', null, 573074366, null, to_date('18-01-2014', 'dd-mm-yyyy'), 'Dennis', 'Kelly', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1620, 'Joan', 'Miller', null, 549667298, null, to_date('02-08-2012', 'dd-mm-yyyy'), 'Sean', 'Penelope', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1622, 'Tyler', 'Young', null, 579075642, null, to_date('17-03-2013', 'dd-mm-yyyy'), 'Andrew', 'Amanda', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1623, 'Daniel', 'Taylor', null, 520503461, null, to_date('08-07-2011', 'dd-mm-yyyy'), 'Ryan', 'Bridget', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1624, 'Brandon', 'Nelson', null, 525521038, null, to_date('05-01-2018', 'dd-mm-yyyy'), 'Noah', 'Luna', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1625, 'Harold', 'Miller', null, 548679916, null, to_date('19-02-2010', 'dd-mm-yyyy'), 'Caleb', 'Michelle', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1628, 'Jonathan', 'Williams', null, 544438996, null, to_date('29-11-2009', 'dd-mm-yyyy'), 'Brian', 'Kristen', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1630, 'Theodore', 'Lopez', null, 538078090, null, to_date('14-08-2009', 'dd-mm-yyyy'), 'Wyatt', 'Alicia', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1631, 'Faith', 'Thomas', null, 529068539, null, to_date('02-09-2017', 'dd-mm-yyyy'), 'Brian', 'Evelyn', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1632, 'Gabriel', 'Sanchez', null, 544371226, null, to_date('30-07-2006', 'dd-mm-yyyy'), 'Owen', 'Laura', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1635, 'Kevin', 'Nguyen', null, 540228165, null, to_date('10-10-2009', 'dd-mm-yyyy'), 'Sebastian', 'Luna', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1636, 'Daniel', 'Campbell', null, 559233457, null, to_date('22-10-2015', 'dd-mm-yyyy'), 'Jack', 'Leah', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1637, 'Joshua', 'Rodriguez', null, 520986276, null, to_date('12-06-2013', 'dd-mm-yyyy'), 'Adrian', 'Teresa', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1638, 'Maya', 'Lopez', null, 593777356, null, to_date('13-08-2017', 'dd-mm-yyyy'), 'Javier', 'Amelia', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1639, 'Oliver', 'Robinson', null, 512288694, null, to_date('12-04-2013', 'dd-mm-yyyy'), 'Eric', 'Charlotte', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1640, 'Maya', 'Scott', null, 566859396, null, to_date('22-11-2013', 'dd-mm-yyyy'), 'Joan', 'Lily', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1641, 'Kristen', 'Allen', null, 581300682, null, to_date('14-01-2009', 'dd-mm-yyyy'), 'Walter', 'Cheryl', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1642, 'Antonio', 'Garcia', null, 581545388, null, to_date('06-02-2009', 'dd-mm-yyyy'), 'Javier', 'Luna', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1643, 'Jordan', 'Lee', null, 581474390, null, to_date('19-06-2007', 'dd-mm-yyyy'), 'Leonardo', 'Ruby', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1644, 'Cole', 'Walker', null, 588083016, null, to_date('21-01-2016', 'dd-mm-yyyy'), 'Nathaniel', 'Ruby', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1645, 'Kristen', 'Lewis', null, 540713170, null, to_date('23-06-2010', 'dd-mm-yyyy'), 'Lawrence', 'Tiffany', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1646, 'Danielle', 'Thompson', null, 533784253, null, to_date('19-03-2012', 'dd-mm-yyyy'), 'Scott', 'Phoebe', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1649, 'George', 'Robinson', null, 519904369, null, to_date('21-03-2017', 'dd-mm-yyyy'), 'Ryan', 'Natalie', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1650, 'Stephen', 'Garcia', null, 512127328, null, to_date('09-09-2006', 'dd-mm-yyyy'), 'Joseph', 'Catherine', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1652, 'Edward', 'Williams', null, 587317546, null, to_date('22-02-2010', 'dd-mm-yyyy'), 'Owen', 'Ashley', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1654, 'Scott', 'Phillips', null, 553261420, null, to_date('06-03-2012', 'dd-mm-yyyy'), 'Dennis', 'Natalie', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1656, 'Jacob', 'Mitchell', null, 583258534, null, to_date('15-06-2017', 'dd-mm-yyyy'), 'Edward', 'Rachel', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1660, 'Dustin', 'Phillips', null, 532238015, null, to_date('13-05-2016', 'dd-mm-yyyy'), 'Brandon', 'Bridget', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1661, 'Kevin', 'Johnson', null, 554258249, null, to_date('13-12-2011', 'dd-mm-yyyy'), 'Brandon', 'Bethany', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1663, 'Ethan', 'Nelson', null, 524915863, null, to_date('05-09-2011', 'dd-mm-yyyy'), 'Jordan', 'Lillian', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1664, 'Claudia', 'Hernandez', null, 571192317, null, to_date('25-11-2013', 'dd-mm-yyyy'), 'David', 'Kayla', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1665, 'Lucy', 'Hernandez', null, 536027980, null, to_date('03-09-2009', 'dd-mm-yyyy'), 'Lawrence', 'Jacqueline', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1666, 'Ezekiel', 'Cruz', null, 564088981, null, to_date('12-07-2016', 'dd-mm-yyyy'), 'Cody', 'Monica', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1667, 'Molly', 'Nguyen', null, 527248992, null, to_date('16-09-2017', 'dd-mm-yyyy'), 'Isaiah', 'Linda', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1668, 'Sarah', 'Moore', null, 521561956, null, to_date('05-08-2013', 'dd-mm-yyyy'), 'Paul', 'Angela', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1670, 'Leonardo', 'Rodriguez', null, 566240465, null, to_date('17-06-2009', 'dd-mm-yyyy'), 'Jayden', 'Julia', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1672, 'Adrian', 'Hernandez', null, 556958612, null, to_date('12-06-2007', 'dd-mm-yyyy'), 'Timothy', 'Meghan', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1673, 'Alan', 'Anderson', null, 536787238, null, to_date('18-12-2011', 'dd-mm-yyyy'), 'Nathan', 'Peyton', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1675, 'Jennifer', 'Williams', null, 523974313, null, to_date('04-11-2013', 'dd-mm-yyyy'), 'Trevor', 'Kayla', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1676, 'Fiona', 'Roy', null, 552456511, null, to_date('06-09-2017', 'dd-mm-yyyy'), 'Tyler', 'Lisa', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1677, 'Isaiah', 'Clark', null, 516199108, null, to_date('12-08-2009', 'dd-mm-yyyy'), 'Luke', 'Helena', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1678, 'Gregory', 'Phillips', null, 523459118, null, to_date('08-12-2012', 'dd-mm-yyyy'), 'Anthony', 'Susan', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1681, 'Jane', 'Adams', null, 564875750, null, to_date('22-06-2016', 'dd-mm-yyyy'), 'Zachary', 'Lauren', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1684, 'Charlene', 'Allen', null, 527430235, null, to_date('20-01-2014', 'dd-mm-yyyy'), 'Isaiah', 'Abigail', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1685, 'Jayden', 'Johnson', null, 513756226, null, to_date('14-07-2018', 'dd-mm-yyyy'), 'Roy', 'Karen', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1687, 'Cameron', 'Thompson', null, 545599978, null, to_date('20-07-2017', 'dd-mm-yyyy'), 'Tyler', 'Ava', 9);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1691, 'Walter', 'Lewis', null, 584016953, null, to_date('05-02-2011', 'dd-mm-yyyy'), 'Philip', 'Brittany', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1692, 'Vincent', 'Garcia', null, 520457401, null, to_date('02-09-2014', 'dd-mm-yyyy'), 'Xavier', 'Diana', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1695, 'Miguel', 'Lopez', null, 581739043, null, to_date('15-01-2010', 'dd-mm-yyyy'), 'Vincent', 'Samantha', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1696, 'Ashley', 'Johnson', null, 532919123, null, to_date('06-03-2009', 'dd-mm-yyyy'), 'Antonio', 'Bridget', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1698, 'Anthony', 'Allen', null, 544268071, null, to_date('17-03-2010', 'dd-mm-yyyy'), 'Chad', 'Gabriella', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1700, 'Isaiah', 'Wright', null, 570378447, null, to_date('03-04-2015', 'dd-mm-yyyy'), 'George', 'Amanda', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1703, 'Jacqueline', 'Taylor', null, 585308824, null, to_date('21-02-2018', 'dd-mm-yyyy'), 'Jack', 'Courtney', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1704, 'Julia', 'Green', null, 597766757, null, to_date('05-12-2010', 'dd-mm-yyyy'), 'Scott', 'Courtney', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1707, 'Adam', 'Moore', null, 583191610, null, to_date('25-12-2007', 'dd-mm-yyyy'), 'Trevor', 'Ruby', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1708, 'Jacob', 'Moore', null, 576620844, null, to_date('11-06-2015', 'dd-mm-yyyy'), 'Stephen', 'Abigail', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1710, 'Ava', 'Lee', null, 522317020, null, to_date('28-01-2009', 'dd-mm-yyyy'), 'Theodore', 'Linda', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1712, 'Lucia', 'Hernandez', null, 523920417, null, to_date('23-05-2014', 'dd-mm-yyyy'), 'Nicholas', 'Vivian', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1713, 'Benjamin', 'Allen', null, 515819212, null, to_date('05-02-2011', 'dd-mm-yyyy'), 'Diego', 'Kayla', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1716, 'Lily', 'Scott', null, 546612610, null, to_date('02-06-2009', 'dd-mm-yyyy'), 'Joshua', 'Sydney', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1720, 'Patricia', 'Garcia', null, 530795249, null, to_date('26-03-2017', 'dd-mm-yyyy'), 'Joseph', 'Charlene', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1721, 'Nathan', 'Rodriguez', null, 598129305, null, to_date('11-07-2009', 'dd-mm-yyyy'), 'Trevor', 'Monica', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1722, 'Katherine', 'Nguyen', null, 528782998, null, to_date('28-07-2013', 'dd-mm-yyyy'), 'Julian', 'Nicole', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1723, 'Chad', 'Clark', null, 560166830, null, to_date('03-01-2013', 'dd-mm-yyyy'), 'Jacob', 'Stephanie', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1724, 'Andrew', 'Thomas', null, 534026854, null, to_date('12-01-2018', 'dd-mm-yyyy'), 'Isaac', 'Caroline', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1725, 'Maria', 'Hernandez', null, 566892833, null, to_date('25-04-2009', 'dd-mm-yyyy'), 'George', 'Alexis', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1727, 'Martha', 'Allen', null, 530745831, null, to_date('04-08-2011', 'dd-mm-yyyy'), 'Cody', 'Hannah', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1728, 'Shannon', 'Lopez', null, 576677565, null, to_date('17-11-2011', 'dd-mm-yyyy'), 'Austin', 'Isabella', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1729, 'Zachary', 'Williams', null, 514774796, null, to_date('17-08-2011', 'dd-mm-yyyy'), 'Ryan', 'Agnes', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1730, 'Isaac', 'Hernandez', null, 546593702, null, to_date('07-02-2018', 'dd-mm-yyyy'), 'Brian', 'Louise', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1731, 'Isabella', 'Adams', null, 540073645, null, to_date('11-02-2011', 'dd-mm-yyyy'), 'Julian', 'Sandra', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1733, 'Diana', 'Clark', null, 524258229, null, to_date('01-02-2014', 'dd-mm-yyyy'), 'Joan', 'Nicole', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1738, 'Felipe', 'Walker', null, 597779079, null, to_date('02-01-2014', 'dd-mm-yyyy'), 'Austin', 'Lydia', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1740, 'Nathan', 'Hernandez', null, 515684880, null, to_date('17-05-2007', 'dd-mm-yyyy'), 'Christopher', 'Meghan', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1741, 'Penelope', 'Walker', null, 522351988, null, to_date('07-05-2015', 'dd-mm-yyyy'), 'Dustin', 'Brittany', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1743, 'Julia', 'Nguyen', null, 594277729, null, to_date('27-03-2016', 'dd-mm-yyyy'), 'Chad', 'Rose', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1748, 'Walter', 'Phillips', null, 542792234, null, to_date('10-01-2008', 'dd-mm-yyyy'), 'Julian', 'Courtney', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1749, 'Roy', 'Rogers', null, 595221830, null, to_date('23-10-2007', 'dd-mm-yyyy'), 'David', 'Linda', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1751, 'Faith', 'Young', null, 515484767, null, to_date('09-07-2011', 'dd-mm-yyyy'), 'Daniel', 'Leslie', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1752, 'Kimberly', 'Williams', null, 527819264, null, to_date('26-01-2009', 'dd-mm-yyyy'), 'Kevin', 'Maria', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1754, 'Sebastian', 'Garcia', null, 539086091, null, to_date('19-12-2013', 'dd-mm-yyyy'), 'Dennis', 'Jade', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1755, 'Andrew', 'Moore', null, 578518565, null, to_date('02-06-2007', 'dd-mm-yyyy'), 'Cody', 'Sheila', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1757, 'Thomas', 'Nguyen', null, 578525948, null, to_date('10-06-2017', 'dd-mm-yyyy'), 'Justin', 'Brenda', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1758, 'Gabriella', 'Garcia', null, 563231712, null, to_date('03-12-2010', 'dd-mm-yyyy'), 'Alan', 'Pamela', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1761, 'Caroline', 'Scott', null, 559372041, null, to_date('25-04-2011', 'dd-mm-yyyy'), 'Austin', 'Julia', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1763, 'Alice', 'Miller', null, 552220253, null, to_date('18-02-2018', 'dd-mm-yyyy'), 'Owen', 'Kristen', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1766, 'Bethany', 'Taylor', null, 573256488, null, to_date('22-06-2018', 'dd-mm-yyyy'), 'Ethan', 'Alicia', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1767, 'Jasmine', 'Wright', null, 570799319, null, to_date('09-06-2017', 'dd-mm-yyyy'), 'Thomas', 'Rose', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1768, 'Penelope', 'Campbell', null, 518205192, null, to_date('27-05-2012', 'dd-mm-yyyy'), 'Wyatt', 'Penelope', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1769, 'Christopher', 'Davis', null, 549179700, null, to_date('03-03-2014', 'dd-mm-yyyy'), 'Patrick', 'Cecilia', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1771, 'Abraham', 'Moore', null, 520336751, null, to_date('20-02-2011', 'dd-mm-yyyy'), 'Abraham', 'Kayla', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1774, 'Antonio', 'Walker', null, 536978813, null, to_date('05-10-2017', 'dd-mm-yyyy'), 'Andrew', 'Danielle', 18);
commit;
prompt 1000 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1777, 'Sharon', 'Rodriguez', null, 584292886, null, to_date('26-01-2007', 'dd-mm-yyyy'), 'Gabriel', 'Katherine', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1781, 'Cole', 'Rodriguez', null, 582569940, null, to_date('22-09-2015', 'dd-mm-yyyy'), 'John', 'Sarah', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1782, 'Andrew', 'Garcia', null, 593034600, null, to_date('09-05-2013', 'dd-mm-yyyy'), 'Wesley', 'Lucy', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1785, 'Lisa', 'Lee', null, 520724991, null, to_date('25-11-2009', 'dd-mm-yyyy'), 'Ethan', 'Caroline', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1788, 'Austin', 'Harris', null, 584004460, null, to_date('20-08-2017', 'dd-mm-yyyy'), 'Antonio', 'Charlotte', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1789, 'Tiffany', 'Walker', null, 540153861, null, to_date('05-03-2017', 'dd-mm-yyyy'), 'Cody', 'Karen', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1791, 'Julian', 'Miller', null, 573122842, null, to_date('11-02-2017', 'dd-mm-yyyy'), 'Patrick', 'Michelle', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1792, 'Katherine', 'Allen', null, 590605495, null, to_date('15-07-2015', 'dd-mm-yyyy'), 'Zachary', 'Ava', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1798, 'Lillian', 'Campbell', null, 525264680, null, to_date('09-10-2014', 'dd-mm-yyyy'), 'Daniel', 'Alana', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1799, 'Sheila', 'Wilson', null, 576562686, null, to_date('21-05-2015', 'dd-mm-yyyy'), 'Isaac', 'Charlotte', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1800, 'Luke', 'Johnson', null, 511633279, null, to_date('15-06-2012', 'dd-mm-yyyy'), 'Trevor', 'Alice', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1803, 'Claire', 'Diaz', null, 557610951, null, to_date('11-01-2015', 'dd-mm-yyyy'), 'Sebastian', 'Bridget', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1805, 'Gabriella', 'Harris', null, 598700130, null, to_date('13-09-2016', 'dd-mm-yyyy'), 'Aaron', 'Reagan', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1807, 'Cole', 'Moore', null, 568873605, null, to_date('21-10-2016', 'dd-mm-yyyy'), 'Aaron', 'Martha', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1811, 'Joan', 'Taylor', null, 588857941, null, to_date('31-08-2006', 'dd-mm-yyyy'), 'Joshua', 'Hayley', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1812, 'Mia', 'Rogers', null, 567247544, null, to_date('26-02-2017', 'dd-mm-yyyy'), 'Richard', 'Linda', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1815, 'Peyton', 'Miller', null, 583989511, null, to_date('09-12-2013', 'dd-mm-yyyy'), 'Dustin', 'Taylor', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1816, 'Michelle', 'Johnson', null, 550953591, null, to_date('31-12-2008', 'dd-mm-yyyy'), 'Philip', 'Penelope', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1817, 'Amelia', 'Nguyen', null, 511744231, null, to_date('05-04-2016', 'dd-mm-yyyy'), 'Eric', 'Lily', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1818, 'Ezekiel', 'Johnson', null, 549479581, null, to_date('11-06-2009', 'dd-mm-yyyy'), 'Shannon', 'Jessica', 39);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1820, 'Theodore', 'Mitchell', null, 557209428, null, to_date('10-02-2013', 'dd-mm-yyyy'), 'Adrian', 'Alexandra', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1823, 'Robert', 'Lee', null, 581391047, null, to_date('05-01-2012', 'dd-mm-yyyy'), 'Ryan', 'Catherine', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1824, 'Albert', 'Johnson', null, 568120620, null, to_date('04-05-2008', 'dd-mm-yyyy'), 'Ezekiel', 'Martha', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1825, 'Joan', 'Wilson', null, 583603253, null, to_date('10-10-2011', 'dd-mm-yyyy'), 'Trevor', 'Brittany', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1827, 'Scott', 'Hernandez', null, 574516964, null, to_date('23-11-2013', 'dd-mm-yyyy'), 'Ezekiel', 'Penelope', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1828, 'Albert', 'Hernandez', null, 579158122, null, to_date('03-11-2006', 'dd-mm-yyyy'), 'Joan', 'Maya', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1829, 'Cole', 'Green', null, 527620537, null, to_date('19-03-2017', 'dd-mm-yyyy'), 'Keith', 'Sheila', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1831, 'Edward', 'Young', null, 587058364, null, to_date('27-11-2013', 'dd-mm-yyyy'), 'Jordan', 'Reagan', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1833, 'Cecilia', 'Lee', null, 577064088, null, to_date('03-09-2016', 'dd-mm-yyyy'), 'Travis', 'Sharon', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1835, 'Karen', 'Young', null, 549565745, null, to_date('26-06-2013', 'dd-mm-yyyy'), 'Philip', 'Susan', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1837, 'Ronald', 'Lee', null, 562343735, null, to_date('14-04-2008', 'dd-mm-yyyy'), 'Richard', 'Stephanie', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1838, 'Faith', 'Wright', null, 582327265, null, to_date('06-08-2011', 'dd-mm-yyyy'), 'Sebastian', 'Kayla', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1840, 'Jacqueline', 'Robinson', null, 519969862, null, to_date('16-04-2013', 'dd-mm-yyyy'), 'Cameron', 'Margaret', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1841, 'Derek', 'Robinson', null, 564044493, null, to_date('11-07-2010', 'dd-mm-yyyy'), 'Isaac', 'Janet', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1842, 'Jacob', 'Moore', null, 589435793, null, to_date('10-12-2015', 'dd-mm-yyyy'), 'Tyler', 'Faith', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1843, 'Kelly', 'Brown', null, 580166566, null, to_date('21-03-2012', 'dd-mm-yyyy'), 'Harold', 'Gabriella', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1844, 'Alana', 'Sanchez', null, 577658798, null, to_date('01-06-2011', 'dd-mm-yyyy'), 'Daniel', 'Kristen', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1845, 'Dylan', 'Johnson', null, 578330696, null, to_date('20-04-2017', 'dd-mm-yyyy'), 'Jack', 'Hayley', 34);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1846, 'Aisha', 'Wright', null, 571190461, null, to_date('08-01-2015', 'dd-mm-yyyy'), 'Harold', 'Ashley', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1849, 'Antonio', 'Walker', null, 520938719, null, to_date('06-12-2016', 'dd-mm-yyyy'), 'Sebastian', 'Aisha', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1850, 'Scott', 'Harris', null, 579419020, null, to_date('27-09-2008', 'dd-mm-yyyy'), 'Dustin', 'Sheila', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1852, 'Lauren', 'Lewis', null, 572043588, null, to_date('30-11-2007', 'dd-mm-yyyy'), 'Jonathan', 'Evelyn', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1853, 'Caleb', 'Sanchez', null, 595670306, null, to_date('15-12-2014', 'dd-mm-yyyy'), 'Abraham', 'Monica', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1854, 'Aaron', 'Hernandez', null, 514831214, null, to_date('26-03-2009', 'dd-mm-yyyy'), 'Diego', 'Lisa', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1855, 'Martha', 'Lee', null, 552321657, null, to_date('29-03-2010', 'dd-mm-yyyy'), 'Owen', 'Lillian', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1856, 'Dustin', 'Robinson', null, 577076094, null, to_date('21-12-2010', 'dd-mm-yyyy'), 'Xavier', 'Penelope', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1858, 'Eric', 'Allen', null, 599020536, null, to_date('25-05-2015', 'dd-mm-yyyy'), 'Richard', 'Bethany', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1859, 'Heather', 'Mitchell', null, 573224707, null, to_date('05-07-2007', 'dd-mm-yyyy'), 'Antonio', 'Faith', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1862, 'Martha', 'Walker', null, 574952711, null, to_date('03-06-2007', 'dd-mm-yyyy'), 'Benjamin', 'Lucy', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1863, 'Luna', 'Walker', null, 599024067, null, to_date('16-06-2013', 'dd-mm-yyyy'), 'Aaron', 'Diana', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1864, 'Diana', 'Walker', null, 568990770, null, to_date('11-10-2009', 'dd-mm-yyyy'), 'Lucas', 'Maya', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1865, 'Lillian', 'Watson', null, 576661594, null, to_date('11-10-2008', 'dd-mm-yyyy'), 'Eric', 'Alice', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1866, 'Justin', 'Rodriguez', null, 518366894, null, to_date('06-12-2016', 'dd-mm-yyyy'), 'Roy', 'Claire', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1868, 'Ethan', 'Wright', null, 564051588, null, to_date('08-04-2016', 'dd-mm-yyyy'), 'Stephen', 'Jane', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1871, 'Jacqueline', 'Lee', null, 527372336, null, to_date('18-06-2013', 'dd-mm-yyyy'), 'Albert', 'Claire', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1873, 'Albert', 'Johnson', null, 583355063, null, to_date('06-05-2015', 'dd-mm-yyyy'), 'Benjamin', 'Nancy', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1875, 'Courtney', 'Cruz', null, 565100974, null, to_date('13-07-2013', 'dd-mm-yyyy'), 'Roy', 'Maya', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1876, 'Rebecca', 'Evans', null, 547441855, null, to_date('23-08-2014', 'dd-mm-yyyy'), 'Derek', 'Jennifer', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1878, 'Sharon', 'Wright', null, 525577480, null, to_date('20-03-2018', 'dd-mm-yyyy'), 'John', 'Stephanie', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1883, 'Lisa', 'Clark', null, 543853980, null, to_date('17-08-2012', 'dd-mm-yyyy'), 'Cole', 'Linda', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1884, 'Ava', 'Nelson', null, 588869048, null, to_date('02-12-2009', 'dd-mm-yyyy'), 'Sebastian', 'Faith', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1885, 'Reagan', 'Rogers', null, 542615555, null, to_date('11-05-2013', 'dd-mm-yyyy'), 'Brandon', 'Taylor', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1887, 'Harold', 'Roy', null, 597631551, null, to_date('01-08-2011', 'dd-mm-yyyy'), 'Isaac', 'Caroline', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1890, 'Gabriel', 'Hernandez', null, 553250393, null, to_date('26-02-2013', 'dd-mm-yyyy'), 'Isaiah', 'Monica', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1891, 'Sean', 'Rogers', null, 564326195, null, to_date('16-01-2014', 'dd-mm-yyyy'), 'Kyle', 'Heather', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1894, 'Daniel', 'Anderson', null, 551746107, null, to_date('04-05-2011', 'dd-mm-yyyy'), 'Austin', 'Jade', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1896, 'Kyle', 'Moore', null, 563356205, null, to_date('02-01-2008', 'dd-mm-yyyy'), 'Adrian', 'Isabella', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1901, 'Brian', 'Rodriguez', null, 543721994, null, to_date('01-04-2009', 'dd-mm-yyyy'), 'Ezekiel', 'Agnes', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1903, 'Evelyn', 'Rodriguez', null, 529192855, null, to_date('25-02-2013', 'dd-mm-yyyy'), 'Wesley', 'Diana', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1904, 'Patricia', 'Phillips', null, 544981012, null, to_date('26-07-2010', 'dd-mm-yyyy'), 'Xavier', 'Sophia', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1905, 'Rachel', 'Sanchez', null, 536551170, null, to_date('06-12-2012', 'dd-mm-yyyy'), 'Theodore', 'Mia', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1906, 'Jayden', 'Allen', null, 581185722, null, to_date('07-12-2006', 'dd-mm-yyyy'), 'Adam', 'Margaret', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1907, 'Antonio', 'Mitchell', null, 579176762, null, to_date('04-01-2012', 'dd-mm-yyyy'), 'Christopher', 'Penelope', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1910, 'Lauren', 'Roy', null, 550394341, null, to_date('23-10-2013', 'dd-mm-yyyy'), 'Andrew', 'Teresa', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1911, 'Samantha', 'Young', null, 522562885, null, to_date('22-11-2017', 'dd-mm-yyyy'), 'Joseph', 'Audrey', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1915, 'Chad', 'Cruz', null, 528206561, null, to_date('02-01-2011', 'dd-mm-yyyy'), 'Jacob', 'Courtney', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1917, 'Ezekiel', 'Moore', null, 528311853, null, to_date('05-02-2013', 'dd-mm-yyyy'), 'Antonio', 'Claudia', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1918, 'Kyle', 'Miller', null, 572505806, null, to_date('08-10-2014', 'dd-mm-yyyy'), 'Nathan', 'Meghan', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1919, 'Benjamin', 'Hernandez', null, 510973964, null, to_date('07-02-2012', 'dd-mm-yyyy'), 'Jesse', 'Lisa', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1920, 'Samantha', 'Hernandez', null, 510399961, null, to_date('31-05-2017', 'dd-mm-yyyy'), 'Anthony', 'Jacqueline', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1922, 'Isabella', 'Evans', null, 593890678, null, to_date('08-08-2012', 'dd-mm-yyyy'), 'Anthony', 'Katherine', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1923, 'Jennifer', 'Mitchell', null, 527992622, null, to_date('01-12-2015', 'dd-mm-yyyy'), 'Theodore', 'Margaret', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1924, 'Sarah', 'Scott', null, 514194094, null, to_date('29-01-2014', 'dd-mm-yyyy'), 'Eric', 'Penelope', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1925, 'Douglas', 'Lopez', null, 582457357, null, to_date('13-08-2015', 'dd-mm-yyyy'), 'Dustin', 'Diana', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1926, 'Karen', 'Hernandez', null, 568360925, null, to_date('13-10-2008', 'dd-mm-yyyy'), 'Charles', 'Helena', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1927, 'Dylan', 'Lopez', null, 552457681, null, to_date('19-03-2012', 'dd-mm-yyyy'), 'Luke', 'Jillian', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1928, 'Nathan', 'Campbell', null, 559007588, null, to_date('27-08-2017', 'dd-mm-yyyy'), 'Lawrence', 'Meghan', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1933, 'Fiona', 'Moore', null, 591181653, null, to_date('07-06-2009', 'dd-mm-yyyy'), 'Jesse', 'Hayley', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1935, 'Amanda', 'Williams', null, 558900968, null, to_date('09-04-2015', 'dd-mm-yyyy'), 'Edward', 'Pamela', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1936, 'Javier', 'Moore', null, 554643857, null, to_date('10-01-2015', 'dd-mm-yyyy'), 'Paul', 'Cheryl', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1939, 'Thomas', 'Moore', null, 587134589, null, to_date('12-05-2008', 'dd-mm-yyyy'), 'Derek', 'Pamela', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1940, 'Michelle', 'Lopez', null, 517227489, null, to_date('04-09-2016', 'dd-mm-yyyy'), 'Gabriel', 'Rachel', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1941, 'Wesley', 'Allen', null, 579753538, null, to_date('17-04-2007', 'dd-mm-yyyy'), 'Richard', 'Meghan', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1942, 'Jonathan', 'Moore', null, 540772325, null, to_date('15-06-2013', 'dd-mm-yyyy'), 'Albert', 'Joan', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1943, 'Margaret', 'Thomas', null, 530511867, null, to_date('19-11-2008', 'dd-mm-yyyy'), 'Samuel', 'Olivia', 8);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1944, 'Karen', 'Roberts', null, 582572375, null, to_date('03-04-2018', 'dd-mm-yyyy'), 'Brandon', 'Danielle', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1945, 'Vivian', 'Hernandez', null, 553535875, null, to_date('11-05-2010', 'dd-mm-yyyy'), 'Oliver', 'Shirley', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1947, 'Laura', 'Rodriguez', null, 510541878, null, to_date('28-03-2008', 'dd-mm-yyyy'), 'Gabriel', 'Angela', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1949, 'Cecilia', 'Mitchell', null, 521163097, null, to_date('05-02-2007', 'dd-mm-yyyy'), 'Oliver', 'Taylor', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1950, 'Aaron', 'Walker', null, 567835154, null, to_date('03-05-2007', 'dd-mm-yyyy'), 'Lucas', 'Kelly', 17);
commit;
prompt 1100 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1951, 'Albert', 'Rogers', null, 528833675, null, to_date('11-08-2012', 'dd-mm-yyyy'), 'Gabriel', 'Stephanie', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1953, 'Andrew', 'Walker', null, 593443295, null, to_date('15-03-2018', 'dd-mm-yyyy'), 'David', 'Alicia', 15);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1956, 'Kristen', 'Hernandez', null, 546381004, null, to_date('16-03-2008', 'dd-mm-yyyy'), 'Adrian', 'Hannah', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1959, 'Dennis', 'Hernandez', null, 568083538, null, to_date('15-04-2017', 'dd-mm-yyyy'), 'Diego', 'Heather', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1960, 'Isaiah', 'Allen', null, 530861548, null, to_date('02-12-2016', 'dd-mm-yyyy'), 'Julian', 'Maria', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1961, 'Laura', 'Lewis', null, 557403039, null, to_date('06-10-2013', 'dd-mm-yyyy'), 'Ezekiel', 'Tiffany', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1962, 'Rose', 'Walker', null, 514208009, null, to_date('10-09-2017', 'dd-mm-yyyy'), 'Edward', 'Phoebe', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1963, 'George', 'Scott', null, 530547561, null, to_date('08-05-2018', 'dd-mm-yyyy'), 'Javier', 'Cheryl', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1964, 'Sheila', 'Nguyen', null, 585737384, null, to_date('06-10-2008', 'dd-mm-yyyy'), 'Austin', 'Isabella', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1967, 'Roy', 'Wright', null, 593350352, null, to_date('26-09-2015', 'dd-mm-yyyy'), 'Luke', 'Dorothy', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1971, 'Adam', 'Thomas', null, 520558017, null, to_date('07-06-2014', 'dd-mm-yyyy'), 'Leonardo', 'Kimberly', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1974, 'Luke', 'Adams', null, 543996830, null, to_date('16-01-2007', 'dd-mm-yyyy'), 'Isaiah', 'Joan', 17);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1976, 'Lydia', 'Miller', null, 558178262, null, to_date('07-10-2007', 'dd-mm-yyyy'), 'Tyler', 'Abigail', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1980, 'Joshua', 'Hall', null, 591762226, null, to_date('29-10-2014', 'dd-mm-yyyy'), 'Travis', 'Amelia', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1981, 'Kristen', 'Hernandez', null, 528972190, null, to_date('14-05-2011', 'dd-mm-yyyy'), 'Harold', 'Rachel', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1982, 'Sophia', 'Rodriguez', null, 565043692, null, to_date('23-04-2018', 'dd-mm-yyyy'), 'Derek', 'Jade', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1985, 'Andrew', 'Allen', null, 540145845, null, to_date('12-07-2017', 'dd-mm-yyyy'), 'Albert', 'Diana', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1987, 'Isaiah', 'Taylor', null, 572458986, null, to_date('20-06-2017', 'dd-mm-yyyy'), 'Owen', 'Lucy', 33);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1988, 'Hannah', 'Rodriguez', null, 596509605, null, to_date('14-06-2012', 'dd-mm-yyyy'), 'Tyler', 'Mia', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1989, 'Peyton', 'Johnson', null, 526419787, null, to_date('02-12-2010', 'dd-mm-yyyy'), 'Dennis', 'Hannah', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1990, 'Cody', 'Allen', null, 536372889, null, to_date('23-06-2009', 'dd-mm-yyyy'), 'Isaac', 'Kelly', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1991, 'Jayden', 'Lee', null, 559026080, null, to_date('28-01-2014', 'dd-mm-yyyy'), 'Abraham', 'Isabella', 22);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1992, 'Tiffany', 'Mitchell', null, 526229425, null, to_date('28-09-2010', 'dd-mm-yyyy'), 'Sebastian', 'Jane', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1996, 'Alan', 'Wilson', null, 511360739, null, to_date('30-06-2013', 'dd-mm-yyyy'), 'Dustin', 'Maya', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1997, 'Bethany', 'Allen', null, 594947206, null, to_date('25-11-2010', 'dd-mm-yyyy'), 'Travis', 'Louise', 13);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1998, 'Trevor', 'Walker', null, 566911947, null, to_date('13-10-2011', 'dd-mm-yyyy'), 'Douglas', 'Jasmine', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (1999, 'Mia', 'Carter', null, 585834404, null, to_date('12-02-2015', 'dd-mm-yyyy'), 'Nathan', 'Fiona', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2000, 'Alana', 'Jones', null, 589091978, null, to_date('22-08-2008', 'dd-mm-yyyy'), 'Joseph', 'Ashley', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2001, 'Joshua', 'Allen', null, 554905373, null, to_date('08-03-2016', 'dd-mm-yyyy'), 'Lawrence', 'Lauren', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2003, 'Rebecca', 'Campbell', null, 555012231, null, to_date('08-02-2011', 'dd-mm-yyyy'), 'Jesse', 'Mia', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2004, 'Charlotte', 'Clark', null, 587125922, null, to_date('10-06-2018', 'dd-mm-yyyy'), 'Stephen', 'Angela', 6);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2005, 'Jesse', 'Adams', null, 584779557, null, to_date('16-08-2014', 'dd-mm-yyyy'), 'Roy', 'Diana', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2007, 'Stephanie', 'Jones', null, 584390599, null, to_date('08-09-2012', 'dd-mm-yyyy'), 'Eric', 'Peyton', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2011, 'Dorothy', 'Davis', null, 575881323, null, to_date('03-08-2010', 'dd-mm-yyyy'), 'John', 'Agnes', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2013, 'Joan', 'Garcia', null, 543387263, null, to_date('16-09-2008', 'dd-mm-yyyy'), 'Daniel', 'Rebecca', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2014, 'Dorothy', 'Lopez', null, 594713819, null, to_date('10-08-2006', 'dd-mm-yyyy'), 'Chad', 'Alexis', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2020, 'Philip', 'Clark', null, 579514546, null, to_date('06-09-2011', 'dd-mm-yyyy'), 'Lawrence', 'Hannah', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2021, 'Douglas', 'Moore', null, 578874412, null, to_date('24-03-2010', 'dd-mm-yyyy'), 'Zachary', 'Leah', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2025, 'Agnes', 'Jones', null, 589199013, null, to_date('11-12-2013', 'dd-mm-yyyy'), 'Austin', 'Danielle', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2027, 'David', 'Lee', null, 599610357, null, to_date('28-07-2015', 'dd-mm-yyyy'), 'Nicholas', 'Taylor', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2028, 'Lori', 'Watson', null, 580786248, null, to_date('26-11-2011', 'dd-mm-yyyy'), 'Jesse', 'Ruby', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2029, 'Brandon', 'Lee', null, 584748173, null, to_date('17-11-2012', 'dd-mm-yyyy'), 'Jonathan', 'Ruby', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2030, 'Katherine', 'Lewis', null, 562234140, null, to_date('24-06-2010', 'dd-mm-yyyy'), 'Brandon', 'Jessica', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2031, 'Michelle', 'Davis', null, 596374729, null, to_date('31-10-2007', 'dd-mm-yyyy'), 'Felipe', 'Lisa', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2032, 'Brenda', 'Garcia', null, 567454118, null, to_date('19-08-2008', 'dd-mm-yyyy'), 'Douglas', 'Sandra', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2034, 'Jordan', 'Wilson', null, 552776686, null, to_date('11-11-2011', 'dd-mm-yyyy'), 'Abraham', 'Samantha', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2036, 'Mia', 'Allen', null, 528295129, null, to_date('28-06-2014', 'dd-mm-yyyy'), 'Antonio', 'Isabella', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2037, 'Aaron', 'Lopez', null, 558730194, null, to_date('17-12-2008', 'dd-mm-yyyy'), 'Cameron', 'Kelly', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2041, 'Alice', 'Clark', null, 599275027, null, to_date('03-03-2007', 'dd-mm-yyyy'), 'Joshua', 'Sheila', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2042, 'Jonathan', 'Walker', null, 537922228, null, to_date('31-03-2011', 'dd-mm-yyyy'), 'Walter', 'Alice', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2043, 'Kayla', 'Hernandez', null, 552131356, null, to_date('31-03-2009', 'dd-mm-yyyy'), 'Nathaniel', 'Audrey', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2044, 'Lauren', 'Lopez', null, 594415213, null, to_date('10-08-2015', 'dd-mm-yyyy'), 'Joseph', 'Claire', 35);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2045, 'Molly', 'Rodriguez', null, 578629179, null, to_date('15-07-2012', 'dd-mm-yyyy'), 'Lawrence', 'Diana', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2046, 'Cody', 'Garcia', null, 585996919, null, to_date('19-03-2012', 'dd-mm-yyyy'), 'Benjamin', 'Danielle', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2047, 'Alexandra', 'Sanchez', null, 515850530, null, to_date('05-04-2012', 'dd-mm-yyyy'), 'Alan', 'Heather', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2049, 'Jack', 'Miller', null, 593473969, null, to_date('13-01-2016', 'dd-mm-yyyy'), 'Ezekiel', 'Ava', 28);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2050, 'Agnes', 'Lopez', null, 589763521, null, to_date('07-10-2011', 'dd-mm-yyyy'), 'Nathan', 'Shirley', 12);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2052, 'Juan', 'Robinson', null, 582050929, null, to_date('11-03-2017', 'dd-mm-yyyy'), 'Ezekiel', 'Lily', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2053, 'Bethany', 'Roy', null, 569316969, null, to_date('22-12-2013', 'dd-mm-yyyy'), 'Wyatt', 'Alexandra', 42);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2054, 'Diego', 'Hernandez', null, 526739358, null, to_date('16-10-2008', 'dd-mm-yyyy'), 'Jacob', 'Heather', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2055, 'Maria', 'Roberts', null, 588731670, null, to_date('18-09-2008', 'dd-mm-yyyy'), 'Derek', 'Lily', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2056, 'Julia', 'Rodriguez', null, 561606422, null, to_date('10-10-2008', 'dd-mm-yyyy'), 'Abraham', 'Rachel', 14);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2057, 'Alana', 'Rodriguez', null, 565545671, null, to_date('21-08-2016', 'dd-mm-yyyy'), 'Harold', 'Shirley', 45);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2060, 'Bethany', 'Scott', null, 599685652, null, to_date('15-11-2014', 'dd-mm-yyyy'), 'Nathan', 'Olivia', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2061, 'Danielle', 'Robinson', null, 539099365, null, to_date('13-06-2007', 'dd-mm-yyyy'), 'Henry', 'Nicole', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2065, 'Charles', 'Rodriguez', null, 595248105, null, to_date('11-12-2016', 'dd-mm-yyyy'), 'Nathaniel', 'Heather', 45);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2066, 'Stephen', 'Rogers', null, 560866111, null, to_date('31-08-2015', 'dd-mm-yyyy'), 'Christopher', 'Charlene', 30);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2067, 'Eric', 'Davis', null, 579896592, null, to_date('20-03-2013', 'dd-mm-yyyy'), 'Douglas', 'Lauren', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2069, 'Lawrence', 'Hernandez', null, 593918858, null, to_date('05-04-2017', 'dd-mm-yyyy'), 'William', 'Lisa', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2072, 'Julian', 'Garcia', null, 589857085, null, to_date('20-01-2012', 'dd-mm-yyyy'), 'Christopher', 'Ruby', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2075, 'Diana', 'Adams', null, 593531629, null, to_date('16-05-2012', 'dd-mm-yyyy'), 'Shannon', 'Alexandra', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2076, 'Peyton', 'Lewis', null, 571532098, null, to_date('05-04-2012', 'dd-mm-yyyy'), 'Scott', 'Bridget', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2077, 'Luke', 'Mitchell', null, 510706307, null, to_date('22-07-2008', 'dd-mm-yyyy'), 'Travis', 'Diana', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2078, 'Miguel', 'Hall', null, 589840333, null, to_date('24-01-2016', 'dd-mm-yyyy'), 'Douglas', 'Olivia', 45);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2079, 'Gregory', 'Lewis', null, 543090541, null, to_date('06-11-2008', 'dd-mm-yyyy'), 'Joseph', 'Danielle', 16);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2080, 'Wesley', 'Williams', null, 513708560, null, to_date('10-06-2012', 'dd-mm-yyyy'), 'George', 'Sandra', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2082, 'Richard', 'Young', null, 562951274, null, to_date('20-03-2011', 'dd-mm-yyyy'), 'Cameron', 'Lucy', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2087, 'Dennis', 'Scott', null, 591061170, null, to_date('19-04-2009', 'dd-mm-yyyy'), 'Keith', 'Kristen', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2088, 'Kelly', 'Rogers', null, 596571631, null, to_date('29-08-2014', 'dd-mm-yyyy'), 'Sean', 'Alexis', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2090, 'Jayden', 'Miller', null, 592794306, null, to_date('18-05-2016', 'dd-mm-yyyy'), 'Scott', 'Bethany', 45);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2091, 'Margaret', 'Lee', null, 535593860, null, to_date('22-04-2012', 'dd-mm-yyyy'), 'Nathaniel', 'Angela', 43);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2093, 'Shannon', 'Johnson', null, 572320344, null, to_date('26-01-2014', 'dd-mm-yyyy'), 'George', 'Lydia', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2094, 'Susan', 'Hernandez', null, 567304037, null, to_date('28-09-2014', 'dd-mm-yyyy'), 'Brian', 'Linda', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2096, 'Sebastian', 'King', null, 534231552, null, to_date('16-10-2011', 'dd-mm-yyyy'), 'John', 'Cecilia', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2099, 'Albert', 'Lopez', null, 595256806, null, to_date('16-04-2013', 'dd-mm-yyyy'), 'Samuel', 'Leslie', 32);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2100, 'Courtney', 'Campbell', null, 534747728, null, to_date('10-05-2009', 'dd-mm-yyyy'), 'Tyler', 'Carla', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2102, 'Laura', 'Rogers', null, 597590684, null, to_date('21-11-2013', 'dd-mm-yyyy'), 'Jacob', 'Maria', 46);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2103, 'Paul', 'Garcia', null, 544134930, null, to_date('06-07-2007', 'dd-mm-yyyy'), 'Carlos', 'Charlene', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2105, 'Isaac', 'Anderson', null, 516079904, null, to_date('15-08-2011', 'dd-mm-yyyy'), 'Ryan', 'Shirley', 20);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2107, 'Christopher', 'Allen', null, 579253766, null, to_date('08-07-2014', 'dd-mm-yyyy'), 'Henry', 'Leah', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2108, 'Alicia', 'Williams', null, 528837993, null, to_date('02-08-2006', 'dd-mm-yyyy'), 'Samuel', 'Caroline', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2109, 'Penelope', 'Campbell', null, 551120257, null, to_date('17-06-2014', 'dd-mm-yyyy'), 'Dennis', 'Diana', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2110, 'Philip', 'Rodriguez', null, 548625592, null, to_date('28-02-2007', 'dd-mm-yyyy'), 'Henry', 'Jennifer', 7);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2111, 'Madison', 'Scott', null, 548413117, null, to_date('11-10-2014', 'dd-mm-yyyy'), 'Jacob', 'Alexis', 37);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2112, 'Samantha', 'Lee', null, 533722821, null, to_date('05-02-2009', 'dd-mm-yyyy'), 'Philip', 'Jennifer', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2113, 'Sophia', 'Miller', null, 590291749, null, to_date('25-01-2009', 'dd-mm-yyyy'), 'Carlos', 'Linda', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2117, 'Sarah', 'Williams', null, 563159031, null, to_date('28-01-2008', 'dd-mm-yyyy'), 'Joan', 'Alexis', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2118, 'Michelle', 'Nguyen', null, 578867512, null, to_date('05-08-2017', 'dd-mm-yyyy'), 'Joshua', 'Allison', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2119, 'Allison', 'Hernandez', null, 598089613, null, to_date('30-06-2016', 'dd-mm-yyyy'), 'Luke', 'Claire', 45);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2120, 'Laura', 'Robinson', null, 525105403, null, to_date('16-06-2010', 'dd-mm-yyyy'), 'Joseph', 'Joan', 44);
commit;
prompt 1200 records committed...
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2121, 'Ronald', 'Lopez', null, 548349087, null, to_date('27-09-2017', 'dd-mm-yyyy'), 'Ethan', 'Bethany', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2122, 'Jillian', 'Wilson', null, 573589835, null, to_date('25-02-2018', 'dd-mm-yyyy'), 'Robert', 'Molly', 21);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2123, 'Caleb', 'Rodriguez', null, 549622450, null, to_date('24-12-2006', 'dd-mm-yyyy'), 'Daniel', 'Stephanie', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2124, 'Samuel', 'Lee', null, 523927646, null, to_date('01-06-2017', 'dd-mm-yyyy'), 'Chad', 'Maria', 36);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2125, 'Antonio', 'Robinson', null, 591888620, null, to_date('17-03-2016', 'dd-mm-yyyy'), 'Sebastian', 'Lucia', 45);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2127, 'Isaac', 'Moore', null, 534351674, null, to_date('28-08-2015', 'dd-mm-yyyy'), 'Gabriel', 'Danielle', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2128, 'Charlene', 'Johnson', null, 588247679, null, to_date('12-06-2018', 'dd-mm-yyyy'), 'Adrian', 'Charlene', 26);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2129, 'Alan', 'Anderson', null, 586482014, null, to_date('22-02-2010', 'dd-mm-yyyy'), 'Antonio', 'Deborah', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2131, 'Catherine', 'Nguyen', null, 548889300, null, to_date('15-10-2017', 'dd-mm-yyyy'), 'Daniel', 'Madison', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2132, 'Harold', 'Jones', null, 518328382, null, to_date('21-05-2010', 'dd-mm-yyyy'), 'Chad', 'Sophia', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2137, 'Lawrence', 'Roberts', null, 598642402, null, to_date('31-05-2018', 'dd-mm-yyyy'), 'Paul', 'Diana', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2139, 'Lillian', 'Harris', null, 563103381, null, to_date('23-08-2006', 'dd-mm-yyyy'), 'Felipe', 'Lisa', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2140, 'Rebecca', 'Mitchell', null, 527727499, null, to_date('08-08-2014', 'dd-mm-yyyy'), 'Chad', 'Jennifer', 23);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2141, 'Adam', 'Allen', null, 510516990, null, to_date('12-09-2012', 'dd-mm-yyyy'), 'Timothy', 'Rebecca', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2142, 'Alicia', 'Wright', null, 586953159, null, to_date('19-09-2017', 'dd-mm-yyyy'), 'Stephen', 'Samantha', 2);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2143, 'David', 'Moore', null, 592883965, null, to_date('06-01-2009', 'dd-mm-yyyy'), 'Cameron', 'Kristen', 31);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2144, 'John', 'Johnson', null, 599406644, null, to_date('16-06-2008', 'dd-mm-yyyy'), 'Xavier', 'Teresa', 38);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2145, 'Kimberly', 'Johnson', null, 579087866, null, to_date('04-03-2015', 'dd-mm-yyyy'), 'Juan', 'Monica', 40);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2146, 'Travis', 'Johnson', null, 597185745, null, to_date('23-01-2009', 'dd-mm-yyyy'), 'Harold', 'Jillian', 10);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2148, 'Monica', 'Lopez', null, 586441380, null, to_date('05-11-2010', 'dd-mm-yyyy'), 'Isaac', 'Alexis', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2152, 'Brittany', 'Mitchell', null, 583193338, null, to_date('24-12-2010', 'dd-mm-yyyy'), 'Luke', 'Cecilia', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2154, 'Amelia', 'Walker', null, 530183231, null, to_date('12-03-2010', 'dd-mm-yyyy'), 'Austin', 'Kimberly', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2155, 'Danielle', 'Clark', null, 539683208, null, to_date('24-01-2010', 'dd-mm-yyyy'), 'Dustin', 'Claire', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2156, 'Alexandra', 'Garcia', null, 588721025, null, to_date('31-12-2012', 'dd-mm-yyyy'), 'Noah', 'Hannah', 27);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2158, 'Jade', 'Young', null, 580462552, null, to_date('09-09-2007', 'dd-mm-yyyy'), 'Cody', 'Penelope', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2160, 'Adam', 'Scott', null, 516905686, null, to_date('11-08-2017', 'dd-mm-yyyy'), 'Alan', 'Jacqueline', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2164, 'Lucas', 'Clark', null, 540550571, null, to_date('20-09-2016', 'dd-mm-yyyy'), 'Tyler', 'Fiona', 45);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2165, 'Brittany', 'Lee', null, 534565097, null, to_date('13-07-2008', 'dd-mm-yyyy'), 'Travis', 'Cecilia', 4);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2167, 'Ava', 'Hernandez', null, 594402160, null, to_date('14-08-2017', 'dd-mm-yyyy'), 'Theodore', 'Rachel', 1);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2168, 'Stephanie', 'Rodriguez', null, 591340477, null, to_date('15-06-2011', 'dd-mm-yyyy'), 'Joshua', 'Jade', 19);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2170, 'Sean', 'Robinson', null, 517431477, null, to_date('15-01-2009', 'dd-mm-yyyy'), 'Eric', 'Alice', 24);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2171, 'Bethany', 'Thompson', null, 523470854, null, to_date('23-04-2008', 'dd-mm-yyyy'), 'Joseph', 'Lillian', 5);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2172, 'Pamela', 'Williams', null, 523531974, null, to_date('21-03-2018', 'dd-mm-yyyy'), 'Oliver', 'Leah', 3);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2176, 'Andrew', 'Rodriguez', null, 578362269, null, to_date('20-12-2010', 'dd-mm-yyyy'), 'Jordan', 'Claire', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2179, 'Hannah', 'Rogers', null, 568268137, null, to_date('09-01-2014', 'dd-mm-yyyy'), 'Cody', 'Sheila', 25);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2181, 'Xavier', 'Hernandez', null, 563721749, null, to_date('02-11-2006', 'dd-mm-yyyy'), 'Edward', 'Jessica', 29);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2184, 'Bridget', 'Robinson', null, 559801222, null, to_date('26-06-2010', 'dd-mm-yyyy'), 'Sebastian', 'Madison', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2186, 'Lawrence', 'Garcia', null, 521575431, null, to_date('08-01-2010', 'dd-mm-yyyy'), 'Zachary', 'Ashley', 44);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2194, 'Luke', 'Allen', null, 533313858, null, to_date('19-07-2007', 'dd-mm-yyyy'), 'Sebastian', 'Samantha', 11);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2195, 'Luna', 'Walker', null, 577689639, null, to_date('11-05-2017', 'dd-mm-yyyy'), 'Paul', 'Olivia', 18);
insert into CLIENTS (client_id, client_fname, client_lname, client_addr, client_tel, client_payment, birthday, father_name, mother_name, class_id)
values (2198, 'Alexis', 'Hall', null, 541105192, null, to_date('27-06-2010', 'dd-mm-yyyy'), 'Javier', 'Abigail', 44);
commit;
prompt 1241 records loaded
prompt Loading GROUPS_...
insert into GROUPS_ (group_id, amount, age_id)
values (1, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (2, 34, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (3, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (4, 7, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (5, 1, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (6, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (7, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (8, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (9, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (10, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (11, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (12, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (13, 20, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (14, 12, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (15, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (16, 39, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (17, 36, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (18, 26, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (19, 25, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (20, 26, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (21, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (22, 20, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (23, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (24, 14, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (25, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (26, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (27, 21, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (28, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (29, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (30, 24, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (31, 3, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (32, 25, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (33, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (34, 26, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (35, 35, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (36, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (37, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (38, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (39, 27, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (40, 23, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (41, 33, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (42, 17, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (43, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (44, 39, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (45, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (46, 14, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (47, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (48, 12, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (49, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (50, 3, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (51, 34, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (52, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (53, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (54, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (55, 30, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (56, 16, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (57, 22, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (58, 9, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (59, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (60, 29, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (61, 2, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (62, 29, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (63, 12, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (64, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (65, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (66, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (67, 3, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (68, 14, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (69, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (70, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (71, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (72, 23, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (73, 11, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (74, 3, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (75, 13, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (76, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (77, 40, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (78, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (79, 15, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (80, 37, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (81, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (82, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (83, 20, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (84, 37, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (85, 6, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (86, 29, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (87, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (88, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (89, 18, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (90, 2, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (91, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (92, 38, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (93, 20, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (94, 38, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (95, 11, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (96, 10, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (97, 5, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (98, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (99, 15, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (100, 23, 5);
commit;
prompt 100 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (101, 30, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (102, 2, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (103, 11, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (104, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (105, 4, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (106, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (107, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (108, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (109, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (110, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (111, 17, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (112, 11, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (113, 18, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (114, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (115, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (116, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (117, 39, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (118, 29, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (119, 28, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (120, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (121, 33, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (122, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (123, 15, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (124, 31, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (125, 24, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (126, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (127, 2, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (128, 40, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (129, 1, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (130, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (131, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (132, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (133, 32, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (134, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (135, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (136, 37, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (137, 33, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (138, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (139, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (140, 1, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (141, 27, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (142, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (143, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (144, 1, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (145, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (146, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (147, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (148, 19, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (149, 11, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (150, 5, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (151, 29, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (152, 13, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (153, 34, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (154, 9, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (155, 33, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (156, 24, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (157, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (158, 38, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (159, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (160, 29, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (161, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (162, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (163, 11, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (164, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (165, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (166, 8, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (167, 24, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (168, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (169, 10, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (170, 23, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (171, 4, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (172, 10, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (173, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (174, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (175, 31, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (176, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (177, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (178, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (179, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (180, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (181, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (182, 13, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (183, 40, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (184, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (185, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (186, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (187, 13, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (188, 2, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (189, 18, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (190, 36, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (191, 15, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (192, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (193, 31, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (194, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (195, 1, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (196, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (197, 12, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (198, 24, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (199, 4, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (200, 26, 2);
commit;
prompt 200 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (201, 18, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (202, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (203, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (204, 6, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (205, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (206, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (207, 6, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (208, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (209, 37, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (210, 31, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (211, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (212, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (213, 20, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (214, 40, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (215, 40, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (216, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (217, 33, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (218, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (219, 19, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (220, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (221, 24, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (222, 14, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (223, 11, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (224, 19, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (225, 14, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (226, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (227, 7, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (228, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (229, 32, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (230, 20, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (231, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (232, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (233, 30, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (234, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (235, 24, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (236, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (237, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (238, 39, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (239, 33, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (240, 8, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (241, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (242, 3, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (243, 25, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (244, 21, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (245, 30, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (246, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (247, 18, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (248, 34, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (249, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (250, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (251, 6, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (252, 26, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (253, 12, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (254, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (255, 26, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (256, 15, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (257, 12, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (258, 28, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (259, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (260, 39, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (261, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (262, 19, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (263, 11, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (264, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (265, 27, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (266, 1, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (267, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (268, 12, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (269, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (270, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (271, 18, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (272, 12, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (273, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (274, 34, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (275, 35, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (276, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (277, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (278, 25, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (279, 14, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (280, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (281, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (282, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (283, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (284, 15, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (285, 15, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (286, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (287, 31, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (288, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (289, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (290, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (291, 27, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (292, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (293, 34, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (294, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (295, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (296, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (297, 1, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (298, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (299, 7, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (300, 13, 4);
commit;
prompt 300 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (301, 1, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (302, 32, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (303, 38, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (304, 36, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (305, 12, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (306, 5, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (307, 33, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (308, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (309, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (310, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (311, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (312, 33, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (313, 27, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (314, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (315, 38, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (316, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (317, 36, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (318, 10, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (319, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (320, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (321, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (322, 23, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (323, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (324, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (325, 37, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (326, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (327, 10, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (328, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (329, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (330, 39, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (331, 3, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (332, 24, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (333, 28, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (334, 28, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (335, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (336, 9, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (337, 24, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (338, 6, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (339, 34, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (340, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (341, 5, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (342, 10, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (343, 25, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (344, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (345, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (346, 5, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (347, 4, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (348, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (349, 9, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (350, 19, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (351, 27, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (352, 16, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (353, 26, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (354, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (355, 14, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (356, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (357, 34, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (358, 29, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (359, 19, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (360, 13, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (361, 23, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (362, 31, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (363, 37, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (364, 26, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (365, 13, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (366, 37, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (367, 18, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (368, 27, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (369, 20, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (370, 17, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (371, 20, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (372, 19, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (373, 9, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (374, 35, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (375, 8, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (376, 2, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (377, 7, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (378, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (379, 32, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (380, 23, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (381, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (382, 13, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (383, 12, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (384, 9, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (385, 23, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (386, 2, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (387, 16, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (388, 40, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (389, 19, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (390, 8, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (391, 37, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (392, 11, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (393, 25, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (394, 38, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (395, 12, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (396, 9, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (397, 4, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (398, 35, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (399, 22, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (400, 37, 3);
commit;
prompt 400 records committed...
insert into GROUPS_ (group_id, amount, age_id)
values (401, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (402, 28, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (403, 23, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (404, 16, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (405, 38, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (406, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (407, 26, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (408, 20, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (409, 40, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (410, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (411, 10, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (412, 19, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (413, 35, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (414, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (415, 14, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (416, 15, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (417, 34, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (418, 40, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (419, 32, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (420, 16, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (421, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (422, 6, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (423, 7, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (424, 37, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (425, 34, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (426, 29, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (427, 36, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (428, 14, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (429, 19, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (430, 4, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (431, 27, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (432, 35, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (433, 30, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (434, 40, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (435, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (436, 36, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (437, 4, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (438, 22, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (439, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (440, 17, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (441, 15, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (442, 12, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (443, 32, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (444, 6, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (445, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (446, 40, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (447, 15, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (448, 17, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (449, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (450, 7, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (451, 8, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (452, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (453, 32, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (454, 25, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (455, 4, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (456, 25, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (457, 13, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (458, 20, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (459, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (460, 13, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (461, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (462, 19, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (463, 1, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (464, 30, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (465, 25, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (466, 21, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (467, 26, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (468, 2, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (469, 29, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (470, 26, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (471, 11, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (472, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (473, 40, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (474, 10, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (475, 4, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (476, 21, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (477, 2, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (478, 21, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (479, 5, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (480, 8, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (481, 29, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (482, 18, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (483, 24, 4);
insert into GROUPS_ (group_id, amount, age_id)
values (484, 21, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (485, 22, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (486, 34, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (487, 32, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (488, 39, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (489, 12, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (490, 39, 1);
insert into GROUPS_ (group_id, amount, age_id)
values (491, 9, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (492, 25, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (493, 7, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (494, 3, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (495, 39, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (496, 37, 2);
insert into GROUPS_ (group_id, amount, age_id)
values (497, 1, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (498, 33, 5);
insert into GROUPS_ (group_id, amount, age_id)
values (499, 20, 3);
insert into GROUPS_ (group_id, amount, age_id)
values (500, 7, 3);
commit;
prompt 500 records loaded
prompt Loading PARTICIPATE...
insert into PARTICIPATE (group_id, client_id)
values (5, 10);
insert into PARTICIPATE (group_id, client_id)
values (9, 9);
insert into PARTICIPATE (group_id, client_id)
values (9, 10);
insert into PARTICIPATE (group_id, client_id)
values (23, 372);
insert into PARTICIPATE (group_id, client_id)
values (28, 238);
insert into PARTICIPATE (group_id, client_id)
values (29, 262);
insert into PARTICIPATE (group_id, client_id)
values (36, 1337);
insert into PARTICIPATE (group_id, client_id)
values (36, 1405);
insert into PARTICIPATE (group_id, client_id)
values (42, 1497);
insert into PARTICIPATE (group_id, client_id)
values (73, 265);
insert into PARTICIPATE (group_id, client_id)
values (74, 407);
insert into PARTICIPATE (group_id, client_id)
values (75, 20);
insert into PARTICIPATE (group_id, client_id)
values (113, 1477);
insert into PARTICIPATE (group_id, client_id)
values (138, 79);
insert into PARTICIPATE (group_id, client_id)
values (181, 1448);
insert into PARTICIPATE (group_id, client_id)
values (184, 475);
insert into PARTICIPATE (group_id, client_id)
values (187, 1296);
insert into PARTICIPATE (group_id, client_id)
values (192, 317);
insert into PARTICIPATE (group_id, client_id)
values (196, 160);
insert into PARTICIPATE (group_id, client_id)
values (213, 380);
insert into PARTICIPATE (group_id, client_id)
values (223, 133);
insert into PARTICIPATE (group_id, client_id)
values (230, 1388);
insert into PARTICIPATE (group_id, client_id)
values (233, 53);
insert into PARTICIPATE (group_id, client_id)
values (234, 1354);
insert into PARTICIPATE (group_id, client_id)
values (241, 374);
insert into PARTICIPATE (group_id, client_id)
values (260, 440);
insert into PARTICIPATE (group_id, client_id)
values (265, 182);
insert into PARTICIPATE (group_id, client_id)
values (288, 220);
insert into PARTICIPATE (group_id, client_id)
values (289, 1493);
insert into PARTICIPATE (group_id, client_id)
values (304, 1111);
insert into PARTICIPATE (group_id, client_id)
values (313, 66);
insert into PARTICIPATE (group_id, client_id)
values (313, 1492);
insert into PARTICIPATE (group_id, client_id)
values (326, 383);
insert into PARTICIPATE (group_id, client_id)
values (330, 1379);
insert into PARTICIPATE (group_id, client_id)
values (351, 1302);
insert into PARTICIPATE (group_id, client_id)
values (371, 447);
insert into PARTICIPATE (group_id, client_id)
values (376, 1214);
insert into PARTICIPATE (group_id, client_id)
values (386, 1107);
insert into PARTICIPATE (group_id, client_id)
values (386, 1384);
insert into PARTICIPATE (group_id, client_id)
values (387, 1383);
insert into PARTICIPATE (group_id, client_id)
values (399, 1280);
insert into PARTICIPATE (group_id, client_id)
values (417, 223);
insert into PARTICIPATE (group_id, client_id)
values (456, 54);
insert into PARTICIPATE (group_id, client_id)
values (463, 1339);
insert into PARTICIPATE (group_id, client_id)
values (475, 72);
insert into PARTICIPATE (group_id, client_id)
values (478, 1488);
commit;
prompt 46 records loaded
prompt Loading ROOMS...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (401, 4, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (402, 1, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (403, 1, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (404, 3, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (405, 1, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (406, 4, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (407, 3, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (408, 0, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (409, 0, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (410, 0, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (411, 3, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (412, 2, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (413, 3, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (414, 4, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (415, 2, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (416, 2, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (417, 1, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (418, 0, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (419, 4, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (420, 3, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (421, 0, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (422, 1, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (423, 4, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (424, 2, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (425, 3, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (426, 2, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (427, 1, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (428, 4, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (429, 4, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (430, 2, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (431, 4, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (432, 2, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (433, 3, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (434, 3, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (435, 1, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (436, 2, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (437, 4, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (438, 3, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (439, 0, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (440, 1, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (441, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (442, 0, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (443, 1, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (444, 3, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (445, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (446, 4, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (447, 0, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (448, 2, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (449, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (450, 3, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (451, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (452, 3, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (453, 4, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (454, 0, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (455, 2, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (456, 2, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (457, 0, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (458, 3, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (459, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (460, 4, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (461, 0, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (462, 2, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (463, 1, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (464, 3, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (465, 1, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (466, 4, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (467, 2, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (468, 3, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (469, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (470, 2, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (471, 1, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (472, 1, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (473, 1, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (474, 4, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (475, 1, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (476, 3, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (477, 1, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (478, 3, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (479, 0, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (480, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (481, 1, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (482, 0, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (483, 1, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (484, 0, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (485, 0, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (486, 0, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (487, 2, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (488, 2, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (489, 4, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (490, 4, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (491, 1, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (492, 4, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (493, 0, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (494, 2, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (495, 2, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (496, 3, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (497, 1, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (498, 0, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (499, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (500, 4, 'F', 21, null, null);
commit;
prompt 100 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (501, 1, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (502, 1, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (503, 4, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (504, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (505, 0, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (506, 3, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (507, 3, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (508, 2, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (509, 1, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (510, 0, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (511, 4, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (512, 2, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (513, 3, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (514, 4, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (515, 2, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (516, 1, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (517, 2, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (518, 1, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (519, 2, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (520, 3, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (521, 1, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (522, 3, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (523, 4, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (524, 0, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (525, 1, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (526, 1, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (527, 0, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (528, 4, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (529, 3, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (530, 1, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (531, 0, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (532, 3, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (533, 2, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (534, 0, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (535, 4, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (536, 1, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (537, 4, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (538, 2, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (539, 0, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (540, 4, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (541, 0, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (542, 3, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (543, 1, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (544, 2, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (545, 0, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (546, 4, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (547, 4, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (548, 4, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (549, 1, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (550, 2, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (551, 4, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (552, 4, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (553, 2, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (554, 3, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (555, 4, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (556, 1, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (557, 2, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (558, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (559, 4, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (560, 1, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (561, 1, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (562, 4, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (563, 2, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (564, 3, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (565, 1, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (566, 2, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (567, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (568, 1, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (569, 3, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (570, 1, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (571, 3, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (572, 3, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (573, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (574, 3, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (575, 4, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (576, 2, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (577, 1, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (578, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (579, 4, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (580, 2, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (581, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (582, 3, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (583, 0, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (584, 0, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (585, 3, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (586, 1, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (587, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (588, 0, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (589, 4, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (590, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (591, 4, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (592, 3, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (593, 3, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (594, 1, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (595, 3, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (596, 4, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (597, 3, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (598, 0, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (599, 0, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (600, 4, 'F', 5, null, null);
commit;
prompt 200 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (601, 0, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (602, 4, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (603, 3, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (604, 4, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (605, 2, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (606, 3, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (607, 1, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (608, 2, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (609, 0, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (610, 2, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (611, 4, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (612, 2, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (613, 0, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (614, 2, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (615, 4, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (616, 0, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (617, 1, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (618, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (619, 0, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (620, 0, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (621, 3, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (622, 4, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (623, 1, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (624, 1, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (625, 1, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (626, 3, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (627, 3, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (628, 2, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (629, 1, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (630, 3, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (631, 3, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (632, 0, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (633, 3, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (634, 0, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (635, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (636, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (637, 2, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (638, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (639, 2, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (640, 4, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (641, 4, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (642, 3, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (643, 3, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (644, 1, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (645, 4, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (646, 3, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (647, 1, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (648, 2, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (649, 1, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (650, 4, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (651, 3, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (652, 1, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (653, 1, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (654, 3, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (655, 4, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (656, 1, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (657, 0, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (658, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (659, 0, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (660, 0, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (661, 0, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (662, 2, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (663, 2, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (664, 1, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (665, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (666, 1, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (667, 2, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (668, 3, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (669, 2, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (670, 0, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (671, 2, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (672, 1, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (673, 4, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (674, 2, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (675, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (676, 0, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (677, 1, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (678, 4, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (679, 2, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (680, 4, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (681, 2, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (682, 1, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (683, 1, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (684, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (685, 2, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (686, 2, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (687, 0, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (688, 4, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (689, 3, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (690, 0, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (691, 4, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (692, 1, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (693, 4, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (694, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (695, 1, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (696, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (697, 3, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (698, 2, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (699, 1, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (700, 3, 'F', 22, null, null);
commit;
prompt 300 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (701, 1, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (702, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (703, 4, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (704, 2, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (705, 4, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (706, 3, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (707, 2, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (708, 0, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (709, 0, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (710, 1, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (711, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (712, 1, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (713, 1, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (714, 3, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (715, 1, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (716, 0, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (717, 2, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (718, 2, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (719, 1, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (720, 3, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (721, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (722, 0, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (723, 2, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (724, 0, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (725, 4, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (726, 1, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (727, 1, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (728, 4, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (729, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (730, 3, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (731, 1, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (732, 3, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (733, 0, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (734, 1, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (735, 0, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (736, 2, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (737, 3, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (738, 3, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (739, 0, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (740, 2, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (741, 3, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (742, 3, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (743, 1, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (744, 3, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (745, 4, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (746, 2, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (747, 0, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (748, 3, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (749, 1, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (750, 0, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (751, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (752, 4, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (753, 4, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (754, 0, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (755, 2, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (756, 4, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (757, 4, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (758, 4, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (759, 2, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (760, 1, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (761, 3, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (762, 2, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (763, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (764, 0, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (765, 2, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (766, 4, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (767, 1, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (768, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (769, 3, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (770, 3, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (771, 3, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (772, 1, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (773, 1, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (774, 1, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (775, 2, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (776, 2, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (777, 1, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (778, 4, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (779, 3, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (780, 3, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (781, 3, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (782, 4, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (783, 2, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (784, 0, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (785, 4, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (786, 2, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (787, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (788, 0, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (789, 0, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (790, 2, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (791, 0, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (792, 1, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (793, 3, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (794, 2, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (795, 2, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (796, 1, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (797, 4, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (798, 0, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (799, 2, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (800, 2, 'F', 38, null, null);
commit;
prompt 400 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (801, 0, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (802, 3, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (803, 0, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (804, 1, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (805, 4, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (806, 0, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (807, 0, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (808, 1, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (809, 2, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (810, 0, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (811, 3, 'F', 33, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (812, 1, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (813, 1, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (814, 1, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (815, 0, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (816, 0, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (817, 2, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (818, 1, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (819, 0, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (820, 1, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (821, 4, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (822, 3, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (823, 1, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (824, 4, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (825, 3, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (826, 2, 'F', 21, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (827, 2, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (828, 1, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (829, 0, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (830, 4, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (831, 1, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (832, 0, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (833, 3, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (834, 3, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (835, 4, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (836, 2, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (837, 4, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (838, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (839, 1, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (840, 0, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (841, 2, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (842, 4, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (843, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (844, 3, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (845, 1, 'F', 12, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (846, 4, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (847, 4, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (848, 2, 'F', 36, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (849, 2, 'F', 5, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (850, 2, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (851, 0, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (852, 2, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (853, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (854, 4, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (855, 3, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (856, 0, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (857, 1, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (858, 3, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (859, 4, 'F', 4, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (860, 0, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (861, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (862, 2, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (863, 4, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (864, 1, 'F', 9, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (865, 2, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (866, 2, 'F', 22, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (867, 0, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (868, 3, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (869, 2, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (870, 4, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (871, 4, 'F', 7, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (872, 0, 'F', 39, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (873, 0, 'F', 13, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (874, 2, 'F', 25, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (875, 0, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (876, 3, 'F', 8, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (877, 3, 'F', 40, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (878, 3, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (879, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (880, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (881, 3, 'F', 29, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (882, 2, 'F', 27, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (883, 1, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (884, 0, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (885, 3, 'F', 10, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (886, 1, 'F', 23, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (887, 0, 'F', 30, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (888, 4, 'F', 14, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (889, 3, 'F', 28, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (890, 3, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (891, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (892, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (893, 3, 'F', 17, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (894, 3, 'F', 6, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (895, 4, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (896, 2, 'F', 34, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (897, 2, 'F', 16, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (898, 4, 'F', 38, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (899, 2, 'F', 26, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (900, 2, 'F', 18, null, null);
commit;
prompt 500 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (901, 0, 'F', 32, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (902, 3, 'F', 24, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (903, 4, 'F', 19, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (904, 2, 'F', 37, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (905, 3, 'F', 15, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (906, 3, 'F', 35, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (907, 4, 'F', 20, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (908, 2, 'F', 18, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (909, 0, 'F', 11, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (910, 2, 'F', 31, null, null);
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (1, null, null, 62, 1, to_date('22-06-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (2, null, null, 21, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (3, null, null, 55, 0, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (4, null, null, 63, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (5, null, null, 63, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (6, null, null, 66, 1, to_date('20-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (7, null, null, 69, 1, to_date('03-06-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (8, null, null, 64, 1, to_date('08-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (9, null, null, 42, 1, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (10, null, null, 66, 0, to_date('30-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (11, null, null, 59, 1, to_date('07-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (12, null, null, 70, 1, to_date('13-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (13, null, null, 57, 1, to_date('04-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (14, null, null, 27, 1, to_date('10-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (15, null, null, 36, 0, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (16, null, null, 48, 1, to_date('14-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (17, null, null, 27, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (18, null, null, 22, 1, to_date('13-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (19, null, null, 54, 1, to_date('16-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (20, null, null, 68, 0, to_date('02-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (21, null, null, 62, 1, to_date('12-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (22, null, null, 34, 0, to_date('22-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (23, null, null, 67, 0, to_date('21-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (24, null, null, 57, 0, to_date('17-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (25, null, null, 26, 1, to_date('23-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (26, null, null, 29, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (27, null, null, 40, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (28, null, null, 29, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (29, null, null, 48, 1, to_date('05-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (30, null, null, 40, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (31, null, null, 68, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (32, null, null, 32, 1, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (33, null, null, 36, 1, to_date('23-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (34, null, null, 57, 0, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (35, null, null, 23, 1, to_date('12-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (36, null, null, 63, 0, to_date('08-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (37, null, null, 67, 1, to_date('17-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (38, null, null, 45, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (39, null, null, 23, 1, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (40, null, null, 28, 0, to_date('02-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (41, null, null, 23, 1, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (42, null, null, 24, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (43, null, null, 63, 1, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (44, null, null, 37, 0, to_date('18-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (45, null, null, 38, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (46, null, null, 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (47, null, null, 66, 0, to_date('10-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (48, null, null, 50, 0, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (49, null, null, 59, 1, to_date('20-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (50, null, null, 20, 0, to_date('17-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (51, null, null, 43, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (52, null, null, 68, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (53, null, null, 60, 1, to_date('20-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (54, null, null, 30, 0, to_date('14-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (55, null, null, 24, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (56, null, null, 61, 1, to_date('06-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (57, null, null, 54, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (58, null, null, 52, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (59, null, null, 28, 0, to_date('16-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (60, null, null, 23, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (61, null, null, 45, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (62, null, null, 44, 0, to_date('16-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (63, null, null, 62, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (64, null, null, 61, 0, to_date('17-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (65, null, null, 47, 0, to_date('18-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (66, null, null, 37, 0, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (67, null, null, 45, 1, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (68, null, null, 44, 0, to_date('27-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (69, null, null, 36, 1, to_date('14-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (70, null, null, 39, 1, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (71, null, null, 24, 1, to_date('11-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (72, null, null, 24, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (73, null, null, 49, 1, to_date('24-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (74, null, null, 43, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (75, null, null, 38, 0, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (76, null, null, 24, 0, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (77, null, null, 56, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (78, null, null, 37, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (79, null, null, 32, 1, to_date('25-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (80, null, null, 55, 0, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (81, null, null, 41, 1, to_date('10-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (82, null, null, 57, 1, to_date('01-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (83, null, null, 61, 0, to_date('23-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (84, null, null, 69, 0, to_date('04-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (85, null, null, 69, 0, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (86, null, null, 45, 1, to_date('26-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (87, null, null, 41, 0, to_date('11-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (88, null, null, 59, 1, to_date('05-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (89, null, null, 68, 1, to_date('11-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (90, null, null, 56, 0, to_date('15-09-2020', 'dd-mm-yyyy'));
commit;
prompt 600 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (91, null, null, 36, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (92, null, null, 55, 1, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (93, null, null, 44, 1, to_date('02-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (94, null, null, 23, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (95, null, null, 35, 0, to_date('18-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (96, null, null, 30, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (97, null, null, 43, 1, to_date('05-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (98, null, null, 61, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (99, null, null, 56, 1, to_date('30-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (100, null, null, 67, 1, to_date('21-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (101, null, null, 22, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (102, null, null, 50, 0, to_date('18-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (103, null, null, 47, 1, to_date('06-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (104, null, null, 53, 0, to_date('30-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (105, null, null, 56, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (106, null, null, 34, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (107, null, null, 47, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (108, null, null, 41, 1, to_date('02-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (109, null, null, 35, 0, to_date('21-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (110, null, null, 27, 1, to_date('08-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (111, null, null, 54, 0, to_date('19-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (112, null, null, 20, 0, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (113, null, null, 26, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (114, null, null, 67, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (115, null, null, 25, 1, to_date('03-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (116, null, null, 35, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (117, null, null, 23, 1, to_date('28-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (118, null, null, 30, 1, to_date('05-09-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (119, null, null, 57, 0, to_date('29-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (120, null, null, 68, 1, to_date('05-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (121, null, null, 69, 1, to_date('05-10-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (122, null, null, 56, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (123, null, null, 70, 0, to_date('29-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (124, null, null, 49, 0, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (125, null, null, 70, 1, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (126, null, null, 33, 1, to_date('08-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (127, null, null, 33, 1, to_date('19-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (128, null, null, 21, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (129, null, null, 55, 1, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (130, null, null, 27, 1, to_date('01-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (131, null, null, 31, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (132, null, null, 26, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (133, null, null, 20, 0, to_date('15-04-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (134, null, null, 48, 1, to_date('25-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (135, null, null, 20, 0, to_date('05-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (136, null, null, 67, 0, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (137, null, null, 33, 0, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (138, null, null, 39, 1, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (139, null, null, 65, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (140, null, null, 59, 0, to_date('18-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (141, null, null, 22, 1, to_date('20-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (142, null, null, 31, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (143, null, null, 24, 0, to_date('26-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (144, null, null, 23, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (145, null, null, 48, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (146, null, null, 38, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (147, null, null, 44, 1, to_date('16-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (148, null, null, 70, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (149, null, null, 54, 1, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (150, null, null, 49, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (151, null, null, 62, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (152, null, null, 47, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (153, null, null, 65, 0, to_date('17-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (154, null, null, 46, 0, to_date('16-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (155, null, null, 49, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (156, null, null, 46, 0, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (157, null, null, 66, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (158, null, null, 23, 1, to_date('25-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (159, null, null, 23, 0, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (160, null, null, 36, 0, to_date('20-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (161, null, null, 45, 1, to_date('19-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (162, null, null, 40, 0, to_date('16-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (163, null, null, 35, 0, to_date('01-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (164, null, null, 54, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (165, null, null, 69, 1, to_date('05-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (166, null, null, 70, 0, to_date('08-06-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (167, null, null, 22, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (168, null, null, 64, 1, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (169, null, null, 30, 0, to_date('16-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (170, null, null, 30, 1, to_date('04-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (171, null, null, 31, 0, to_date('24-05-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (172, null, null, 58, 1, to_date('28-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (173, null, null, 34, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (174, null, null, 28, 0, to_date('03-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (175, null, null, 64, 1, to_date('04-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (176, null, null, 67, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (177, null, null, 22, 1, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (178, null, null, 68, 0, to_date('03-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (179, null, null, 64, 1, to_date('26-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (180, null, null, 57, 0, to_date('31-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (181, null, null, 33, 1, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (182, null, null, 35, 0, to_date('07-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (183, null, null, 48, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (184, null, null, 58, 1, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (185, null, null, 70, 0, to_date('20-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (186, null, null, 48, 1, to_date('21-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (187, null, null, 58, 0, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (188, null, null, 42, 1, to_date('14-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (189, null, null, 44, 1, to_date('21-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (190, null, null, 32, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
commit;
prompt 700 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (191, null, null, 53, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (192, null, null, 49, 1, to_date('03-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (193, null, null, 58, 0, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (194, null, null, 57, 1, to_date('21-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (195, null, null, 20, 0, to_date('17-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (196, null, null, 67, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (197, null, null, 51, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (198, null, null, 68, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (199, null, null, 33, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (200, null, null, 39, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (201, null, null, 54, 0, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (202, null, null, 55, 1, to_date('05-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (203, null, null, 48, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (204, null, null, 27, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (205, null, null, 55, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (206, null, null, 42, 1, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (207, null, null, 67, 0, to_date('27-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (208, null, null, 22, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (209, null, null, 48, 0, to_date('09-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (210, null, null, 49, 0, to_date('25-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (211, null, null, 67, 1, to_date('26-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (212, null, null, 69, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (213, null, null, 30, 0, to_date('04-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (214, null, null, 37, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (215, null, null, 59, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (216, null, null, 59, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (217, null, null, 56, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (218, null, null, 64, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (219, null, null, 42, 1, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (220, null, null, 47, 0, to_date('25-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (221, null, null, 38, 0, to_date('03-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (222, null, null, 40, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (223, null, null, 40, 0, to_date('11-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (224, null, null, 59, 0, to_date('11-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (225, null, null, 20, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (226, null, null, 40, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (227, null, null, 26, 0, to_date('12-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (228, null, null, 66, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (229, null, null, 46, 1, to_date('13-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (230, null, null, 63, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (231, null, null, 34, 1, to_date('01-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (232, null, null, 39, 0, to_date('23-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (233, null, null, 66, 1, to_date('17-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (234, null, null, 42, 1, to_date('19-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (235, null, null, 32, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (236, null, null, 70, 0, to_date('04-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (237, null, null, 41, 0, to_date('26-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (238, null, null, 37, 0, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (239, null, null, 55, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (240, null, null, 39, 0, to_date('18-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (241, null, null, 55, 0, to_date('25-09-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (242, null, null, 36, 0, to_date('21-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (243, null, null, 25, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (244, null, null, 61, 1, to_date('01-10-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (245, null, null, 58, 1, to_date('24-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (246, null, null, 70, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (247, null, null, 36, 1, to_date('08-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (248, null, null, 54, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (249, null, null, 53, 1, to_date('28-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (250, null, null, 22, 0, to_date('23-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (251, null, null, 62, 1, to_date('01-08-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (252, null, null, 27, 1, to_date('22-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (253, null, null, 51, 1, to_date('22-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (254, null, null, 21, 0, to_date('03-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (255, null, null, 33, 1, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (256, null, null, 34, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (257, null, null, 41, 0, to_date('21-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (258, null, null, 56, 1, to_date('31-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (259, null, null, 33, 0, to_date('08-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (260, null, null, 36, 1, to_date('10-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (261, null, null, 25, 1, to_date('28-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (262, null, null, 38, 1, to_date('06-02-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (263, null, null, 55, 0, to_date('25-02-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (264, null, null, 54, 1, to_date('28-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (265, null, null, 35, 1, to_date('04-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (266, null, null, 50, 1, to_date('05-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (267, null, null, 61, 1, to_date('27-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (268, null, null, 44, 0, to_date('22-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (269, null, null, 66, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (270, null, null, 68, 0, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (271, null, null, 25, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (272, null, null, 34, 0, to_date('28-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (273, null, null, 54, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (274, null, null, 33, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (275, null, null, 52, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (276, null, null, 25, 0, to_date('04-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (277, null, null, 23, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (278, null, null, 64, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (279, null, null, 25, 0, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (280, null, null, 46, 0, to_date('02-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (281, null, null, 45, 1, to_date('01-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (282, null, null, 36, 1, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (283, null, null, 40, 0, to_date('04-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (284, null, null, 63, 1, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (285, null, null, 54, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (286, null, null, 37, 0, to_date('12-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (287, null, null, 54, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (288, null, null, 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (289, null, null, 61, 0, to_date('27-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (290, null, null, 22, 0, to_date('21-11-2023', 'dd-mm-yyyy'));
commit;
prompt 800 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (291, null, null, 57, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (292, null, null, 50, 0, to_date('10-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (293, null, null, 58, 0, to_date('13-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (294, null, null, 49, 1, to_date('16-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (295, null, null, 27, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (296, null, null, 22, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (297, null, null, 40, 1, to_date('22-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (298, null, null, 64, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (299, null, null, 27, 1, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (300, null, null, 22, 1, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (301, null, null, 23, 0, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (302, null, null, 31, 0, to_date('09-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (303, null, null, 51, 1, to_date('24-03-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (304, null, null, 50, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (305, null, null, 40, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (306, null, null, 49, 1, to_date('13-04-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (307, null, null, 42, 0, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (308, null, null, 40, 0, to_date('02-02-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (309, null, null, 29, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (310, null, null, 67, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (311, null, null, 20, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (312, null, null, 36, 0, to_date('16-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (313, null, null, 25, 0, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (314, null, null, 40, 1, to_date('12-12-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (315, null, null, 63, 1, to_date('22-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (316, null, null, 41, 0, to_date('13-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (317, null, null, 38, 0, to_date('04-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (318, null, null, 44, 0, to_date('21-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (319, null, null, 51, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (320, null, null, 30, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (321, null, null, 51, 1, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (322, null, null, 64, 0, to_date('22-11-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (323, null, null, 54, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (324, null, null, 65, 1, to_date('17-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (325, null, null, 54, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (326, null, null, 61, 1, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (327, null, null, 36, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (328, null, null, 32, 0, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (329, null, null, 63, 0, to_date('01-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (330, null, null, 49, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (331, null, null, 37, 0, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (332, null, null, 36, 0, to_date('04-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (333, null, null, 28, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (334, null, null, 67, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (335, null, null, 30, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (336, null, null, 51, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (337, null, null, 40, 1, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (338, null, null, 47, 1, to_date('16-06-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (339, null, null, 34, 1, to_date('15-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (340, null, null, 65, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (341, null, null, 22, 0, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (342, null, null, 45, 0, to_date('11-06-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (343, null, null, 68, 0, to_date('03-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (344, null, null, 23, 0, to_date('04-07-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (345, null, null, 43, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (346, null, null, 53, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (347, null, null, 31, 0, to_date('03-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (348, null, null, 61, 0, to_date('11-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (349, null, null, 64, 1, to_date('22-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (350, null, null, 38, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (351, null, null, 49, 1, to_date('17-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (352, null, null, 55, 1, to_date('19-03-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (353, null, null, 67, 0, to_date('12-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (354, null, null, 58, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (355, null, null, 66, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (356, null, null, 22, 1, to_date('23-03-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (357, null, null, 20, 1, to_date('09-09-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (358, null, null, 61, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (359, null, null, 63, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (360, null, null, 69, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (361, null, null, 46, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (362, null, null, 49, 1, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (363, null, null, 59, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (364, null, null, 26, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (365, null, null, 63, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (366, null, null, 52, 1, to_date('31-12-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (367, null, null, 38, 0, to_date('17-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (368, null, null, 24, 1, to_date('30-01-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (369, null, null, 62, 0, to_date('19-08-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (370, null, null, 43, 1, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (371, null, null, 55, 1, to_date('02-12-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (372, null, null, 47, 0, to_date('27-11-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (373, null, null, 42, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (374, null, null, 27, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (375, null, null, 63, 0, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (376, null, null, 53, 1, to_date('24-11-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (377, null, null, 57, 0, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (378, null, null, 70, 1, to_date('13-07-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (379, null, null, 56, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (380, null, null, 32, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (381, null, null, 62, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (382, null, null, 57, 0, to_date('05-04-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (383, null, null, 45, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (384, null, null, 54, 1, to_date('15-03-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (385, null, null, 46, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (386, null, null, 36, 1, to_date('07-10-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (387, null, null, 26, 1, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (388, null, null, 49, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (389, null, null, 58, 1, to_date('18-04-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (390, null, null, 48, 1, to_date('13-11-2020', 'dd-mm-yyyy'));
commit;
prompt 900 records committed...
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (391, null, null, 43, 0, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (392, null, null, 63, 0, to_date('25-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (393, null, null, 35, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (394, null, null, 37, 0, to_date('12-09-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (395, null, null, 23, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (396, null, null, 44, 1, to_date('24-10-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (397, null, null, 29, 0, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (398, null, null, 60, 1, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (399, null, null, 23, 0, to_date('20-05-2020', 'dd-mm-yyyy'));
insert into ROOMS (room_id, room_floor, isstudio, room_capacity, is_lab, last_maintenance_check)
values (400, null, null, 29, 1, to_date('04-03-2021', 'dd-mm-yyyy'));
commit;
prompt 910 records loaded
prompt Loading WORKSHOPS...
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (53, 'Zumba', 167, 2, 12, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (54, 'Cooking', 237, 1, 34, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (55, 'Drawing', 351, 1, 10, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (56, 'Baking', 369, 1, 29, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (57, 'Ballet', 370, 4, 27, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (58, 'Judo', 188, 2, 19, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (59, 'Photography', 280, 1, 20, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (60, 'Piano', 304, 3, 1, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (61, 'Violin', 151, 4, 1, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (62, 'Sewing', 377, 4, 22, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (63, 'Guitar', 200, 2, 3, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (64, 'Swimming', 100, 3, 15, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (65, 'Gardening', 250, 1, 10, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (66, 'Singing', 150, 5, 2, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (1, ' Anatomy', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (2, ' Astronomy', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (3, ' Algebra', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (4, ' Band/Orchestra', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (5, ' Ballet', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (6, ' Bible Studies', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (7, ' Biology', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (8, ' Business and Entrepreneurship', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (9, ' Calculus', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (10, ' Career Exploration', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (11, ' Chemistry', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (12, ' Chorus', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (13, ' Civics and Government', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (14, ' Computer Science', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (15, ' Creative Writing', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (16, ' Dance', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (17, ' Digital Literacy', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (18, ' Drama', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (19, ' Economics', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (20, ' Engineering Design', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (21, ' English Language Arts', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (22, ' Environmental Science', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (23, ' Film Studies', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (24, ' Foreign Language (French)', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (25, ' Foreign Language (German)', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (26, ' Foreign Language (Hebrew)', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (27, ' Foreign Language (Spanish)', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (28, ' Geography', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (29, ' Health', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (30, ' Jewish History', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (31, ' Jewish Philosophy', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (32, ' Latin', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (33, ' Literature', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (34, ' Mathematics', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (35, ' Media Literacy', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (36, ' Modern Art', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (37, ' Music', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (38, ' Mythology', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (39, ' Physical Education', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (40, ' Physics', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (41, ' Psychology', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (42, ' Robotics', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (43, ' Science (General)', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (44, ' Social Studies (General)', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (45, ' Sociology', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (46, ' Speech and Debate', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (47, ' Sports', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (48, ' Statistics', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (49, ' Talmud', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (50, ' United States History', null, null, null, 1);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (51, ' Visual Arts', null, null, null, 0);
insert into WORKSHOPS (workshop_id, workshop_name, workshop_price, workshop_hours, workshop_capacity, mandatory)
values (52, ' World History', null, null, null, 1);
commit;
prompt 66 records loaded
prompt Loading SCHEDULER...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 4, 455, 5, 57, 407, 407, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 640, 156, 57, 401, 710, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 719, 206, 54, 402, 831, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 771, 498, 54, 407, 672, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 2145, 284, 62, 872, 1009, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 2, 2147, 23, 55, 745, 619, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 6, 2148, 157, 57, 765, 883, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 4, 2151, 338, 58, 487, 764, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 2152, 494, 53, 668, 812, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 6, 2157, 144, 53, 878, 433, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2159, 416, 56, 405, 571, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 3, 2160, 341, 65, 457, 780, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 2161, 26, 65, 874, 487, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 1, 2164, 360, 57, 591, 430, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 6, 2165, 152, 58, 873, 584, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 2166, 63, 53, 863, 498, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 4, 1472, 150, 54, 784, 486, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 2167, 289, 64, 581, 896, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2168, 335, 58, 408, 648, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 1, 2170, 157, 58, 508, 772, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 5, 2171, 26, 54, 686, 871, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 2178, 450, 62, 847, 907, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 4, 2180, 163, 58, 558, 778, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 3, 2182, 45, 56, 781, 469, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2187, 169, 62, 403, 895, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 6, 2192, 301, 58, 769, 443, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2195, 48, 59, 406, 484, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1502, 169, 54, 410, 778, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 2196, 461, 55, 689, 800, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2198, 453, 54, 413, 524, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 2199, 66, 62, 550, 894, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 2200, 102, 56, 683, 670, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 2203, 305, 59, 554, 871, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 2205, 484, 62, 787, 681, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2208, 324, 62, 411, 471, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 1, 2211, 142, 53, 774, 734, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 1, 2212, 499, 62, 651, 698, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 2217, 327, 57, 628, 514, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 2219, 310, 53, 782, 773, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 6, 2220, 242, 59, 567, 618, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 6, 2223, 222, 59, 662, 574, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 2224, 203, 55, 522, 882, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2226, 160, 56, 414, 412, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2228, 336, 55, 412, 698, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 2231, 449, 65, 420, 737, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 2233, 64, 56, 421, 530, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 2235, 319, 56, 684, 807, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 2236, 221, 56, 621, 736, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 5, 2247, 188, 57, 626, 720, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2253, 70, 57, 415, 642, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2255, 431, 56, 417, 685, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 4, 2258, 67, 63, 706, 698, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 2260, 264, 56, 413, 595, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 2263, 277, 66, 658, 744, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2264, 359, 59, 420, 542, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2265, 7, 53, 421, 402, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 6, 2267, 173, 57, 669, 702, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 5, 2271, 500, 53, 620, 641, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 4, 2272, 169, 62, 540, 784, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 2280, 475, 58, 547, 523, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 6, 2286, 67, 54, 471, 671, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 5, 2287, 47, 56, 780, 667, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 2288, 15, 59, 430, 632, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2291, 426, 56, 423, 711, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 6, 2292, 149, 58, 667, 615, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 2294, 500, 64, 790, 807, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 6, 2295, 14, 59, 842, 828, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2297, 201, 59, 422, 529, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 2, 2299, 96, 54, 739, 659, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 2301, 346, 55, 840, 609, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 6, 2302, 268, 53, 484, 830, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 1, 2303, 457, 58, 906, 444, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 3, 2304, 340, 62, 895, 807, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 2309, 422, 65, 669, 444, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2316, 411, 55, 418, 1009, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 2320, 79, 59, 414, 648, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2322, 213, 62, 425, 463, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 2325, 201, 58, 598, 636, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 2327, 247, 57, 401, 524, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 2328, 341, 58, 874, 848, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 2329, 53, 62, 441, 501, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 2330, 59, 56, 411, 627, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2331, 442, 53, 427, 435, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2332, 460, 62, 428, 504, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 6, 2335, 452, 62, 627, 459, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 2337, 357, 54, 819, 849, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 2338, 169, 58, 693, 835, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 3, 2347, 387, 58, 678, 486, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 2356, 36, 57, 653, 495, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 2357, 111, 58, 874, 642, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 2358, 283, 56, 861, 715, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2362, 45, 55, 409, 880, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 3, 2364, 463, 66, 841, 619, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 6, 2366, 355, 56, 763, 767, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 2375, 154, 58, 808, 465, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 2376, 481, 56, 402, 402, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1900, 483, 56, 429, 724, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 1902, 292, 56, 491, 431, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 5, 1904, 263, 64, 477, 697, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 3, 1906, 375, 56, 794, 889, null);
commit;
prompt 100 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 2, 1910, 415, 57, 685, 518, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1913, 440, 54, 430, 815, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 1916, 321, 57, 442, 652, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 1917, 241, 62, 510, 665, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 1918, 451, 55, 569, 443, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 1922, 377, 54, 612, 768, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 2, 1925, 188, 54, 570, 898, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 5, 1926, 65, 65, 528, 776, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 1929, 378, 65, 788, 886, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 2, 1931, 203, 58, 407, 501, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 4, 1933, 475, 55, 710, 665, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1938, 85, 64, 424, 810, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1943, 20, 57, 432, 490, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 1944, 301, 59, 534, 788, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 1945, 85, 57, 647, 896, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 1948, 236, 56, 417, 462, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 1949, 466, 57, 773, 571, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 4, 1950, 491, 53, 448, 712, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 1, 1954, 103, 54, 605, 601, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1955, 46, 62, 434, 556, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 6, 1957, 199, 58, 705, 453, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1961, 393, 57, 438, 430, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 5, 1962, 489, 54, 451, 790, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 4, 1963, 179, 54, 663, 744, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 1965, 143, 53, 545, 460, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 6, 1969, 115, 53, 456, 636, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 1976, 321, 54, 862, 458, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 1978, 145, 62, 889, 797, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1979, 193, 54, 441, 696, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 1982, 218, 59, 673, 507, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 1983, 369, 62, 843, 496, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 2, 1991, 129, 53, 861, 631, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 6, 1995, 157, 58, 655, 883, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 1998, 126, 54, 893, 806, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 1999, 5, 60, 590, 749, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 2000, 289, 53, 420, 831, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 4, 2002, 377, 53, 442, 604, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2004, 107, 54, 439, 735, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 4, 2006, 251, 65, 567, 463, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 6, 2011, 249, 58, 548, 461, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 2013, 199, 53, 605, 801, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2014, 491, 65, 435, 612, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 2, 2015, 257, 62, 423, 402, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2018, 96, 57, 440, 701, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 2022, 250, 62, 603, 830, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 3, 2027, 31, 55, 717, 523, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 2029, 67, 63, 656, 779, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 2, 2032, 347, 64, 904, 528, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 2038, 157, 59, 675, 469, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 5, 2039, 176, 62, 894, 587, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 2041, 172, 65, 754, 895, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2042, 382, 59, 807, 583, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 2043, 445, 53, 873, 444, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 4, 2045, 384, 64, 603, 706, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 5, 2046, 292, 57, 542, 884, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 2049, 349, 54, 489, 612, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 2051, 149, 57, 704, 745, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 1, 2058, 254, 53, 436, 566, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 5, 2059, 319, 62, 799, 473, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 2065, 428, 59, 666, 574, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 2069, 416, 62, 797, 902, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 4, 2073, 36, 55, 563, 841, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2078, 230, 62, 442, 774, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 2086, 309, 56, 500, 895, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 2089, 95, 62, 734, 632, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 2, 2091, 163, 56, 471, 601, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 2093, 324, 55, 528, 791, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 1, 2094, 279, 58, 541, 463, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 1, 2095, 341, 65, 663, 429, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2096, 420, 56, 443, 675, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 4, 2097, 5, 61, 793, 826, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 2098, 163, 58, 638, 862, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2105, 356, 57, 444, 586, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 2109, 272, 54, 745, 502, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 2110, 37, 58, 768, 416, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 4, 2111, 1, 59, 562, 477, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 2, 2113, 61, 56, 417, 627, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 2115, 140, 53, 513, 518, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 1, 2117, 109, 62, 581, 747, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2120, 255, 56, 446, 720, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 2125, 127, 54, 413, 562, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 2127, 256, 58, 895, 867, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 6, 2128, 166, 56, 675, 527, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 2129, 96, 64, 629, 802, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2130, 38, 54, 464, 458, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 2135, 298, 57, 862, 823, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 1886, 367, 59, 705, 629, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1889, 336, 64, 436, 848, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 3, 1896, 375, 65, 447, 734, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 4, 1897, 195, 60, 637, 831, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 1898, 53, 53, 897, 908, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 1650, 474, 53, 623, 865, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 1653, 349, 64, 413, 572, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 1660, 180, 56, 402, 402, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 1661, 191, 58, 661, 841, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 3, 1662, 195, 56, 708, 890, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 1664, 134, 65, 688, 606, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 5, 1665, 349, 65, 682, 660, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 6, 1667, 53, 58, 907, 814, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 1668, 241, 53, 451, 524, null);
commit;
prompt 200 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 1670, 385, 56, 502, 529, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 2, 1672, 173, 62, 698, 883, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1674, 308, 62, 447, 1008, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 6, 1678, 126, 63, 499, 624, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 5, 1680, 266, 54, 567, 618, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1681, 367, 56, 448, 473, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 1687, 461, 64, 895, 618, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 4, 1688, 441, 54, 489, 595, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 2, 1691, 25, 55, 854, 750, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1692, 46, 54, 450, 603, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 6, 1693, 324, 58, 746, 607, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 1696, 174, 56, 904, 766, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 5, 1697, 142, 59, 804, 581, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 1698, 85, 54, 835, 567, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 4, 1703, 365, 58, 560, 896, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 4, 1706, 423, 64, 678, 764, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 6, 1708, 416, 64, 492, 613, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1712, 407, 57, 458, 669, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 1, 1718, 377, 62, 431, 612, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 1724, 67, 65, 660, 654, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 1728, 211, 59, 757, 1001, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1730, 416, 58, 451, 508, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 1735, 195, 64, 740, 791, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 6, 1738, 396, 55, 457, 776, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 2, 1739, 144, 55, 440, 784, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 4, 1741, 270, 55, 762, 497, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1743, 372, 56, 465, 813, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 2, 1744, 26, 63, 659, 410, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 1746, 1, 58, 467, 476, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 6, 1747, 90, 58, 419, 578, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 1748, 67, 63, 738, 686, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 6, 1755, 174, 57, 589, 890, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 5, 1756, 344, 59, 700, 553, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1763, 205, 64, 426, 408, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 1767, 423, 55, 403, 612, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 3, 1771, 358, 54, 603, 411, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 3, 1777, 331, 65, 854, 531, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 6, 1778, 314, 56, 560, 543, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 2, 1782, 331, 63, 459, 702, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 1784, 280, 58, 808, 1001, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 6, 1786, 26, 56, 907, 457, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 5, 1788, 102, 56, 851, 454, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1796, 231, 62, 467, 533, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 1799, 52, 58, 681, 675, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 3, 1802, 162, 58, 544, 792, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 1803, 341, 55, 670, 785, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 3, 1806, 299, 65, 454, 880, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1809, 86, 54, 471, 812, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 3, 1811, 58, 62, 816, 653, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 6, 1812, 96, 58, 728, 586, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 4, 1814, 105, 58, 510, 780, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 3, 1817, 267, 58, 887, 723, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 2, 1820, 191, 62, 860, 616, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 1821, 201, 54, 405, 774, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 1824, 340, 53, 486, 758, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 1825, 216, 56, 895, 430, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1826, 179, 59, 452, 591, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 4, 1828, 74, 56, 623, 805, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 1829, 195, 57, 578, 491, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 1832, 289, 53, 679, 444, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 3, 1833, 157, 56, 886, 528, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 1836, 73, 62, 719, 624, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 4, 1837, 463, 59, 416, 453, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 1838, 445, 53, 882, 478, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 3, 1843, 188, 59, 531, 794, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 2, 1848, 385, 54, 441, 453, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 1849, 229, 54, 851, 443, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 1, 1854, 129, 64, 654, 770, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 1855, 226, 56, 641, 693, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 1865, 271, 59, 407, 710, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 3, 1866, 342, 65, 579, 745, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1867, 313, 54, 468, 841, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 1, 1869, 411, 54, 540, 646, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 5, 1871, 263, 58, 810, 745, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 3, 1872, 211, 65, 468, 897, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 6, 1877, 241, 62, 567, 556, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 1878, 8, 56, 473, 799, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 1880, 105, 62, 884, 782, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 5, 2378, 451, 62, 709, 790, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2380, 58, 57, 453, 527, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 2383, 23, 54, 853, 427, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 2386, 242, 55, 561, 830, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 2390, 463, 53, 724, 626, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 1, 2391, 182, 62, 776, 626, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 3, 2392, 410, 64, 840, 449, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 2, 2394, 299, 56, 601, 618, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 2398, 309, 53, 642, 706, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2399, 161, 56, 456, 530, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 1, 2400, 142, 53, 520, 738, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 2401, 211, 64, 666, 766, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 4, 2406, 410, 58, 677, 803, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2409, 359, 58, 475, 454, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 2410, 335, 54, 486, 419, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2414, 265, 57, 478, 597, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2417, 282, 53, 454, 738, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 6, 2422, 177, 53, 520, 410, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 2425, 23, 57, 713, 738, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2426, 499, 56, 476, 677, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2427, 431, 56, 482, 600, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 2, 2432, 178, 55, 566, 693, null);
commit;
prompt 300 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 3, 2433, 224, 62, 837, 884, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2436, 395, 53, 457, 907, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2437, 216, 54, 484, 404, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 1, 2439, 308, 56, 854, 450, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 4, 2443, 494, 65, 516, 532, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 2445, 375, 53, 406, 600, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 2453, 390, 54, 486, 821, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 2455, 289, 54, 635, 409, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 5, 2457, 96, 58, 831, 440, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2460, 99, 59, 461, 821, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 5, 2463, 83, 57, 685, 480, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 5, 2464, 497, 61, 577, 710, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 2, 2465, 340, 53, 617, 702, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 3, 2466, 389, 62, 736, 548, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 5, 2467, 57, 57, 443, 415, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 2471, 471, 64, 641, 432, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 5, 2473, 14, 64, 784, 820, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 2474, 90, 63, 841, 433, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 2475, 474, 59, 650, 626, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 2477, 123, 59, 880, 798, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 2481, 406, 64, 898, 664, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 2, 2483, 479, 58, 701, 620, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 5, 2485, 143, 62, 551, 535, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 2488, 489, 53, 494, 779, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2489, 247, 57, 462, 816, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 2490, 74, 56, 818, 401, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 4, 2491, 152, 56, 738, 713, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 2494, 10, 55, 799, 526, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 4, 2495, 439, 56, 882, 694, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 1, 2498, 258, 54, 749, 869, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 5, 2502, 25, 57, 887, 430, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2503, 352, 58, 480, 864, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 2504, 390, 59, 870, 447, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 2509, 142, 65, 488, 554, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 2, 2517, 27, 54, 567, 725, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 2, 2520, 266, 56, 419, 802, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 1, 2521, 134, 64, 718, 670, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2522, 431, 54, 488, 773, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 2524, 218, 64, 716, 432, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 4, 2525, 306, 54, 523, 816, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 2526, 253, 54, 756, 673, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 2529, 266, 63, 660, 584, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2530, 235, 57, 490, 481, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (7, 1, 2532, 316, 54, 413, 862, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 2536, 378, 62, 788, 696, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2539, 415, 64, 470, 873, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2540, 253, 58, 474, 415, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 2, 2541, 168, 62, 732, 497, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 2, 2542, 270, 62, 544, 1003, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 2544, 37, 59, 667, 619, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 2545, 142, 57, 516, 731, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2556, 268, 53, 479, 580, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 4, 2557, 277, 64, 456, 714, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2559, 290, 56, 491, 558, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 3, 2561, 79, 56, 537, 774, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2564, 349, 58, 460, 509, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 4, 2565, 423, 53, 658, 629, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 2, 2567, 493, 65, 733, 526, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 1, 2568, 199, 65, 669, 600, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 1, 2571, 332, 54, 627, 759, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 2573, 65, 59, 637, 870, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 2578, 386, 65, 556, 588, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 2581, 386, 59, 894, 574, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (18, 1, 2589, 346, 57, 759, 738, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 2, 2590, 230, 54, 415, 694, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 2, 2593, 6, 56, 783, 898, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 2600, 336, 65, 587, 558, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 5, 2605, 318, 53, 887, 462, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (6, 1, 2609, 11, 64, 466, 871, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 2614, 31, 62, 795, 831, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 2615, 154, 57, 630, 641, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 2617, 171, 53, 575, 1002, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (21, 3, 2621, 61, 54, 650, 544, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 2622, 476, 57, 441, 654, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (22, 4, 2623, 246, 62, 586, 904, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 2625, 109, 59, 505, 545, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 2627, 120, 58, 882, 408, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 5, 2628, 120, 53, 489, 404, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 4, 2631, 439, 64, 415, 897, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (24, 3, 2633, 53, 59, 495, 538, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 4, 2638, 174, 57, 875, 603, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (23, 1, 2639, 308, 58, 700, 842, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (19, 3, 2640, 367, 62, 747, 404, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 2642, 204, 57, 487, 484, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (20, 3, 2645, 111, 62, 562, 461, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (17, 4, 2646, 36, 56, 435, 794, null);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 1, null, 52, null, 12, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 2, null, 45, null, 340, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 3, null, 11, null, 150, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 4, null, 43, null, 85, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 5, null, 30, null, 124, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 6, null, 2, null, 263, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 7, null, 24, null, 80, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 8, null, 12, null, 269, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 9, null, 51, null, 185, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 10, null, 42, null, 172, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 11, null, 50, null, 160, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 12, null, 50, null, 232, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 13, null, 34, null, 125, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 14, null, 43, null, 5, 6);
commit;
prompt 400 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 15, null, 23, null, 147, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 16, null, 9, null, 135, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 17, null, 42, null, 129, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 18, null, 43, null, 283, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 19, null, 4, null, 157, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 20, null, 15, null, 148, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 21, null, 22, null, 6, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 22, null, 5, null, 243, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 23, null, 33, null, 325, 37);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 24, null, 11, null, 226, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 25, null, 17, null, 390, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 26, null, 7, null, 163, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 27, null, 52, null, 176, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 28, null, 8, null, 149, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 29, null, 28, null, 388, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 30, null, 6, null, 65, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 31, null, 42, null, 70, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 32, null, 28, null, 305, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 33, null, 39, null, 88, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 34, null, 27, null, 344, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 35, null, 13, null, 41, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 36, null, 20, null, 184, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 37, null, 17, null, 90, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 38, null, 32, null, 318, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 39, null, 40, null, 211, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 40, null, 20, null, 48, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 41, null, 9, null, 304, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 42, null, 43, null, 39, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 43, null, 48, null, 270, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 44, null, 14, null, 150, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 45, null, 34, null, 342, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 46, null, 16, null, 360, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 47, null, 39, null, 27, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 48, null, 29, null, 374, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 6, 49, null, 4, null, 367, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 50, null, 44, null, 5, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 51, null, 27, null, 316, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 52, null, 18, null, 45, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 53, null, 34, null, 131, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 54, null, 29, null, 34, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 55, null, 21, null, 50, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 56, null, 1, null, 210, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 57, null, 44, null, 52, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 58, null, 17, null, 237, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 59, null, 34, null, 128, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 60, null, 4, null, 331, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 61, null, 28, null, 268, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 62, null, 21, null, 76, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 63, null, 20, null, 180, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 64, null, 8, null, 270, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 65, null, 22, null, 117, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 66, null, 24, null, 81, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 67, null, 49, null, 238, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 68, null, 15, null, 138, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 69, null, 30, null, 183, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 71, null, 21, null, 343, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 72, null, 43, null, 266, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 73, null, 2, null, 354, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 74, null, 35, null, 370, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 75, null, 41, null, 369, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 76, null, 24, null, 80, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 77, null, 1, null, 238, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 78, null, 48, null, 41, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 79, null, 52, null, 61, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 80, null, 21, null, 338, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 81, null, 48, null, 372, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 82, null, 30, null, 396, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 83, null, 28, null, 179, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 84, null, 40, null, 102, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 85, null, 11, null, 376, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 86, null, 40, null, 256, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 87, null, 34, null, 151, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 88, null, 21, null, 317, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 89, null, 8, null, 300, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 90, null, 26, null, 94, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 91, null, 12, null, 116, 37);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 92, null, 50, null, 355, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 93, null, 30, null, 287, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 94, null, 44, null, 400, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 96, null, 1, null, 7, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 97, null, 25, null, 222, 37);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 98, null, 52, null, 260, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 99, null, 52, null, 6, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 100, null, 7, null, 284, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 101, null, 45, null, 296, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 102, null, 52, null, 169, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 103, null, 37, null, 273, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 5, 104, null, 31, null, 92, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 105, null, 18, null, 327, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 106, null, 51, null, 390, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 107, null, 45, null, 170, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 108, null, 8, null, 358, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 109, null, 19, null, 190, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 110, null, 27, null, 287, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 111, null, 14, null, 263, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 6, 112, null, 36, null, 72, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 113, null, 45, null, 193, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 3, 114, null, 52, null, 144, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 115, null, 17, null, 253, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 116, null, 2, null, 11, 8);
commit;
prompt 500 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 117, null, 8, null, 352, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 3, 118, null, 19, null, 286, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 119, null, 30, null, 17, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 120, null, 5, null, 20, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 121, null, 44, null, 392, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 122, null, 41, null, 36, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 123, null, 15, null, 191, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 124, null, 5, null, 213, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 125, null, 25, null, 37, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 126, null, 34, null, 304, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 127, null, 28, null, 296, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 128, null, 33, null, 165, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 129, null, 51, null, 18, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 6, 130, null, 16, null, 150, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 131, null, 32, null, 95, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 132, null, 43, null, 267, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 134, null, 25, null, 118, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 135, null, 15, null, 378, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 137, null, 2, null, 148, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 138, null, 48, null, 80, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 139, null, 22, null, 266, 37);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 140, null, 40, null, 33, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 3, 141, null, 8, null, 7, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 142, null, 8, null, 193, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 143, null, 20, null, 231, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 145, null, 2, null, 14, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 146, null, 1, null, 94, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 147, null, 33, null, 126, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 148, null, 52, null, 368, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 149, null, 44, null, 100, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 150, null, 32, null, 357, 34);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 151, null, 34, null, 13, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 152, null, 52, null, 398, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 153, null, 36, null, 318, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 154, null, 42, null, 321, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 155, null, 18, null, 88, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 156, null, 29, null, 204, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 157, null, 47, null, 143, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 158, null, 11, null, 111, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 159, null, 15, null, 97, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 160, null, 3, null, 400, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 161, null, 35, null, 54, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 162, null, 29, null, 373, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 163, null, 30, null, 333, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 164, null, 33, null, 237, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 165, null, 45, null, 323, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 166, null, 40, null, 147, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 3, 167, null, 49, null, 16, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 168, null, 21, null, 82, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 169, null, 8, null, 71, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 3, 172, null, 31, null, 54, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 173, null, 40, null, 129, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 174, null, 5, null, 307, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 175, null, 52, null, 344, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 176, null, 12, null, 71, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 177, null, 12, null, 147, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 178, null, 30, null, 47, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 179, null, 37, null, 69, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 4, 180, null, 42, null, 277, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 181, null, 4, null, 94, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 182, null, 27, null, 360, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 183, null, 31, null, 290, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 6, 184, null, 2, null, 136, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 185, null, 29, null, 398, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 6, 186, null, 34, null, 366, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 187, null, 51, null, 22, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 188, null, 15, null, 133, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 189, null, 23, null, 263, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 190, null, 8, null, 398, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 192, null, 49, null, 174, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 4, 193, null, 47, null, 208, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 5, 194, null, 46, null, 109, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 196, null, 6, null, 50, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 197, null, 33, null, 184, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 198, null, 52, null, 72, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 199, null, 43, null, 326, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 6, 200, null, 44, null, 216, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 201, null, 48, null, 285, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 202, null, 27, null, 176, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 203, null, 13, null, 121, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 204, null, 38, null, 81, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 205, null, 26, null, 30, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 206, null, 40, null, 239, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 207, null, 22, null, 161, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 208, null, 15, null, 258, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 209, null, 46, null, 237, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 211, null, 16, null, 233, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 212, null, 51, null, 147, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 3, 213, null, 4, null, 39, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 214, null, 41, null, 239, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 216, null, 12, null, 326, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 217, null, 25, null, 86, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 4, 218, null, 42, null, 343, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 219, null, 40, null, 290, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 221, null, 30, null, 283, 37);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 223, null, 19, null, 128, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 224, null, 27, null, 355, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 225, null, 34, null, 91, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 226, null, 18, null, 293, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 227, null, 52, null, 381, 14);
commit;
prompt 600 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 229, null, 33, null, 359, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 230, null, 48, null, 169, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 231, null, 17, null, 229, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 232, null, 18, null, 299, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 234, null, 36, null, 325, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 3, 235, null, 9, null, 273, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 236, null, 5, null, 77, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 237, null, 27, null, 211, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 6, 239, null, 44, null, 23, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 240, null, 19, null, 64, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 241, null, 4, null, 60, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 242, null, 28, null, 351, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 243, null, 38, null, 249, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 244, null, 17, null, 94, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 245, null, 19, null, 70, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 246, null, 42, null, 397, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 247, null, 20, null, 384, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 248, null, 35, null, 66, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 249, null, 32, null, 365, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 250, null, 14, null, 378, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 251, null, 17, null, 69, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 252, null, 26, null, 154, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 253, null, 33, null, 322, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 254, null, 31, null, 12, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 255, null, 23, null, 41, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 257, null, 32, null, 243, 40);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 258, null, 51, null, 18, 35);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 259, null, 28, null, 55, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 262, null, 4, null, 366, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 263, null, 3, null, 27, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 264, null, 16, null, 334, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 265, null, 50, null, 383, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 6, 266, null, 30, null, 30, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 267, null, 48, null, 306, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 268, null, 23, null, 312, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 269, null, 44, null, 208, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 270, null, 13, null, 59, 22);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 271, null, 7, null, 253, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 272, null, 16, null, 165, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 6, 273, null, 26, null, 322, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 274, null, 26, null, 286, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 275, null, 38, null, 32, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 276, null, 52, null, 340, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 277, null, 49, null, 355, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 278, null, 35, null, 93, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 279, null, 2, null, 206, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 280, null, 28, null, 59, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 5, 281, null, 16, null, 149, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 282, null, 24, null, 156, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 283, null, 12, null, 218, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 285, null, 46, null, 329, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 286, null, 17, null, 177, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 287, null, 1, null, 176, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 288, null, 28, null, 42, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 290, null, 38, null, 131, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 1, 291, null, 26, null, 8, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 292, null, 23, null, 305, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 293, null, 40, null, 291, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 295, null, 51, null, 203, 37);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 4, 296, null, 10, null, 326, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 297, null, 18, null, 298, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 298, null, 30, null, 254, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 299, null, 43, null, 19, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 300, null, 20, null, 164, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 301, null, 23, null, 185, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 302, null, 51, null, 43, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 303, null, 51, null, 353, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 6, 304, null, 28, null, 246, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 305, null, 28, null, 262, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 306, null, 4, null, 191, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 307, null, 34, null, 177, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 308, null, 24, null, 13, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 310, null, 11, null, 241, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 313, null, 51, null, 285, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 314, null, 14, null, 118, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 4, 315, null, 8, null, 78, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 316, null, 38, null, 42, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 317, null, 24, null, 88, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 318, null, 47, null, 100, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 5, 319, null, 20, null, 326, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 320, null, 17, null, 315, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 6, 321, null, 42, null, 178, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 322, null, 30, null, 37, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 323, null, 13, null, 275, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 324, null, 2, null, 179, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 325, null, 7, null, 244, 5);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 1, 326, null, 29, null, 267, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 2, 327, null, 12, null, 222, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 328, null, 28, null, 290, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 330, null, 28, null, 316, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 5, 331, null, 16, null, 93, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 332, null, 15, null, 116, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 333, null, 8, null, 140, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 3, 334, null, 17, null, 33, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 5, 335, null, 41, null, 209, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 336, null, 2, null, 197, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 337, null, 7, null, 50, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 338, null, 48, null, 251, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 339, null, 17, null, 359, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 340, null, 28, null, 348, 5);
commit;
prompt 700 records committed...
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 341, null, 38, null, 110, 31);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 342, null, 48, null, 211, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 343, null, 43, null, 167, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 344, null, 35, null, 55, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 345, null, 12, null, 350, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 6, 347, null, 36, null, 269, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 349, null, 20, null, 8, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 3, 350, null, 49, null, 41, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 6, 351, null, 32, null, 267, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 352, null, 25, null, 130, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 6, 353, null, 29, null, 100, 13);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 356, null, 8, null, 372, 2);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 357, null, 7, null, 105, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 359, null, 15, null, 129, 17);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 1, 362, null, 41, null, 289, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 363, null, 39, null, 90, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 364, null, 23, null, 156, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 6, 365, null, 37, null, 300, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 4, 367, null, 41, null, 87, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 368, null, 22, null, 114, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 2, 369, null, 51, null, 385, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 370, null, 33, null, 3, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 371, null, 3, null, 136, 37);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 1, 372, null, 19, null, 285, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 373, null, 43, null, 71, 6);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 374, null, 2, null, 232, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 375, null, 19, null, 198, 28);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 3, 376, null, 36, null, 296, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 378, null, 25, null, 136, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 379, null, 28, null, 295, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 5, 380, null, 17, null, 58, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 383, null, 28, null, 156, 39);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 4, 384, null, 7, null, 186, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 386, null, 49, null, 28, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 387, null, 44, null, 101, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 388, null, 17, null, 178, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 390, null, 28, null, 341, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 5, 391, null, 44, null, 150, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 4, 395, null, 29, null, 53, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 6, 397, null, 36, null, 325, 3);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 4, 398, null, 1, null, 239, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 5, 399, null, 49, null, 234, 26);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 400, null, 42, null, 298, 30);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 401, null, 16, null, 100, 14);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 402, null, 42, null, 343, 24);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 5, 404, null, 20, null, 72, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 2, 406, null, 23, null, 185, 4);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 1, 409, null, 27, null, 232, 7);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 2, 410, null, 47, null, 53, 1);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 5, 411, null, 18, null, 139, 11);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 412, null, 40, null, 212, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 6, 414, null, 47, null, 298, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 415, null, 39, null, 130, 19);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 4, 416, null, 51, null, 189, 8);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 3, 418, null, 5, null, 102, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (8, 1, 419, null, 49, null, 337, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 2, 420, null, 23, null, 197, 20);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 5, 422, null, 48, null, 366, 12);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (14, 3, 423, null, 46, null, 295, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 424, null, 51, null, 239, 27);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 425, null, 29, null, 332, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 6, 426, null, 31, null, 52, 32);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 6, 427, null, 10, null, 107, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 428, null, 26, null, 389, 29);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 1, 432, null, 50, null, 60, 33);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 4, 433, null, 3, null, 159, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 4, 434, null, 48, null, 322, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 435, null, 39, null, 110, 15);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 2, 436, null, 22, null, 62, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 2, 437, null, 3, null, 20, 16);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (9, 1, 439, null, 34, null, 247, 25);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (12, 2, 440, null, 52, null, 111, 9);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (13, 3, 442, null, 52, null, 278, 21);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 3, 443, null, 42, null, 266, 38);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (16, 4, 444, null, 41, null, 167, 18);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 6, 446, null, 5, null, 15, 36);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (10, 2, 448, null, 15, null, 51, 23);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (11, 3, 449, null, 38, null, 73, 10);
insert into SCHEDULER (sc_time, sc_day, scheduler_id, group_id, workshop_id, room_id, teacher_id, class_id)
values (15, 1, 450, null, 30, null, 350, 8);
commit;
prompt 779 records loaded
prompt Enabling foreign key constraints for TEACHERS...
alter table TEACHERS enable constraint SYS_C007695;
prompt Enabling foreign key constraints for CLASS_...
alter table CLASS_ enable constraint SYS_C007538;
prompt Enabling foreign key constraints for CLIENTS...
alter table CLIENTS enable constraint SYS_C007680;
prompt Enabling foreign key constraints for GROUPS_...
alter table GROUPS_ enable constraint SYS_C007683;
prompt Enabling foreign key constraints for PARTICIPATE...
alter table PARTICIPATE enable constraint SYS_C007687;
alter table PARTICIPATE enable constraint SYS_C007688;
prompt Enabling foreign key constraints for SCHEDULER...
alter table SCHEDULER enable constraint FK_CLASS_;
alter table SCHEDULER enable constraint SYS_C007701;
alter table SCHEDULER enable constraint SYS_C007702;
alter table SCHEDULER enable constraint SYS_C007703;
alter table SCHEDULER enable constraint SYS_C007704;
prompt Enabling triggers for AGE_GROUP...
alter table AGE_GROUP enable all triggers;
prompt Enabling triggers for CITY...
alter table CITY enable all triggers;
prompt Enabling triggers for TEACHERS...
alter table TEACHERS enable all triggers;
prompt Enabling triggers for CLASS_...
alter table CLASS_ enable all triggers;
prompt Enabling triggers for CLIENTS...
alter table CLIENTS enable all triggers;
prompt Enabling triggers for GROUPS_...
alter table GROUPS_ enable all triggers;
prompt Enabling triggers for PARTICIPATE...
alter table PARTICIPATE enable all triggers;
prompt Enabling triggers for ROOMS...
alter table ROOMS enable all triggers;
prompt Enabling triggers for WORKSHOPS...
alter table WORKSHOPS enable all triggers;
prompt Enabling triggers for SCHEDULER...
alter table SCHEDULER enable all triggers;
set feedback on
set define on
prompt Done.
