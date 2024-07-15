select * from room;
select * from class_;
select * from teacher;
select * from subject;
select * from lesson;
select * from student;

select c.class_id, c.grade, count(student_id)
from class_ c join student s on c.class_id = s.class_id
group by c.class_id, c.grade
order by c.grade

select s.student_id, s.birth_date, c.grade
from student s join class_ c on s.class_id = c.class_id
where c.grade = 12
