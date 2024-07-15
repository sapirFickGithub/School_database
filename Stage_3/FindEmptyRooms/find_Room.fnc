CREATE OR REPLACE PROCEDURE class_students(classid IN class_.class_id%TYPE) IS
    classS SYS_REFCURSOR;
    v_id student.student_id%TYPE;
    v_name student.first_name%TYPE;
BEGIN
    OPEN classS FOR
        SELECT s.student_id AS id, s.first_name AS nam
        FROM student s
        JOIN class_ c ON s.class_id = c.class_id
        WHERE c.class_id = classid;

    LOOP
        FETCH classS INTO v_id, v_name;
        EXIT WHEN classS%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Name: ' || v_name);
    END LOOP;

    CLOSE classS;
END class_students;
/
