-- query to select the grade and count of distinct mandatory subjects for each grade
SELECT Grade, COUNT(DISTINCT Subject_ID) AS Mandatory_Subject_Count
FROM (    
    SELECT c.Grade AS Grade, s.Subject_ID               
    FROM Lesson l                       
        JOIN Class_ c ON l.Class_ID = c.Class_ID       
        JOIN Subject s ON l.Subject_ID = s.Subject_ID 
    WHERE 
        s.mandatory = 1                  
) subquery
GROUP BY Grade                              
ORDER BY Grade;
