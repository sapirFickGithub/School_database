-- delete all lessons schedualed to friday after 16:00
DELETE from Lesson 
where lesson_day = 6 AND lesson_hour >= 16;
