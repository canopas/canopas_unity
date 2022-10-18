import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/ui/user/home/widget/leave_navigation_card.dart';
import 'package:projectunity/ui/user/home/widget/leave_status.dart';
import 'package:projectunity/ui/user/home/widget/team_leave_card.dart';

import '../../../bloc/employee/home/employee_home_bloc.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../model/leave_count.dart';
import '../../../widget/expanded_app_bar.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _leaveCount = getIt<EmployeeHomeBLoc>();

  @override
  void initState() {
    _leaveCount.attach();
    super.initState();
  }

  @override
  void dispose() {
    _leaveCount.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ExpandedAppBar(
                content: Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        _stateManager
                            .push(const NavStackItem.employeeSettingsState());
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: AppColors.whiteColor,
                      )),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      top: 80,
                      left: primaryHorizontalSpacing,
                      right: primaryHorizontalSpacing),
                  child: Column(
                    children: [
                      LeaveNavigationCard(
                          color: AppColors.primaryPink,
                          leaveText: AppLocalizations.of(context)
                              .user_home_all_leaves_tag,
                          onPress: () => _stateManager.push(
                              const NavStackItem.userAllLeaveState())),
                      LeaveNavigationCard(
                          color: AppColors.primaryBlue,
                          leaveText: AppLocalizations.of(context)
                              .user_home_requested_leaves_tag,
                          onPress: () => _stateManager.push(
                              const NavStackItem.requestedLeaves())),
                      LeaveNavigationCard(
                          color: AppColors.primaryGreen,
                          leaveText: AppLocalizations.of(context)
                              .user_home_upcoming_leaves_tag,
                          onPress: () => _stateManager.push(
                              const NavStackItem.userUpcomingLeaveState())),
                      LeaveNavigationCard(
                          color: AppColors.primaryDarkYellow,
                          leaveText: AppLocalizations.of(context)
                              .user_home_apply_leave_tag,
                          onPress: () {
                            _stateManager
                                .push(const NavStackItem.leaveRequestState());
                          }),
                      StreamBuilder<ApiResponse<List<LeaveApplication>>>(
                        initialData: const ApiResponse.idle(),
                          stream: _leaveCount.absenceEmployee,
                          builder: (context, snapshot) => snapshot.data!.when(
                              idle: () => const SizedBox(),
                              loading: () => const SizedBox(),
                              completed: (data) => TeamLeaveCard(onTap: (){
                                /// TODO: Navigate to calender page.
                              }, leaveApplication: data,),
                              error: (error) => const SizedBox(),
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 100,
              right: 10,
              left: 10,
              child: StreamBuilder<LeaveCounts>(
                  stream: _leaveCount.leaveCounts,
                  initialData: LeaveCounts(),
                  builder: (context, AsyncSnapshot snapshot) => LeaveStatus(leaveCounts: snapshot.data)))
        ],
      ),
    );
  }

  Widget _buildTitle({required Function() onPress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            AppLocalizations.of(context).user_home_who_onLeave_tag,
            style: const TextStyle(
              fontSize: titleTextSize,
              color: AppColors.secondaryText,
            ),
          ),
          TextButton(
              onPressed: onPress,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  AppLocalizations.of(context).user_home_button_view_all,
                  style: const TextStyle(
                    color: AppColors.blueGrey,
                    fontSize: smallTextSize,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
