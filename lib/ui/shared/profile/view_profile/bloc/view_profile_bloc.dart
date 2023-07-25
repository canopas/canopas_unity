import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_event.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_state.dart';
import '../../../../../data/provider/user_status_notifier.dart';

@Injectable()
class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {
  final UserStatusNotifier _userManager;
  final EmployeeRepo _employeeRepo;

  ViewProfileBloc(this._userManager, this._employeeRepo)
      : super(ViewProfileInitialState()) {
    on<InitialLoadevent>(_initialLoad);
  }

  Future<void> _initialLoad(
      InitialLoadevent event, Emitter<ViewProfileState> emit) async {
    emit(ViewProfileLoadingState());
    try {
      return emit.forEach(_employeeRepo.memberDetails(_userManager.employeeId),
          onData: (Employee? employee) {
            if (employee == null) {
              return ViewProfileErrorState(firestoreFetchDataError);
            } else {
              return ViewProfileSuccessState(employee);
            }
          },
          onError: (error, stackTrace) =>
              ViewProfileErrorState(firestoreFetchDataError));
    } on Exception {
      emit(ViewProfileErrorState(firestoreFetchDataError));
    }
  }
}
