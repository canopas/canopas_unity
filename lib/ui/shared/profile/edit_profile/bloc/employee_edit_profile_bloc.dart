import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/mixin/input_validation.dart';
import 'package:projectunity/data/core/utils/const/image_storage_path_const.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/pref/user_preference.dart';
import '../../../../../data/provider/user_state.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/storage_service.dart';
import 'employee_edit_profile_event.dart';
import 'employee_edit_profile_state.dart';

@Injectable()
class EmployeeEditProfileBloc
    extends Bloc<EditProfileEvent, EmployeeEditProfileState>
    with InputValidationMixin {
  final EmployeeService _employeeService;
  final UserStateNotifier _userManager;
  final UserPreference _preference;
  final StorageService storageService;

  EmployeeEditProfileBloc(this._employeeService, this._preference,
      this._userManager, this.storageService)
      : super(const EmployeeEditProfileState()) {
    on<EditProfileInitialLoadEvent>(_init);
    on<EditProfileNameChangedEvent>(_validName);
    on<EditProfileNumberChangedEvent>(_validNumber);
    on<EditProfileChangeDateOfBirthEvent>(_changeDateOfBirth);
    on<EditProfileChangeGenderEvent>(_changeGender);
    on<EditProfileUpdateProfileEvent>(_updateEmployeeDetails);
    on<ChangeImageEvent>(_changeImage);
  }

  void _init(EditProfileInitialLoadEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    emit(state.copyWith(gender: event.gender, dateOfBirth: event.dateOfBirth));
  }

  Future<void> _changeImage(
      ChangeImageEvent event, Emitter<EmployeeEditProfileState> emit) async {
    emit(state.copyWith(imageURL: event.imagePath));
  }

  void _validName(EditProfileNameChangedEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    if (validInputLength(event.name)) {
      emit(state.copyWith(nameError: false));
    } else {
      emit(state.copyWith(nameError: true));
    }
  }

  void _validNumber(EditProfileNumberChangedEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    if (validPhoneNumber(event.number)) {
      emit(state.copyWith(numberError: false));
    } else {
      emit(state.copyWith(numberError: true));
    }
  }

  void _changeDateOfBirth(EditProfileChangeDateOfBirthEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    emit(state.changeDateOfBirth(dateOfBirth: event.dateOfBirth));
  }

  void _changeGender(EditProfileChangeGenderEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    emit(state.changeGender(gender: event.gender));
  }

  void _updateEmployeeDetails(EditProfileUpdateProfileEvent event,
      Emitter<EmployeeEditProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));
    if (state.nameError) {
      emit(state.copyWith(status: Status.error, error: fillDetailsError));
    } else {
      final String? uri = await _saveImage();
      try {
        Employee employee = Employee(
          uid: _userManager.employeeId,
          role: _userManager.employee.role,
          name: event.name,
          employeeId: _userManager.employee.employeeId,
          email: _userManager.employee.email,
          designation: event.designation,
          level: event.level.isEmpty ? null : event.level,
          address: event.address.isEmpty ? null : event.address,
          imageUrl: uri ?? _userManager.employee.imageUrl,
          gender: state.gender,
          dateOfBirth: state.dateOfBirth,
          phone: event.phoneNumber.isEmpty ? null : event.phoneNumber,
          dateOfJoining: _userManager.employee.dateOfJoining,
        );
        await _employeeService.updateEmployeeDetails(employee: employee);
        _preference.setEmployee(employee);

        ///TODO: updateUserDataOnUserProfile
        emit(state.copyWith(status: Status.success));
      } on Exception {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    }
  }

  Future<String?> _saveImage() async {
    final String storagePath = ImageStoragePath.membersProfilePath(
        spaceId: _userManager.currentSpaceId!, uid: _userManager.userUID!);

    if (state.imageURL != null) {
      try {
        final imageURL = await storageService.uploadProfilePic(
            path: storagePath, imagePath: state.imageURL!);
        return imageURL;
      } on Exception {
        throw Exception();
      }
    }
    return null;
  }
}
