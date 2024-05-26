
[General]
Version=1

[Preferences]
Username=
Password=2203
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HADASSAH
Name=CLASS_
Count=40

[Record]
Name=CLASS_ID
Type=NUMBER
Size=3
Data=Sequence(1)
Master=

[Record]
Name=GRADE
Type=NUMBER
Size=2
Data=Random(1, 12)
Master=

[Record]
Name=TEACHER_ID
Type=NUMBER
Size=3
Data=List(select Teacher_ID from Teacher)
Master=

[Record]
Name=ROOM_ID
Type=NUMBER
Size=3
Data=List(select ROOM_ID from ROOM WHERE IS_LAB = 0 AND MAX_CAPACITY>19)
Master=

