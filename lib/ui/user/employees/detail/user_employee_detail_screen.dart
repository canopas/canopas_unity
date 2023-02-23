import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_event.dart';

class EmployeeDetailPage extends StatelessWidget {
  final String employeeId;
  const EmployeeDetailPage({Key? key, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserEmployeeDetailBloc>(
        create: (_) => getIt<UserEmployeeDetailBloc>()
          ..add(UserEmployeeDetailFetchEvent(employeeId: employeeId)),
        child: const EmployeeDetailScreen());
  }
}

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
