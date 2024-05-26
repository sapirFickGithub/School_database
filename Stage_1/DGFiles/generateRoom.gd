
[General]
Version=1

[Preferences]
Username=
Password=2722
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HADASSAH
Name=ROOM
Count=400

[Record]
Name=ROOM_ID
Type=NUMBER
Size=3
Data=Sequence(1)
Master=

[Record]
Name=MAX_CAPACITY
Type=NUMBER
Size=
Data=Random(20, 70)
Master=

[Record]
Name=IS_LAB
Type=NUMBER
Size=1
Data=Random(0,1)
Master=

[Record]
Name=LAST_MAINTENANCE_CHECK
Type=DATE
Size=
Data=Random(02/12/2020, 24/5/2024)
Master=

