CREATE OR REPLACE PROCEDURE Main AS
    v_new_grade NUMBER;
    v_new_class_id NUMBER;
    v_changes_made NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting update_student_classes procedure');
    FOR student_rec IN (SELECT Student_ID, birth_date, Class_ID FROM Student) LOOP
        DBMS_OUTPUT.PUT_LINE('Processing Student ID: ' || student_rec.Student_ID);
        v_new_grade := functionCalcGrade(student_rec.student_id);
        DBMS_OUTPUT.PUT_LINE('Calculated Grade: ' || v_new_grade);
        v_new_class_id := find_or_create_class(v_new_grade);
        DBMS_OUTPUT.PUT_LINE('Found/Created Class ID: ' || v_new_class_id);
        
        IF v_new_class_id != student_rec.Class_ID THEN
            UPDATE Student
            SET Class_ID = v_new_class_id
            WHERE Student_ID = student_rec.Student_ID;
            v_changes_made := v_changes_made + 1;
            DBMS_OUTPUT.PUT_LINE('Updated Student ' || student_rec.Student_ID || ' to Class ' || v_new_class_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('No change needed for Student ' || student_rec.Student_ID);
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total changes made: ' || v_changes_made);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Changes committed');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END Main;
/
