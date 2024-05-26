
[General]
Version=1

[Preferences]
Username=
Password=2158
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HADASSAH
Name=LESSON
Count=450

[Record]
Name=LESSON_ID
Type=NUMBER
Size=3
Data=Sequence(1)
Master=

[Record]
Name=LESSON_DAY
Type=NUMBER
Size=1
Data=Random(1,6)
Master=

[Record]
Name=LESSON_HOUR
Type=NUMBER
Size=2
Data=Random(8, 16)
Master=

[Record]
Name=CLASS_ID
Type=NUMBER
Size=3
Data=List(select CLASS_ID from class_)
Master=

[Record]
Name=TEACHER_ID
Type=NUMBER
Size=3
Data=List(select teacher_id from teacher)
Master=

[Record]
Name=SUBJECT_ID
Type=NUMBER
Size=3
Data=List(select subject_id from subject)
Master=

