prompt PL/SQL Developer import file
prompt Created on Sunday, May 26, 2024 by dasst
set feedback off
set define off
prompt Creating ROOM...
create table ROOM
(
  room_id                NUMBER(3) not null,
  max_capacity           INTEGER not null,
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
alter table ROOM
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
alter table ROOM
  add check (is_lab = 1 OR is_lab = 0);

prompt Creating TEACHER...
create table TEACHER
(
  teacher_id  NUMBER(3) not null,
  tlast_name  VARCHAR2(15) not null,
  tfirst_name VARCHAR2(15) not null
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
alter table TEACHER
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

prompt Creating CLASS_...
create table CLASS_
(
  class_id   NUMBER(3) not null,
  grade      NUMBER(2) not null,
  teacher_id NUMBER(3) not null,
  room_id    NUMBER(3) not null
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
  references TEACHER (TEACHER_ID);
alter table CLASS_
  add foreign key (ROOM_ID)
  references ROOM (ROOM_ID);

prompt Creating SUBJECT...
create table SUBJECT
(
  subject_id   NUMBER(3) not null,
  subject_name VARCHAR2(30) not null,
  mandatory    NUMBER(1) not null
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
alter table SUBJECT
  add primary key (SUBJECT_ID)
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
alter table SUBJECT
  add check (mandatory = 1 OR mandatory = 0);

prompt Creating LESSON...
create table LESSON
(
  lesson_id   NUMBER(3) not null,
  lesson_day  INTEGER not null,
  lesson_hour INTEGER not null,
  class_id    NUMBER(3),
  teacher_id  NUMBER(3),
  subject_id  NUMBER(3)
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
alter table LESSON
  add primary key (LESSON_ID)
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
alter table LESSON
  add unique (CLASS_ID, LESSON_DAY, LESSON_HOUR)
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
alter table LESSON
  add unique (TEACHER_ID, LESSON_DAY, LESSON_HOUR)
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
alter table LESSON
  add foreign key (CLASS_ID)
  references CLASS_ (CLASS_ID);
alter table LESSON
  add foreign key (TEACHER_ID)
  references TEACHER (TEACHER_ID);
alter table LESSON
  add foreign key (SUBJECT_ID)
  references SUBJECT (SUBJECT_ID);
alter table LESSON
  add check (Lesson_Day BETWEEN 1 AND 6);

prompt Creating STUDENT...
create table STUDENT
(
  student_id NUMBER(3) not null,
  first_name VARCHAR2(15) not null,
  last_name  VARCHAR2(15) not null,
  birth_date DATE not null,
  phone      INTEGER not null,
  fathername VARCHAR2(15) not null,
  mothername VARCHAR2(15) not null,
  class_id   NUMBER(3)
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
alter table STUDENT
  add primary key (STUDENT_ID)
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
alter table STUDENT
  add foreign key (CLASS_ID)
  references CLASS_ (CLASS_ID);

prompt Disabling triggers for ROOM...
alter table ROOM disable all triggers;
prompt Disabling triggers for TEACHER...
alter table TEACHER disable all triggers;
prompt Disabling triggers for CLASS_...
alter table CLASS_ disable all triggers;
prompt Disabling triggers for SUBJECT...
alter table SUBJECT disable all triggers;
prompt Disabling triggers for LESSON...
alter table LESSON disable all triggers;
prompt Disabling triggers for STUDENT...
alter table STUDENT disable all triggers;
prompt Disabling foreign key constraints for CLASS_...
alter table CLASS_ disable constraint SYS_C007314;
alter table CLASS_ disable constraint SYS_C007315;
prompt Disabling foreign key constraints for LESSON...
alter table LESSON disable constraint SYS_C007322;
alter table LESSON disable constraint SYS_C007323;
alter table LESSON disable constraint SYS_C007324;
prompt Disabling foreign key constraints for STUDENT...
alter table STUDENT disable constraint SYS_C007340;
prompt Deleting STUDENT...
delete from STUDENT;
commit;
prompt Deleting LESSON...
delete from LESSON;
commit;
prompt Deleting SUBJECT...
delete from SUBJECT;
commit;
prompt Deleting CLASS_...
delete from CLASS_;
commit;
prompt Deleting TEACHER...
delete from TEACHER;
commit;
prompt Deleting ROOM...
delete from ROOM;
commit;
prompt Loading ROOM...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (1, 62, 1, to_date('22-06-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (2, 21, 0, to_date('27-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (3, 55, 0, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (4, 63, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (5, 63, 0, to_date('13-09-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (6, 66, 1, to_date('20-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (7, 69, 1, to_date('03-06-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (8, 64, 1, to_date('08-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (9, 42, 1, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (10, 66, 0, to_date('30-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (11, 59, 1, to_date('07-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (12, 70, 1, to_date('13-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (13, 57, 1, to_date('04-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (14, 27, 1, to_date('10-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (15, 36, 0, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (16, 48, 1, to_date('14-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (17, 27, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (18, 22, 1, to_date('13-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (19, 54, 1, to_date('16-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (20, 68, 0, to_date('02-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (21, 62, 1, to_date('12-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (22, 34, 0, to_date('22-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (23, 67, 0, to_date('21-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (24, 57, 0, to_date('17-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (25, 26, 1, to_date('23-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (26, 29, 0, to_date('17-10-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (27, 40, 0, to_date('19-12-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (28, 29, 1, to_date('03-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (29, 48, 1, to_date('05-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (30, 40, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (31, 68, 0, to_date('16-12-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (32, 32, 1, to_date('04-12-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (33, 36, 1, to_date('23-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (34, 57, 0, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (35, 23, 1, to_date('12-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (36, 63, 0, to_date('08-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (37, 67, 1, to_date('17-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (38, 45, 0, to_date('11-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (39, 23, 1, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (40, 28, 0, to_date('02-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (41, 23, 1, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (42, 24, 0, to_date('24-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (43, 63, 1, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (44, 37, 0, to_date('18-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (45, 38, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (46, 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (47, 66, 0, to_date('10-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (48, 50, 0, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (49, 59, 1, to_date('20-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (50, 20, 0, to_date('17-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (51, 43, 1, to_date('16-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (52, 68, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (53, 60, 1, to_date('20-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (54, 30, 0, to_date('14-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (55, 24, 0, to_date('18-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (56, 61, 1, to_date('06-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (57, 54, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (58, 52, 0, to_date('22-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (59, 28, 0, to_date('16-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (60, 23, 0, to_date('26-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (61, 45, 1, to_date('15-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (62, 44, 0, to_date('16-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (63, 62, 1, to_date('19-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (64, 61, 0, to_date('17-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (65, 47, 0, to_date('18-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (66, 37, 0, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (67, 45, 1, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (68, 44, 0, to_date('27-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (69, 36, 1, to_date('14-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (70, 39, 1, to_date('18-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (71, 24, 1, to_date('11-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (72, 24, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (73, 49, 1, to_date('24-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (74, 43, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (75, 38, 0, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (76, 24, 0, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (77, 56, 0, to_date('04-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (78, 37, 1, to_date('19-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (79, 32, 1, to_date('25-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (80, 55, 0, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (81, 41, 1, to_date('10-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (82, 57, 1, to_date('01-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (83, 61, 0, to_date('23-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (84, 69, 0, to_date('04-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (85, 69, 0, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (86, 45, 1, to_date('26-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (87, 41, 0, to_date('11-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (88, 59, 1, to_date('05-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (89, 68, 1, to_date('11-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (90, 56, 0, to_date('15-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (91, 36, 0, to_date('07-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (92, 55, 1, to_date('31-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (93, 44, 1, to_date('02-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (94, 23, 1, to_date('16-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (95, 35, 0, to_date('18-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (96, 30, 1, to_date('13-05-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (97, 43, 1, to_date('05-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (98, 61, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (99, 56, 1, to_date('30-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (100, 67, 1, to_date('21-06-2021', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (101, 22, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (102, 50, 0, to_date('18-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (103, 47, 1, to_date('06-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (104, 53, 0, to_date('30-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (105, 56, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (106, 34, 0, to_date('31-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (107, 47, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (108, 41, 1, to_date('02-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (109, 35, 0, to_date('21-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (110, 27, 1, to_date('08-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (111, 54, 0, to_date('19-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (112, 20, 0, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (113, 26, 0, to_date('15-09-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (114, 67, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (115, 25, 1, to_date('03-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (116, 35, 0, to_date('25-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (117, 23, 1, to_date('28-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (118, 30, 1, to_date('05-09-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (119, 57, 0, to_date('29-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (120, 68, 1, to_date('05-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (121, 69, 1, to_date('05-10-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (122, 56, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (123, 70, 0, to_date('29-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (124, 49, 0, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (125, 70, 1, to_date('02-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (126, 33, 1, to_date('08-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (127, 33, 1, to_date('19-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (128, 21, 0, to_date('06-09-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (129, 55, 1, to_date('21-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (130, 27, 1, to_date('01-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (131, 31, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (132, 26, 1, to_date('10-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (133, 20, 0, to_date('15-04-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (134, 48, 1, to_date('25-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (135, 20, 0, to_date('05-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (136, 67, 0, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (137, 33, 0, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (138, 39, 1, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (139, 65, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (140, 59, 0, to_date('18-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (141, 22, 1, to_date('20-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (142, 31, 0, to_date('19-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (143, 24, 0, to_date('26-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (144, 23, 0, to_date('13-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (145, 48, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (146, 38, 1, to_date('08-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (147, 44, 1, to_date('16-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (148, 70, 1, to_date('06-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (149, 54, 1, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (150, 49, 0, to_date('26-12-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (151, 62, 1, to_date('09-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (152, 47, 0, to_date('05-10-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (153, 65, 0, to_date('17-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (154, 46, 0, to_date('16-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (155, 49, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (156, 46, 0, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (157, 66, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (158, 23, 1, to_date('25-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (159, 23, 0, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (160, 36, 0, to_date('20-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (161, 45, 1, to_date('19-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (162, 40, 0, to_date('16-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (163, 35, 0, to_date('01-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (164, 54, 0, to_date('28-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (165, 69, 1, to_date('05-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (166, 70, 0, to_date('08-06-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (167, 22, 1, to_date('26-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (168, 64, 1, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (169, 30, 0, to_date('16-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (170, 30, 1, to_date('04-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (171, 31, 0, to_date('24-05-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (172, 58, 1, to_date('28-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (173, 34, 1, to_date('05-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (174, 28, 0, to_date('03-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (175, 64, 1, to_date('04-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (176, 67, 0, to_date('05-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (177, 22, 1, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (178, 68, 0, to_date('03-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (179, 64, 1, to_date('26-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (180, 57, 0, to_date('31-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (181, 33, 1, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (182, 35, 0, to_date('07-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (183, 48, 0, to_date('24-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (184, 58, 1, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (185, 70, 0, to_date('20-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (186, 48, 1, to_date('21-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (187, 58, 0, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (188, 42, 1, to_date('14-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (189, 44, 1, to_date('21-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (190, 32, 1, to_date('06-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (191, 53, 0, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (192, 49, 1, to_date('03-07-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (193, 58, 0, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (194, 57, 1, to_date('21-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (195, 20, 0, to_date('17-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (196, 67, 1, to_date('04-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (197, 51, 1, to_date('21-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (198, 68, 1, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (199, 33, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (200, 39, 0, to_date('16-01-2024', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (201, 54, 0, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (202, 55, 1, to_date('05-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (203, 48, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (204, 27, 1, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (205, 55, 0, to_date('12-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (206, 42, 1, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (207, 67, 0, to_date('27-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (208, 22, 0, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (209, 48, 0, to_date('09-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (210, 49, 0, to_date('25-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (211, 67, 1, to_date('26-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (212, 69, 0, to_date('08-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (213, 30, 0, to_date('04-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (214, 37, 1, to_date('04-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (215, 59, 0, to_date('06-04-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (216, 59, 0, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (217, 56, 0, to_date('06-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (218, 64, 1, to_date('16-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (219, 42, 1, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (220, 47, 0, to_date('25-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (221, 38, 0, to_date('03-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (222, 40, 0, to_date('16-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (223, 40, 0, to_date('11-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (224, 59, 0, to_date('11-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (225, 20, 0, to_date('18-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (226, 40, 1, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (227, 26, 0, to_date('12-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (228, 66, 0, to_date('27-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (229, 46, 1, to_date('13-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (230, 63, 0, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (231, 34, 1, to_date('01-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (232, 39, 0, to_date('23-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (233, 66, 1, to_date('17-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (234, 42, 1, to_date('19-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (235, 32, 1, to_date('02-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (236, 70, 0, to_date('04-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (237, 41, 0, to_date('26-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (238, 37, 0, to_date('11-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (239, 55, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (240, 39, 0, to_date('18-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (241, 55, 0, to_date('25-09-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (242, 36, 0, to_date('21-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (243, 25, 0, to_date('12-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (244, 61, 1, to_date('01-10-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (245, 58, 1, to_date('24-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (246, 70, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (247, 36, 1, to_date('08-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (248, 54, 0, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (249, 53, 1, to_date('28-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (250, 22, 0, to_date('23-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (251, 62, 1, to_date('01-08-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (252, 27, 1, to_date('22-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (253, 51, 1, to_date('22-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (254, 21, 0, to_date('03-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (255, 33, 1, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (256, 34, 1, to_date('29-04-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (257, 41, 0, to_date('21-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (258, 56, 1, to_date('31-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (259, 33, 0, to_date('08-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (260, 36, 1, to_date('10-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (261, 25, 1, to_date('28-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (262, 38, 1, to_date('06-02-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (263, 55, 0, to_date('25-02-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (264, 54, 1, to_date('28-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (265, 35, 1, to_date('04-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (266, 50, 1, to_date('05-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (267, 61, 1, to_date('27-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (268, 44, 0, to_date('22-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (269, 66, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (270, 68, 0, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (271, 25, 1, to_date('12-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (272, 34, 0, to_date('28-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (273, 54, 1, to_date('26-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (274, 33, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (275, 52, 0, to_date('20-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (276, 25, 0, to_date('04-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (277, 23, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (278, 64, 0, to_date('09-12-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (279, 25, 0, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (280, 46, 0, to_date('02-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (281, 45, 1, to_date('01-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (282, 36, 1, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (283, 40, 0, to_date('04-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (284, 63, 1, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (285, 54, 1, to_date('28-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (286, 37, 0, to_date('12-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (287, 54, 0, to_date('05-12-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (288, 20, 0, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (289, 61, 0, to_date('27-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (290, 22, 0, to_date('21-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (291, 57, 1, to_date('17-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (292, 50, 0, to_date('10-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (293, 58, 0, to_date('13-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (294, 49, 1, to_date('16-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (295, 27, 0, to_date('10-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (296, 22, 1, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (297, 40, 1, to_date('22-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (298, 64, 0, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (299, 27, 1, to_date('19-08-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (300, 22, 1, to_date('29-12-2023', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (301, 23, 0, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (302, 31, 0, to_date('09-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (303, 51, 1, to_date('24-03-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (304, 50, 0, to_date('24-12-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (305, 40, 0, to_date('27-12-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (306, 49, 1, to_date('13-04-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (307, 42, 0, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (308, 40, 0, to_date('02-02-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (309, 29, 1, to_date('29-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (310, 67, 0, to_date('11-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (311, 20, 1, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (312, 36, 0, to_date('16-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (313, 25, 0, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (314, 40, 1, to_date('12-12-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (315, 63, 1, to_date('22-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (316, 41, 0, to_date('13-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (317, 38, 0, to_date('04-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (318, 44, 0, to_date('21-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (319, 51, 0, to_date('27-06-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (320, 30, 1, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (321, 51, 1, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (322, 64, 0, to_date('22-11-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (323, 54, 1, to_date('11-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (324, 65, 1, to_date('17-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (325, 54, 1, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (326, 61, 1, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (327, 36, 1, to_date('30-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (328, 32, 0, to_date('22-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (329, 63, 0, to_date('01-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (330, 49, 0, to_date('04-05-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (331, 37, 0, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (332, 36, 0, to_date('04-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (333, 28, 1, to_date('26-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (334, 67, 0, to_date('28-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (335, 30, 1, to_date('10-05-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (336, 51, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (337, 40, 1, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (338, 47, 1, to_date('16-06-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (339, 34, 1, to_date('15-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (340, 65, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (341, 22, 0, to_date('02-05-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (342, 45, 0, to_date('11-06-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (343, 68, 0, to_date('03-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (344, 23, 0, to_date('04-07-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (345, 43, 1, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (346, 53, 1, to_date('16-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (347, 31, 0, to_date('03-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (348, 61, 0, to_date('11-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (349, 64, 1, to_date('22-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (350, 38, 0, to_date('18-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (351, 49, 1, to_date('17-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (352, 55, 1, to_date('19-03-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (353, 67, 0, to_date('12-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (354, 58, 0, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (355, 66, 1, to_date('03-12-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (356, 22, 1, to_date('23-03-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (357, 20, 1, to_date('09-09-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (358, 61, 1, to_date('20-08-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (359, 63, 1, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (360, 69, 0, to_date('23-03-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (361, 46, 0, to_date('28-05-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (362, 49, 1, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (363, 59, 1, to_date('22-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (364, 26, 0, to_date('27-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (365, 63, 1, to_date('01-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (366, 52, 1, to_date('31-12-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (367, 38, 0, to_date('17-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (368, 24, 1, to_date('30-01-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (369, 62, 0, to_date('19-08-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (370, 43, 1, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (371, 55, 1, to_date('02-12-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (372, 47, 0, to_date('27-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (373, 42, 1, to_date('05-02-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (374, 27, 0, to_date('02-05-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (375, 63, 0, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (376, 53, 1, to_date('24-11-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (377, 57, 0, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (378, 70, 1, to_date('13-07-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (379, 56, 1, to_date('12-11-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (380, 32, 0, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (381, 62, 0, to_date('30-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (382, 57, 0, to_date('05-04-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (383, 45, 0, to_date('28-01-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (384, 54, 1, to_date('15-03-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (385, 46, 1, to_date('30-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (386, 36, 1, to_date('07-10-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (387, 26, 1, to_date('31-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (388, 49, 0, to_date('29-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (389, 58, 1, to_date('18-04-2024', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (390, 48, 1, to_date('13-11-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (391, 43, 0, to_date('02-07-2022', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (392, 63, 0, to_date('25-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (393, 35, 0, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (394, 37, 0, to_date('12-09-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (395, 23, 1, to_date('09-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (396, 44, 1, to_date('24-10-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (397, 29, 0, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (398, 60, 1, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (399, 23, 0, to_date('20-05-2020', 'dd-mm-yyyy'));
insert into ROOM (room_id, max_capacity, is_lab, last_maintenance_check)
values (400, 29, 1, to_date('04-03-2021', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading TEACHER...
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (1, 'Price', 'Neneh');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (2, 'Dorff', 'Treat');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (3, 'Portman', 'Tommy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (4, 'Rosas', 'Henry');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (5, 'Goldwyn', 'Beverley');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (6, 'Makeba', 'Ernie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (7, 'Satriani', 'Gilberto');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (8, 'Albright', 'Jeffrey');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (9, 'Craven', 'Emm');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (10, 'Folds', 'Hex');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (11, 'Doucette', 'Woody');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (12, 'Wincott', 'Nigel');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (13, 'Parm', 'Taye');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (14, 'McKean', 'Chuck');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (15, 'Dickinson', 'Clarence');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (16, 'Harmon', 'Tara');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (17, 'Ruffalo', 'Philip');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (18, 'Gough', 'Shirley');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (19, 'Prinze', 'Nathan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (20, 'Green', 'Carol');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (21, 'O''Neal', 'Colin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (22, 'Butler', 'Pierce');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (23, 'Cobbs', 'Isaiah');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (24, 'Berenger', 'Jose');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (25, 'Trejo', 'Emerson');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (26, 'Sawa', 'Coley');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (27, 'Ripley', 'Kitty');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (28, 'Dafoe', 'Ashton');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (29, 'Gordon', 'Roddy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (30, 'Navarro', 'Vin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (31, 'Garfunkel', 'Paul');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (32, 'Rodriguez', 'Debra');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (33, 'Hawn', 'Andrea');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (34, 'Barnett', 'Annette');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (35, 'Mueller-Stahl', 'Chuck');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (36, 'Orbit', 'Christine');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (37, 'Vanian', 'Ellen');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (38, 'O''Neal', 'Julianna');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (39, 'Griffin', 'Cameron');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (40, 'Lynne', 'Rita');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (41, 'Stevens', 'Hal');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (42, 'Hershey', 'Rhys');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (43, 'O''Connor', 'Mekhi');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (44, 'Navarro', 'Adrien');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (45, 'Cantrell', 'Sammy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (46, 'Mattea', 'Joseph');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (47, 'Cohn', 'Tilda');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (48, 'O''Donnell', 'Bridgette');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (49, 'Dunst', 'Alan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (50, 'Benet', 'Anthony');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (51, 'Paymer', 'Kate');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (52, 'Ripley', 'Parker');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (53, 'Oates', 'Phoebe');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (54, 'McAnally', 'David');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (55, 'Hanley', 'Daryle');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (56, 'McDowell', 'Wade');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (57, 'Daniels', 'Dionne');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (58, 'Wood', 'Jessica');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (59, 'Leachman', 'Austin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (60, 'Gayle', 'Robby');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (61, 'Paymer', 'Hex');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (62, 'Oakenfold', 'Russell');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (63, 'Sanchez', 'Rueben');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (64, 'Vassar', 'Steven');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (65, 'Lemmon', 'Bryan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (66, 'Tillis', 'Emilio');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (67, 'Faithfull', 'Kurt');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (68, 'Diddley', 'Meg');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (69, 'Diaz', 'Jonatha');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (70, 'Kurtz', 'Wang');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (71, 'Shand', 'Miguel');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (72, 'Gold', 'Maura');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (73, 'Lewis', 'Lila');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (74, 'Cozier', 'Dean');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (75, 'Arthur', 'Diane');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (76, 'Thorton', 'Frankie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (77, 'Negbaur', 'Dylan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (78, 'Hershey', 'Kathleen');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (79, 'Thurman', 'Rachael');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (80, 'Lauper', 'Adina');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (81, 'Nakai', 'Nik');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (82, 'Sobieski', 'Wallace');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (83, 'Whitford', 'Robert');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (84, 'Crouse', 'Doug');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (85, 'Wen', 'Ossie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (86, 'Finn', 'Chet');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (87, 'Watley', 'Mae');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (88, 'Yorn', 'Judi');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (89, 'Postlethwaite', 'Tori');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (90, 'Holmes', 'Aida');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (91, 'Berkeley', 'Gates');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (92, 'Iglesias', 'Tori');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (93, 'Kahn', 'Pete');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (94, 'McLachlan', 'Eliza');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (95, 'Scott', 'Delbert');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (96, 'Ferrell', 'Tzi');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (97, 'Lloyd', 'Chanté');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (98, 'Vannelli', 'Connie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (99, 'Heche', 'Lindsey');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (100, 'Dourif', 'Lauren');
commit;
prompt 100 records committed...
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (101, 'Adler', 'Eric');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (102, 'Conley', 'Joan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (103, 'Orton', 'Janeane');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (104, 'Pierce', 'Geena');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (105, 'Clarkson', 'Terence');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (106, 'Sizemore', 'Kirsten');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (107, 'Moore', 'Chubby');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (108, 'Matthau', 'Nancy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (109, 'Lewis', 'Loretta');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (110, 'Fehr', 'Ed');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (111, 'Lang', 'Tracy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (112, 'Doucette', 'Freda');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (113, 'Kilmer', 'Nick');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (114, 'Webb', 'Rolando');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (115, 'Heche', 'Remy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (116, 'Lucien', 'Armand');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (117, 'Hunt', 'Gordon');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (118, 'MacDonald', 'Tamala');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (119, 'Law', 'Minnie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (120, 'Palminteri', 'Andrew');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (121, 'Makeba', 'Albertina');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (122, 'Hawkins', 'Giancarlo');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (123, 'Silverman', 'Frederic');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (124, 'Jeter', 'Catherine');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (125, 'Borgnine', 'Victoria');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (126, 'Santa Rosa', 'Teri');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (127, 'Margolyes', 'Rory');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (128, 'Garofalo', 'Phil');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (129, 'Cervine', 'Marina');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (130, 'Kudrow', 'Liev');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (131, 'Underwood', 'Boyd');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (132, 'Pierce', 'Stevie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (133, 'Cross', 'Mae');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (134, 'Burstyn', 'Shannyn');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (135, 'Ness', 'Campbell');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (136, 'Cartlidge', 'Lauren');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (137, 'Balaban', 'Neve');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (138, 'Rodgers', 'Rosanna');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (139, 'Willis', 'Andrae');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (140, 'Preston', 'Jeffrey');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (141, 'Fiennes', 'Kevn');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (142, 'Penders', 'Alana');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (143, 'Duchovny', 'Wes');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (144, 'Laurie', 'Adrien');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (145, 'McGinley', 'Bill');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (146, 'Stevenson', 'Whoopi');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (147, 'Berry', 'Scarlett');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (148, 'Tomei', 'Peter');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (149, 'Clayton', 'Charlie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (150, 'Shepard', 'Allan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (151, 'Thurman', 'Pat');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (152, 'Fiennes', 'Suzy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (153, 'Burmester', 'Hikaru');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (154, 'Jeter', 'Cloris');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (155, 'Kattan', 'Edward');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (156, 'Margulies', 'Geggy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (157, 'Davidson', 'Gina');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (158, 'Sharp', 'Mia');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (159, 'King', 'Powers');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (160, 'Rhys-Davies', 'Stanley');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (161, 'Everett', 'Diamond');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (162, 'Coughlan', 'Jill');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (163, 'Birch', 'Cathy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (164, 'Singh', 'Taylor');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (165, 'Bates', 'Lennie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (166, 'Vaughan', 'Ike');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (167, 'Rankin', 'Neve');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (168, 'Horton', 'Collective');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (169, 'Orton', 'Jim');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (170, 'O''Hara', 'Joan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (171, 'Spears', 'Natacha');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (172, 'O''Connor', 'Carol');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (173, 'Rock', 'Xander');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (174, 'Fiorentino', 'Edgar');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (175, 'Rauhofer', 'Miles');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (176, 'Brody', 'Emm');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (177, 'Berkley', 'Crispin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (178, 'Fox', 'Cheryl');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (179, 'Flanagan', 'Nelly');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (180, 'Paquin', 'David');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (181, 'Larter', 'Sara');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (182, 'Trejo', 'Giovanni');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (183, 'Dreyfuss', 'Herbie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (184, 'Ripley', 'Lynn');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (185, 'Aiken', 'Dave');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (186, 'Head', 'Katrin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (187, 'Sossamon', 'Miles');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (188, 'Dafoe', 'Night');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (189, 'Rubinek', 'Joey');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (190, 'Leachman', 'Marc');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (191, 'Dean', 'Jean');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (192, 'Luongo', 'Clive');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (193, 'Cochran', 'Woody');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (194, 'Summer', 'Catherine');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (195, 'Fichtner', 'Aidan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (196, 'Chilton', 'Brian');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (197, 'Azaria', 'Keith');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (198, 'Logue', 'Kirsten');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (199, 'Cromwell', 'Harrison');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (200, 'McLean', 'Howard');
commit;
prompt 200 records committed...
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (201, 'Sawa', 'Vanessa');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (202, 'Hornsby', 'Andrae');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (203, 'Evanswood', 'Drew');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (204, 'von Sydow', 'Lee');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (205, 'Whitmore', 'Danni');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (206, 'Boone', 'Red');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (207, 'Redgrave', 'Winona');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (208, 'Cara', 'Marlon');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (209, 'Curry', 'Melanie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (210, 'Epps', 'Devon');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (211, 'Pigott-Smith', 'Denzel');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (212, 'Klein', 'Lin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (213, 'Bell', 'Jon');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (214, 'Sedaka', 'Trick');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (215, 'Visnjic', 'Jill');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (216, 'Dean', 'Terrence');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (217, 'Carradine', 'Tanya');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (218, 'Easton', 'Lauren');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (219, 'Chan', 'Diane');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (220, 'Borden', 'Nicholas');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (221, 'Vince', 'Carrie-Anne');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (222, 'Utada', 'Colin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (223, 'Reeves', 'Judge');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (224, 'Thorton', 'Pamela');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (225, 'Daniels', 'Bradley');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (226, 'Paquin', 'Chris');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (227, 'Furay', 'Dorry');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (228, 'Heron', 'Darren');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (229, 'Stone', 'Brooke');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (230, 'Bean', 'Timothy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (231, 'Lawrence', 'Lynette');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (232, 'Warden', 'Lois');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (233, 'Jeter', 'Dick');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (234, 'DeLuise', 'Ike');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (235, 'Lowe', 'Brenda');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (236, 'Harris', 'Rebeka');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (237, 'Cooper', 'Luis');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (238, 'Davis', 'Lily');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (239, 'Gandolfini', 'Diane');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (240, 'Vannelli', 'Oro');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (241, 'McGoohan', 'Edgar');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (242, 'Adkins', 'Irene');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (243, 'Bright', 'Melba');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (244, 'Conroy', 'Coley');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (245, 'Paige', 'Drew');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (246, 'Sandoval', 'Celia');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (247, 'Mantegna', 'Al');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (248, 'Bridges', 'Spike');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (249, 'Mirren', 'Cameron');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (250, 'Guinness', 'Reese');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (251, 'Ramirez', 'Woody');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (252, 'Burrows', 'Willem');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (253, 'Briscoe', 'Isaiah');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (254, 'Hershey', 'Aidan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (255, 'David', 'Rod');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (256, 'Finn', 'Stellan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (257, 'Cazale', 'Albertina');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (258, 'Wainwright', 'Gaby');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (259, 'Brooks', 'Molly');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (260, 'McCoy', 'Dennis');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (261, 'MacDonald', 'Daryl');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (262, 'Strathairn', 'Leon');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (263, 'Himmelman', 'Bernie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (264, 'Zane', 'Holland');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (265, 'Stiers', 'Mae');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (266, 'Leary', 'Murray');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (267, 'Cassel', 'Ronny');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (268, 'Baranski', 'Burt');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (269, 'Wariner', 'Sammy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (270, 'Coolidge', 'Suzanne');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (271, 'Sainte-Marie', 'Todd');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (272, 'Burns', 'Liev');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (273, 'Bale', 'Chrissie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (274, 'Weisberg', 'Benicio');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (275, 'Mandrell', 'Gilberto');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (276, 'Tinsley', 'Moe');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (277, 'Kane', 'Nils');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (278, 'Hall', 'Kathleen');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (279, 'Young', 'Hope');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (280, 'Andrews', 'Rachel');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (281, 'Slater', 'Quentin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (282, 'DiBiasio', 'Trace');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (283, 'Emmett', 'Cherry');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (284, 'Koteas', 'Katrin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (285, 'Turner', 'Marlon');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (286, 'Lindley', 'Victor');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (287, 'Bergen', 'Lena');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (288, 'Keen', 'David');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (289, 'Stowe', 'Joseph');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (290, 'Ellis', 'Mika');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (291, 'Sirtis', 'Gary');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (292, 'Walken', 'Jack');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (293, 'Emmett', 'Vickie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (294, 'Nicholas', 'Marianne');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (295, 'Thomson', 'Rade');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (296, 'Lillard', 'Oro');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (297, 'Margulies', 'Lindsay');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (298, 'Underwood', 'David');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (299, 'Sorvino', 'Ernest');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (300, 'DeVito', 'Buddy');
commit;
prompt 300 records committed...
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (301, 'Belushi', 'Taryn');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (302, 'Olin', 'Edgar');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (303, 'Payne', 'Rosie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (304, 'Lapointe', 'Glenn');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (305, 'Milsap', 'Mos');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (306, 'Sweet', 'Tamala');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (307, 'Iglesias', 'Alec');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (308, 'Atlas', 'Teri');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (309, 'Richardson', 'Lydia');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (310, 'Ford', 'Seth');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (311, 'Gold', 'Collin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (312, 'Ticotin', 'Boyd');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (313, 'Jackman', 'Woody');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (314, 'Palminteri', 'Adam');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (315, 'Osmond', 'Daryl');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (316, 'Navarro', 'Jeffery');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (317, 'Frost', 'Gary');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (318, 'Buffalo', 'Collective');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (319, 'Westerberg', 'Bryan');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (320, 'Gough', 'Linda');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (321, 'Mohr', 'Jimmie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (322, 'LuPone', 'Joely');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (323, 'Adams', 'Kate');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (324, 'Woodard', 'Dick');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (325, 'MacDonald', 'Ossie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (326, 'Downey', 'Larnelle');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (327, 'Dalton', 'Sigourney');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (328, 'Makowicz', 'Patty');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (329, 'Farris', 'Tim');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (330, 'Haysbert', 'Manu');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (331, 'Pitney', 'Marisa');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (332, 'Lithgow', 'Lloyd');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (333, 'MacDowell', 'Victoria');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (334, 'Mitra', 'Jennifer');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (335, 'Shatner', 'Udo');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (336, 'Cronin', 'Laurie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (337, 'Nash', 'James');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (338, 'Rispoli', 'Ronnie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (339, 'Forrest', 'Lois');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (340, 'Conlee', 'Amy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (341, 'Conley', 'Taye');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (342, 'Moriarty', 'Emma');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (343, 'Zappacosta', 'Dean');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (344, 'Tobolowsky', 'Melanie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (345, 'Fiennes', 'Demi');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (346, 'Purefoy', 'Courtney');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (347, 'Belle', 'Talvin');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (348, 'Duncan', 'Daryl');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (349, 'Keith', 'Gilberto');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (350, 'DeLuise', 'Barbara');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (351, 'Sobieski', 'Campbell');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (352, 'Crimson', 'Angie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (353, 'Sedgwick', 'Christian');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (354, 'Snider', 'Elvis');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (355, 'Ferry', 'Philip');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (356, 'Judd', 'Joseph');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (357, 'Blige', 'Chaka');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (358, 'Sizemore', 'Ann');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (359, 'Snipes', 'Sander');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (360, 'Harrison', 'Rupert');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (361, 'Belushi', 'Nicole');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (362, 'Brooks', 'Oliver');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (363, 'Wiedlin', 'Christmas');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (364, 'Posener', 'Lizzy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (365, 'Pitney', 'Joaquim');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (366, 'Dillon', 'Jean-Luc');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (367, 'Dorff', 'Lily');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (368, 'Lynn', 'Sigourney');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (369, 'Paquin', 'Debbie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (370, 'Shorter', 'Wayman');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (371, 'Arjona', 'Davis');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (372, 'Davidtz', 'Hazel');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (373, 'Malkovich', 'Sydney');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (374, 'McBride', 'Bret');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (375, 'MacNeil', 'Linda');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (376, 'Idle', 'Jena');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (377, 'Lynn', 'Carlos');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (378, 'Payton', 'Aaron');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (379, 'Shue', 'Daryle');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (380, 'Farrell', 'Kelli');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (381, 'Roberts', 'Patricia');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (382, 'Deejay', 'Derrick');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (383, 'Teng', 'Jonny Lee');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (384, 'Janssen', 'Vendetta');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (385, 'Clayton', 'Beverley');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (386, 'Mac', 'Suzi');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (387, 'Patton', 'Sophie');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (388, 'Gough', 'Brian');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (389, 'Singletary', 'Bo');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (390, 'Ryder', 'Azucar');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (391, 'Lovitz', 'Illeana');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (392, 'Lloyd', 'Miguel');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (393, 'Candy', 'Cornell');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (394, 'Johansson', 'Mickey');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (395, 'Collins', 'Laurence');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (396, 'Stuermer', 'Jake');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (397, 'Biehn', 'Bette');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (398, 'Affleck', 'Kathy');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (399, 'Elizabeth', 'Curtis');
insert into TEACHER (teacher_id, tlast_name, tfirst_name)
values (400, 'Carrere', 'Emilio');
commit;
prompt 400 records loaded
prompt Loading CLASS_...
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (1, 2, 177, 238);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (2, 2, 207, 153);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (3, 1, 387, 137);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (4, 11, 315, 112);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (5, 11, 27, 224);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (6, 1, 272, 5);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (7, 12, 384, 106);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (8, 11, 353, 140);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (9, 2, 397, 157);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (10, 10, 103, 243);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (11, 12, 146, 85);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (12, 8, 63, 288);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (13, 9, 249, 228);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (14, 11, 269, 185);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (15, 1, 160, 263);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (16, 11, 181, 77);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (17, 12, 234, 316);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (18, 2, 5, 140);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (19, 8, 381, 55);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (20, 8, 364, 152);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (21, 1, 309, 104);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (22, 5, 365, 270);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (23, 5, 328, 259);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (24, 10, 242, 22);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (25, 5, 162, 302);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (26, 1, 212, 342);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (27, 7, 120, 64);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (28, 3, 89, 239);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (29, 12, 208, 58);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (30, 4, 144, 20);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (31, 10, 338, 347);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (32, 6, 290, 207);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (33, 2, 80, 26);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (34, 2, 383, 397);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (35, 4, 288, 60);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (36, 2, 39, 354);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (37, 5, 60, 310);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (38, 11, 302, 55);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (39, 10, 348, 341);
insert into CLASS_ (class_id, grade, teacher_id, room_id)
values (40, 4, 237, 23);
commit;
prompt 40 records loaded
prompt Loading SUBJECT...
insert into SUBJECT (subject_id, subject_name, mandatory)
values (1, ' Anatomy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (2, ' Astronomy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (3, ' Algebra', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (4, ' Band/Orchestra', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (5, ' Ballet', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (6, ' Bible Studies', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (7, ' Biology', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (8, ' Business and Entrepreneurship', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (9, ' Calculus', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (10, ' Career Exploration', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (11, ' Chemistry', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (12, ' Chorus', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (13, ' Civics and Government', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (14, ' Computer Science', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (15, ' Creative Writing', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (16, ' Dance', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (17, ' Digital Literacy', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (18, ' Drama', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (19, ' Economics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (20, ' Engineering Design', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (21, ' English Language Arts', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (22, ' Environmental Science', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (23, ' Film Studies', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (24, ' Foreign Language (French)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (25, ' Foreign Language (German)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (26, ' Foreign Language (Hebrew)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (27, ' Foreign Language (Spanish)', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (28, ' Geography', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (29, ' Health', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (30, ' Jewish History', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (31, ' Jewish Philosophy', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (32, ' Latin', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (33, ' Literature', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (34, ' Mathematics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (35, ' Media Literacy', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (36, ' Modern Art', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (37, ' Music', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (38, ' Mythology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (39, ' Physical Education', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (40, ' Physics', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (41, ' Psychology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (42, ' Robotics', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (43, ' Science (General)', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (44, ' Social Studies (General)', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (45, ' Sociology', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (46, ' Speech and Debate', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (47, ' Sports', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (48, ' Statistics', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (49, ' Talmud', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (50, ' United States History', 1);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (51, ' Visual Arts', 0);
insert into SUBJECT (subject_id, subject_name, mandatory)
values (52, ' World History', 1);
commit;
prompt 52 records loaded
prompt Loading LESSON...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (1, 3, 9, 18, 12, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (2, 3, 10, 1, 340, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (3, 1, 11, 36, 150, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (4, 4, 12, 14, 85, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (5, 4, 10, 6, 124, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (6, 5, 9, 16, 263, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (7, 3, 8, 2, 80, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (8, 5, 10, 2, 269, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (9, 4, 9, 18, 185, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (10, 6, 11, 10, 172, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (11, 3, 14, 17, 160, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (12, 5, 14, 1, 232, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (13, 1, 14, 22, 125, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (14, 3, 13, 6, 5, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (15, 1, 12, 5, 147, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (16, 5, 9, 8, 135, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (17, 5, 16, 10, 129, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (18, 3, 8, 34, 283, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (19, 1, 10, 27, 157, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (20, 6, 11, 16, 148, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (21, 3, 12, 28, 6, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (22, 4, 8, 15, 243, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (23, 5, 16, 37, 325, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (24, 2, 10, 13, 226, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (25, 2, 13, 26, 390, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (26, 5, 11, 35, 163, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (27, 2, 11, 1, 176, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (28, 1, 16, 4, 149, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (29, 4, 14, 15, 388, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (30, 2, 8, 26, 65, 6);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (31, 6, 13, 4, 70, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (32, 6, 11, 24, 305, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (33, 2, 13, 9, 88, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (34, 2, 15, 21, 344, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (35, 3, 9, 4, 41, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (36, 4, 10, 36, 184, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (37, 6, 12, 29, 90, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (38, 2, 11, 3, 318, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (39, 6, 11, 18, 211, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (40, 1, 14, 39, 48, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (41, 6, 12, 6, 304, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (42, 1, 12, 31, 39, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (43, 3, 15, 36, 270, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (44, 4, 15, 4, 150, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (45, 4, 12, 30, 342, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (46, 1, 15, 40, 360, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (47, 2, 8, 19, 27, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (48, 1, 12, 26, 374, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (49, 6, 8, 35, 367, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (50, 1, 14, 18, 5, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (51, 3, 13, 11, 316, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (52, 6, 14, 20, 45, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (53, 1, 10, 34, 131, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (54, 2, 10, 14, 34, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (55, 1, 13, 40, 50, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (56, 2, 12, 35, 210, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (57, 1, 8, 20, 52, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (58, 1, 12, 15, 237, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (59, 3, 10, 4, 128, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (60, 2, 8, 24, 331, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (61, 2, 13, 18, 268, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (62, 3, 8, 30, 76, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (63, 1, 14, 33, 180, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (64, 1, 13, 1, 270, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (65, 3, 8, 23, 117, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (66, 3, 15, 7, 81, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (67, 4, 14, 36, 238, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (68, 1, 16, 2, 138, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (69, 6, 13, 19, 183, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (70, 6, 16, 31, 137, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (71, 5, 14, 17, 343, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (72, 5, 13, 1, 266, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (73, 6, 13, 22, 354, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (74, 2, 12, 36, 370, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (75, 3, 8, 10, 369, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (76, 2, 11, 20, 80, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (77, 1, 10, 12, 238, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (78, 4, 13, 19, 41, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (79, 6, 10, 33, 61, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (80, 1, 10, 2, 338, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (81, 1, 14, 32, 372, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (82, 1, 13, 26, 396, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (83, 6, 13, 17, 179, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (84, 6, 14, 27, 102, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (85, 1, 11, 14, 376, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (86, 1, 8, 10, 256, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (87, 2, 11, 12, 151, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (88, 2, 11, 21, 317, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (89, 5, 13, 6, 300, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (90, 5, 12, 30, 94, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (91, 6, 13, 37, 116, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (92, 3, 16, 35, 355, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (93, 3, 16, 1, 287, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (94, 3, 13, 7, 400, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (96, 3, 13, 22, 7, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (97, 3, 16, 37, 222, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (98, 5, 16, 36, 260, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (99, 5, 9, 10, 6, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (100, 5, 8, 25, 284, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (101, 1, 10, 19, 296, 45);
commit;
prompt 100 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (102, 5, 13, 13, 169, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (103, 4, 11, 1, 273, 37);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (104, 5, 15, 18, 92, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (105, 3, 10, 31, 327, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (106, 4, 15, 2, 390, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (107, 5, 10, 26, 170, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (108, 4, 9, 34, 358, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (109, 5, 10, 29, 190, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (110, 1, 12, 32, 287, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (111, 1, 10, 4, 263, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (112, 6, 9, 34, 72, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (113, 5, 13, 32, 193, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (114, 3, 11, 9, 144, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (115, 3, 14, 36, 253, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (116, 4, 13, 8, 11, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (117, 6, 12, 22, 352, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (118, 3, 11, 26, 286, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (119, 1, 14, 3, 17, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (120, 6, 13, 34, 20, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (121, 6, 14, 13, 392, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (122, 1, 11, 39, 36, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (123, 3, 10, 10, 191, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (124, 6, 13, 28, 213, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (125, 2, 11, 27, 37, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (126, 5, 10, 23, 304, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (127, 2, 16, 35, 296, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (128, 6, 14, 28, 165, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (129, 3, 10, 18, 18, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (130, 6, 8, 32, 150, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (131, 6, 12, 10, 95, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (132, 3, 15, 32, 267, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (134, 1, 8, 17, 118, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (135, 6, 11, 6, 378, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (137, 5, 16, 29, 148, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (138, 1, 12, 10, 80, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (139, 6, 14, 37, 266, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (140, 2, 10, 27, 33, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (141, 3, 11, 1, 7, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (142, 4, 14, 21, 193, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (143, 5, 16, 25, 231, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (144, 6, 16, 8, 230, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (145, 4, 13, 34, 14, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (146, 1, 11, 1, 94, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (147, 4, 9, 26, 126, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (148, 6, 11, 31, 368, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (149, 5, 10, 30, 100, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (150, 3, 9, 34, 357, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (151, 6, 13, 16, 13, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (152, 5, 14, 24, 398, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (153, 5, 13, 24, 318, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (154, 1, 12, 24, 321, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (155, 5, 11, 19, 88, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (156, 3, 13, 36, 204, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (157, 1, 12, 17, 143, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (158, 1, 9, 36, 111, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (159, 1, 14, 14, 97, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (160, 1, 14, 29, 400, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (161, 5, 13, 21, 54, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (162, 5, 14, 39, 373, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (163, 4, 14, 7, 333, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (164, 6, 14, 14, 237, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (165, 6, 14, 25, 323, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (166, 5, 14, 22, 147, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (167, 3, 11, 24, 16, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (168, 1, 9, 9, 82, 21);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (169, 3, 9, 1, 71, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (171, 6, 16, 21, 131, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (172, 3, 8, 19, 54, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (173, 4, 8, 30, 129, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (174, 2, 11, 23, 307, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (175, 3, 14, 5, 344, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (176, 4, 12, 38, 71, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (177, 6, 10, 10, 147, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (178, 4, 8, 38, 47, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (179, 4, 15, 29, 69, 37);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (180, 4, 16, 24, 277, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (181, 1, 12, 13, 94, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (182, 5, 16, 1, 360, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (183, 4, 14, 12, 290, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (184, 6, 15, 30, 136, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (185, 1, 14, 8, 398, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (186, 6, 15, 29, 366, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (187, 2, 11, 26, 22, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (188, 4, 14, 8, 133, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (189, 4, 10, 32, 263, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (190, 5, 10, 20, 398, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (192, 5, 9, 24, 174, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (193, 4, 16, 32, 208, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (194, 5, 15, 27, 109, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (196, 1, 14, 15, 50, 6);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (197, 3, 15, 40, 184, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (198, 2, 15, 3, 72, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (199, 4, 11, 3, 326, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (200, 6, 9, 40, 216, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (201, 3, 13, 5, 285, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (202, 4, 14, 30, 176, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (203, 4, 14, 23, 121, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (204, 6, 10, 28, 81, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (205, 3, 12, 39, 30, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (206, 1, 9, 7, 239, 40);
commit;
prompt 200 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (207, 1, 13, 28, 161, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (208, 2, 14, 25, 258, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (209, 2, 13, 22, 237, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (211, 4, 14, 13, 233, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (212, 5, 10, 11, 147, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (213, 3, 11, 27, 39, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (214, 3, 16, 8, 239, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (216, 6, 13, 18, 326, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (217, 5, 8, 9, 86, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (218, 4, 16, 4, 343, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (219, 2, 16, 17, 290, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (221, 4, 14, 37, 283, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (223, 4, 9, 20, 128, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (224, 2, 8, 39, 355, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (225, 6, 13, 9, 91, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (226, 1, 9, 8, 293, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (227, 5, 10, 14, 381, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (229, 1, 8, 3, 359, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (230, 1, 10, 5, 169, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (231, 1, 10, 6, 229, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (232, 3, 15, 1, 299, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (234, 1, 15, 38, 325, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (235, 3, 9, 33, 273, 9);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (236, 5, 9, 31, 77, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (237, 4, 14, 11, 211, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (238, 6, 16, 35, 249, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (239, 6, 9, 33, 23, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (240, 5, 8, 22, 64, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (241, 3, 16, 23, 60, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (242, 1, 8, 13, 351, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (243, 3, 12, 31, 249, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (244, 2, 8, 36, 94, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (245, 4, 9, 7, 70, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (246, 6, 11, 7, 397, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (247, 4, 15, 9, 384, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (248, 1, 13, 4, 66, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (249, 1, 8, 19, 365, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (250, 5, 13, 40, 378, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (251, 4, 10, 5, 69, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (252, 2, 16, 28, 154, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (253, 5, 9, 13, 322, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (254, 2, 12, 16, 12, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (255, 1, 8, 27, 41, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (257, 4, 13, 40, 243, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (258, 2, 11, 35, 18, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (259, 3, 12, 32, 55, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (262, 5, 14, 29, 366, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (263, 4, 11, 12, 27, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (264, 6, 10, 19, 334, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (265, 6, 13, 6, 383, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (266, 6, 8, 2, 30, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (267, 2, 15, 25, 306, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (268, 1, 11, 2, 312, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (269, 4, 11, 29, 208, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (270, 4, 15, 22, 59, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (271, 1, 13, 16, 253, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (272, 6, 12, 26, 165, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (273, 6, 8, 15, 322, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (274, 6, 11, 1, 286, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (275, 6, 14, 23, 32, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (276, 2, 16, 1, 340, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (277, 2, 12, 10, 355, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (278, 2, 8, 25, 93, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (279, 1, 8, 29, 206, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (280, 5, 14, 10, 59, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (281, 5, 14, 21, 149, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (282, 1, 13, 12, 156, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (283, 2, 13, 28, 218, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (285, 1, 8, 6, 329, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (286, 6, 10, 39, 177, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (287, 2, 14, 36, 176, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (288, 3, 15, 15, 42, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (290, 2, 12, 7, 131, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (291, 1, 10, 20, 8, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (292, 1, 14, 31, 305, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (293, 4, 15, 39, 291, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (295, 5, 12, 37, 203, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (296, 4, 16, 33, 326, 10);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (297, 2, 16, 31, 298, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (298, 4, 15, 38, 254, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (299, 4, 13, 1, 19, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (300, 2, 16, 33, 164, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (301, 3, 14, 38, 185, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (302, 2, 8, 18, 43, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (303, 6, 11, 29, 353, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (304, 6, 15, 24, 246, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (305, 3, 10, 12, 262, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (306, 4, 13, 13, 191, 4);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (307, 2, 13, 13, 177, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (308, 5, 11, 25, 13, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (309, 6, 16, 12, 291, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (310, 5, 12, 1, 241, 11);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (313, 1, 9, 29, 285, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (314, 3, 14, 18, 118, 14);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (315, 4, 15, 30, 78, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (316, 2, 16, 5, 42, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (317, 4, 10, 39, 88, 24);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (318, 3, 15, 14, 100, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (319, 5, 9, 15, 326, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (320, 6, 10, 9, 315, 17);
commit;
prompt 300 records committed...
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (321, 6, 15, 27, 178, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (322, 6, 10, 25, 37, 30);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (323, 4, 13, 16, 275, 13);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (324, 4, 14, 16, 179, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (325, 3, 10, 5, 244, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (326, 1, 14, 25, 267, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (327, 2, 8, 10, 222, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (328, 4, 10, 27, 290, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (330, 2, 10, 4, 316, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (331, 5, 13, 27, 93, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (332, 4, 8, 16, 116, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (333, 5, 16, 3, 140, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (334, 3, 11, 3, 33, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (335, 5, 10, 17, 209, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (336, 5, 12, 31, 197, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (337, 6, 12, 39, 50, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (338, 5, 12, 24, 251, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (339, 4, 12, 33, 359, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (340, 3, 15, 5, 348, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (341, 2, 11, 31, 110, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (342, 3, 10, 26, 211, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (343, 5, 11, 23, 167, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (344, 1, 16, 18, 55, 35);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (345, 4, 11, 7, 350, 12);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (347, 6, 8, 20, 269, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (349, 5, 11, 38, 8, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (350, 3, 12, 19, 41, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (351, 6, 8, 29, 267, 32);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (352, 1, 16, 10, 130, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (353, 6, 9, 13, 100, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (356, 4, 9, 2, 372, 8);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (357, 3, 13, 28, 105, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (359, 5, 11, 17, 129, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (362, 1, 16, 25, 289, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (363, 2, 11, 36, 90, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (364, 2, 14, 38, 156, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (365, 6, 14, 29, 300, 37);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (367, 4, 14, 24, 87, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (368, 2, 9, 9, 114, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (369, 2, 13, 11, 385, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (370, 1, 12, 8, 3, 33);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (371, 6, 10, 37, 136, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (372, 1, 13, 18, 285, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (373, 5, 8, 6, 71, 43);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (374, 2, 11, 28, 232, 2);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (375, 2, 9, 28, 198, 19);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (376, 3, 10, 27, 296, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (378, 4, 9, 36, 136, 25);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (379, 2, 12, 33, 295, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (380, 5, 15, 23, 58, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (381, 6, 16, 29, 336, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (383, 3, 13, 39, 156, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (384, 4, 10, 25, 186, 7);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (386, 4, 9, 19, 28, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (387, 1, 12, 12, 101, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (388, 2, 10, 26, 178, 17);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (390, 3, 15, 9, 341, 28);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (391, 5, 15, 20, 150, 44);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (395, 4, 13, 25, 53, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (396, 6, 16, 28, 180, 45);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (397, 6, 11, 3, 325, 36);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (398, 4, 8, 14, 239, 1);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (399, 5, 12, 26, 234, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (400, 2, 15, 30, 298, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (401, 6, 13, 14, 100, 16);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (402, 6, 10, 24, 343, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (404, 5, 16, 38, 72, 20);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (406, 2, 15, 4, 185, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (409, 1, 11, 7, 232, 27);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (410, 2, 9, 1, 53, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (411, 5, 8, 11, 139, 18);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (412, 2, 10, 36, 212, 40);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (414, 6, 8, 19, 298, 47);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (415, 4, 11, 19, 130, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (416, 4, 9, 8, 189, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (418, 3, 16, 12, 102, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (419, 1, 8, 36, 337, 49);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (420, 2, 14, 20, 197, 23);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (422, 5, 11, 12, 366, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (423, 3, 14, 16, 295, 46);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (424, 6, 13, 27, 239, 51);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (425, 1, 15, 25, 332, 29);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (426, 6, 13, 32, 52, 31);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (427, 6, 12, 18, 107, 10);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (428, 6, 10, 29, 389, 26);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (432, 1, 12, 33, 60, 50);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (433, 4, 11, 23, 159, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (434, 4, 12, 15, 322, 48);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (435, 1, 15, 15, 110, 39);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (436, 2, 16, 16, 62, 22);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (437, 2, 11, 16, 20, 3);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (439, 1, 9, 25, 247, 34);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (440, 2, 12, 9, 111, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (442, 3, 13, 21, 278, 52);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (443, 3, 15, 38, 266, 42);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (444, 4, 16, 18, 167, 41);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (446, 6, 10, 36, 15, 5);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (448, 2, 10, 23, 51, 15);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (449, 3, 11, 10, 73, 38);
insert into LESSON (lesson_id, lesson_day, lesson_hour, class_id, teacher_id, subject_id)
values (450, 1, 15, 8, 350, 30);
commit;
prompt 400 records loaded
prompt Loading STUDENT...
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (1, 'Alexandra', 'Wright', to_date('11-10-2011', 'dd-mm-yyyy'), 541868000, 'Derek', 'Deborah', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (2, 'Mia', 'Walker', to_date('28-06-2024', 'dd-mm-yyyy'), 511009005, 'Antonio', 'Kelly', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (3, 'Cameron', 'Diaz', to_date('08-05-2008', 'dd-mm-yyyy'), 540884427, 'Lucas', 'Samantha', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (4, 'Karen', 'Clark', to_date('03-04-2017', 'dd-mm-yyyy'), 543497247, 'Charles', 'Cheryl', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (5, 'Sarah', 'Harris', to_date('30-12-2017', 'dd-mm-yyyy'), 575968929, 'Douglas', 'Brenda', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (6, 'Stephanie', 'Green', to_date('20-08-2022', 'dd-mm-yyyy'), 520369940, 'Tyler', 'Charlene', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (7, 'Theodore', 'Evans', to_date('09-10-2011', 'dd-mm-yyyy'), 581154956, 'Henry', 'Jennifer', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (8, 'Mia', 'Mitchell', to_date('05-12-2018', 'dd-mm-yyyy'), 543150699, 'Adrian', 'Kristen', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (9, 'Daniel', 'Thomas', to_date('22-09-2005', 'dd-mm-yyyy'), 545467347, 'Joseph', 'Patricia', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (10, 'Susan', 'Anderson', to_date('13-04-2014', 'dd-mm-yyyy'), 556407681, 'Adam', 'Lucia', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (11, 'Nathan', 'Thomas', to_date('04-01-2022', 'dd-mm-yyyy'), 569477971, 'Edward', 'Lauren', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (12, 'Keith', 'Roberts', to_date('16-04-2012', 'dd-mm-yyyy'), 580489883, 'Patrick', 'Janet', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (13, 'David', 'Rodriguez', to_date('16-05-2018', 'dd-mm-yyyy'), 551793120, 'George', 'Angela', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (14, 'Victoria', 'Smith', to_date('22-09-2006', 'dd-mm-yyyy'), 583976968, 'Travis', 'Pamela', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (15, 'Charlene', 'Hernandez', to_date('10-01-2015', 'dd-mm-yyyy'), 593016420, 'Justin', 'Helena', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (16, 'Roy', 'Moore', to_date('02-11-2014', 'dd-mm-yyyy'), 544552372, 'Ethan', 'Mia', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (17, 'Abigail', 'Hernandez', to_date('23-12-2012', 'dd-mm-yyyy'), 546531441, 'Eric', 'Stephanie', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (18, 'Andrew', 'Clark', to_date('18-08-2005', 'dd-mm-yyyy'), 550254262, 'Diego', 'Phoebe', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (19, 'Caroline', 'Anderson', to_date('13-05-2006', 'dd-mm-yyyy'), 557114103, 'Walter', 'Phoebe', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (20, 'Isaiah', 'Nelson', to_date('11-11-2017', 'dd-mm-yyyy'), 519345594, 'Ronald', 'Lisa', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (21, 'Victoria', 'Clark', to_date('02-11-2021', 'dd-mm-yyyy'), 519974702, 'Charles', 'Katherine', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (22, 'Robert', 'Allen', to_date('10-11-2020', 'dd-mm-yyyy'), 564036725, 'William', 'Allison', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (23, 'William', 'Walker', to_date('22-07-2023', 'dd-mm-yyyy'), 584296492, 'Owen', 'Alexandra', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (24, 'Helena', 'Young', to_date('11-05-2022', 'dd-mm-yyyy'), 542408698, 'Diego', 'Carla', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (25, 'Sebastian', 'Rogers', to_date('09-02-2011', 'dd-mm-yyyy'), 535170706, 'Paul', 'Brenda', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (26, 'William', 'Diaz', to_date('07-04-2022', 'dd-mm-yyyy'), 512806148, 'Robert', 'Claudia', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (27, 'Karen', 'Wilson', to_date('16-01-2023', 'dd-mm-yyyy'), 550563551, 'Lawrence', 'Margaret', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (28, 'Philip', 'Wright', to_date('11-10-2015', 'dd-mm-yyyy'), 579950551, 'Richard', 'Agnes', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (29, 'Stephanie', 'Garcia', to_date('10-01-2008', 'dd-mm-yyyy'), 590374515, 'Austin', 'Abigail', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (30, 'Luna', 'Cruz', to_date('25-04-2015', 'dd-mm-yyyy'), 527902077, 'Eric', 'Natalie', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (31, 'Sebastian', 'Moore', to_date('11-02-2007', 'dd-mm-yyyy'), 526383220, 'Walter', 'Alicia', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (32, 'Louise', 'Adams', to_date('04-04-2020', 'dd-mm-yyyy'), 568031016, 'Walter', 'Sarah', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (33, 'Penelope', 'Clark', to_date('17-05-2023', 'dd-mm-yyyy'), 587722574, 'Douglas', 'Courtney', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (34, 'Teresa', 'Jones', to_date('27-07-2008', 'dd-mm-yyyy'), 520755116, 'Derek', 'Helena', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (35, 'Evelyn', 'Jones', to_date('06-09-2009', 'dd-mm-yyyy'), 564431584, 'Zachary', 'Penelope', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (36, 'Stephanie', 'Hernandez', to_date('04-07-2013', 'dd-mm-yyyy'), 560034458, 'Shannon', 'Alexandra', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (37, 'Shirley', 'Nguyen', to_date('15-01-2008', 'dd-mm-yyyy'), 511851887, 'Gregory', 'Danielle', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (38, 'Isaac', 'Mitchell', to_date('10-12-2021', 'dd-mm-yyyy'), 511229004, 'Cole', 'Katherine', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (39, 'Timothy', 'Young', to_date('06-07-2014', 'dd-mm-yyyy'), 556653152, 'Christopher', 'Maria', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (40, 'Jacob', 'Nguyen', to_date('05-01-2007', 'dd-mm-yyyy'), 551354560, 'Richard', 'Linda', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (41, 'Patricia', 'Walker', to_date('20-12-2021', 'dd-mm-yyyy'), 537645707, 'Ryan', 'Rebecca', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (42, 'Heather', 'Robinson', to_date('06-08-2008', 'dd-mm-yyyy'), 565140285, 'Eric', 'Tiffany', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (43, 'Charles', 'Wilson', to_date('29-11-2005', 'dd-mm-yyyy'), 553151314, 'Juan', 'Nancy', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (44, 'Keith', 'Nelson', to_date('06-11-2020', 'dd-mm-yyyy'), 573970189, 'Daniel', 'Sophia', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (45, 'Vincent', 'Lee', to_date('03-04-2011', 'dd-mm-yyyy'), 543636551, 'Sebastian', 'Monica', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (46, 'Paul', 'Allen', to_date('08-02-2019', 'dd-mm-yyyy'), 533173413, 'Adrian', 'Sharon', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (47, 'Margaret', 'Young', to_date('21-10-2016', 'dd-mm-yyyy'), 535175866, 'Andrew', 'Lydia', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (48, 'Gabriella', 'Jones', to_date('23-09-2024', 'dd-mm-yyyy'), 567373285, 'Gabriel', 'Carla', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (49, 'Travis', 'Lewis', to_date('09-02-2023', 'dd-mm-yyyy'), 574609405, 'Cole', 'Pamela', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (50, 'Sebastian', 'Scott', to_date('01-07-2014', 'dd-mm-yyyy'), 595869513, 'Dylan', 'Brittany', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (51, 'Nicholas', 'Robinson', to_date('06-12-2023', 'dd-mm-yyyy'), 568053726, 'Joshua', 'Claire', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (52, 'Brian', 'Taylor', to_date('15-03-2011', 'dd-mm-yyyy'), 550109206, 'Cole', 'Rachel', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (53, 'Courtney', 'Clark', to_date('21-03-2009', 'dd-mm-yyyy'), 539075311, 'George', 'Audrey', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (54, 'Cody', 'Campbell', to_date('21-09-2010', 'dd-mm-yyyy'), 589785335, 'Albert', 'Stephanie', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (55, 'Leslie', 'Miller', to_date('07-07-2013', 'dd-mm-yyyy'), 561934338, 'Isaac', 'Danielle', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (56, 'Ryan', 'Nelson', to_date('20-01-2005', 'dd-mm-yyyy'), 516240171, 'Cody', 'Alexis', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (57, 'Zachary', 'Garcia', to_date('13-12-2014', 'dd-mm-yyyy'), 597518023, 'Cody', 'Kelly', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (58, 'Jennifer', 'Lopez', to_date('19-10-2011', 'dd-mm-yyyy'), 562958849, 'Jayden', 'Sarah', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (59, 'Eric', 'Allen', to_date('20-05-2022', 'dd-mm-yyyy'), 529111519, 'Douglas', 'Zoe', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (60, 'Jayden', 'Hernandez', to_date('16-01-2016', 'dd-mm-yyyy'), 578572076, 'Harold', 'Claudia', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (61, 'Scott', 'Hall', to_date('13-12-2011', 'dd-mm-yyyy'), 549987298, 'Gabriel', 'Hannah', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (62, 'Linda', 'Green', to_date('07-03-2020', 'dd-mm-yyyy'), 598905001, 'Theodore', 'Sophia', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (63, 'Julian', 'Nguyen', to_date('04-10-2014', 'dd-mm-yyyy'), 547002676, 'Ezekiel', 'Amanda', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (64, 'Rose', 'Davis', to_date('23-08-2018', 'dd-mm-yyyy'), 529432685, 'Nathaniel', 'Taylor', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (65, 'Anthony', 'Moore', to_date('12-10-2017', 'dd-mm-yyyy'), 580891495, 'William', 'Penelope', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (66, 'Shirley', 'Nelson', to_date('14-03-2011', 'dd-mm-yyyy'), 534178182, 'Abraham', 'Jasmine', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (67, 'Laura', 'Wilson', to_date('02-12-2011', 'dd-mm-yyyy'), 537788912, 'Adam', 'Charlotte', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (68, 'Courtney', 'Rodriguez', to_date('23-03-2006', 'dd-mm-yyyy'), 548752704, 'Jacob', 'Sophia', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (69, 'Scott', 'Johnson', to_date('19-03-2023', 'dd-mm-yyyy'), 527648184, 'Justin', 'Danielle', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (70, 'Julian', 'Nelson', to_date('03-02-2023', 'dd-mm-yyyy'), 575692887, 'Benjamin', 'Katherine', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (71, 'Nathan', 'Anderson', to_date('13-09-2009', 'dd-mm-yyyy'), 556710704, 'Vincent', 'Jennifer', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (72, 'Edward', 'Robinson', to_date('28-03-2014', 'dd-mm-yyyy'), 551852535, 'Antonio', 'Maya', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (73, 'Gregory', 'Rodriguez', to_date('08-09-2008', 'dd-mm-yyyy'), 553872224, 'Adam', 'Lucy', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (74, 'Nicole', 'Moore', to_date('19-04-2008', 'dd-mm-yyyy'), 583140414, 'Felipe', 'Claire', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (75, 'Victoria', 'Clark', to_date('16-08-2018', 'dd-mm-yyyy'), 570950356, 'Adam', 'Alexis', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (76, 'Xavier', 'Scott', to_date('06-08-2011', 'dd-mm-yyyy'), 594596575, 'John', 'Leslie', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (77, 'Martha', 'Hernandez', to_date('29-04-2011', 'dd-mm-yyyy'), 595223556, 'Eric', 'Reagan', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (78, 'Susan', 'Brown', to_date('03-12-2016', 'dd-mm-yyyy'), 528048939, 'Thomas', 'Agnes', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (79, 'Derek', 'Walker', to_date('24-08-2013', 'dd-mm-yyyy'), 576353114, 'Samuel', 'Mia', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (80, 'Nancy', 'Garcia', to_date('04-04-2023', 'dd-mm-yyyy'), 514964671, 'Philip', 'Bridget', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (81, 'Xavier', 'Thomas', to_date('19-08-2020', 'dd-mm-yyyy'), 595425197, 'Nathaniel', 'Phoebe', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (82, 'Shirley', 'Garcia', to_date('17-05-2023', 'dd-mm-yyyy'), 568159553, 'Daniel', 'Allison', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (83, 'Lily', 'Rodriguez', to_date('03-06-2019', 'dd-mm-yyyy'), 535581157, 'Nathan', 'Louise', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (84, 'Jordan', 'Jones', to_date('12-11-2019', 'dd-mm-yyyy'), 521968258, 'Lucas', 'Stephanie', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (85, 'Lisa', 'Wright', to_date('17-10-2006', 'dd-mm-yyyy'), 597321822, 'Albert', 'Alice', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (86, 'Derek', 'Miller', to_date('25-12-2013', 'dd-mm-yyyy'), 525424277, 'Joshua', 'Jasmine', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (87, 'Linda', 'Lewis', to_date('20-09-2012', 'dd-mm-yyyy'), 566196455, 'Owen', 'Victoria', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (88, 'Kelly', 'Roberts', to_date('04-10-2006', 'dd-mm-yyyy'), 581748972, 'Edward', 'Diana', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (89, 'Ava', 'Williams', to_date('02-08-2013', 'dd-mm-yyyy'), 596273809, 'Nicholas', 'Abigail', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (90, 'Louise', 'Robinson', to_date('16-10-2011', 'dd-mm-yyyy'), 542101305, 'Ronald', 'Heather', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (91, 'Gabriel', 'Hernandez', to_date('29-06-2007', 'dd-mm-yyyy'), 519866412, 'Dennis', 'Caroline', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (92, 'Claire', 'Jones', to_date('09-12-2011', 'dd-mm-yyyy'), 549141214, 'Cameron', 'Louise', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (93, 'Victoria', 'Evans', to_date('01-11-2017', 'dd-mm-yyyy'), 557330759, 'Owen', 'Rose', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (94, 'Margaret', 'Clark', to_date('17-09-2012', 'dd-mm-yyyy'), 571413868, 'Walter', 'Jade', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (95, 'Keith', 'Lewis', to_date('14-04-2021', 'dd-mm-yyyy'), 572883987, 'Travis', 'Samantha', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (96, 'Zachary', 'Hernandez', to_date('18-03-2019', 'dd-mm-yyyy'), 567029538, 'Eric', 'Teresa', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (97, 'Lisa', 'Green', to_date('28-04-2008', 'dd-mm-yyyy'), 557527598, 'Ezekiel', 'Jacqueline', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (98, 'Derek', 'Nelson', to_date('15-03-2011', 'dd-mm-yyyy'), 538919598, 'Cameron', 'Charlotte', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (99, 'Julia', 'Jones', to_date('28-10-2012', 'dd-mm-yyyy'), 535976064, 'Gabriel', 'Samantha', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (100, 'Ruby', 'Allen', to_date('02-01-2016', 'dd-mm-yyyy'), 518985766, 'Jonathan', 'Nancy', 27);
commit;
prompt 100 records committed...
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (101, 'Leah', 'Young', to_date('04-05-2020', 'dd-mm-yyyy'), 562650556, 'Nicholas', 'Hayley', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (102, 'Nicholas', 'Garcia', to_date('29-01-2009', 'dd-mm-yyyy'), 527767652, 'Derek', 'Linda', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (103, 'Charlene', 'Garcia', to_date('18-06-2024', 'dd-mm-yyyy'), 550657707, 'Zachary', 'Rebecca', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (104, 'Heather', 'Roberts', to_date('17-03-2008', 'dd-mm-yyyy'), 585481271, 'Jesse', 'Madison', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (105, 'Thomas', 'Robinson', to_date('26-01-2018', 'dd-mm-yyyy'), 560259224, 'Theodore', 'Hayley', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (106, 'Anthony', 'Hernandez', to_date('24-10-2008', 'dd-mm-yyyy'), 578863284, 'Christopher', 'Sandra', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (107, 'Laura', 'Taylor', to_date('03-04-2012', 'dd-mm-yyyy'), 527134416, 'Zachary', 'Alana', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (108, 'Stephanie', 'Cruz', to_date('03-01-2007', 'dd-mm-yyyy'), 560920589, 'Luke', 'Peyton', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (109, 'Rebecca', 'Evans', to_date('23-02-2009', 'dd-mm-yyyy'), 591609320, 'Jacob', 'Audrey', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (110, 'Carlos', 'Robinson', to_date('23-03-2013', 'dd-mm-yyyy'), 592407738, 'Douglas', 'Sarah', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (111, 'Karen', 'Wright', to_date('26-07-2020', 'dd-mm-yyyy'), 511030643, 'Charles', 'Maria', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (112, 'Diego', 'Clark', to_date('03-05-2022', 'dd-mm-yyyy'), 556632054, 'Javier', 'Ashley', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (113, 'Rose', 'Green', to_date('10-11-2014', 'dd-mm-yyyy'), 547970151, 'Jacob', 'Jasmine', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (114, 'Cole', 'Mitchell', to_date('18-04-2014', 'dd-mm-yyyy'), 560826081, 'Brandon', 'Carla', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (115, 'Lillian', 'Lewis', to_date('27-06-2010', 'dd-mm-yyyy'), 585744067, 'Sebastian', 'Tiffany', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (116, 'Dustin', 'Lewis', to_date('24-06-2006', 'dd-mm-yyyy'), 575952384, 'George', 'Rachel', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (117, 'Isaac', 'Watson', to_date('07-06-2006', 'dd-mm-yyyy'), 536388836, 'Julian', 'Madison', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (118, 'Aaron', 'Lee', to_date('11-10-2015', 'dd-mm-yyyy'), 515240356, 'Julian', 'Cheryl', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (119, 'Amelia', 'Allen', to_date('03-01-2007', 'dd-mm-yyyy'), 590409951, 'Wesley', 'Nancy', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (120, 'Julian', 'Young', to_date('18-01-2014', 'dd-mm-yyyy'), 573074366, 'Dennis', 'Kelly', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (121, 'Joan', 'Miller', to_date('02-08-2012', 'dd-mm-yyyy'), 549667298, 'Sean', 'Penelope', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (122, 'Charlotte', 'Robinson', to_date('20-01-2023', 'dd-mm-yyyy'), 598839038, 'Wyatt', 'Margaret', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (123, 'Tyler', 'Young', to_date('17-03-2013', 'dd-mm-yyyy'), 579075642, 'Andrew', 'Amanda', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (124, 'Daniel', 'Taylor', to_date('08-07-2011', 'dd-mm-yyyy'), 520503461, 'Ryan', 'Bridget', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (125, 'Brandon', 'Nelson', to_date('05-01-2018', 'dd-mm-yyyy'), 525521038, 'Noah', 'Luna', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (126, 'Harold', 'Miller', to_date('19-02-2010', 'dd-mm-yyyy'), 548679916, 'Caleb', 'Michelle', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (127, 'Charles', 'Hernandez', to_date('02-07-2005', 'dd-mm-yyyy'), 523482174, 'Jacob', 'Angela', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (128, 'Louise', 'Hernandez', to_date('14-07-2022', 'dd-mm-yyyy'), 535225245, 'Trevor', 'Joan', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (129, 'Jonathan', 'Williams', to_date('29-11-2009', 'dd-mm-yyyy'), 544438996, 'Brian', 'Kristen', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (130, 'Mia', 'Moore', to_date('25-09-2023', 'dd-mm-yyyy'), 529091375, 'Brandon', 'Tiffany', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (131, 'Theodore', 'Lopez', to_date('14-08-2009', 'dd-mm-yyyy'), 538078090, 'Wyatt', 'Alicia', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (132, 'Faith', 'Thomas', to_date('02-09-2017', 'dd-mm-yyyy'), 529068539, 'Brian', 'Evelyn', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (133, 'Gabriel', 'Sanchez', to_date('30-07-2006', 'dd-mm-yyyy'), 544371226, 'Owen', 'Laura', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (134, 'Kelly', 'Mitchell', to_date('05-04-2022', 'dd-mm-yyyy'), 557712651, 'Chad', 'Vivian', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (135, 'Leonardo', 'Robinson', to_date('08-06-2005', 'dd-mm-yyyy'), 593911753, 'Cole', 'Shirley', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (136, 'Kevin', 'Nguyen', to_date('10-10-2009', 'dd-mm-yyyy'), 540228165, 'Sebastian', 'Luna', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (137, 'Daniel', 'Campbell', to_date('22-10-2015', 'dd-mm-yyyy'), 559233457, 'Jack', 'Leah', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (138, 'Joshua', 'Rodriguez', to_date('12-06-2013', 'dd-mm-yyyy'), 520986276, 'Adrian', 'Teresa', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (139, 'Maya', 'Lopez', to_date('13-08-2017', 'dd-mm-yyyy'), 593777356, 'Javier', 'Amelia', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (140, 'Oliver', 'Robinson', to_date('12-04-2013', 'dd-mm-yyyy'), 512288694, 'Eric', 'Charlotte', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (141, 'Maya', 'Scott', to_date('22-11-2013', 'dd-mm-yyyy'), 566859396, 'Joan', 'Lily', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (142, 'Kristen', 'Allen', to_date('14-01-2009', 'dd-mm-yyyy'), 581300682, 'Walter', 'Cheryl', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (143, 'Antonio', 'Garcia', to_date('06-02-2009', 'dd-mm-yyyy'), 581545388, 'Javier', 'Luna', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (144, 'Jordan', 'Lee', to_date('19-06-2007', 'dd-mm-yyyy'), 581474390, 'Leonardo', 'Ruby', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (145, 'Cole', 'Walker', to_date('21-01-2016', 'dd-mm-yyyy'), 588083016, 'Nathaniel', 'Ruby', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (146, 'Kristen', 'Lewis', to_date('23-06-2010', 'dd-mm-yyyy'), 540713170, 'Lawrence', 'Tiffany', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (147, 'Danielle', 'Thompson', to_date('19-03-2012', 'dd-mm-yyyy'), 533784253, 'Scott', 'Phoebe', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (148, 'Tyler', 'Campbell', to_date('03-10-2021', 'dd-mm-yyyy'), 546755004, 'Sebastian', 'Patricia', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (149, 'Stephen', 'Clark', to_date('17-11-2019', 'dd-mm-yyyy'), 525154600, 'Henry', 'Faith', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (150, 'George', 'Robinson', to_date('21-03-2017', 'dd-mm-yyyy'), 519904369, 'Ryan', 'Natalie', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (151, 'Stephen', 'Garcia', to_date('09-09-2006', 'dd-mm-yyyy'), 512127328, 'Joseph', 'Catherine', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (152, 'Wyatt', 'Rodriguez', to_date('22-11-2021', 'dd-mm-yyyy'), 526254691, 'Jayden', 'Alice', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (153, 'Edward', 'Williams', to_date('22-02-2010', 'dd-mm-yyyy'), 587317546, 'Owen', 'Ashley', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (154, 'Cameron', 'Allen', to_date('27-07-2022', 'dd-mm-yyyy'), 587599624, 'Caleb', 'Sharon', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (155, 'Scott', 'Phillips', to_date('06-03-2012', 'dd-mm-yyyy'), 553261420, 'Dennis', 'Natalie', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (156, 'Meghan', 'Adams', to_date('16-07-2023', 'dd-mm-yyyy'), 597337543, 'Henry', 'Jessica', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (157, 'Jacob', 'Mitchell', to_date('15-06-2017', 'dd-mm-yyyy'), 583258534, 'Edward', 'Rachel', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (158, 'Nancy', 'Allen', to_date('12-06-2024', 'dd-mm-yyyy'), 582623149, 'Gregory', 'Kelly', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (159, 'Jane', 'Smith', to_date('10-06-2023', 'dd-mm-yyyy'), 595555040, 'Adrian', 'Leslie', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (160, 'Shannon', 'Lopez', to_date('12-09-2019', 'dd-mm-yyyy'), 556205812, 'Abraham', 'Claudia', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (161, 'Dustin', 'Phillips', to_date('13-05-2016', 'dd-mm-yyyy'), 532238015, 'Brandon', 'Bridget', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (162, 'Kevin', 'Johnson', to_date('13-12-2011', 'dd-mm-yyyy'), 554258249, 'Brandon', 'Bethany', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (163, 'Dennis', 'Phillips', to_date('12-05-2019', 'dd-mm-yyyy'), 586175621, 'Jonathan', 'Maria', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (164, 'Ethan', 'Nelson', to_date('05-09-2011', 'dd-mm-yyyy'), 524915863, 'Jordan', 'Lillian', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (165, 'Claudia', 'Hernandez', to_date('25-11-2013', 'dd-mm-yyyy'), 571192317, 'David', 'Kayla', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (166, 'Lucy', 'Hernandez', to_date('03-09-2009', 'dd-mm-yyyy'), 536027980, 'Lawrence', 'Jacqueline', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (167, 'Ezekiel', 'Cruz', to_date('12-07-2016', 'dd-mm-yyyy'), 564088981, 'Cody', 'Monica', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (168, 'Molly', 'Nguyen', to_date('16-09-2017', 'dd-mm-yyyy'), 527248992, 'Isaiah', 'Linda', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (169, 'Sarah', 'Moore', to_date('05-08-2013', 'dd-mm-yyyy'), 521561956, 'Paul', 'Angela', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (170, 'Lily', 'Scott', to_date('26-11-2020', 'dd-mm-yyyy'), 592329065, 'Dylan', 'Michelle', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (171, 'Leonardo', 'Rodriguez', to_date('17-06-2009', 'dd-mm-yyyy'), 566240465, 'Jayden', 'Julia', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (172, 'Lydia', 'Garcia', to_date('14-12-2021', 'dd-mm-yyyy'), 550430876, 'Lucas', 'Olivia', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (173, 'Adrian', 'Hernandez', to_date('12-06-2007', 'dd-mm-yyyy'), 556958612, 'Timothy', 'Meghan', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (174, 'Alan', 'Anderson', to_date('18-12-2011', 'dd-mm-yyyy'), 536787238, 'Nathan', 'Peyton', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (175, 'Hayley', 'Nguyen', to_date('04-10-2020', 'dd-mm-yyyy'), 535957359, 'Aaron', 'Mia', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (176, 'Jennifer', 'Williams', to_date('04-11-2013', 'dd-mm-yyyy'), 523974313, 'Trevor', 'Kayla', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (177, 'Fiona', 'Roy', to_date('06-09-2017', 'dd-mm-yyyy'), 552456511, 'Tyler', 'Lisa', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (178, 'Isaiah', 'Clark', to_date('12-08-2009', 'dd-mm-yyyy'), 516199108, 'Luke', 'Helena', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (179, 'Gregory', 'Phillips', to_date('08-12-2012', 'dd-mm-yyyy'), 523459118, 'Anthony', 'Susan', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (180, 'Evelyn', 'Campbell', to_date('25-12-2021', 'dd-mm-yyyy'), 593426838, 'Leonardo', 'Michelle', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (181, 'Patricia', 'Nguyen', to_date('01-01-2022', 'dd-mm-yyyy'), 512487682, 'Thomas', 'Sharon', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (182, 'Jane', 'Adams', to_date('22-06-2016', 'dd-mm-yyyy'), 564875750, 'Zachary', 'Lauren', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (183, 'Rachel', 'Garcia', to_date('08-12-2023', 'dd-mm-yyyy'), 536891277, 'Keith', 'Lydia', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (184, 'Stephanie', 'Robinson', to_date('21-11-2023', 'dd-mm-yyyy'), 583494415, 'Jesse', 'Fiona', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (185, 'Charlene', 'Allen', to_date('20-01-2014', 'dd-mm-yyyy'), 527430235, 'Isaiah', 'Abigail', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (186, 'Jayden', 'Johnson', to_date('14-07-2018', 'dd-mm-yyyy'), 513756226, 'Roy', 'Karen', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (187, 'Cameron', 'Garcia', to_date('08-12-2018', 'dd-mm-yyyy'), 534191331, 'Richard', 'Karen', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (188, 'Cameron', 'Thompson', to_date('20-07-2017', 'dd-mm-yyyy'), 545599978, 'Tyler', 'Ava', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (189, 'Sebastian', 'Nguyen', to_date('19-01-2021', 'dd-mm-yyyy'), 553479042, 'Juan', 'Janet', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (190, 'Ethan', 'Green', to_date('26-07-2018', 'dd-mm-yyyy'), 572232907, 'Douglas', 'Patricia', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (191, 'Hannah', 'Garcia', to_date('28-03-2021', 'dd-mm-yyyy'), 518558811, 'William', 'Sheila', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (192, 'Walter', 'Lewis', to_date('05-02-2011', 'dd-mm-yyyy'), 584016953, 'Philip', 'Brittany', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (193, 'Vincent', 'Garcia', to_date('02-09-2014', 'dd-mm-yyyy'), 520457401, 'Xavier', 'Diana', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (194, 'Noah', 'Wright', to_date('29-08-2023', 'dd-mm-yyyy'), 560591272, 'Roy', 'Kayla', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (195, 'Angela', 'Allen', to_date('14-05-2024', 'dd-mm-yyyy'), 537415927, 'Henry', 'Jillian', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (196, 'Miguel', 'Lopez', to_date('15-01-2010', 'dd-mm-yyyy'), 581739043, 'Vincent', 'Samantha', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (197, 'Ashley', 'Johnson', to_date('06-03-2009', 'dd-mm-yyyy'), 532919123, 'Antonio', 'Bridget', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (198, 'Diego', 'Garcia', to_date('04-02-2023', 'dd-mm-yyyy'), 596695941, 'Juan', 'Sarah', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (199, 'Anthony', 'Allen', to_date('17-03-2010', 'dd-mm-yyyy'), 544268071, 'Chad', 'Gabriella', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (200, 'Joan', 'Lee', to_date('16-11-2020', 'dd-mm-yyyy'), 578198291, 'Charles', 'Sheila', 33);
commit;
prompt 200 records committed...
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (201, 'Isaiah', 'Wright', to_date('03-04-2015', 'dd-mm-yyyy'), 570378447, 'George', 'Amanda', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (202, 'William', 'Williams', to_date('26-08-2024', 'dd-mm-yyyy'), 521462189, 'Lucas', 'Lucy', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (203, 'Cole', 'Lopez', to_date('20-12-2023', 'dd-mm-yyyy'), 526217515, 'Felipe', 'Lydia', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (204, 'Jacqueline', 'Taylor', to_date('21-02-2018', 'dd-mm-yyyy'), 585308824, 'Jack', 'Courtney', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (205, 'Julia', 'Green', to_date('05-12-2010', 'dd-mm-yyyy'), 597766757, 'Scott', 'Courtney', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (206, 'Samuel', 'Campbell', to_date('28-02-2005', 'dd-mm-yyyy'), 552429514, 'Sebastian', 'Lisa', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (207, 'Brandon', 'Johnson', to_date('23-06-2022', 'dd-mm-yyyy'), 570578110, 'Nicholas', 'Jillian', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (208, 'Adam', 'Moore', to_date('25-12-2007', 'dd-mm-yyyy'), 583191610, 'Trevor', 'Ruby', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (209, 'Jacob', 'Moore', to_date('11-06-2015', 'dd-mm-yyyy'), 576620844, 'Stephen', 'Abigail', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (210, 'Diego', 'Ramirez', to_date('01-08-2024', 'dd-mm-yyyy'), 588124847, 'Zachary', 'Susan', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (211, 'Ava', 'Lee', to_date('28-01-2009', 'dd-mm-yyyy'), 522317020, 'Theodore', 'Linda', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (212, 'Claudia', 'Wilson', to_date('03-05-2022', 'dd-mm-yyyy'), 578764688, 'Nathan', 'Deborah', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (213, 'Lucia', 'Hernandez', to_date('23-05-2014', 'dd-mm-yyyy'), 523920417, 'Nicholas', 'Vivian', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (214, 'Benjamin', 'Allen', to_date('05-02-2011', 'dd-mm-yyyy'), 515819212, 'Diego', 'Kayla', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (215, 'Adam', 'Anderson', to_date('02-01-2020', 'dd-mm-yyyy'), 521830833, 'Nathaniel', 'Karen', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (216, 'Karen', 'Moore', to_date('14-03-2023', 'dd-mm-yyyy'), 533811339, 'Felipe', 'Gabriella', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (217, 'Lily', 'Scott', to_date('02-06-2009', 'dd-mm-yyyy'), 546612610, 'Joshua', 'Sydney', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (218, 'Philip', 'Nguyen', to_date('23-08-2005', 'dd-mm-yyyy'), 526936108, 'Wyatt', 'Lillian', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (219, 'Rebecca', 'King', to_date('04-09-2018', 'dd-mm-yyyy'), 512749302, 'Lawrence', 'Taylor', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (220, 'Christopher', 'Davis', to_date('27-03-2021', 'dd-mm-yyyy'), 539457847, 'Brandon', 'Louise', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (221, 'Patricia', 'Garcia', to_date('26-03-2017', 'dd-mm-yyyy'), 530795249, 'Joseph', 'Charlene', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (222, 'Nathan', 'Rodriguez', to_date('11-07-2009', 'dd-mm-yyyy'), 598129305, 'Trevor', 'Monica', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (223, 'Katherine', 'Nguyen', to_date('28-07-2013', 'dd-mm-yyyy'), 528782998, 'Julian', 'Nicole', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (224, 'Chad', 'Clark', to_date('03-01-2013', 'dd-mm-yyyy'), 560166830, 'Jacob', 'Stephanie', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (225, 'Andrew', 'Thomas', to_date('12-01-2018', 'dd-mm-yyyy'), 534026854, 'Isaac', 'Caroline', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (226, 'Maria', 'Hernandez', to_date('25-04-2009', 'dd-mm-yyyy'), 566892833, 'George', 'Alexis', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (227, 'Sebastian', 'Nelson', to_date('16-07-2021', 'dd-mm-yyyy'), 527977319, 'Juan', 'Hannah', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (228, 'Martha', 'Allen', to_date('04-08-2011', 'dd-mm-yyyy'), 530745831, 'Cody', 'Hannah', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (229, 'Shannon', 'Lopez', to_date('17-11-2011', 'dd-mm-yyyy'), 576677565, 'Austin', 'Isabella', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (230, 'Zachary', 'Williams', to_date('17-08-2011', 'dd-mm-yyyy'), 514774796, 'Ryan', 'Agnes', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (231, 'Isaac', 'Hernandez', to_date('07-02-2018', 'dd-mm-yyyy'), 546593702, 'Brian', 'Louise', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (232, 'Isabella', 'Adams', to_date('11-02-2011', 'dd-mm-yyyy'), 540073645, 'Julian', 'Sandra', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (233, 'Javier', 'Thompson', to_date('31-01-2021', 'dd-mm-yyyy'), 539781392, 'Lucas', 'Sheila', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (234, 'Diana', 'Clark', to_date('01-02-2014', 'dd-mm-yyyy'), 524258229, 'Joan', 'Nicole', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (235, 'Jacqueline', 'Lopez', to_date('17-07-2020', 'dd-mm-yyyy'), 577898295, 'Thomas', 'Claire', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (236, 'Henry', 'Lee', to_date('07-04-2019', 'dd-mm-yyyy'), 590529203, 'Douglas', 'Alana', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (237, 'Ezekiel', 'Thomas', to_date('21-07-2022', 'dd-mm-yyyy'), 552886768, 'Miguel', 'Isabella', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (238, 'Trevor', 'Taylor', to_date('25-04-2005', 'dd-mm-yyyy'), 536583996, 'Walter', 'Olivia', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (239, 'Felipe', 'Walker', to_date('02-01-2014', 'dd-mm-yyyy'), 597779079, 'Austin', 'Lydia', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (240, 'Eric', 'Lewis', to_date('15-10-2018', 'dd-mm-yyyy'), 559514485, 'Abraham', 'Agnes', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (241, 'Nathan', 'Hernandez', to_date('17-05-2007', 'dd-mm-yyyy'), 515684880, 'Christopher', 'Meghan', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (242, 'Penelope', 'Walker', to_date('07-05-2015', 'dd-mm-yyyy'), 522351988, 'Dustin', 'Brittany', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (243, 'Walter', 'Nguyen', to_date('31-03-2023', 'dd-mm-yyyy'), 596883442, 'Cody', 'Sarah', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (244, 'Julia', 'Nguyen', to_date('27-03-2016', 'dd-mm-yyyy'), 594277729, 'Chad', 'Rose', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (245, 'Felipe', 'Wilson', to_date('04-07-2020', 'dd-mm-yyyy'), 520990225, 'Timothy', 'Margaret', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (246, 'Rose', 'Lewis', to_date('18-12-2018', 'dd-mm-yyyy'), 546490895, 'Owen', 'Lisa', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (247, 'Nicholas', 'Anderson', to_date('27-10-2022', 'dd-mm-yyyy'), 533789076, 'Sebastian', 'Maria', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (248, 'Nancy', 'Lewis', to_date('30-01-2006', 'dd-mm-yyyy'), 512823440, 'Stephen', 'Lauren', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (249, 'Walter', 'Phillips', to_date('10-01-2008', 'dd-mm-yyyy'), 542792234, 'Julian', 'Courtney', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (250, 'Roy', 'Rogers', to_date('23-10-2007', 'dd-mm-yyyy'), 595221830, 'David', 'Linda', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (251, 'Leonardo', 'King', to_date('12-11-2024', 'dd-mm-yyyy'), 512881904, 'Sebastian', 'Brittany', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (252, 'Faith', 'Young', to_date('09-07-2011', 'dd-mm-yyyy'), 515484767, 'Daniel', 'Leslie', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (253, 'Kimberly', 'Williams', to_date('26-01-2009', 'dd-mm-yyyy'), 527819264, 'Kevin', 'Maria', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (254, 'Rebecca', 'Roberts', to_date('24-01-2005', 'dd-mm-yyyy'), 526678219, 'Miguel', 'Courtney', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (255, 'Sebastian', 'Garcia', to_date('19-12-2013', 'dd-mm-yyyy'), 539086091, 'Dennis', 'Jade', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (256, 'Andrew', 'Moore', to_date('02-06-2007', 'dd-mm-yyyy'), 578518565, 'Cody', 'Sheila', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (257, 'Molly', 'Williams', to_date('26-12-2018', 'dd-mm-yyyy'), 590915832, 'Eric', 'Kristen', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (258, 'Thomas', 'Nguyen', to_date('10-06-2017', 'dd-mm-yyyy'), 578525948, 'Justin', 'Brenda', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (259, 'Gabriella', 'Garcia', to_date('03-12-2010', 'dd-mm-yyyy'), 563231712, 'Alan', 'Pamela', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (260, 'Paul', 'Moore', to_date('03-12-2022', 'dd-mm-yyyy'), 516353106, 'Shannon', 'Patricia', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (261, 'Nancy', 'Wilson', to_date('17-10-2019', 'dd-mm-yyyy'), 520417603, 'Julian', 'Michelle', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (262, 'Caroline', 'Scott', to_date('25-04-2011', 'dd-mm-yyyy'), 559372041, 'Austin', 'Julia', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (263, 'Maria', 'Rodriguez', to_date('20-10-2024', 'dd-mm-yyyy'), 567878964, 'Philip', 'Charlene', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (264, 'Alice', 'Miller', to_date('18-02-2018', 'dd-mm-yyyy'), 552220253, 'Owen', 'Kristen', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (265, 'Jessica', 'Campbell', to_date('30-03-2019', 'dd-mm-yyyy'), 599153056, 'George', 'Jade', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (266, 'Jesse', 'Moore', to_date('02-07-2019', 'dd-mm-yyyy'), 518367894, 'Justin', 'Maya', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (267, 'Bethany', 'Taylor', to_date('22-06-2018', 'dd-mm-yyyy'), 573256488, 'Ethan', 'Alicia', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (268, 'Jasmine', 'Wright', to_date('09-06-2017', 'dd-mm-yyyy'), 570799319, 'Thomas', 'Rose', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (269, 'Penelope', 'Campbell', to_date('27-05-2012', 'dd-mm-yyyy'), 518205192, 'Wyatt', 'Penelope', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (270, 'Christopher', 'Davis', to_date('03-03-2014', 'dd-mm-yyyy'), 549179700, 'Patrick', 'Cecilia', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (271, 'Isaiah', 'Thompson', to_date('19-07-2019', 'dd-mm-yyyy'), 531905787, 'Luke', 'Luna', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (272, 'Abraham', 'Moore', to_date('20-02-2011', 'dd-mm-yyyy'), 520336751, 'Abraham', 'Kayla', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (273, 'Nicholas', 'Allen', to_date('26-02-2005', 'dd-mm-yyyy'), 548807005, 'Ezekiel', 'Pamela', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (274, 'Dorothy', 'Young', to_date('21-04-2019', 'dd-mm-yyyy'), 537271375, 'Charles', 'Victoria', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (275, 'Antonio', 'Walker', to_date('05-10-2017', 'dd-mm-yyyy'), 536978813, 'Andrew', 'Danielle', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (276, 'Bethany', 'Rogers', to_date('14-09-2023', 'dd-mm-yyyy'), 530415873, 'Aaron', 'Luna', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (277, 'Juan', 'Harris', to_date('11-04-2005', 'dd-mm-yyyy'), 594493653, 'Joseph', 'Lillian', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (278, 'Sharon', 'Rodriguez', to_date('26-01-2007', 'dd-mm-yyyy'), 584292886, 'Gabriel', 'Katherine', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (279, 'William', 'Rodriguez', to_date('22-03-2022', 'dd-mm-yyyy'), 529423222, 'Patrick', 'Sheila', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (280, 'Timothy', 'Walker', to_date('02-03-2020', 'dd-mm-yyyy'), 510263054, 'Walter', 'Linda', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (281, 'Ava', 'Garcia', to_date('27-05-2020', 'dd-mm-yyyy'), 532811130, 'Adrian', 'Lauren', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (282, 'Cole', 'Rodriguez', to_date('22-09-2015', 'dd-mm-yyyy'), 582569940, 'John', 'Sarah', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (283, 'Andrew', 'Garcia', to_date('09-05-2013', 'dd-mm-yyyy'), 593034600, 'Wesley', 'Lucy', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (284, 'Miguel', 'Lopez', to_date('17-08-2021', 'dd-mm-yyyy'), 559122043, 'Kyle', 'Fiona', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (285, 'Molly', 'Rodriguez', to_date('29-07-2018', 'dd-mm-yyyy'), 536248838, 'Miguel', 'Lydia', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (286, 'Lisa', 'Lee', to_date('25-11-2009', 'dd-mm-yyyy'), 520724991, 'Ethan', 'Caroline', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (287, 'Isaiah', 'Carter', to_date('20-04-2019', 'dd-mm-yyyy'), 514312596, 'Diego', 'Amelia', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (288, 'Joseph', 'Scott', to_date('30-12-2005', 'dd-mm-yyyy'), 590938354, 'Isaac', 'Courtney', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (289, 'Austin', 'Harris', to_date('20-08-2017', 'dd-mm-yyyy'), 584004460, 'Antonio', 'Charlotte', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (290, 'Tiffany', 'Walker', to_date('05-03-2017', 'dd-mm-yyyy'), 540153861, 'Cody', 'Karen', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (291, 'Cole', 'Lopez', to_date('31-07-2019', 'dd-mm-yyyy'), 577419751, 'Austin', 'Lisa', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (292, 'Julian', 'Miller', to_date('11-02-2017', 'dd-mm-yyyy'), 573122842, 'Patrick', 'Michelle', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (293, 'Katherine', 'Allen', to_date('15-07-2015', 'dd-mm-yyyy'), 590605495, 'Zachary', 'Ava', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (294, 'Katherine', 'Moore', to_date('03-08-2020', 'dd-mm-yyyy'), 516706012, 'Antonio', 'Sheila', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (295, 'Keith', 'Ramirez', to_date('22-03-2019', 'dd-mm-yyyy'), 571379729, 'Paul', 'Penelope', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (296, 'Nathan', 'Young', to_date('03-09-2022', 'dd-mm-yyyy'), 568961219, 'Vincent', 'Agnes', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (297, 'Chad', 'Wright', to_date('28-07-2005', 'dd-mm-yyyy'), 528989557, 'Dustin', 'Louise', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (298, 'Jacob', 'Williams', to_date('05-01-2005', 'dd-mm-yyyy'), 539690238, 'Nathaniel', 'Rachel', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (299, 'Lillian', 'Campbell', to_date('09-10-2014', 'dd-mm-yyyy'), 525264680, 'Daniel', 'Alana', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (300, 'Sheila', 'Wilson', to_date('21-05-2015', 'dd-mm-yyyy'), 576562686, 'Isaac', 'Charlotte', 34);
commit;
prompt 300 records committed...
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (301, 'Luke', 'Johnson', to_date('15-06-2012', 'dd-mm-yyyy'), 511633279, 'Trevor', 'Alice', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (302, 'Jacqueline', 'Hernandez', to_date('30-01-2023', 'dd-mm-yyyy'), 511380205, 'Dylan', 'Courtney', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (303, 'Gabriel', 'Wright', to_date('08-11-2023', 'dd-mm-yyyy'), 568150140, 'Brian', 'Lily', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (304, 'Claire', 'Diaz', to_date('11-01-2015', 'dd-mm-yyyy'), 557610951, 'Sebastian', 'Bridget', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (305, 'Ava', 'Robinson', to_date('15-05-2005', 'dd-mm-yyyy'), 545355795, 'Dennis', 'Lydia', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (306, 'Gabriella', 'Harris', to_date('13-09-2016', 'dd-mm-yyyy'), 598700130, 'Aaron', 'Reagan', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (307, 'Joshua', 'Brown', to_date('14-11-2024', 'dd-mm-yyyy'), 543342943, 'Nathaniel', 'Luna', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (308, 'Cole', 'Moore', to_date('21-10-2016', 'dd-mm-yyyy'), 568873605, 'Aaron', 'Martha', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (309, 'Julia', 'Carter', to_date('29-10-2022', 'dd-mm-yyyy'), 519862969, 'Christopher', 'Michelle', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (310, 'Ruby', 'Mitchell', to_date('12-06-2020', 'dd-mm-yyyy'), 575178847, 'Lawrence', 'Sheila', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (311, 'Kelly', 'Hernandez', to_date('24-06-2005', 'dd-mm-yyyy'), 560470721, 'Philip', 'Allison', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (312, 'Joan', 'Taylor', to_date('31-08-2006', 'dd-mm-yyyy'), 588857941, 'Joshua', 'Hayley', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (313, 'Mia', 'Rogers', to_date('26-02-2017', 'dd-mm-yyyy'), 567247544, 'Richard', 'Linda', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (314, 'Joseph', 'Lopez', to_date('24-06-2020', 'dd-mm-yyyy'), 526878649, 'Diego', 'Sarah', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (315, 'Nathan', 'Lee', to_date('21-09-2023', 'dd-mm-yyyy'), 521491025, 'Carlos', 'Charlotte', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (316, 'Peyton', 'Miller', to_date('09-12-2013', 'dd-mm-yyyy'), 583989511, 'Dustin', 'Taylor', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (317, 'Michelle', 'Johnson', to_date('31-12-2008', 'dd-mm-yyyy'), 550953591, 'Philip', 'Penelope', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (318, 'Amelia', 'Nguyen', to_date('05-04-2016', 'dd-mm-yyyy'), 511744231, 'Eric', 'Lily', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (319, 'Ezekiel', 'Johnson', to_date('11-06-2009', 'dd-mm-yyyy'), 549479581, 'Shannon', 'Jessica', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (320, 'Maya', 'Anderson', to_date('01-06-2023', 'dd-mm-yyyy'), 575340134, 'Charles', 'Brittany', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (321, 'Theodore', 'Mitchell', to_date('10-02-2013', 'dd-mm-yyyy'), 557209428, 'Adrian', 'Alexandra', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (322, 'Stephen', 'Thomas', to_date('16-05-2023', 'dd-mm-yyyy'), 597820356, 'Henry', 'Kayla', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (323, 'Kevin', 'Moore', to_date('02-12-2020', 'dd-mm-yyyy'), 518547399, 'Zachary', 'Maria', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (324, 'Robert', 'Lee', to_date('05-01-2012', 'dd-mm-yyyy'), 581391047, 'Ryan', 'Catherine', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (325, 'Albert', 'Johnson', to_date('04-05-2008', 'dd-mm-yyyy'), 568120620, 'Ezekiel', 'Martha', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (326, 'Joan', 'Wilson', to_date('10-10-2011', 'dd-mm-yyyy'), 583603253, 'Trevor', 'Brittany', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (327, 'Robert', 'Scott', to_date('14-07-2019', 'dd-mm-yyyy'), 527125160, 'Joshua', 'Zoe', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (328, 'Scott', 'Hernandez', to_date('23-11-2013', 'dd-mm-yyyy'), 574516964, 'Ezekiel', 'Penelope', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (329, 'Albert', 'Hernandez', to_date('03-11-2006', 'dd-mm-yyyy'), 579158122, 'Joan', 'Maya', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (330, 'Cole', 'Green', to_date('19-03-2017', 'dd-mm-yyyy'), 527620537, 'Keith', 'Sheila', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (331, 'Paul', 'Sanchez', to_date('28-01-2024', 'dd-mm-yyyy'), 548343601, 'Carlos', 'Reagan', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (332, 'Edward', 'Young', to_date('27-11-2013', 'dd-mm-yyyy'), 587058364, 'Jordan', 'Reagan', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (333, 'Maya', 'Lewis', to_date('28-07-2024', 'dd-mm-yyyy'), 518259674, 'Jordan', 'Allison', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (334, 'Cecilia', 'Lee', to_date('03-09-2016', 'dd-mm-yyyy'), 577064088, 'Travis', 'Sharon', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (335, 'Jordan', 'Thomas', to_date('12-10-2018', 'dd-mm-yyyy'), 570781137, 'Antonio', 'Faith', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (336, 'Karen', 'Young', to_date('26-06-2013', 'dd-mm-yyyy'), 549565745, 'Philip', 'Susan', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (337, 'Owen', 'Nelson', to_date('21-02-2019', 'dd-mm-yyyy'), 553533137, 'Gregory', 'Hannah', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (338, 'Ronald', 'Lee', to_date('14-04-2008', 'dd-mm-yyyy'), 562343735, 'Richard', 'Stephanie', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (339, 'Faith', 'Wright', to_date('06-08-2011', 'dd-mm-yyyy'), 582327265, 'Sebastian', 'Kayla', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (340, 'Cheryl', 'Allen', to_date('10-01-2019', 'dd-mm-yyyy'), 597911404, 'Zachary', 'Olivia', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (341, 'Jacqueline', 'Robinson', to_date('16-04-2013', 'dd-mm-yyyy'), 519969862, 'Cameron', 'Margaret', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (342, 'Derek', 'Robinson', to_date('11-07-2010', 'dd-mm-yyyy'), 564044493, 'Isaac', 'Janet', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (343, 'Jacob', 'Moore', to_date('10-12-2015', 'dd-mm-yyyy'), 589435793, 'Tyler', 'Faith', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (344, 'Kelly', 'Brown', to_date('21-03-2012', 'dd-mm-yyyy'), 580166566, 'Harold', 'Gabriella', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (345, 'Alana', 'Sanchez', to_date('01-06-2011', 'dd-mm-yyyy'), 577658798, 'Daniel', 'Kristen', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (346, 'Dylan', 'Johnson', to_date('20-04-2017', 'dd-mm-yyyy'), 578330696, 'Jack', 'Hayley', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (347, 'Aisha', 'Wright', to_date('08-01-2015', 'dd-mm-yyyy'), 571190461, 'Harold', 'Ashley', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (348, 'Miguel', 'Moore', to_date('09-12-2021', 'dd-mm-yyyy'), 555459866, 'Jonathan', 'Lori', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (349, 'Jade', 'Roy', to_date('24-02-2005', 'dd-mm-yyyy'), 570502563, 'Adrian', 'Lucy', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (350, 'Antonio', 'Walker', to_date('06-12-2016', 'dd-mm-yyyy'), 520938719, 'Sebastian', 'Aisha', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (351, 'Scott', 'Harris', to_date('27-09-2008', 'dd-mm-yyyy'), 579419020, 'Dustin', 'Sheila', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (352, 'Sebastian', 'Garcia', to_date('18-12-2023', 'dd-mm-yyyy'), 527699812, 'Noah', 'Ashley', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (353, 'Lauren', 'Lewis', to_date('30-11-2007', 'dd-mm-yyyy'), 572043588, 'Jonathan', 'Evelyn', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (354, 'Caleb', 'Sanchez', to_date('15-12-2014', 'dd-mm-yyyy'), 595670306, 'Abraham', 'Monica', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (355, 'Aaron', 'Hernandez', to_date('26-03-2009', 'dd-mm-yyyy'), 514831214, 'Diego', 'Lisa', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (356, 'Martha', 'Lee', to_date('29-03-2010', 'dd-mm-yyyy'), 552321657, 'Owen', 'Lillian', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (357, 'Dustin', 'Robinson', to_date('21-12-2010', 'dd-mm-yyyy'), 577076094, 'Xavier', 'Penelope', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (358, 'Taylor', 'Rogers', to_date('17-05-2024', 'dd-mm-yyyy'), 517199052, 'Ezekiel', 'Teresa', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (359, 'Eric', 'Allen', to_date('25-05-2015', 'dd-mm-yyyy'), 599020536, 'Richard', 'Bethany', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (360, 'Heather', 'Mitchell', to_date('05-07-2007', 'dd-mm-yyyy'), 573224707, 'Antonio', 'Faith', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (361, 'Felipe', 'Lee', to_date('10-06-2005', 'dd-mm-yyyy'), 511592484, 'Jordan', 'Sandra', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (362, 'Douglas', 'Campbell', to_date('08-02-2024', 'dd-mm-yyyy'), 531164104, 'Oliver', 'Amanda', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (363, 'Martha', 'Walker', to_date('03-06-2007', 'dd-mm-yyyy'), 574952711, 'Benjamin', 'Lucy', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (364, 'Luna', 'Walker', to_date('16-06-2013', 'dd-mm-yyyy'), 599024067, 'Aaron', 'Diana', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (365, 'Diana', 'Walker', to_date('11-10-2009', 'dd-mm-yyyy'), 568990770, 'Lucas', 'Maya', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (366, 'Lillian', 'Watson', to_date('11-10-2008', 'dd-mm-yyyy'), 576661594, 'Eric', 'Alice', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (367, 'Justin', 'Rodriguez', to_date('06-12-2016', 'dd-mm-yyyy'), 518366894, 'Roy', 'Claire', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (368, 'Faith', 'Lewis', to_date('01-03-2022', 'dd-mm-yyyy'), 535355891, 'Ethan', 'Heather', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (369, 'Ethan', 'Wright', to_date('08-04-2016', 'dd-mm-yyyy'), 564051588, 'Stephen', 'Jane', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (370, 'Nicholas', 'Young', to_date('29-09-2021', 'dd-mm-yyyy'), 537765008, 'Daniel', 'Martha', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (371, 'Kelly', 'Wright', to_date('04-01-2024', 'dd-mm-yyyy'), 567492085, 'Austin', 'Sydney', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (372, 'Jacqueline', 'Lee', to_date('18-06-2013', 'dd-mm-yyyy'), 527372336, 'Albert', 'Claire', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (373, 'Sheila', 'Scott', to_date('07-09-2023', 'dd-mm-yyyy'), 560379929, 'Joan', 'Aisha', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (374, 'Albert', 'Johnson', to_date('06-05-2015', 'dd-mm-yyyy'), 583355063, 'Benjamin', 'Nancy', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (375, 'Ryan', 'Watson', to_date('02-07-2020', 'dd-mm-yyyy'), 573820454, 'Sean', 'Taylor', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (376, 'Courtney', 'Cruz', to_date('13-07-2013', 'dd-mm-yyyy'), 565100974, 'Roy', 'Maya', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (377, 'Rebecca', 'Evans', to_date('23-08-2014', 'dd-mm-yyyy'), 547441855, 'Derek', 'Jennifer', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (378, 'Michelle', 'Evans', to_date('10-10-2018', 'dd-mm-yyyy'), 550103065, 'Dennis', 'Janet', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (379, 'Sharon', 'Wright', to_date('20-03-2018', 'dd-mm-yyyy'), 525577480, 'John', 'Stephanie', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (380, 'Jennifer', 'Hernandez', to_date('31-03-2005', 'dd-mm-yyyy'), 520194852, 'Oliver', 'Evelyn', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (381, 'Agnes', 'Nelson', to_date('28-09-2020', 'dd-mm-yyyy'), 597821468, 'Stephen', 'Isabella', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (382, 'Cecilia', 'Young', to_date('08-12-2024', 'dd-mm-yyyy'), 528381083, 'Lawrence', 'Jillian', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (383, 'Kyle', 'Rogers', to_date('15-02-2023', 'dd-mm-yyyy'), 511027790, 'Wesley', 'Agnes', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (384, 'Lisa', 'Clark', to_date('17-08-2012', 'dd-mm-yyyy'), 543853980, 'Cole', 'Linda', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (385, 'Ava', 'Nelson', to_date('02-12-2009', 'dd-mm-yyyy'), 588869048, 'Sebastian', 'Faith', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (386, 'Reagan', 'Rogers', to_date('11-05-2013', 'dd-mm-yyyy'), 542615555, 'Brandon', 'Taylor', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (387, 'Isaac', 'Robinson', to_date('23-03-2022', 'dd-mm-yyyy'), 588135555, 'Philip', 'Lucia', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (388, 'Harold', 'Roy', to_date('01-08-2011', 'dd-mm-yyyy'), 597631551, 'Isaac', 'Caroline', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (389, 'George', 'Robinson', to_date('13-02-2023', 'dd-mm-yyyy'), 536564990, 'Wyatt', 'Sydney', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (390, 'Ronald', 'Miller', to_date('19-06-2006', 'dd-mm-yyyy'), 595377768, 'Philip', 'Sheila', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (391, 'Gabriel', 'Hernandez', to_date('26-02-2013', 'dd-mm-yyyy'), 553250393, 'Isaiah', 'Monica', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (392, 'Sean', 'Rogers', to_date('16-01-2014', 'dd-mm-yyyy'), 564326195, 'Kyle', 'Heather', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (393, 'Leslie', 'Lewis', to_date('12-05-2021', 'dd-mm-yyyy'), 520579403, 'Jordan', 'Nicole', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (394, 'Sandra', 'Thomas', to_date('20-03-2024', 'dd-mm-yyyy'), 597592014, 'Stephen', 'Lucia', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (395, 'Daniel', 'Anderson', to_date('04-05-2011', 'dd-mm-yyyy'), 551746107, 'Austin', 'Jade', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (396, 'Jacqueline', 'Wright', to_date('02-09-2024', 'dd-mm-yyyy'), 580390050, 'Eric', 'Patricia', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (397, 'Kyle', 'Moore', to_date('02-01-2008', 'dd-mm-yyyy'), 563356205, 'Adrian', 'Isabella', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (398, 'Isaac', 'Rogers', to_date('08-09-2022', 'dd-mm-yyyy'), 563238752, 'Aaron', 'Sandra', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (399, 'Catherine', 'Moore', to_date('22-01-2006', 'dd-mm-yyyy'), 555223398, 'Nathan', 'Bridget', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (400, 'Alexandra', 'Anderson', to_date('13-10-2023', 'dd-mm-yyyy'), 571437591, 'Javier', 'Joan', 1);
commit;
prompt 400 records committed...
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (401, 'Alan', 'Thomas', to_date('14-10-2019', 'dd-mm-yyyy'), 583808797, 'Adrian', 'Kayla', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (402, 'Brian', 'Rodriguez', to_date('01-04-2009', 'dd-mm-yyyy'), 543721994, 'Ezekiel', 'Agnes', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (403, 'Edward', 'Lopez', to_date('20-03-2005', 'dd-mm-yyyy'), 522170895, 'Travis', 'Alexis', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (404, 'Evelyn', 'Rodriguez', to_date('25-02-2013', 'dd-mm-yyyy'), 529192855, 'Wesley', 'Diana', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (405, 'Patricia', 'Phillips', to_date('26-07-2010', 'dd-mm-yyyy'), 544981012, 'Xavier', 'Sophia', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (406, 'Rachel', 'Sanchez', to_date('06-12-2012', 'dd-mm-yyyy'), 536551170, 'Theodore', 'Mia', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (407, 'Jayden', 'Allen', to_date('07-12-2006', 'dd-mm-yyyy'), 581185722, 'Adam', 'Margaret', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (408, 'Antonio', 'Mitchell', to_date('04-01-2012', 'dd-mm-yyyy'), 579176762, 'Christopher', 'Penelope', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (409, 'Maya', 'Lopez', to_date('25-03-2021', 'dd-mm-yyyy'), 582616462, 'Gregory', 'Margaret', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (410, 'Phoebe', 'Brown', to_date('11-10-2024', 'dd-mm-yyyy'), 529514514, 'Chad', 'Dorothy', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (411, 'Lauren', 'Roy', to_date('23-10-2013', 'dd-mm-yyyy'), 550394341, 'Andrew', 'Teresa', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (412, 'Samantha', 'Young', to_date('22-11-2017', 'dd-mm-yyyy'), 522562885, 'Joseph', 'Audrey', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (413, 'Noah', 'Clark', to_date('06-10-2022', 'dd-mm-yyyy'), 512587711, 'Vincent', 'Maria', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (414, 'Noah', 'Hernandez', to_date('17-08-2024', 'dd-mm-yyyy'), 573390526, 'Cole', 'Monica', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (415, 'Jayden', 'Brown', to_date('28-07-2005', 'dd-mm-yyyy'), 548333734, 'Miguel', 'Lillian', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (416, 'Chad', 'Cruz', to_date('02-01-2011', 'dd-mm-yyyy'), 528206561, 'Jacob', 'Courtney', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (417, 'Charles', 'Wright', to_date('15-10-2019', 'dd-mm-yyyy'), 533841026, 'Alan', 'Natalie', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (418, 'Ezekiel', 'Moore', to_date('05-02-2013', 'dd-mm-yyyy'), 528311853, 'Antonio', 'Claudia', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (419, 'Kyle', 'Miller', to_date('08-10-2014', 'dd-mm-yyyy'), 572505806, 'Nathan', 'Meghan', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (420, 'Benjamin', 'Hernandez', to_date('07-02-2012', 'dd-mm-yyyy'), 510973964, 'Jesse', 'Lisa', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (421, 'Samantha', 'Hernandez', to_date('31-05-2017', 'dd-mm-yyyy'), 510399961, 'Anthony', 'Jacqueline', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (422, 'Teresa', 'Garcia', to_date('02-01-2020', 'dd-mm-yyyy'), 598876910, 'Derek', 'Sheila', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (423, 'Isabella', 'Evans', to_date('08-08-2012', 'dd-mm-yyyy'), 593890678, 'Anthony', 'Katherine', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (424, 'Jennifer', 'Mitchell', to_date('01-12-2015', 'dd-mm-yyyy'), 527992622, 'Theodore', 'Margaret', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (425, 'Sarah', 'Scott', to_date('29-01-2014', 'dd-mm-yyyy'), 514194094, 'Eric', 'Penelope', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (426, 'Douglas', 'Lopez', to_date('13-08-2015', 'dd-mm-yyyy'), 582457357, 'Dustin', 'Diana', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (427, 'Karen', 'Hernandez', to_date('13-10-2008', 'dd-mm-yyyy'), 568360925, 'Charles', 'Helena', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (428, 'Dylan', 'Lopez', to_date('19-03-2012', 'dd-mm-yyyy'), 552457681, 'Luke', 'Jillian', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (429, 'Nathan', 'Campbell', to_date('27-08-2017', 'dd-mm-yyyy'), 559007588, 'Lawrence', 'Meghan', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (430, 'Hannah', 'Lee', to_date('26-10-2023', 'dd-mm-yyyy'), 516758592, 'Isaiah', 'Jade', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (431, 'Karen', 'Young', to_date('15-05-2005', 'dd-mm-yyyy'), 531485516, 'Henry', 'Lori', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (432, 'Luke', 'Carter', to_date('09-03-2024', 'dd-mm-yyyy'), 576677625, 'Adam', 'Rachel', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (433, 'Richard', 'Rodriguez', to_date('29-11-2018', 'dd-mm-yyyy'), 553182996, 'Alan', 'Taylor', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (434, 'Fiona', 'Moore', to_date('07-06-2009', 'dd-mm-yyyy'), 591181653, 'Jesse', 'Hayley', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (435, 'Wesley', 'Taylor', to_date('24-12-2020', 'dd-mm-yyyy'), 530434510, 'Eric', 'Abigail', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (436, 'Amanda', 'Williams', to_date('09-04-2015', 'dd-mm-yyyy'), 558900968, 'Edward', 'Pamela', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (437, 'Javier', 'Moore', to_date('10-01-2015', 'dd-mm-yyyy'), 554643857, 'Paul', 'Cheryl', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (438, 'Miguel', 'Young', to_date('08-01-2023', 'dd-mm-yyyy'), 538923808, 'John', 'Jillian', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (439, 'Leah', 'Thomas', to_date('03-12-2020', 'dd-mm-yyyy'), 570150019, 'Henry', 'Maria', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (440, 'Thomas', 'Moore', to_date('12-05-2008', 'dd-mm-yyyy'), 587134589, 'Derek', 'Pamela', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (441, 'Michelle', 'Lopez', to_date('04-09-2016', 'dd-mm-yyyy'), 517227489, 'Gabriel', 'Rachel', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (442, 'Wesley', 'Allen', to_date('17-04-2007', 'dd-mm-yyyy'), 579753538, 'Richard', 'Meghan', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (443, 'Jonathan', 'Moore', to_date('15-06-2013', 'dd-mm-yyyy'), 540772325, 'Albert', 'Joan', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (444, 'Margaret', 'Thomas', to_date('19-11-2008', 'dd-mm-yyyy'), 530511867, 'Samuel', 'Olivia', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (445, 'Karen', 'Roberts', to_date('03-04-2018', 'dd-mm-yyyy'), 582572375, 'Brandon', 'Danielle', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (446, 'Vivian', 'Hernandez', to_date('11-05-2010', 'dd-mm-yyyy'), 553535875, 'Oliver', 'Shirley', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (447, 'Jennifer', 'Lopez', to_date('29-05-2024', 'dd-mm-yyyy'), 570134786, 'Oliver', 'Julia', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (448, 'Laura', 'Rodriguez', to_date('28-03-2008', 'dd-mm-yyyy'), 510541878, 'Gabriel', 'Angela', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (449, 'Carlos', 'Allen', to_date('18-05-2022', 'dd-mm-yyyy'), 574148015, 'Jordan', 'Jillian', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (450, 'Cecilia', 'Mitchell', to_date('05-02-2007', 'dd-mm-yyyy'), 521163097, 'Oliver', 'Taylor', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (451, 'Aaron', 'Walker', to_date('03-05-2007', 'dd-mm-yyyy'), 567835154, 'Lucas', 'Kelly', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (452, 'Albert', 'Rogers', to_date('11-08-2012', 'dd-mm-yyyy'), 528833675, 'Gabriel', 'Stephanie', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (453, 'Bethany', 'Garcia', to_date('01-06-2023', 'dd-mm-yyyy'), 572895092, 'Jacob', 'Sydney', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (454, 'Andrew', 'Walker', to_date('15-03-2018', 'dd-mm-yyyy'), 593443295, 'David', 'Alicia', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (455, 'Cole', 'Garcia', to_date('15-07-2023', 'dd-mm-yyyy'), 589664384, 'Ryan', 'Jasmine', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (456, 'Alexis', 'Scott', to_date('15-11-2022', 'dd-mm-yyyy'), 583887984, 'Miguel', 'Diana', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (457, 'Kristen', 'Hernandez', to_date('16-03-2008', 'dd-mm-yyyy'), 546381004, 'Adrian', 'Hannah', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (458, 'Dorothy', 'Young', to_date('08-09-2019', 'dd-mm-yyyy'), 552504198, 'William', 'Kristen', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (459, 'Sydney', 'Johnson', to_date('24-08-2023', 'dd-mm-yyyy'), 555465818, 'Jordan', 'Linda', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (460, 'Dennis', 'Hernandez', to_date('15-04-2017', 'dd-mm-yyyy'), 568083538, 'Diego', 'Heather', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (461, 'Isaiah', 'Allen', to_date('02-12-2016', 'dd-mm-yyyy'), 530861548, 'Julian', 'Maria', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (462, 'Laura', 'Lewis', to_date('06-10-2013', 'dd-mm-yyyy'), 557403039, 'Ezekiel', 'Tiffany', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (463, 'Rose', 'Walker', to_date('10-09-2017', 'dd-mm-yyyy'), 514208009, 'Edward', 'Phoebe', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (464, 'George', 'Scott', to_date('08-05-2018', 'dd-mm-yyyy'), 530547561, 'Javier', 'Cheryl', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (465, 'Sheila', 'Nguyen', to_date('06-10-2008', 'dd-mm-yyyy'), 585737384, 'Austin', 'Isabella', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (466, 'Bridget', 'Hernandez', to_date('16-02-2019', 'dd-mm-yyyy'), 538513588, 'Kyle', 'Gabriella', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (467, 'Lawrence', 'Campbell', to_date('04-07-2022', 'dd-mm-yyyy'), 588480681, 'Carlos', 'Deborah', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (468, 'Roy', 'Wright', to_date('26-09-2015', 'dd-mm-yyyy'), 593350352, 'Luke', 'Dorothy', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (469, 'Taylor', 'Thomas', to_date('01-05-2020', 'dd-mm-yyyy'), 582555517, 'Austin', 'Zoe', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (470, 'Dylan', 'Wright', to_date('18-05-2022', 'dd-mm-yyyy'), 521868898, 'Nathan', 'Michelle', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (471, 'Joshua', 'Scott', to_date('28-06-2024', 'dd-mm-yyyy'), 531637872, 'George', 'Penelope', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (472, 'Adam', 'Thomas', to_date('07-06-2014', 'dd-mm-yyyy'), 520558017, 'Leonardo', 'Kimberly', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (473, 'Julian', 'Garcia', to_date('16-02-2023', 'dd-mm-yyyy'), 558540848, 'Richard', 'Hayley', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (474, 'Leah', 'Taylor', to_date('17-06-2006', 'dd-mm-yyyy'), 545462139, 'Cody', 'Maya', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (475, 'Luke', 'Adams', to_date('16-01-2007', 'dd-mm-yyyy'), 543996830, 'Isaiah', 'Joan', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (476, 'Joshua', 'Robinson', to_date('15-03-2019', 'dd-mm-yyyy'), 536676298, 'Diego', 'Charlotte', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (477, 'Lydia', 'Miller', to_date('07-10-2007', 'dd-mm-yyyy'), 558178262, 'Tyler', 'Abigail', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (478, 'Carlos', 'Miller', to_date('05-12-2020', 'dd-mm-yyyy'), 584472941, 'Cameron', 'Courtney', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (479, 'Douglas', 'Lewis', to_date('25-08-2022', 'dd-mm-yyyy'), 589261975, 'William', 'Luna', 28);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (480, 'John', 'Campbell', to_date('24-12-2020', 'dd-mm-yyyy'), 519939327, 'Sean', 'Lucy', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (481, 'Joshua', 'Hall', to_date('29-10-2014', 'dd-mm-yyyy'), 591762226, 'Travis', 'Amelia', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (482, 'Kristen', 'Hernandez', to_date('14-05-2011', 'dd-mm-yyyy'), 528972190, 'Harold', 'Rachel', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (483, 'Sophia', 'Rodriguez', to_date('23-04-2018', 'dd-mm-yyyy'), 565043692, 'Derek', 'Jade', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (484, 'Kyle', 'Davis', to_date('29-08-2022', 'dd-mm-yyyy'), 522176201, 'Wesley', 'Michelle', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (485, 'Noah', 'Roy', to_date('22-03-2022', 'dd-mm-yyyy'), 595271662, 'Brandon', 'Brenda', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (486, 'Andrew', 'Allen', to_date('12-07-2017', 'dd-mm-yyyy'), 540145845, 'Albert', 'Diana', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (487, 'Jasmine', 'Phillips', to_date('12-06-2022', 'dd-mm-yyyy'), 575434378, 'Gabriel', 'Ava', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (488, 'Isaiah', 'Taylor', to_date('20-06-2017', 'dd-mm-yyyy'), 572458986, 'Owen', 'Lucy', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (489, 'Hannah', 'Rodriguez', to_date('14-06-2012', 'dd-mm-yyyy'), 596509605, 'Tyler', 'Mia', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (490, 'Peyton', 'Johnson', to_date('02-12-2010', 'dd-mm-yyyy'), 526419787, 'Dennis', 'Hannah', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (491, 'Cody', 'Allen', to_date('23-06-2009', 'dd-mm-yyyy'), 536372889, 'Isaac', 'Kelly', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (492, 'Jayden', 'Lee', to_date('28-01-2014', 'dd-mm-yyyy'), 559026080, 'Abraham', 'Isabella', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (493, 'Tiffany', 'Mitchell', to_date('28-09-2010', 'dd-mm-yyyy'), 526229425, 'Sebastian', 'Jane', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (494, 'Natalie', 'Moore', to_date('31-08-2018', 'dd-mm-yyyy'), 577911766, 'Sebastian', 'Lauren', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (495, 'Patrick', 'Clark', to_date('27-11-2021', 'dd-mm-yyyy'), 525373755, 'Harold', 'Cheryl', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (496, 'Audrey', 'Robinson', to_date('14-09-2023', 'dd-mm-yyyy'), 564917666, 'Cole', 'Jessica', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (497, 'Alan', 'Wilson', to_date('30-06-2013', 'dd-mm-yyyy'), 511360739, 'Dustin', 'Maya', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (498, 'Bethany', 'Allen', to_date('25-11-2010', 'dd-mm-yyyy'), 594947206, 'Travis', 'Louise', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (499, 'Trevor', 'Walker', to_date('13-10-2011', 'dd-mm-yyyy'), 566911947, 'Douglas', 'Jasmine', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (500, 'Mia', 'Carter', to_date('12-02-2015', 'dd-mm-yyyy'), 585834404, 'Nathan', 'Fiona', 5);
commit;
prompt 500 records committed...
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (501, 'Alana', 'Jones', to_date('22-08-2008', 'dd-mm-yyyy'), 589091978, 'Joseph', 'Ashley', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (502, 'Joshua', 'Allen', to_date('08-03-2016', 'dd-mm-yyyy'), 554905373, 'Lawrence', 'Lauren', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (503, 'Kyle', 'Garcia', to_date('03-08-2023', 'dd-mm-yyyy'), 576755342, 'Aaron', 'Susan', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (504, 'Rebecca', 'Campbell', to_date('08-02-2011', 'dd-mm-yyyy'), 555012231, 'Jesse', 'Mia', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (505, 'Charlotte', 'Clark', to_date('10-06-2018', 'dd-mm-yyyy'), 587125922, 'Stephen', 'Angela', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (506, 'Jesse', 'Adams', to_date('16-08-2014', 'dd-mm-yyyy'), 584779557, 'Roy', 'Diana', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (507, 'Alan', 'Lopez', to_date('23-04-2020', 'dd-mm-yyyy'), 570859410, 'Roy', 'Tiffany', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (508, 'Stephanie', 'Jones', to_date('08-09-2012', 'dd-mm-yyyy'), 584390599, 'Eric', 'Peyton', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (509, 'Alexis', 'Wright', to_date('03-06-2023', 'dd-mm-yyyy'), 599941829, 'Sebastian', 'Charlene', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (510, 'Jayden', 'Lopez', to_date('30-11-2024', 'dd-mm-yyyy'), 575602109, 'William', 'Olivia', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (511, 'Brittany', 'Thomas', to_date('07-07-2020', 'dd-mm-yyyy'), 578887670, 'Juan', 'Alexandra', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (512, 'Dorothy', 'Davis', to_date('03-08-2010', 'dd-mm-yyyy'), 575881323, 'John', 'Agnes', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (513, 'Olivia', 'Taylor', to_date('05-10-2018', 'dd-mm-yyyy'), 571971865, 'Ezekiel', 'Reagan', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (514, 'Joan', 'Garcia', to_date('16-09-2008', 'dd-mm-yyyy'), 543387263, 'Daniel', 'Rebecca', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (515, 'Dorothy', 'Lopez', to_date('10-08-2006', 'dd-mm-yyyy'), 594713819, 'Chad', 'Alexis', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (516, 'Lauren', 'Hernandez', to_date('14-10-2020', 'dd-mm-yyyy'), 585367987, 'John', 'Brenda', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (517, 'Andrew', 'Hernandez', to_date('29-03-2006', 'dd-mm-yyyy'), 549660321, 'Cameron', 'Kristen', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (518, 'Isaiah', 'Scott', to_date('29-03-2006', 'dd-mm-yyyy'), 583797642, 'Julian', 'Shirley', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (519, 'Jack', 'Moore', to_date('10-12-2020', 'dd-mm-yyyy'), 558976142, 'Joan', 'Joan', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (520, 'Agnes', 'Rodriguez', to_date('11-10-2021', 'dd-mm-yyyy'), 558530673, 'Derek', 'Allison', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (521, 'Philip', 'Clark', to_date('06-09-2011', 'dd-mm-yyyy'), 579514546, 'Lawrence', 'Hannah', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (522, 'Douglas', 'Moore', to_date('24-03-2010', 'dd-mm-yyyy'), 578874412, 'Zachary', 'Leah', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (523, 'Dorothy', 'Clark', to_date('21-01-2006', 'dd-mm-yyyy'), 529184493, 'Aaron', 'Sheila', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (524, 'Owen', 'Garcia', to_date('17-01-2005', 'dd-mm-yyyy'), 563578217, 'Cole', 'Rebecca', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (525, 'Lucas', 'Nelson', to_date('27-12-2022', 'dd-mm-yyyy'), 599680777, 'Aaron', 'Lucia', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (526, 'Agnes', 'Jones', to_date('11-12-2013', 'dd-mm-yyyy'), 589199013, 'Austin', 'Danielle', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (527, 'Justin', 'Hernandez', to_date('20-02-2023', 'dd-mm-yyyy'), 551168807, 'David', 'Brittany', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (528, 'David', 'Lee', to_date('28-07-2015', 'dd-mm-yyyy'), 599610357, 'Nicholas', 'Taylor', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (529, 'Lori', 'Watson', to_date('26-11-2011', 'dd-mm-yyyy'), 580786248, 'Jesse', 'Ruby', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (530, 'Brandon', 'Lee', to_date('17-11-2012', 'dd-mm-yyyy'), 584748173, 'Jonathan', 'Ruby', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (531, 'Katherine', 'Lewis', to_date('24-06-2010', 'dd-mm-yyyy'), 562234140, 'Brandon', 'Jessica', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (532, 'Michelle', 'Davis', to_date('31-10-2007', 'dd-mm-yyyy'), 596374729, 'Felipe', 'Lisa', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (533, 'Brenda', 'Garcia', to_date('19-08-2008', 'dd-mm-yyyy'), 567454118, 'Douglas', 'Sandra', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (534, 'Benjamin', 'Garcia', to_date('26-06-2023', 'dd-mm-yyyy'), 565257856, 'Adrian', 'Jane', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (535, 'Jordan', 'Wilson', to_date('11-11-2011', 'dd-mm-yyyy'), 552776686, 'Abraham', 'Samantha', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (536, 'Sophia', 'Wilson', to_date('31-05-2021', 'dd-mm-yyyy'), 573636872, 'Kevin', 'Dorothy', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (537, 'Mia', 'Allen', to_date('28-06-2014', 'dd-mm-yyyy'), 528295129, 'Antonio', 'Isabella', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (538, 'Aaron', 'Lopez', to_date('17-12-2008', 'dd-mm-yyyy'), 558730194, 'Cameron', 'Kelly', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (539, 'Jennifer', 'Wilson', to_date('13-12-2021', 'dd-mm-yyyy'), 573576211, 'Kyle', 'Helena', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (540, 'Sharon', 'Hernandez', to_date('03-05-2006', 'dd-mm-yyyy'), 560037605, 'Jordan', 'Vivian', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (541, 'Pamela', 'Brown', to_date('02-11-2024', 'dd-mm-yyyy'), 573388892, 'Xavier', 'Vivian', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (542, 'Alice', 'Clark', to_date('03-03-2007', 'dd-mm-yyyy'), 599275027, 'Joshua', 'Sheila', 34);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (543, 'Jonathan', 'Walker', to_date('31-03-2011', 'dd-mm-yyyy'), 537922228, 'Walter', 'Alice', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (544, 'Kayla', 'Hernandez', to_date('31-03-2009', 'dd-mm-yyyy'), 552131356, 'Nathaniel', 'Audrey', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (545, 'Lauren', 'Lopez', to_date('10-08-2015', 'dd-mm-yyyy'), 594415213, 'Joseph', 'Claire', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (546, 'Molly', 'Rodriguez', to_date('15-07-2012', 'dd-mm-yyyy'), 578629179, 'Lawrence', 'Diana', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (547, 'Cody', 'Garcia', to_date('19-03-2012', 'dd-mm-yyyy'), 585996919, 'Benjamin', 'Danielle', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (548, 'Alexandra', 'Sanchez', to_date('05-04-2012', 'dd-mm-yyyy'), 515850530, 'Alan', 'Heather', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (549, 'Jack', 'Lewis', to_date('30-10-2021', 'dd-mm-yyyy'), 518893313, 'Thomas', 'Cecilia', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (550, 'Jack', 'Miller', to_date('13-01-2016', 'dd-mm-yyyy'), 593473969, 'Ezekiel', 'Ava', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (551, 'Agnes', 'Lopez', to_date('07-10-2011', 'dd-mm-yyyy'), 589763521, 'Nathan', 'Shirley', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (552, 'Ava', 'Clark', to_date('21-12-2021', 'dd-mm-yyyy'), 528422917, 'Vincent', 'Natalie', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (553, 'Juan', 'Robinson', to_date('11-03-2017', 'dd-mm-yyyy'), 582050929, 'Ezekiel', 'Lily', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (554, 'Bethany', 'Roy', to_date('22-12-2013', 'dd-mm-yyyy'), 569316969, 'Wyatt', 'Alexandra', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (555, 'Diego', 'Hernandez', to_date('16-10-2008', 'dd-mm-yyyy'), 526739358, 'Jacob', 'Heather', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (556, 'Maria', 'Roberts', to_date('18-09-2008', 'dd-mm-yyyy'), 588731670, 'Derek', 'Lily', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (557, 'Julia', 'Rodriguez', to_date('10-10-2008', 'dd-mm-yyyy'), 561606422, 'Abraham', 'Rachel', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (558, 'Alana', 'Rodriguez', to_date('21-08-2016', 'dd-mm-yyyy'), 565545671, 'Harold', 'Shirley', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (559, 'Samuel', 'Phillips', to_date('24-02-2020', 'dd-mm-yyyy'), 525292362, 'Juan', 'Ruby', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (560, 'Lydia', 'Thomas', to_date('02-02-2020', 'dd-mm-yyyy'), 540779562, 'Noah', 'Diana', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (561, 'Bethany', 'Scott', to_date('15-11-2014', 'dd-mm-yyyy'), 599685652, 'Nathan', 'Olivia', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (562, 'Danielle', 'Robinson', to_date('13-06-2007', 'dd-mm-yyyy'), 539099365, 'Henry', 'Nicole', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (563, 'Jonathan', 'Garcia', to_date('01-11-2005', 'dd-mm-yyyy'), 573222939, 'Alan', 'Kimberly', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (564, 'Robert', 'Kim', to_date('27-08-2022', 'dd-mm-yyyy'), 523192420, 'Justin', 'Karen', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (565, 'Charles', 'Lopez', to_date('19-02-2022', 'dd-mm-yyyy'), 583121550, 'Oliver', 'Leslie', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (566, 'Charles', 'Rodriguez', to_date('11-12-2016', 'dd-mm-yyyy'), 595248105, 'Nathaniel', 'Heather', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (567, 'Stephen', 'Rogers', to_date('31-08-2015', 'dd-mm-yyyy'), 560866111, 'Christopher', 'Charlene', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (568, 'Eric', 'Davis', to_date('20-03-2013', 'dd-mm-yyyy'), 579896592, 'Douglas', 'Lauren', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (569, 'Carlos', 'Moore', to_date('08-09-2018', 'dd-mm-yyyy'), 526903654, 'Miguel', 'Samantha', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (570, 'Lawrence', 'Hernandez', to_date('05-04-2017', 'dd-mm-yyyy'), 593918858, 'William', 'Lisa', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (571, 'Ezekiel', 'Nguyen', to_date('14-08-2018', 'dd-mm-yyyy'), 527383863, 'Samuel', 'Lillian', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (572, 'Stephen', 'Rodriguez', to_date('17-03-2024', 'dd-mm-yyyy'), 541137056, 'Brian', 'Leslie', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (573, 'Julian', 'Garcia', to_date('20-01-2012', 'dd-mm-yyyy'), 589857085, 'Christopher', 'Ruby', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (574, 'Charlotte', 'Young', to_date('01-07-2022', 'dd-mm-yyyy'), 555264424, 'William', 'Lydia', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (575, 'Vincent', 'Nguyen', to_date('28-03-2023', 'dd-mm-yyyy'), 564316966, 'Jayden', 'Natalie', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (576, 'Diana', 'Adams', to_date('16-05-2012', 'dd-mm-yyyy'), 593531629, 'Shannon', 'Alexandra', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (577, 'Peyton', 'Lewis', to_date('05-04-2012', 'dd-mm-yyyy'), 571532098, 'Scott', 'Bridget', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (578, 'Luke', 'Mitchell', to_date('22-07-2008', 'dd-mm-yyyy'), 510706307, 'Travis', 'Diana', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (579, 'Miguel', 'Hall', to_date('24-01-2016', 'dd-mm-yyyy'), 589840333, 'Douglas', 'Olivia', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (580, 'Gregory', 'Lewis', to_date('06-11-2008', 'dd-mm-yyyy'), 543090541, 'Joseph', 'Danielle', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (581, 'Wesley', 'Williams', to_date('10-06-2012', 'dd-mm-yyyy'), 513708560, 'George', 'Sandra', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (582, 'Jonathan', 'Anderson', to_date('18-05-2022', 'dd-mm-yyyy'), 577228412, 'Justin', 'Jessica', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (583, 'Richard', 'Young', to_date('20-03-2011', 'dd-mm-yyyy'), 562951274, 'Cameron', 'Lucy', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (584, 'Kevin', 'Brown', to_date('22-02-2022', 'dd-mm-yyyy'), 513857917, 'Diego', 'Alicia', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (585, 'Linda', 'Wright', to_date('18-03-2019', 'dd-mm-yyyy'), 551967143, 'Philip', 'Angela', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (586, 'Danielle', 'Martinez', to_date('22-02-2023', 'dd-mm-yyyy'), 598164065, 'George', 'Dorothy', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (587, 'Diana', 'King', to_date('11-10-2005', 'dd-mm-yyyy'), 537683003, 'Xavier', 'Nicole', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (588, 'Dennis', 'Scott', to_date('19-04-2009', 'dd-mm-yyyy'), 591061170, 'Keith', 'Kristen', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (589, 'Kelly', 'Rogers', to_date('29-08-2014', 'dd-mm-yyyy'), 596571631, 'Sean', 'Alexis', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (590, 'Benjamin', 'Phillips', to_date('30-10-2019', 'dd-mm-yyyy'), 533646937, 'Nathaniel', 'Aisha', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (591, 'Jayden', 'Miller', to_date('18-05-2016', 'dd-mm-yyyy'), 592794306, 'Scott', 'Bethany', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (592, 'Margaret', 'Lee', to_date('22-04-2012', 'dd-mm-yyyy'), 535593860, 'Nathaniel', 'Angela', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (593, 'Leonardo', 'Walker', to_date('26-12-2022', 'dd-mm-yyyy'), 548412117, 'Antonio', 'Kayla', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (594, 'Shannon', 'Johnson', to_date('26-01-2014', 'dd-mm-yyyy'), 572320344, 'George', 'Lydia', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (595, 'Susan', 'Hernandez', to_date('28-09-2014', 'dd-mm-yyyy'), 567304037, 'Brian', 'Linda', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (596, 'Ryan', 'Jones', to_date('27-01-2020', 'dd-mm-yyyy'), 540859206, 'Ronald', 'Pamela', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (597, 'Sebastian', 'King', to_date('16-10-2011', 'dd-mm-yyyy'), 534231552, 'John', 'Cecilia', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (598, 'Eric', 'Cruz', to_date('01-10-2021', 'dd-mm-yyyy'), 595507661, 'Sean', 'Evelyn', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (599, 'Jade', 'Jones', to_date('05-03-2006', 'dd-mm-yyyy'), 593101954, 'Douglas', 'Lori', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (600, 'Albert', 'Lopez', to_date('16-04-2013', 'dd-mm-yyyy'), 595256806, 'Samuel', 'Leslie', 4);
commit;
prompt 600 records committed...
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (601, 'Courtney', 'Campbell', to_date('10-05-2009', 'dd-mm-yyyy'), 534747728, 'Tyler', 'Carla', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (602, 'Aisha', 'Allen', to_date('18-01-2022', 'dd-mm-yyyy'), 539364334, 'Joshua', 'Audrey', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (603, 'Laura', 'Rogers', to_date('21-11-2013', 'dd-mm-yyyy'), 597590684, 'Jacob', 'Maria', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (604, 'Paul', 'Garcia', to_date('06-07-2007', 'dd-mm-yyyy'), 544134930, 'Carlos', 'Charlene', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (605, 'Evelyn', 'Campbell', to_date('01-08-2023', 'dd-mm-yyyy'), 570282411, 'Joan', 'Jade', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (606, 'Isaac', 'Anderson', to_date('15-08-2011', 'dd-mm-yyyy'), 516079904, 'Ryan', 'Shirley', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (607, 'Daniel', 'Garcia', to_date('16-02-2022', 'dd-mm-yyyy'), 536112708, 'Xavier', 'Hannah', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (608, 'Christopher', 'Allen', to_date('08-07-2014', 'dd-mm-yyyy'), 579253766, 'Henry', 'Leah', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (609, 'Alicia', 'Williams', to_date('02-08-2006', 'dd-mm-yyyy'), 528837993, 'Samuel', 'Caroline', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (610, 'Penelope', 'Campbell', to_date('17-06-2014', 'dd-mm-yyyy'), 551120257, 'Dennis', 'Diana', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (611, 'Philip', 'Rodriguez', to_date('28-02-2007', 'dd-mm-yyyy'), 548625592, 'Henry', 'Jennifer', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (612, 'Madison', 'Scott', to_date('11-10-2014', 'dd-mm-yyyy'), 548413117, 'Jacob', 'Alexis', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (613, 'Samantha', 'Lee', to_date('05-02-2009', 'dd-mm-yyyy'), 533722821, 'Philip', 'Jennifer', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (614, 'Sophia', 'Miller', to_date('25-01-2009', 'dd-mm-yyyy'), 590291749, 'Carlos', 'Linda', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (615, 'Molly', 'Robinson', to_date('10-10-2021', 'dd-mm-yyyy'), 582699161, 'Cole', 'Natalie', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (616, 'Philip', 'Anderson', to_date('24-06-2005', 'dd-mm-yyyy'), 595155058, 'Henry', 'Ashley', 15);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (617, 'Chad', 'Lewis', to_date('28-08-2020', 'dd-mm-yyyy'), 553927545, 'John', 'Rachel', 19);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (618, 'Sarah', 'Williams', to_date('28-01-2008', 'dd-mm-yyyy'), 563159031, 'Joan', 'Alexis', 6);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (619, 'Michelle', 'Nguyen', to_date('05-08-2017', 'dd-mm-yyyy'), 578867512, 'Joshua', 'Allison', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (620, 'Allison', 'Hernandez', to_date('30-06-2016', 'dd-mm-yyyy'), 598089613, 'Luke', 'Claire', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (621, 'Laura', 'Robinson', to_date('16-06-2010', 'dd-mm-yyyy'), 525105403, 'Joseph', 'Joan', 36);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (622, 'Ronald', 'Lopez', to_date('27-09-2017', 'dd-mm-yyyy'), 548349087, 'Ethan', 'Bethany', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (623, 'Jillian', 'Wilson', to_date('25-02-2018', 'dd-mm-yyyy'), 573589835, 'Robert', 'Molly', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (624, 'Caleb', 'Rodriguez', to_date('24-12-2006', 'dd-mm-yyyy'), 549622450, 'Daniel', 'Stephanie', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (625, 'Samuel', 'Lee', to_date('01-06-2017', 'dd-mm-yyyy'), 523927646, 'Chad', 'Maria', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (626, 'Antonio', 'Robinson', to_date('17-03-2016', 'dd-mm-yyyy'), 591888620, 'Sebastian', 'Lucia', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (627, 'Julia', 'Wilson', to_date('20-06-2023', 'dd-mm-yyyy'), 562839649, 'Andrew', 'Nancy', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (628, 'Isaac', 'Moore', to_date('28-08-2015', 'dd-mm-yyyy'), 534351674, 'Gabriel', 'Danielle', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (629, 'Charlene', 'Johnson', to_date('12-06-2018', 'dd-mm-yyyy'), 588247679, 'Adrian', 'Charlene', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (630, 'Alan', 'Anderson', to_date('22-02-2010', 'dd-mm-yyyy'), 586482014, 'Antonio', 'Deborah', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (631, 'Walter', 'Scott', to_date('30-07-2019', 'dd-mm-yyyy'), 569937029, 'Justin', 'Heather', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (632, 'Catherine', 'Nguyen', to_date('15-10-2017', 'dd-mm-yyyy'), 548889300, 'Daniel', 'Madison', 40);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (633, 'Harold', 'Jones', to_date('21-05-2010', 'dd-mm-yyyy'), 518328382, 'Chad', 'Sophia', 16);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (634, 'Charlene', 'Moore', to_date('08-05-2019', 'dd-mm-yyyy'), 514698377, 'Dustin', 'Angela', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (635, 'Alan', 'Walker', to_date('06-05-2021', 'dd-mm-yyyy'), 582071308, 'Caleb', 'Julia', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (636, 'Zachary', 'Moore', to_date('04-05-2019', 'dd-mm-yyyy'), 599932265, 'Nathan', 'Amelia', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (637, 'Ronald', 'Lopez', to_date('19-11-2020', 'dd-mm-yyyy'), 538675573, 'Nathan', 'Kristen', 4);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (638, 'Lawrence', 'Roberts', to_date('31-05-2018', 'dd-mm-yyyy'), 598642402, 'Paul', 'Diana', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (639, 'Isabella', 'Robinson', to_date('19-05-2005', 'dd-mm-yyyy'), 577637063, 'Kyle', 'Evelyn', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (640, 'Lillian', 'Harris', to_date('23-08-2006', 'dd-mm-yyyy'), 563103381, 'Felipe', 'Lisa', 10);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (641, 'Rebecca', 'Mitchell', to_date('08-08-2014', 'dd-mm-yyyy'), 527727499, 'Chad', 'Jennifer', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (642, 'Adam', 'Allen', to_date('12-09-2012', 'dd-mm-yyyy'), 510516990, 'Timothy', 'Rebecca', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (643, 'Alicia', 'Wright', to_date('19-09-2017', 'dd-mm-yyyy'), 586953159, 'Stephen', 'Samantha', 1);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (644, 'David', 'Moore', to_date('06-01-2009', 'dd-mm-yyyy'), 592883965, 'Cameron', 'Kristen', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (645, 'John', 'Johnson', to_date('16-06-2008', 'dd-mm-yyyy'), 599406644, 'Xavier', 'Teresa', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (646, 'Kimberly', 'Johnson', to_date('04-03-2015', 'dd-mm-yyyy'), 579087866, 'Juan', 'Monica', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (647, 'Travis', 'Johnson', to_date('23-01-2009', 'dd-mm-yyyy'), 597185745, 'Harold', 'Jillian', 31);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (648, 'Walter', 'Campbell', to_date('31-05-2019', 'dd-mm-yyyy'), 569929919, 'Xavier', 'Lydia', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (649, 'Monica', 'Lopez', to_date('05-11-2010', 'dd-mm-yyyy'), 586441380, 'Isaac', 'Alexis', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (650, 'Jennifer', 'Watson', to_date('06-05-2023', 'dd-mm-yyyy'), 556772169, 'Brandon', 'Michelle', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (651, 'Shirley', 'Garcia', to_date('15-06-2006', 'dd-mm-yyyy'), 549206669, 'Christopher', 'Heather', 33);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (652, 'Jordan', 'Cruz', to_date('30-09-2019', 'dd-mm-yyyy'), 565719292, 'Patrick', 'Kimberly', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (653, 'Brittany', 'Mitchell', to_date('24-12-2010', 'dd-mm-yyyy'), 583193338, 'Luke', 'Cecilia', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (654, 'Joseph', 'Jones', to_date('25-09-2022', 'dd-mm-yyyy'), 539058996, 'Timothy', 'Charlotte', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (655, 'Amelia', 'Walker', to_date('12-03-2010', 'dd-mm-yyyy'), 530183231, 'Austin', 'Kimberly', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (656, 'Danielle', 'Clark', to_date('24-01-2010', 'dd-mm-yyyy'), 539683208, 'Dustin', 'Claire', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (657, 'Alexandra', 'Garcia', to_date('31-12-2012', 'dd-mm-yyyy'), 588721025, 'Noah', 'Hannah', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (658, 'David', 'Lopez', to_date('18-08-2022', 'dd-mm-yyyy'), 540487212, 'Philip', 'Deborah', 14);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (659, 'Jade', 'Young', to_date('09-09-2007', 'dd-mm-yyyy'), 580462552, 'Cody', 'Penelope', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (660, 'Paul', 'Martinez', to_date('13-10-2005', 'dd-mm-yyyy'), 514960332, 'Kyle', 'Samantha', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (661, 'Adam', 'Scott', to_date('11-08-2017', 'dd-mm-yyyy'), 516905686, 'Alan', 'Jacqueline', 25);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (662, 'Jack', 'Nelson', to_date('27-10-2023', 'dd-mm-yyyy'), 515300089, 'Julian', 'Ruby', 32);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (663, 'Sebastian', 'Hernandez', to_date('01-06-2024', 'dd-mm-yyyy'), 559178399, 'Sebastian', 'Lily', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (664, 'Stephanie', 'Hernandez', to_date('14-08-2023', 'dd-mm-yyyy'), 597887408, 'Anthony', 'Lori', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (665, 'Lucas', 'Clark', to_date('20-09-2016', 'dd-mm-yyyy'), 540550571, 'Tyler', 'Fiona', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (666, 'Brittany', 'Lee', to_date('13-07-2008', 'dd-mm-yyyy'), 534565097, 'Travis', 'Cecilia', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (667, 'Monica', 'Nguyen', to_date('12-03-2022', 'dd-mm-yyyy'), 592992060, 'Brian', 'Victoria', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (668, 'Ava', 'Hernandez', to_date('14-08-2017', 'dd-mm-yyyy'), 594402160, 'Theodore', 'Rachel', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (669, 'Stephanie', 'Rodriguez', to_date('15-06-2011', 'dd-mm-yyyy'), 591340477, 'Joshua', 'Jade', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (670, 'Deborah', 'Rodriguez', to_date('25-05-2020', 'dd-mm-yyyy'), 579641392, 'Albert', 'Deborah', 20);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (671, 'Sean', 'Robinson', to_date('15-01-2009', 'dd-mm-yyyy'), 517431477, 'Eric', 'Alice', 17);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (672, 'Bethany', 'Thompson', to_date('23-04-2008', 'dd-mm-yyyy'), 523470854, 'Joseph', 'Lillian', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (673, 'Pamela', 'Williams', to_date('21-03-2018', 'dd-mm-yyyy'), 523531974, 'Oliver', 'Leah', 11);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (674, 'Ethan', 'Anderson', to_date('17-12-2020', 'dd-mm-yyyy'), 578241507, 'Benjamin', 'Diana', 9);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (675, 'Ava', 'Garcia', to_date('18-08-2018', 'dd-mm-yyyy'), 583364386, 'Leonardo', 'Nicole', 23);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (676, 'Abigail', 'Miller', to_date('21-01-2006', 'dd-mm-yyyy'), 559512168, 'Xavier', 'Courtney', 13);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (677, 'Andrew', 'Rodriguez', to_date('20-12-2010', 'dd-mm-yyyy'), 578362269, 'Jordan', 'Claire', 3);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (678, 'Phoebe', 'Wright', to_date('18-02-2021', 'dd-mm-yyyy'), 556936116, 'Jordan', 'Margaret', 30);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (679, 'Ashley', 'Moore', to_date('29-03-2020', 'dd-mm-yyyy'), 511013323, 'Nathaniel', 'Louise', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (680, 'Hannah', 'Rogers', to_date('09-01-2014', 'dd-mm-yyyy'), 568268137, 'Cody', 'Sheila', 21);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (681, 'Gabriel', 'Moore', to_date('29-08-2019', 'dd-mm-yyyy'), 590733955, 'Abraham', 'Lauren', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (682, 'Xavier', 'Hernandez', to_date('02-11-2006', 'dd-mm-yyyy'), 563721749, 'Edward', 'Jessica', 22);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (683, 'Caleb', 'Lewis', to_date('17-01-2021', 'dd-mm-yyyy'), 527589310, 'Keith', 'Kimberly', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (684, 'Travis', 'Smith', to_date('20-03-2021', 'dd-mm-yyyy'), 547157038, 'Miguel', 'Audrey', 24);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (685, 'Bridget', 'Robinson', to_date('26-06-2010', 'dd-mm-yyyy'), 559801222, 'Sebastian', 'Madison', 18);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (686, 'Brenda', 'Thomas', to_date('07-01-2021', 'dd-mm-yyyy'), 524696781, 'Miguel', 'Fiona', 38);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (687, 'Lawrence', 'Garcia', to_date('08-01-2010', 'dd-mm-yyyy'), 521575431, 'Zachary', 'Ashley', 26);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (688, 'Natalie', 'Allen', to_date('03-06-2006', 'dd-mm-yyyy'), 546803125, 'Theodore', 'Meghan', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (689, 'Philip', 'Clark', to_date('13-05-2006', 'dd-mm-yyyy'), 572557971, 'Keith', 'Olivia', 35);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (690, 'Austin', 'Wilson', to_date('07-09-2024', 'dd-mm-yyyy'), 562997529, 'Anthony', 'Phoebe', 5);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (691, 'Zachary', 'Hernandez', to_date('26-08-2021', 'dd-mm-yyyy'), 515637708, 'Antonio', 'Samantha', 37);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (692, 'Claudia', 'Lopez', to_date('03-07-2020', 'dd-mm-yyyy'), 521090591, 'Nathan', 'Karen', 2);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (693, 'Nancy', 'Martinez', to_date('19-07-2022', 'dd-mm-yyyy'), 567152236, 'Keith', 'Lucy', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (694, 'Hannah', 'Walker', to_date('26-03-2021', 'dd-mm-yyyy'), 527155110, 'Ethan', 'Louise', 12);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (695, 'Luke', 'Allen', to_date('19-07-2007', 'dd-mm-yyyy'), 533313858, 'Sebastian', 'Samantha', 27);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (696, 'Luna', 'Walker', to_date('11-05-2017', 'dd-mm-yyyy'), 577689639, 'Paul', 'Olivia', 7);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (697, 'Jennifer', 'Williams', to_date('15-07-2018', 'dd-mm-yyyy'), 513727916, 'Lucas', 'Catherine', 8);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (698, 'Diego', 'Moore', to_date('16-06-2006', 'dd-mm-yyyy'), 558699771, 'Albert', 'Alana', 39);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (699, 'Alexis', 'Hall', to_date('27-06-2010', 'dd-mm-yyyy'), 541105192, 'Javier', 'Abigail', 29);
insert into STUDENT (student_id, first_name, last_name, birth_date, phone, fathername, mothername, class_id)
values (700, 'Javier', 'Clark', to_date('07-10-2024', 'dd-mm-yyyy'), 590979759, 'Kevin', 'Meghan', 10);
commit;
prompt 700 records loaded
prompt Enabling foreign key constraints for CLASS_...
alter table CLASS_ enable constraint SYS_C007314;
alter table CLASS_ enable constraint SYS_C007315;
prompt Enabling foreign key constraints for LESSON...
alter table LESSON enable constraint SYS_C007322;
alter table LESSON enable constraint SYS_C007323;
alter table LESSON enable constraint SYS_C007324;
prompt Enabling foreign key constraints for STUDENT...
alter table STUDENT enable constraint SYS_C007340;
prompt Enabling triggers for ROOM...
alter table ROOM enable all triggers;
prompt Enabling triggers for TEACHER...
alter table TEACHER enable all triggers;
prompt Enabling triggers for CLASS_...
alter table CLASS_ enable all triggers;
prompt Enabling triggers for SUBJECT...
alter table SUBJECT enable all triggers;
prompt Enabling triggers for LESSON...
alter table LESSON enable all triggers;
prompt Enabling triggers for STUDENT...
alter table STUDENT enable all triggers;
set feedback on
set define on
prompt Done.
