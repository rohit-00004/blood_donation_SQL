const String tableCertificate = "Certificate";

class Certificatefields{
  static const String mis = "mis";
  static const String dateIssued = "dateIssued";
}

class Certificate{
  int mis;
  String dateIssued;

  Certificate({required this.mis, required this.dateIssued});

  static Certificate fromJson(Map<String, dynamic> json) => Certificate(
    mis: json[Certificatefields.mis] as int, 
    dateIssued: json[Certificatefields.dateIssued] as String
  );

  
}