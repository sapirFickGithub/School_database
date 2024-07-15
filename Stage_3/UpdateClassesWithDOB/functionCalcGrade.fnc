CREATE OR REPLACE FUNCTION functionCalcGrade(studentID IN NUMBER) RETURN NUMBER IS
  result NUMBER;
  birthDate DATE;
  birthYear NUMBER;
  currentYear NUMBER := EXTRACT(YEAR FROM SYSDATE);
BEGIN
    SELECT birth_date INTO birthDate
    FROM Student
    WHERE Student_ID = studentID;
    
    birthYear := EXTRACT(YEAR FROM birthDate);
    result := currentYear - birthYear - 5;
    
    RETURN result;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student not found');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RETURN NULL;
END functionCalcGrade;
/
