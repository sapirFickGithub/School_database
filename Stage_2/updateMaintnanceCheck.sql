-- Update the maintenance check date for rooms that the last maintnance check was in 2022
UPDATE Room
SET Last_maintenance_check = TRUNC(SYSDATE)
WHERE EXTRACT(YEAR FROM Last_maintenance_check) = 2022;
