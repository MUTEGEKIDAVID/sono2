// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.age,
    required this.gender,
    required this.occupation,
    required this.smokingStatus,
    required this.district,
    required this.subcounty,
    required this.parish,
    required this.village,

  });

  String firstName;
  String lastName;
  String middleName;
  String age;
  String gender;
  String occupation;
  String smokingStatus;
  String district;
  String subcounty;
  String parish;
  String village;


  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    middleName: json["middle_name"],
    age: json["age"],
    gender: json["gender"],
    occupation: json["occupation"],
    smokingStatus: json["smokingStatus"],
    district: json["district"],
    subcounty: json["subcounty"],
    parish: json["parish"],
    village: json["village"],

  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "middle_name": middleName,
    "age": age,
    "gender": gender,
    "occupation": occupation,
    "smokingStatus": smokingStatus,
    "district": district,
    "subcounty": subcounty,
    "parish": parish,
    "village": village,

  };
}
