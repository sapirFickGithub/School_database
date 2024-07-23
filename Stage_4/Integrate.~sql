-- removing the many to many relationship between teacher and workshop
drop table teach;


-------------------------------------------------------------------------
-- merge room & rooms tables

-- adding the missing columns
alter table ROOMS
ADD (is_lab number(1));
alter table ROOMS
ADD (last_maintenance_check date);

-- preventing ID duplicates and correcting all dependents
-- find constraints
SELECT uc.constraint_name, ucc.column_name, uc.table_name AS child_table, uc.r_constraint_name, uc.constraint_type
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'SCHEDULER'
  AND uc.constraint_type = 'R';
-- disabling foriegn key constraint
ALTER TABLE scheduler
DISABLE CONSTRAINT SYS_C007703;
-- udating dependent table
UPDATE scheduler
SET ROOM_ID = ROOM_ID + 400;
-- updating room ID
UPDATE ROOMS
SET ROOM_ID = ROOM_ID + 400;
commit;

-- enabling dependents constraints
ALTER TABLE scheduler
ENABLE CONSTRAINT SYS_C007703;

-- merge room & rooms data
INSERT INTO ROOMS (ROOM_ID, ROOM_CAPACITY, IS_LAB, LAST_MAINTENANCE_CHECK)
SELECT ROOM_ID, MAX_CAPACITY, IS_LAB, LAST_MAINTENANCE_CHECK
FROM ROOM;
commit;

--delete ROOM and all dependencies
-- find foriegn key constraint
SELECT uc.constraint_name, ucc.column_name, uc.table_name AS child_table, uc.r_constraint_name, uc.constraint_type
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'CLASS_'
  AND uc.constraint_type = 'R';
  
-- remove constraint
ALTER TABLE class_
DROP CONSTRAINT SYS_C007539;

-- alter constraint to depend on rooms
ALTER TABLE class_
ADD CONSTRAINT SYS_C007539
FOREIGN KEY (ROOM_ID)
REFERENCES ROOMS(ROOM_ID);

-- after all alterations we can remove the dup table
drop table ROOM;

-----------------------------------------------------------------------------

-- merge teacher and teachers tables

-- adding the missing columns
alter table Teachers
ADD (bonus number);

-- preventing ID duplicates and correcting all dependents
-- find constraints
SELECT uc.constraint_name, ucc.column_name, uc.table_name AS child_table, uc.r_constraint_name, uc.constraint_type
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'SCHEDULER'
  AND uc.constraint_type = 'R';
  
-- disabling foriegn key constraint
ALTER TABLE scheduler
disable CONSTRAINT SYS_C007704;
-- udating dependent table
UPDATE scheduler
SET TEACHER_ID = TEACHER_ID + 400;

-- updating teacher ID
UPDATE TEACHERS
SET  TEACHER_ID =  TEACHER_ID + 400;
commit;

-- enabling foriegn key constraint
ALTER TABLE scheduler
enable CONSTRAINT SYS_C007704;

-- merge teacher & tachers data
INSERT INTO TEACHERS (TEACHER_ID, TEACHER_FNAME, TEACHER_LNAME, TEACHER_SALARY, BONUS)
SELECT TEACHER_ID, TFIRST_NAME, TLAST_NAME, HOURLY_SALARY, BONUS
FROM TEACHER;

commit;

--delete TEACHER and all dependencies
-- find foriegn key constraint
SELECT uc.constraint_name, ucc.column_name, uc.table_name AS child_table, uc.r_constraint_name, uc.constraint_type
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE (uc.table_name = 'CLASS_' or uc.table_name = 'LESSON')
  AND uc.constraint_type = 'R';
  
-- remove constraint
ALTER TABLE class_
DROP CONSTRAINT SYS_C007538;
ALTER TABLE lesson
DROP CONSTRAINT SYS_C007552;


-- alter constraint to depend on teachers
ALTER TABLE class_
ADD CONSTRAINT SYS_C007538
FOREIGN KEY (TEACHER_ID)
REFERENCES TEACHERS(TEACHER_ID);

ALTER TABLE lesson
ADD CONSTRAINT SYS_C007552
FOREIGN KEY (TEACHER_ID)
REFERENCES TEACHERS(TEACHER_ID);

-- after all alterations we can remove the dup table
drop table TEACHER;

-----------------------------------------------------------------------------------

-- merge clients and student tables

-- adding the missing columns
alter table clients
ADD (father_name varchar2(15));
alter table clients
ADD (mother_name varchar2(15));
alter table clients
ADD (class_id number(3));

-- make student_id longer
ALTER TABLE student
MODIFY (student_id number(5))

-- updating student ID
UPDATE student
SET  student_id =  student_id + 1499;
commit;

-- merge clients & student data
INSERT INTO CLIENTS (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_TEL, BIRTHDAY, FATHER_NAME, MOTHER_NAME, CLASS_ID)
SELECT STUDENT_ID, FIRST_NAME, LAST_NAME, PHONE, BIRTH_DATE, FATHERNAME, MOTHERNAME, CLASS_ID
FROM STUDENT;

commit;

-- after all alterations we can remove the dup table
drop table STUDENT;

----------------------------------------------------------------------------------

-- merge subject & workshop

-- adding the missing columns
alter table workshops
ADD (mandatory number(1) DEFAULT 0);


-- preventing ID duplicates and correcting all dependents
-- find constraints
SELECT uc.constraint_name, ucc.column_name, uc.table_name AS child_table, uc.r_constraint_name, uc.constraint_type
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'SCHEDULER'
  AND uc.constraint_type = 'R';
  
-- disabling foriegn key constraint
ALTER TABLE scheduler
disable CONSTRAINT SYS_C007702;
-- udating dependent table
UPDATE scheduler
SET WORKSHOP_ID = WORKSHOP_ID + 52;
-- udating workshop table
UPDATE WORKSHOPS
SET WORKSHOP_ID = WORKSHOP_ID + 52;
commit;

-- enabling foriegn key constraint
ALTER TABLE scheduler
enable CONSTRAINT SYS_C007702;

-- make workshop name longer
ALTER TABLE workshops
MODIFY (workshop_name varchar2(30))


-- merge subject & workshops data
INSERT INTO WORKSHOPS (WORKSHOP_ID, WORKSHOP_NAME, MANDATORY)
SELECT SUBJECT_ID, SUBJECT_NAME, MANDATORY
FROM SUBJECT;

commit;


--delete SUBJECT and all dependencies
-- find foriegn key constraint
SELECT uc.constraint_name, ucc.column_name, uc.table_name AS child_table, uc.r_constraint_name, uc.constraint_type
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'LESSON'
  AND uc.constraint_type = 'R';
  
-- remove constraint
ALTER TABLE lesson
DROP CONSTRAINT SYS_C007553;

-- alter constraint to depend on teachers
ALTER TABLE lesson
ADD CONSTRAINT SYS_C007553
FOREIGN KEY (SUBJECT_ID)
REFERENCES WORKSHOPS(WORKSHOP_ID);

-- after all alterations we can remove the dup table
drop table subject;

---------------------------------------------------------------------------------------

-- merge scheduler and lesson taables

-- adding the missing columns
alter table scheduler
ADD (class_id number(3));

ALTER TABLE SCHEDULER
ADD CONSTRAINT fk_class_
FOREIGN KEY (class_id)
REFERENCES class_(class_id);

-- udating workshop table
UPDATE SCHEDULER
SET SCHEDULER_ID = SCHEDULER_ID + 450;
commit;

-- remove unique constraint
ALTER TABLE SCHEDULER
DROP CONSTRAINT SYS_C007699;

-- index based function to avoid loooing at null values as unique constraint violaion
CREATE UNIQUE INDEX unique_day_hour_room
ON SCHEDULER (
    SC_DAY,
    SC_TIME,
    NVL(ROOM_ID, TO_CHAR(SCHEDULER_ID))
);

-- merge subject & workshops data
INSERT INTO SCHEDULER (SC_TIME, SC_DAY, SCHEDULER_ID, WORKSHOP_ID, TEACHER_ID, CLASS_ID )
SELECT LESSON_HOUR,LESSON_DAY, LESSON_ID, SUBJECT_ID, TEACHER_ID, CLASS_ID
FROM LESSON;

commit;

-- after all alterations we can remove the dup table
drop table lesson;



