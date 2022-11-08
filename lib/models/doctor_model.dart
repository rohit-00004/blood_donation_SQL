
class Doctorfields{
  final List<String> values = [id, bedno, age, name];

  static final String id = '_id';
  static final String bedno= 'bedno';
  static final String age = 'age';
  static final String name= 'name';

}


class Doctor {
  final int? id;
  final int bedno, age;
  final String name;

  Doctor({this.id, required this.bedno, required this.age, required this.name});

// static Doctor fromJson(Map<String, dynamic> json) => Doctor(
//     id:  int.parse(json[Doctorfields.id].toString()),
//     bedno: int.parse(json[Doctorfields.bedno].toString()),
//     name: json[Doctorfields.name] as String,
//     age: int.parse([Doctorfields.age].toString())
//   );

static Doctor fromJson(Map<String, dynamic> json){
  print(json.toString());
return Doctor(
    id:  json[Doctorfields.id] as int,
    bedno: json[Doctorfields.bedno] as int,
    name: json[Doctorfields.name] as String,
    age: json[Doctorfields.age] as int
  );}

    Map<String, dynamic> toJson() => {
      Doctorfields.id: id ?? 0,
      Doctorfields.age: age,
      Doctorfields.name: name,
      Doctorfields.bedno: bedno
      };
}
