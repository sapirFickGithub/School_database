-- Query to find the schedual of all classes in a certain grade on a chosen days
SELECT l.class_id, t.Teacher_ID, TFirst_Name ||' ' || TLast_Name as "Teacher name", subject_name, lesson_hour
FROM lesson l left join Teacher t on t.teacher_id = l.teacher_id
left join subject s on l.subject_id = s.subject_id
WHERE t.Teacher_ID IN (
  SELECT l.Teacher_ID
  FROM Lesson l
  inner join Class_ c ON l.Class_ID = c.Class_ID
  WHERE l.Lesson_Day = &<name = "Day"
                   list = "1, Sunday, 
                       2, Monday, 
                       3, Tuesday, 
                       4, Wednesday, 
                       5, Thursday,
                       6, Friday"
                       description = "true" default = "Sunday" restricted="yes">
   AND c.grade = &<name="grade Name" hint= "grade Name between (1-12)" type= "integer">)
ORDER BY class_id;


