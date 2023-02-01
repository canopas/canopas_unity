import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/edit_employee_details/bloc/edit_employee_details_employee_event.dart';
import 'package:projectunity/ui/user/edit_employee_details/bloc/edit_employee_details_employee_state.dart';
import 'package:projectunity/ui/user/edit_employee_details/widget/edit_employee_details_form_employee.dart';
import '../../../configs/colors.dart';
import '../../../model/employee/employee.dart';
import '../../../widget/app_app_bar.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/edit_employee_details_employee_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class EmployeeEditEmployeeDetailsPage extends StatelessWidget {
  final Employee employee;

  const EmployeeEditEmployeeDetailsPage({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployeeEditEmployeeDetailsBloc>()
        ..add(EmployeeEditEmployeeDetailsInitialLoadEvent(
            dateOfBirth: employee.dateOfBirth, gender: employee.gender)),
      child: EmployeeEditEmployeeDetailsView(employee: employee),
    );
  }
}

class EmployeeEditEmployeeDetailsView extends StatefulWidget {
  final Employee employee;

  const EmployeeEditEmployeeDetailsView({Key? key, required this.employee})
      : super(key: key);

  @override
  State<EmployeeEditEmployeeDetailsView> createState() =>
      _EmployeeEditEmployeeDetailsViewState();
}

class _EmployeeEditEmployeeDetailsViewState
    extends State<EmployeeEditEmployeeDetailsView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.employee.name;
    designationController.text = widget.employee.designation;
    phoneNumberController.text = widget.employee.phone ?? "";
    addressController.text = widget.employee.address ?? "";
    bloodGroupController.text = widget.employee.bloodGroup ?? "";
    levelController.text = widget.employee.level ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppAppBar(
        onBack: (){
          context.pop();
        },
        bottomTitlePadding: 0,
        title: AppLocalizations.of(context).edit_tag,
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(primaryVerticalSpacing),
              ),
              onPressed: () {
                context
                    .read<EmployeeEditEmployeeDetailsBloc>()
                    .add(UpdateEmployeeDetailsEvent(
                      address: addressController.text,
                      bloodGroup: bloodGroupController.text,
                      level: levelController.text,
                      name: nameController.text,
                      designation: designationController.text,
                      phoneNumber: phoneNumberController.text,
                    ));
              },
              child: Text(
                AppLocalizations.of(context).save_tag,
                style: AppTextStyle.subtitleTextDark,
              ))
        ],
      ),
      body: BlocListener<EmployeeEditEmployeeDetailsBloc,
          EmployeeEditEmployeeDetailsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == EmployeeEditEmployeeDetailsStatus.failure) {
            showSnackBar(context: context, error: state.error);
          } else if (state.status ==
              EmployeeEditEmployeeDetailsStatus.success) {
            context.pop();
          }
        },
        child: EmployeeEditEmployeeDetailsForm(
          profileImageURL: widget.employee.imageUrl,
          nameController: nameController,
          levelController: levelController,
          designationController: designationController,
          addressController: addressController,
          bloodGroupController: bloodGroupController,
          phoneNumberController: phoneNumberController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    designationController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    bloodGroupController.dispose();
    levelController.dispose();
    super.dispose();
  }
}
