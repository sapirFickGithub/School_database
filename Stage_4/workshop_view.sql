-- create a view of the workshop participates
create view workshop_participants as 
select

    c.client_id,
    c.client_fname || ' ' || c.client_lname as client_name,
    c.client_tel,
    ag.minage || ' - ' || ag.maxage as age_group,
    w.workshop_name,
    'day: '|| sc.sc_day || ' hour: ' || sc.sc_time as workshop_time,
    r.room_floor,
    t.teacher_fname || ' ' || t.teacher_lname as teacher_name
    
from scheduler sc
join workshops w on w.workshop_id = sc.workshop_id
join groups_ g on sc.group_id = g.group_id
join age_group ag on ag.age_id = g.age_id
join participate p on p.group_id = g.group_id
join clients c on c.client_id = p.client_id
join teachers t on t.teacher_id = sc.teacher_id
join rooms r on r.room_id = sc.room_id;

-- select information of all clients tat participates in a workshop in 1st floor
select client_name, client_tel, age_group, workshop_name
from workshop_participants 
where room_floor = 1


-- selct all necessary info about workshops that has more than 1 participant 
SELECT workshop_name, age_group, workshop_time, teacher_name, COUNT(DISTINCT client_id) AS participant_count
FROM workshop_participants
GROUP BY workshop_name, age_group, workshop_time, teacher_name
HAVING COUNT(DISTINCT client_id) > 1
ORDER BY participant_count ASC, workshop_name;


