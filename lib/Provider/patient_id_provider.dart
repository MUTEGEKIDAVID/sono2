import 'package:flutter/material.dart';



import 'package:flutter/foundation.dart';

class PatientIdProvider with ChangeNotifier {
  String _patientId = '';

  String get patientId => _patientId;

  void setPatientId(String id) {
    patientId = id;
  }

  set patientId(String value) {
    _patientId = value;
    notifyListeners();
  }


}