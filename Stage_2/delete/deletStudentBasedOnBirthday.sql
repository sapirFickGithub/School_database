--delete all the student that have a invalid birthDate
DELETE FROM Student
WHERE birth_date > ADD_MONTHS(SYSDATE, -12*6)  -- Younger than 6 years old
   OR birth_date < ADD_MONTHS(SYSDATE, -12*18);  
