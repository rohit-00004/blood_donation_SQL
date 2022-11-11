const String tablestudent = 'student';

class Studentfields {
  static const String mis = "mis";
  static const String haemoglobinCount = "haemoglobinCount";
  static const String name = "name";
  static const String gender = "gender";
  static const String bloodGroup = "bloodGroup";
  static const String email = "email";
  static const String certificateGiven = "certificateGiven";
  static const String donated = "donated";
  static const String weight = "weight";

  static List<String> values = [
    "mis",
    "haemoglobinCount",
    "name",
    "gender",
    "bloodGroup",
    "email",
    "certificateGiven",
    "donated",
    "weight"
  ];
}

class Student {
  int mis, haemoglobinCount;
  String name, gender, bloodGroup, email;
  bool certificateGiven, donated;
  double weight;

  Student(
      {required this.mis,
      required this.haemoglobinCount,
      required this.name,
      required this.gender,
      required this.bloodGroup,
      required this.email,
      required this.certificateGiven,
      required this.donated,
      required this.weight});

  static Student fromJson(Map<String, dynamic> json) => Student(
      mis: json[Studentfields.mis] as int,
      haemoglobinCount: json[Studentfields.haemoglobinCount] as int,
      name: json[Studentfields.name] as String,
      gender: json[Studentfields.gender] as String,
      bloodGroup: json[Studentfields.bloodGroup] as String,
      email: json[Studentfields.email] as String,
      certificateGiven: json[Studentfields.certificateGiven] == 1,
      donated: json[Studentfields.donated] == 1,
      weight: json[Studentfields.weight].toDouble());


  Map<String, dynamic> toJson() => {
        Studentfields.mis: mis,
        Studentfields.haemoglobinCount: haemoglobinCount,
        Studentfields.name: name,
        Studentfields.gender: gender,
        Studentfields.bloodGroup: bloodGroup,
        Studentfields.email: email,
        Studentfields.certificateGiven: certificateGiven ? 1 : 0,
        Studentfields.donated: donated ? 1 : 0,
        Studentfields.weight: weight
      };
}
