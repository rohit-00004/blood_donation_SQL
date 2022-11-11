
const String tableDiseases = "Diseases";

class Diseasesfields{
  static const String mis = "mis";
  static const String disease = "disease";
}

class Diseases{
  int mis;
  String disease;

  Diseases({required this.mis, required this.disease});

  static fromJson(Map<String, dynamic> json) => Diseases(
    mis: json[Diseasesfields.mis] as int, 
    disease: json[Diseasesfields.disease] as String
    );
  
  Map<String, dynamic> toJson() => {
    Diseasesfields.mis: mis,
    Diseasesfields.disease: disease
  };
}