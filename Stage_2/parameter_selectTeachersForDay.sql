-- recieve teacher id and a day, and display info of all lessons given by that techer in that day
SELECT tfirst_name|| ' ' ||tlast_name AS teacher_name, class_ID, subject_name, lesson_hour
FROM Lesson l inner join subject s ON l.subject_id = s.subject_id
     inner join teacher t ON t.teacher_id = l.teacher_id
WHERE t.teacher_id = &"Teacher ID"
      AND Lesson_Day = &<name = "Day"
                   list = "1, Sunday, 
                       2, Monday, 
                       3, Tuesday, 
                       4, Wednesday, 
                       5, Thursday,
                       6, Friday"
                       description = "true" default = "Sunday" restricted = "yes">                 
