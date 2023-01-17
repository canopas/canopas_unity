import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/setting/bloc/employee_setting_event.dart';
import 'package:projectunity/ui/user/setting/bloc/employee_setting_state.dart';
import '../../../../event_bus/events.dart';
import '../../../../provider/user_data.dart';

@Injectable()
class EmployeeSettingBloc extends Bloc<EmployeeSettingEvent,EmployeeSettingState>{
  late StreamSubscription _subscription;
  final UserManager _userManager;
  EmployeeSettingBloc(this._userManager) : super(EmployeeSettingState(employee:_userManager.employee)){

    on<UpdateUserDetailsOnEmployeeSettingEvent>(_updateEmployeeDetails);

    _subscription = eventBus.on<UpdateUserDetailsOnEmployeeSettingEvent>().listen((event) {
      add(UpdateUserDetailsOnEmployeeSettingEvent());
    });
  }


  void _updateEmployeeDetails(UpdateUserDetailsOnEmployeeSettingEvent event, Emitter<EmployeeSettingState> emit){
    emit(EmployeeSettingState(employee: _userManager.employee));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}