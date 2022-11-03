import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/ui/user/home/widget/leave_navigation_card.dart';
import 'package:projectunity/ui/user/home/widget/leave_status.dart';
import 'package:projectunity/ui/user/home/widget/team_leave_card.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
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
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          _stateManager.push(NavStackItem.userLeaveCalendarState(userId: _leaveCount.userID));
                        },
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.whiteColor,
                        )),
                    IconButton(
                        onPressed: () {
                          _stateManager
                              .push(const NavStackItem.employeeSettingsState());
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: AppColors.whiteColor,
                        )),
                  ],
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
                              loading: () => SizedBox(
                                height: MediaQuery.of(context).size.height*0.15,
                                child: const kCircularProgressIndicator(),
                              ),
                              completed: (data) => TeamLeaveCard(onTap: (){
                                _stateManager.push(const NavStackItem.whoIsOutCalendarState());
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
}