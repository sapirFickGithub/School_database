CREATE OR REPLACE FUNCTION find_or_create_class(p_grade NUMBER) RETURN NUMBER IS
    v_class_id NUMBER;
    v_room_id NUMBER;
    v_teacher_id NUMBER;
    v_student_count NUMBER;
BEGIN
    -- Try to find an existing class with fewer than 20 students
    BEGIN
        SELECT Class_ID, Student_Count
        INTO v_class_id, v_student_count
        FROM (
            SELECT c.Class_ID, COUNT(s.Student_ID) AS Student_Count
            FROM Class_ c
            LEFT JOIN Student s ON c.Class_ID = s.Class_ID
            WHERE c.Grade = p_grade
            GROUP BY c.Class_ID
            HAVING COUNT(s.Student_ID) < 20
            ORDER BY COUNT(s.Student_ID)  -- Order by student count to get the least filled class
        )
        WHERE ROWNUM = 1;
        
        RETURN v_class_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Create a new class if no existing class has fewer than 20 students
            -- Select an available room with capacity over 20
            BEGIN
                SELECT r.Room_ID
                INTO v_room_id
                FROM Room r
                WHERE r.Max_Capacity > 20
                AND NOT EXISTS (SELECT 1 FROM Class_ c WHERE c.Room_ID = r.Room_ID)
                AND ROWNUM = 1;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20001, 'No available room with capacity over 20 found');
            END;

            -- Select an available teacher
            BEGIN
                SELECT t.Teacher_ID
                INTO v_teacher_id
                FROM Teacher t
                WHERE NOT EXISTS (SELECT 1 FROM Class_ c WHERE c.Teacher_ID = t.Teacher_ID)
                AND ROWNUM = 1;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20002, 'No available teacher found');
            END;
            
            -- Generate a new Class_ID
            SELECT NVL(MAX(Class_ID), 0) + 1 INTO v_class_id FROM Class_;
            
            -- Create the new class
            INSERT INTO Class_ (Class_ID, Grade, Teacher_ID, Room_ID)
            VALUES (v_class_id, p_grade, v_teacher_id, v_room_id);
            
            RETURN v_class_id;
    END;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An error occurred in find_or_create_class: ' || SQLERRM);
END find_or_create_class;
/
