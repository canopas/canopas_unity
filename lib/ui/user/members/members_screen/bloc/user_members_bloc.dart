import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_event.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/services/employee_service.dart';

@Injectable()
class UserMembersBloc extends Bloc<UserMembersEvent, UserMembersState> {
  final EmployeeService employeeService;
  late StreamSubscription _memberDBSubscription;

  UserMembersBloc(this.employeeService) : super(UserMembersInitialState()) {
    on<UserMemberSuccessEvent>(_addChanges);
    on<UserMemberLoadingEvent>(_showLoading);
    on<UserMemberFailureEvent>(_showError);
    add(UserMemberLoadingEvent());
    _memberDBSubscription =
        employeeService.memberDBSnapshot().listen((members) {
      add(UserMemberSuccessEvent(members));
    }, onError: (error, _) {
      add(UserMemberFailureEvent(firestoreFetchDataError));
    });
  }

  Future<void> _addChanges(
      UserMemberSuccessEvent event, Emitter<UserMembersState> emit) async {
    emit(UserMembersSuccessState(employees: event.members));
  }

  Future<void> _showLoading(
      UserMemberLoadingEvent event, Emitter<UserMembersState> emit) async {
    emit(UserMembersLoadingState());
  }

  Future<void> _showError(
      UserMemberFailureEvent event, Emitter<UserMembersState> emit) async {
    emit(UserMembersFailureState(error: event.error));
  }

  @override
  Future<void> close() async {
    await _memberDBSubscription.cancel();
    return super.close();
  }
}
