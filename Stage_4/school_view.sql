-- create a view of the entire school schedual, including every detail on each lesson
create view school_schedual as 
select

     sc.scheduler_id,
     sc.sc_day,
     sc.sc_time,
     cls.class_id,
     cls.grade,
     w.workshop_name,
     w.mandatory,
     t.teacher_fname || ' ' || t.teacher_lname as teacher_name
     
from scheduler sc
join class_ cls on cls.class_id = sc.class_id
join workshops w on w.workshop_id = sc.workshop_id
join teachers t on t.teacher_id = sc.teacher_id

-- for each grade this query present all the subjects that they study,
-- is it mandatoy and how many times during the week they study the subject
select grade, workshop_name as subject, mandatory, count(scheduler_id) as weekly_amount
from school_schedual
group by grade, workshop_name, mandatory
order by grade


-- for each theacher the query present for every mandatory lesson he teaches the class, grade and time of the lesson
select teacher_name, class_id, grade, sc_day, sc_time
from school_schedual
where mandatory = 1
