-- adding two columns to teacher table and setting initial values
ALTER TABLE TEACHER ADD (hourly_salary NUMBER);
ALTER TABLE TEACHER ADD (bonus NUMBER);

UPDATE TEACHER SET hourly_salary = 35;
UPDATE TEACHER SET bonus = 0;

