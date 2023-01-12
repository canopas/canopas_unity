import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_bloc.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_events.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/admin/edit_employe_details/widgets/admin_edit_employee_details_form.dart';
import '../../../configs/colors.dart';
import 'bloc/admin_edit_employee_details_state.dart';

class AdminEditEmployeeDetailsPage extends StatelessWidget {
  final Employee employee;

  const AdminEditEmployeeDetailsPage({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminEditEmployeeDetailsBloc>()
        ..add(AdminEditEmployeeDetailsInitialEvent(employee: employee)),
      child: AdminEditEmployeeDetailsView(
        employee: employee,
      ),
    );
  }
}

class AdminEditEmployeeDetailsView extends StatefulWidget {
  final Employee employee;

  const AdminEditEmployeeDetailsView({Key? key, required this.employee})
      : super(key: key);

  @override
  State<AdminEditEmployeeDetailsView> createState() =>
      _AdminEditEmployeeDetailsViewState();
}

class _AdminEditEmployeeDetailsViewState
    extends State<AdminEditEmployeeDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).edit_tag),
      ),
      body: AdminEditEmployeeDetailsForm(employeeId: widget.employee.id),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
        child: BlocBuilder<AdminEditEmployeeDetailsBloc,
            AdminEditEmployeeDetailsState>(
          buildWhen: (previous, current) =>
              previous.isValid != current.isValid ||
              previous.adminEditEmployeeDetailsStatus !=
                  current.adminEditEmployeeDetailsStatus,
          builder: (context, state) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width / 2, 45),
                disabledBackgroundColor: AppColors.greyColor,
              ),
              onPressed: (state.isValid)
                  ? () {
                      context.read<AdminEditEmployeeDetailsBloc>().add(
                              UpdateEmployeeDetailsAdminEditEmployeeDetailsEvent(
                            id: widget.employee.id,
                          ));
                    }
                  : null,
              child: state.adminEditEmployeeDetailsStatus ==
                      AdminEditEmployeeDetailsStatus.loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                        strokeWidth: 3,
                      ))
                  : Text(
                      AppLocalizations.of(context).update_button_text,
                      style: AppTextStyle.subtitleTextWhite,
                    )),
        ),
      ),
    );
  }
}
