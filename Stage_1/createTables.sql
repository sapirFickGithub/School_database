CREATE TABLE Teacher
(
  Teacher_ID NUMBER(3),
  TLast_Name VARCHAR2(15) NOT NULL,
  TFirst_Name VARCHAR2(15) NOT NULL,
  PRIMARY KEY (Teacher_ID)
);

CREATE TABLE Room
(
  Room_ID NUMBER(3),
  Max_Capacity INT NOT NULL,
  is_lab NUMBER(1),
  Last_maintenance_check DATE,
  PRIMARY KEY (Room_ID),
  CHECK (is_lab = 1 OR is_lab = 0)

);

CREATE TABLE Subject
(
  Subject_ID NUMBER(3),
  Subject_Name VARCHAR2(30) NOT NULL,
  mandatory number(1) NOT NULL,
  PRIMARY KEY (Subject_ID),
  CHECK (mandatory = 1 OR mandatory = 0)

);

CREATE TABLE Class_
(
  Class_ID NUMBER(3),
  Grade NUMBER(2) NOT NULL,
  Teacher_ID NUMBER(3) NOT NULL,
  Room_ID NUMBER(3) NOT NULL,
  PRIMARY KEY (Class_ID),
  FOREIGN KEY (Teacher_ID) REFERENCES Teacher(Teacher_ID),
  FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

CREATE TABLE Lesson
(
  Lesson_ID NUMBER(3),
  Lesson_Day INT NOT NULL,
  Lesson_Hour INT NOT NULL,
  Class_ID NUMBER(3),
  Teacher_ID NUMBER(3),
  Subject_ID NUMBER(3),
  PRIMARY KEY (Lesson_ID),
  FOREIGN KEY (Class_ID) REFERENCES Class_(Class_ID),
  FOREIGN KEY (Teacher_ID) REFERENCES Teacher(Teacher_ID),
  FOREIGN KEY (Subject_ID) REFERENCES Subject(Subject_ID),
  UNIQUE (Class_ID, Lesson_Day, Lesson_Hour),
  UNIQUE (Teacher_ID, Lesson_Day, Lesson_Hour),
  CHECK (Lesson_Day BETWEEN 1 AND 6)
);

CREATE TABLE Student
(
  Student_ID NUMBER(3),
  First_Name VARCHAR(15) NOT NULL,
  Last_Name VARCHAR2(15) NOT NULL,
  birth_date DATE NOT NULL,
  Phone INT NOT NULL,
  fatherName VARCHAR(15) NOT NULL,
  motherName VARCHAR(15) NOT NULL,
  Class_ID NUMBER(3),
  PRIMARY KEY (Student_ID),
  FOREIGN KEY (Class_ID) REFERENCES Class_(Class_ID)
);
