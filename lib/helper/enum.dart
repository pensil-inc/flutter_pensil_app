enum Role { TEACHER, STUDENT }

extension TypeOfSearch on Role {
  String asString() => {
        Role.TEACHER: "teacher",
        Role.STUDENT: "student",
      }[this];
  static Role fromString(String value) => {
        "teacher": Role.TEACHER,
        "student": Role.STUDENT,
      }[value];
}

enum RawType { VIDEO, MATERIAL, ANNOUNCEMENT }

final typeValues = EnumValues({
  "announcement": RawType.ANNOUNCEMENT,
  "material": RawType.MATERIAL,
  "video": RawType.VIDEO
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
