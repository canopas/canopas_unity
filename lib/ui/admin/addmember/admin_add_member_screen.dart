import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/admin/employee/employee_validation.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:projectunity/ui/admin/addmember/widget/employee_form.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/role.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryBlue,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 2,
                collapseMode: CollapseMode.pin,
                title: Text(
                  AppLocalizations.of(context).admin_addMember_addMember_tag,
                  style: AppTextStyle.appBarTitle,
                ),
              ),
            )
          ],
          body: EmployeeForm(selectedRole: selectedRole),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
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
                isEnabled: snapshot.data ?? false,
                onPress: () {
                  Employee employee = _bloc.submit(selectedRole);
                  try {
                    employeeService.addEmployee(employee);
                    snapshot.data == true ? _stateManager.pop() : () {};
                  } catch (error) {
                    showSnackBar(
                        context,
                        AppLocalizations.of(context)
                            .error_something_went_wrong);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.onPress, required this.isEnabled})
      : super(key: key);

  final VoidCallback onPress;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: isEnabled ? AppColors.darkBlue : AppColors.primaryBlue,
          ),
          onPressed: onPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              AppLocalizations.of(context).admin_addMember_button_submit,
              style: AppTextStyle.titleText
            ),
          )),
    );
  }
}
