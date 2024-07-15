PL/SQL Developer Test script 3.0
26
DECLARE
    available_rooms SYS_REFCURSOR;    room_id Room.Room_ID%TYPE;       p_day INT ; 
    p_room_id Room.Room_ID%TYPE ;     p_is_available int;              p_hour INT ;
 available_roomstwo SYS_REFCURSOR; 
BEGIN
    p_room_id := 263; 
    p_day := 5;   
    p_hour := 9;
    
    
    available_rooms := find_room(p_room_id, p_day, p_hour, p_is_available);-- call the function:
    available_roomstwo :=find_room(p_room_id, p_day, p_hour, p_is_available);
    IF p_is_available =0 THEN
        DBMS_OUTPUT.PUT_LINE('The requested room ' || p_room_id || ' is available at day ' || p_day || ' hour ' || p_hour);
    ELSE
        DBMS_OUTPUT.PUT_LINE('The requested room ' || p_room_id || ' is not available at day '  || p_day || ' hour ' || p_hour);
     --   room_with_right_capacity(available_rooms,10);--call the procedur:
         LOOP
           FETCH available_rooms INTO room_id;
             EXIT WHEN available_rooms%NOTFOUND;
             DBMS_OUTPUT.PUT_LINE('Available Room ID: ' || room_id);
         END LOOP;
         CLOSE available_rooms;
     END IF;
   room_with_right_capacity(available_roomsTWO,10);--call the procedur:
END;
0
1
p_is_available
