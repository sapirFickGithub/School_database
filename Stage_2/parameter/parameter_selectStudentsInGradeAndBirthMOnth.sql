--Show all the students how there is a birthday in a specific month and in a specific grade
SELECT Student_ID, First_Name, Last_Name, birth_date, c.Class_ID
FROM Student s left join class_ c on c.class_id = s.class_id
WHERE EXTRACT(MONTH FROM birth_date) = &<name="birth month"
          list= "1, January ,
                 2, February,
                 3, March,
                 4, April,
                 5, May,
                 6, June,
                 7, July,
                 8, August,
                 9, September,
                 10, October,
                 11, November,
                 12, December"
                 description="true" default="January" restricted="yes">
  AND c.grade = &<name="grade Name" hint= "grade Name between (1-12)" type= "integer" >
order by EXTRACT(Day FROM s.birth_date);
