import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/bloc/admin/leave/leave_application_bloc.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../configs/colors.dart';
import '../../../../core/utils/const/other_constant.dart';
import 'leaveRequestCard/leave_request_card.dart';

class AdminLeaveRequestsScreen extends StatefulWidget {
  const AdminLeaveRequestsScreen({Key? key}) : super(key: key);

  @override
  State<AdminLeaveRequestsScreen> createState() =>
      _AdminLeaveRequestsScreenState();
}

class _AdminLeaveRequestsScreenState extends State<AdminLeaveRequestsScreen> {
  final NavigationStackManager _stackManager = getIt<NavigationStackManager>();
  final _leaveApplicationBloc = getIt<LeaveApplicationBloc>();

  @override
  void initState() {
    _leaveApplicationBloc.getLeaveApplication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkText,
          ),
          onPressed: () {
            _stackManager.pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context).admin_home_request_tag,
          style: AppTextStyle.headerDark600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: primaryHorizontalSpacing,
            right: primaryHorizontalSpacing,
            left: primaryHorizontalSpacing),
        child: StreamBuilder<ApiResponse<List<LeaveApplication>>>(
            initialData: const ApiResponse.idle(),
            stream: _leaveApplicationBloc.leaveApplication,
            builder: (context, snapshot) {
              return snapshot.data!.when(
                  idle: () => Container(),
                  loading: () => const kCircularProgressIndicator(),
                  completed: (List<LeaveApplication> list) {
                    return ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        LeaveApplication employeeLeave = list[index];
                        return LeaveRequestCard(employeeLeave: employeeLeave);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
                  },
                  error: (String error) {
                    return showSnackBar(context, error);
                  });
            }),
      ),
    );
  }
}
