// To parse this JSON data, do
//
//     final dataModel2 = dataModel2FromJson(jsonString);

import 'dart:convert';
import 'dart:io';

DataModel2 dataModel2FromJson(String str) => DataModel2.fromJson(json.decode(str));

String dataModel2ToJson(DataModel2 data) => json.encode(data.toJson());

class DataModel2 {
  DataModel2({
    required this.id,
    required this.image,
    required this.diagnosisId,
    required this.hemithorax,
    required this.lungzone,
    required this.location,
    required this.patientId,
  });

  int id;
  String image;
  String diagnosisId;
  String hemithorax;
  String lungzone;
  String location;
  int patientId;

  factory DataModel2.fromJson(Map<String, dynamic> json) => DataModel2(
    id: json["id"],
    image: json["image"],
    diagnosisId: json["diagnosisId"],
    hemithorax: json["hemithorax"],
    lungzone: json["lungzone"],
    location: json["location"],
    patientId: json["patientId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "diagnosisId": diagnosisId,
    "hemithorax": hemithorax,
    "lungzone": lungzone,
    "location": location,
    "patientId": patientId,
  };
}
