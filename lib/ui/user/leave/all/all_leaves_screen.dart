import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/bloc/leaves/user_all_leaves_bloc.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/ui/user/leave/all/widget/leave_widget.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';

import '../../../../configs/colors.dart';
import '../../../../widget/error_snackbar.dart';

class AllLeaveScreen extends StatefulWidget {
  AllLeaveScreen({Key? key}) : super(key: key);

  @override
  State<AllLeaveScreen> createState() => _AllLeaveScreenState();
}

class _AllLeaveScreenState extends State<AllLeaveScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _userAllLeavesBloc = getIt<UserAllLeavesBloc>();

  @override
  void initState() {
    _userAllLeavesBloc.getAllLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            _stateManager.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'All Leaves',
          style: TextStyle(
              color: AppColors.darkText,
              fontSize: headerTextSize,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<ApiResponse<List<LeaveRequestData>>>(
                stream: _userAllLeavesBloc.allLeaves,
                initialData: const ApiResponse.idle(),
                builder: (context, snapshot) {
                  return snapshot.data!.when(
                      idle: () => Container(),
                      loading: () => const kCircularProgressIndicator(),
                      completed: (List<LeaveRequestData> leaves) {
                        return ListView.builder(
                            itemCount: leaves.length,
                            itemBuilder: (BuildContext context, int index) {
                              leaves.sortedByDate();
                              LeaveRequestData leave = leaves[index];
                              return LeaveWidget(
                     leave: leave,
                              );
                            });
                      },
                      error: (String error) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          buildSnackBar(context, error);
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
