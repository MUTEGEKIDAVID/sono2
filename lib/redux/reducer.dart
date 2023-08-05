import 'app_state.dart';
import 'actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  if (action is SetChoiceScreenDataAction) {
    return AppState(
      firstName: action.firstName,
      lastName: action.lastName,
      middleName: action.middleName,
      age: action.age,
      gender: action.gender,
      job: action.job,
      smokerStatus: action.smokerStatus,
      district: action.district,
      subcounty: action.subcounty,
      parish: action.parish,
      village: action.village,
      hemithorax: state.hemithorax,
      lungZone: state.lungZone,
      location: state.location,
      image: state.image,
      diagnosis: state.diagnosis
    );
  }

  if (action is SetUltraSoundDataAction) {
    return AppState(
      firstName: state.firstName,
      lastName: state.lastName,
      middleName: state.middleName,
      age: state.age,
      gender: state.gender,
      job: state.job,
      smokerStatus: state.smokerStatus,
      district: state.district,
      subcounty: state.subcounty,
      parish: state.parish,
      village: state.village,
      hemithorax: action.hemithorax,
      lungZone: action.lungZone,
      location: action.location,
      image: action.image,
      diagnosis: action.diagnosis,
    );
  }

  return state;
}
