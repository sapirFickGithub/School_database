--delete all the student that have a invalid birthDate
DELETE FROM Student
WHERE birth_date > TO_DATE('2018-01-01', 'YYYY-MM-DD')
   OR birth_date < TO_DATE('2005-01-01', 'YYYY-MM-DD');
