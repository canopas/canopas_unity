import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_event.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_state.dart';

import '../../../../../data/provider/user_state.dart';
import '../../../../../data/services/employee_service.dart';

@Injectable()
class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {
  final UserStateNotifier _userManager;
  final EmployeeService _employeeService;

  ViewProfileBloc(this._userManager, this._employeeService)
      : super(ViewProfileInitialState()) {
    on<InitialLoadevent>(_initialLoad);
  }

  Future<void> _initialLoad(
      InitialLoadevent event, Emitter<ViewProfileState> emit) async {
    emit(ViewProfileLoadingState());
    try {
      final employee =
      await _employeeService.getEmployee(_userManager.userUID!);
      if (employee == null) {
        emit(ViewProfileErrorState(firestoreFetchDataError));
      } else {
        emit(ViewProfileSuccessState(employee));
      }
    } on Exception {
      emit(ViewProfileErrorState(firestoreFetchDataError));
    }
  }
}
