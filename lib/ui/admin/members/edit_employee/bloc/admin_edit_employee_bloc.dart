import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/core/utils/const/image_storage_path_const.dart';
import 'package:projectunity/data/provider/user_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/storage_service.dart';
import 'admin_edit_employee_events.dart';
import 'admin_edit_employee_state.dart';

@Injectable()
class AdminEditEmployeeDetailsBloc
    extends Bloc<EditEmployeeByAdminEvent, AdminEditEmployeeDetailsState> {
  final EmployeeService _employeeService;
  final UserStateNotifier _userStateNotifier;
  final StorageService _storageService;

  AdminEditEmployeeDetailsBloc(
      this._employeeService, this._userStateNotifier, this._storageService)
      : super(const AdminEditEmployeeDetailsState()) {
    on<EditEmployeeByAdminInitialEvent>(_initRoleTypeAndDate);
    on<ChangeEmployeeRoleEvent>(_changeRoleType);
    on<UpdateEmployeeByAdminEvent>(_updateEmployee);
    on<ChangeEmployeeDateOfJoiningEvent>(_changeDateOfJoining);
    on<ChangeEmployeeDesignationEvent>(_validDesignation);
    on<ChangeEmployeeEmailEvent>(_validEmail);
    on<ChangeEmployeeIdEvent>(_validEmployeeId);
    on<ChangeEmployeeNameEvent>(_validName);
    on<ChangeProfileImageEvent>(_changeImage);
    on<ChangeEmployeeDateOfBirth>(_changeDateOfBirth);

  }

  void _initRoleTypeAndDate(EditEmployeeByAdminInitialEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(
        role: event.roleType,
        dateOfJoining: event.dateOfJoining ?? DateTime.now().dateOnly,
      dateOfBirth:  event.dateOfBirth?? DateTime.now().dateOnly
    ));
  }

  void _changeRoleType(ChangeEmployeeRoleEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(role: event.roleType));
  }

  void _changeDateOfJoining(ChangeEmployeeDateOfJoiningEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(dateOfJoining: event.dateOfJoining));
  }

  void _changeDateOfBirth(ChangeEmployeeDateOfBirth event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    emit(state.copyWith(dateOfBirth: event.dateOfBirth));
  }
  void _validName(ChangeEmployeeNameEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.name.length < 4) {
      emit(state.copyWith(nameError: true));
    } else {
      emit(state.copyWith(nameError: false));
    }
  }

  void _validEmail(ChangeEmployeeEmailEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.email.isEmpty || !event.email.contains('@')) {
      emit(state.copyWith(emailError: true));
    } else {
      emit(state.copyWith(emailError: false));
    }
  }

  void _validDesignation(ChangeEmployeeDesignationEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.designation.isEmpty) {
      emit(state.copyWith(designationError: true));
    } else {
      emit(state.copyWith(designationError: false));
    }
  }

  void _validEmployeeId(ChangeEmployeeIdEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) {
    if (event.employeeId.isEmpty) {
      emit(state.copyWith(employeeIdError: true));
    } else {
      emit(state.copyWith(employeeIdError: false));
    }
  }

  Future<void> _changeImage(ChangeProfileImageEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) async {
    emit(state.copyWith(pickedImage: event.imagePath));
  }

  void _updateEmployee(UpdateEmployeeByAdminEvent event,
      Emitter<AdminEditEmployeeDetailsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    if (state.nameError ||
        state.designationError ||
        state.employeeIdError ||
        state.emailError) {
      emit(state.copyWith(status: Status.error, error: fillDetailsError));
    } else {
      try {
        String? imageUrl;

        if (state.pickedImage != null) {
          imageUrl = await _storageService.uploadProfilePic(
              path: ImageStoragePath.membersProfilePath(
                  spaceId: _userStateNotifier.currentSpaceId!,
                  uid: event.previousEmployeeData.uid),
              imagePath: state.pickedImage!);
        }

        await _employeeService.updateEmployeeDetails(
          employee: Employee(
            uid: event.previousEmployeeData.uid,
            role: state.role,
            name: event.name,
            employeeId: event.employeeId,
            email: event.email,
            designation: event.designation,
            level: event.level.isEmpty ? null : event.level,
            dateOfJoining: state.dateOfJoining!,
            phone: event.previousEmployeeData.phone,
            address: event.previousEmployeeData.address,
            dateOfBirth: state.dateOfBirth,
            gender: event.previousEmployeeData.gender,
            imageUrl: imageUrl ?? event.previousEmployeeData.imageUrl,
          ),
        );
        emit(state.copyWith(status: Status.success));
      } on Exception {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    }
  }
}
