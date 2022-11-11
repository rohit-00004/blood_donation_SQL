
const String tableAllotment = "Allotment";

class Allotmentfields{
  static const String mis = "mis";
  static const String bedno = 'bedno';
  static const String time = "time";
  static const String date = "date";
}

class AllotmentDetails{
  int mis, bedno;
  String time, date;

  AllotmentDetails({required this.mis, required this.bedno,
   required this.time, required this.date});
  
  static fromJson(Map<String, dynamic> json) => AllotmentDetails(
    mis: json[Allotmentfields.mis] as int, 
    bedno: json[Allotmentfields.bedno] as int, 
    time: json[Allotmentfields.time] as String, 
    date: json[Allotmentfields.date] as String
  );

  Map<String, dynamic> toJson() =>{
    Allotmentfields.mis: mis,
    Allotmentfields.bedno: bedno,
    Allotmentfields.time: time,
    Allotmentfields.date: date,
  };

}