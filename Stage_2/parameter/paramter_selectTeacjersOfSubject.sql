-- find all teachers that teach a certain subject
SELECT t.teacher_id, t.tfirst_name || ' ' || t.tlast_name AS "Name"
FROM lesson l LEFT JOIN teacher t ON l.teacher_id = t.teacher_id
WHERE l.subject_id = &<name = "Subject"
                       list="SELECT Subject_id, subject_name FROM subject"
                       description = "true" restricted="yes">;
