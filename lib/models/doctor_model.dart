const String doctable1 = "doc_bed";
const String doctable2 = "doc_info";

class Doctorfields {
  final List<String> values = [id, bedno, age, name];

  static const String id = '_id';
  static const String bedno = 'bedno';
  static const String age = 'age';
  static const String name = 'name';
}

class Doctorinfo {
  final int id;
  final int age;
  final String name;

  Doctorinfo({required this.id, required this.age, required this.name});

// static Doctorinfo fromJson(Map<String, dynamic> json) => Doctorinfo(
//     id:  int.parse(json[Doctorfields.id].toString()),
//     bedno: int.parse(json[Doctorfields.bedno].toString()),
//     name: json[Doctorfields.name] as String,
//     age: int.parse([Doctorfields.age].toString())
//   );

  static Doctorinfo fromJson(Map<String, dynamic> json) {
    // print(json.toString());
    return Doctorinfo(
        id: json[Doctorfields.id] as int,
        name: json[Doctorfields.name] as String,
        age: json[Doctorfields.age] as int);
  }

  Map<String, dynamic> toJson() => {
        Doctorfields.id: id,
        Doctorfields.age: age,
        Doctorfields.name: name,
      };
}


class DoctorAndBed{
  final int id, bedno;

  DoctorAndBed({required this.id,  required this.bedno});

  static DoctorAndBed fromJson(Map<String, dynamic> json) {
    // print(json.toString());
    return DoctorAndBed(
    id: json[Doctorfields.id] as int,
    bedno: json[Doctorfields.bedno] as int
  );}

  Map<String, dynamic> toJson() => {
    Doctorfields.id: id,
    Doctorfields.bedno: bedno
  };


}

class Getdocname{
  String name;
  Getdocname({required this.name});

  static Getdocname fromJson(Map<String, dynamic> json) {
    return Getdocname(name: json['name']);
  }
  Map<String, dynamic> toJson() =>{
    name: name
  };
}