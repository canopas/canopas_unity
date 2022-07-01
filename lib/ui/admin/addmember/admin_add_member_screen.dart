import 'package:flutter/material.dart';
import 'package:projectunity/bloc/employee_validation.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:projectunity/ui/admin/addmember/widget/employee_form.dart';
import 'package:projectunity/ui/admin/addmember/widget/header_title.dart';
import 'package:projectunity/utils/const/color_constant.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../model/employee/employee.dart';

class AdminAddMemberScreen extends StatefulWidget {
  const AdminAddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddMemberScreen> createState() => _AdminAddMemberScreenState();
}

class _AdminAddMemberScreenState extends State<AdminAddMemberScreen> {
  final employeeService = getIt<EmployeeService>();
  final _stateManager = getIt<NavigationStackManager>();
  final EmployeeValidationBloc _bloc = getIt<EmployeeValidationBloc>();
  int selectedRole = kRoleTypeEmployee;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryBlue,
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverAppBar(
                  backgroundColor: primaryBlue,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 24,
                    ),
                    onPressed: () {
                      _stateManager.pop();
                    },
                  ),
                  expandedHeight: 150,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: HeaderTitle(),
                  ),
                )
              ],
              body: EmployeeForm(selectedRole: selectedRole),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 10,
                      spreadRadius: 15,
                    ),
                  ]),
                  //   color: Colors.white,
                  child: StreamBuilder<bool>(
                    initialData: false,
                    stream: _bloc.validateSubmit,
                    builder: (BuildContext context, snapshot) {
                      return SubmitButton(
                        data: snapshot.data!,
                        onPress: () {
                          Employee employee = _bloc.submit(selectedRole);
                          try {
                            employeeService.addEmployee(employee);
                            snapshot.data == true ? _stateManager.pop() : () {};
                          } catch (error) {
                            buildSnackBar(context, 'Something went wrong');
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.onPress, required this.data})
      : super(key: key);

  final VoidCallback onPress;
  final bool data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: data == true ? secondaryBlue : primaryBlue,
          ),
          onPressed: onPress,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}
