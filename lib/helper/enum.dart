enum Role {
  TEACHER,
  STUDENT
}

extension TypeOfSearch on Role {
  String asString() => {
       Role.TEACHER:"teacher",
       Role.STUDENT:"student",
      }[this];
 static Role fromString(String value) => {
        "teacher":Role.TEACHER,
        "student":Role.STUDENT,
      }[value];
}