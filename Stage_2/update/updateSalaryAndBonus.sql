-- Update the salary of teachers based on there lessson amount
-- giving a 10% raise in hourly_salary and 50 nis bonus to those teaching 4 or more lessons.
UPDATE Teacher t
SET hourly_salary = hourly_salary * 1.1, bonus = 50
WHERE t.Teacher_ID IN (
  SELECT Teacher_ID
  FROM Lesson
  GROUP BY Teacher_ID
  HAVING COUNT(Lesson_ID) >= 4
);
