
[General]
Version=1

[Preferences]
Username=
Password=2964
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SAPIR
Name=CLASS_
Count=500

[Record]
Name=CLASS_ID
Type=NUMBER
Size=3
Data=Sequence(1)
Master=

[Record]
Name=CLASS_NAME
Type=NUMBER
Size=2
Data=Random(1, 12)
Master=

[Record]
Name=TEACHER_ID
Type=NUMBER
Size=3
Data=List(SELECT TEACHER_ID FROM TEACHER)
Master=

[Record]
Name=ROOM_ID
Type=NUMBER
Size=3
Data=List(select ROOM_ID FROM ROOM WHERE ROOM.MAX_CAPACITY>19)
Master=

