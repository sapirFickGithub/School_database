SELECT c.grade, c.class_id, t.tfirst_name||' '||t.tlast_name AS "Teacher Name", COUNT(l.lesson_id) AS lesson_count
FROM class_ c
INNER JOIN lesson l ON c.class_id = l.class_id
INNER JOIN teacher t ON l.teacher_id = t.teacher_id
GROUP BY c.grade, c.class_id, t.tfirst_name, t.tlast_name
ORDER BY c.grade, c.class_id;
