students =  LOAD '10-semesters' USING PigStorage(',') As (StudentID: int , Semester: datetime);
stud = filter students by StudentID > -1;
sems = foreach stud generate YearsBetween(CurrentTime(), Semester)*2 As semesters;
STORE sems INTO 'Output' using PigStorage(';');