// To parse this JSON data, do
//
//     final dataModel2 = dataModel2FromJson(jsonString);

import 'dart:convert';
import 'dart:io';

DataModel2 dataModel2FromJson(String str) => DataModel2.fromJson(json.decode(str));

String dataModel2ToJson(DataModel2 data) => json.encode(data.toJson());

class DataModel2 {
  final int? patientId;
  final String? diagnosis;
  final String? scanError;

  DataModel2({this.patientId, this.diagnosis, this.scanError});

  factory DataModel2.fromJson(Map<String, dynamic> json) {
    return DataModel2(
      patientId: json['patient_id'],
      diagnosis: json['diagnosis'],
      scanError: json['scan error'],
    );
  }

  Object? toJson() {


  }
}
