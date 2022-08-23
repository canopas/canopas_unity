import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/user/leave/leaveScreen/widget/leave_card.dart';
import 'package:projectunity/widget/empty_leave_screen.dart';

import '../../../../configs/colors.dart';
import '../../../../model/leave/leave.dart';
import '../../../../rest/api_response.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/error_snackbar.dart';

class LeaveScreen extends StatelessWidget {
  final _stateManager = getIt<NavigationStackManager>();

  final Stream<ApiResponse<List<Leave>>> leaveStream;
  final String header;

  LeaveScreen({Key? key, required this.leaveStream, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBlue,
        leading: IconButton(
          onPressed: () {
            _stateManager.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          header,
          style: const TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<ApiResponse<List<Leave>>>(
                stream: leaveStream,
                initialData: const ApiResponse.idle(),
                builder: (context, snapshot) {
                  return snapshot.data!.when(
                      idle: () => Container(),
                      loading: () => const kCircularProgressIndicator(),
                      completed: (List<Leave> leaves) {
                        if (leaves.isEmpty) {
                          return const EmptyLeaveScreen();
                        } else {
                          return ListView.builder(
                              itemCount: leaves.length,
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 16),
                              itemBuilder: (BuildContext context, int index) {
                                leaves.sortedByDate();
                                Leave leave = leaves[index];
                                return LeaveCard(
                                  leave: leave,
                                );
                              });
                        }
                      },
                      error: (String error) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          showSnackBar(context, error);
                        });
                        return Container();
                      });
                }),
          )
        ],
      ),
    );
  }
}
