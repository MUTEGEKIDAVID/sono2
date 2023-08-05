import 'package:redux/redux.dart';

import 'actions.dart';
import 'app_state.dart';
import 'reducer.dart';

final store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initialState(),
);

class IncrementCounterViewModel {
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
  final String hemithorax;
  final String lungZone;
  final String location;
  final String image;
  final String diagnosis;

  final Function({
  required String firstName,
  required String lastName,
  required String middleName,
  required String age,
  required String gender,
  required String job,
  required String smokerStatus,
  required String district,
  required String subcounty,
  required String parish,
  required String village,
  }) setChoiceScreenData;

  final Function({
  required String hemithorax,
  required String lungZone,
  required String location,
  required String image,
  required String diagnosis,
  }) setUltraSoundData;


  IncrementCounterViewModel({
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
    required this.hemithorax,
    required this.lungZone,
    required this.location,
    required this.image,
    required this.diagnosis,
    required this.setChoiceScreenData,
    required this.setUltraSoundData,
  });

  static IncrementCounterViewModel fromStore(Store<AppState> store) {
    return IncrementCounterViewModel(
      firstName: store.state.firstName,
      lastName: store.state.lastName,
      middleName: store.state.middleName,
      age: store.state.age,
      gender: store.state.gender,
      job: store.state.job,
      smokerStatus: store.state.smokerStatus,
      district: store.state.district,
      subcounty: store.state.subcounty,
      parish: store.state.parish,
      village: store.state.village,
      hemithorax: store.state.hemithorax,
      lungZone: store.state.lungZone,
      location: store.state.location,
      image: store.state.image,
      diagnosis: store.state.diagnosis,

      setChoiceScreenData: ({
        required String firstName,
        required String lastName,
        required String middleName,
        required String age,
        required String gender,
        required String job,
        required String smokerStatus,
        required String district,
        required String subcounty,
        required String parish,
        required String village,
      }) {
        store.dispatch(
          SetChoiceScreenDataAction(
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            age: age,
            gender: gender,
            job: job,
            smokerStatus: smokerStatus,
            district: district,
            subcounty: subcounty,
            parish: parish,
            village: village,
          ),
        );
      },
      setUltraSoundData: ({
        required String hemithorax,
        required String lungZone,
        required String location,
        required String image,
        required String diagnosis,
      }) {
        store.dispatch(
          SetUltraSoundDataAction(
            hemithorax: hemithorax,
            lungZone: lungZone,
            location: location,
            image: image,
            diagnosis:diagnosis,
          ),
        );
      },
    );
  }
}
