CREATE OR REPLACE PROCEDURE room_with_right_capacity(
    p_cursor IN SYS_REFCURSOR,   
    p_required_capacity IN NUMBER  
) IS
    l_room_id Room.Room_ID%TYPE;
    l_max_capacity Room.Max_Capacity%TYPE;
BEGIN
    LOOP
        FETCH p_cursor INTO l_room_id;
        EXIT WHEN p_cursor%NOTFOUND;
        
        -- Check the capacity of the current room
        SELECT Max_Capacity 
        INTO l_max_capacity 
        FROM Room 
        WHERE Room_ID = l_room_id;

        IF l_max_capacity >= p_required_capacity THEN
            DBMS_OUTPUT.PUT_LINE('Room with sufficient capacity: ' || l_room_id);
            EXIT; -- Exit the loop once the first suitable room is found
        END IF;
    END LOOP;
    CLOSE p_cursor;
END room_with_right_capacity;
/
