import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart';

import '../../../admin/home/home_screen/bloc/admin_home_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, UserLeaveService, UserEmployeeDetailBloc])
void main() {
  late final EmployeeService employeeService;
  late final UserLeaveService userLeaveService;
  late final UserEmployeeDetailBloc bloc;

  setUp(() {
    employeeService = MockEmployeeService();
    userLeaveService = MockUserLeaveService();
    bloc = UserEmployeeDetailBloc(employeeService, userLeaveService);
  });
}
