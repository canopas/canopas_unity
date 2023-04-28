import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/mixin/input_validation.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/pref/user_preference.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/storage_service.dart';
import '../../settings_screen/bloc/user_settings_event.dart';
import 'employee_edit_profile_event.dart';
import 'employee_edit_profile_state.dart';

@Injectable()
class EmployeeEditProfileBloc
    extends Bloc<EditProfileEvent, EmployeeEditProfileState> with InputValidationMixin{
  final EmployeeService _employeeService;
  final UserManager _userManager;
  final UserPreference _preference;
  final ImagePicker imagePicker;
  final StorageService storageService;

  EmployeeEditProfileBloc(this._employeeService, this._preference,
      this._userManager, this.storageService, this.imagePicker)
      : super(const EmployeeEditProfileState()) {
    on<EditProfileInitialLoadEvent>(_init);
    on<EditProfileNameChangedEvent>(_validName);
    on<EditProfileChangeDateOfBirthEvent>(_changeDateOfBirth);
    on<EditProfileChangeGenderEvent>(_changeGender);
    on<EditProfileUpdateProfileEvent>(_updateEmployeeDetails);
    on<ChangeImageEvent>(_changeImage);
  }

  void _init(EditProfileInitialLoadEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    emit(state.copyWith(
        gender: event.gender, dateOfBirth: event.dateOfBirth?.toDate));
  }

  Future<void> _changeImage(
      ChangeImageEvent event, Emitter<EmployeeEditProfileState> emit) async {
    final XFile? image = await imagePicker.pickImage(source: event.imageSource);
    if (image != null) {
      final file = File(image.path);
      emit(state.copyWith(imageURL: file.path));
    }
  }

  void _validName(EditProfileNameChangedEvent event,
      Emitter<EmployeeEditProfileState> emit) {
    if (validInputLength(event.name)) {
      emit(state.copyWith(nameError: false));
    } else {
      emit(state.copyWith(nameError: true));
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
          dateOfBirth: state.dateOfBirth?.timeStampToInt,
          phone: event.phoneNumber.isEmpty ? null : event.phoneNumber,
          dateOfJoining: _userManager.employee.dateOfJoining,
        );
        await _employeeService.updateEmployeeDetails(employee: employee);
        _preference.setSpaceUser(employee);
        eventBus.fire(GetCurrentEmployeeUserSettingsEvent());
        emit(state.copyWith(status: Status.success));
      } on Exception {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    }
  }

  Future<String?> _saveImage() async {
    final String storagePath =
        'images/${_userManager.currentSpaceId}/${_userManager.userUID}/profile';

    if (state.imageURL != null) {
      try {
        final File imageFile = File(state.imageURL!);
        final imageURL =
            await storageService.uploadProfilePic(storagePath, imageFile);
        return imageURL;
      } on FirebaseException {
        throw Exception(firestoreFetchDataError);
      }
    }
    return null;
  }
}
