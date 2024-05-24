
[General]
Version=1

[Preferences]
Username=
Password=2856
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SAPIR
Name=STUDENT
Count=10..20

[Record]
Name=STUDENT_ID
Type=NUMBER
Size=3
Data=Sequence(1)
Master=

[Record]
Name=FIRST_NAME
Type=VARCHAR2
Size=15
Data=FirstName
Master=

[Record]
Name=LAST_NAME
Type=VARCHAR2
Size=15
Data=LastName
Master=

[Record]
Name=BIRTH_DATE
Type=DATE
Size=
Data=Random(1/1/2005,1/1/2018)
Master=

[Record]
Name=PHONE
Type=NUMBER
Size=
Data='05'[1]'-'[000]'-'[0000]
Master=

[Record]
Name=FATHERNAME
Type=VARCHAR2
Size=15
Data=FirstName
Master=

[Record]
Name=MOTHERNAME
Type=VARCHAR2
Size=15
Data=FirstName
Master=

[Record]
Name=CLASS_ID
Type=NUMBER
Size=3
Data=List(select Class_ID from class_) 
Master=

