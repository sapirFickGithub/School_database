-- for each teacher counts the amount of different subject he teaches and display from ost to least
SELECT t.Teacher_ID, t.TFirst_Name, t.TLast_Name , top_teacher.subject_count
FROM (SELECT Teacher_ID, COUNT(DISTINCT Subject_ID) AS Subject_Count
    FROM Lesson
    GROUP BY Teacher_ID )
    top_teacher
    
JOIN Teacher t ON t.Teacher_ID = top_teacher.Teacher_ID
ORDER BY Subject_Count desc;
