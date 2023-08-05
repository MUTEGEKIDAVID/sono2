
class SetChoiceScreenDataAction {
  final String firstName;
  final String lastName;
  final String middleName;
  final String age;
  final String gender;
  final String job;
  final String smokerStatus;
  final String district;
  final String subcounty;
  final String parish;
  final String village;

  SetChoiceScreenDataAction({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.age,
    required this.gender,
    required this.job,
    required this.smokerStatus,
    required this.district,
    required this.subcounty,
    required this.parish,
    required this.village,
  });
}

class SetUltraSoundDataAction {
  final String hemithorax;
  final String lungZone;
  final String location;
  final String image;
  final String diagnosis;

  SetUltraSoundDataAction({
    required this.hemithorax,
    required this.lungZone,
    required this.location,
    required this.image,
    required this.diagnosis,
  });
}
