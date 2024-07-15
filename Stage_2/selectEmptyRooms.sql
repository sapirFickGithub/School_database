-- finds all empty rooms that had maintenance check since 2021, 
select roo.Room_ID as "Empty Rooms", roo.max_capacity, roo.last_maintenance_check AS "Last Check",
       CASE WHEN roo.is_lab = 1 THEN 'Yes' 
            ELSE 'No' 
       END AS "Is Lab"
from Room roo left join class_ cls
ON roo.Room_ID = cls.Room_ID
where cls.room_id is null
AND roo.last_maintenance_check > to_date('01/01/2021', 'dd/mm/yyyy')
