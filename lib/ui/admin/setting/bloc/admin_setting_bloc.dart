import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../model/employee/employee.dart';
import '../../../../provider/user_data.dart';
import 'admin_setting_event.dart';
import 'admin_setting_state.dart';

@Injectable()
class AdminSettingBloc extends Bloc<AdminSettingEvent,AdminSettingState>{
  final UserManager _userManager;
  AdminSettingBloc(this._userManager) : super(AdminSettingState(employee:_userManager.employee));

  Employee get employee => _userManager.employee;
}