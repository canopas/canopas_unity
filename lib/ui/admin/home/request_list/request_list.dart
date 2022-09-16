import 'package:flutter/material.dart';
import 'package:projectunity/bloc/admin/leave/leave_application_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import '../../../../configs/colors.dart';
import '../../../../core/utils/const/other_constant.dart';
import '../leaveRequestCard/leave_request_card.dart';

class AdminLeaveRequestsList extends StatefulWidget {
  const AdminLeaveRequestsList({Key? key}) : super(key: key);

  @override
  State<AdminLeaveRequestsList> createState() =>
      _AdminLeaveRequestsListState();
}

class _AdminLeaveRequestsListState extends State<AdminLeaveRequestsList> {
  final _leaveApplicationBloc = getIt<LeaveApplicationBloc>();

  @override
  void initState() {
    _leaveApplicationBloc.getLeaveApplication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<LeaveApplication>>>(
        initialData: const ApiResponse.idle(),
        stream: _leaveApplicationBloc.leaveApplication,
        builder: (context, snapshot) {
          return snapshot.data!.when(
              idle: () =>  Container(),
              loading: () => const Expanded(child: Center(child: kCircularProgressIndicator())),
              completed: (List<LeaveApplication> list) {
                return Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top: 6),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LeaveRequestCard(leaveApplication: list[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                );
              },
              error: (String error) {
                return showSnackBar(context, error);
              });
        });
  }
}
