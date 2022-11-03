import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/admin/home/widget/requests/request_list.dart';
import 'package:projectunity/ui/admin/home/widget/summary_content.dart';
import 'package:projectunity/widget/expanded_app_bar.dart';
import '../../../bloc/admin/home/admin_home_screen_bloc.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../navigation/nav_stack/nav_stack_item.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _bloc = getIt<AdminHomeScreenBloc>();

  @override
  void initState() {
    _bloc.attach();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandedAppBar(
                  content: Row(children: [
                const Spacer(),
                IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      _stateManager.push(const NavStackItem.addMemberState());
                    }),
                IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      _stateManager
                          .push(const NavStackItem.adminSettingsState());
                    }),
              ])),
              const SizedBox(
                height: 66,
              ),
              AdminLeaveRequestsList(
                  leaveApplicationStream: _bloc.leaveApplication),
            ],
          ),
          Positioned(
            top: 100,
            right: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: primaryHorizontalSpacing,
                  right: primaryHorizontalSpacing),
              child: Card(
                  elevation: 6,
                  shadowColor: AppColors.greyColor.withOpacity(0.25),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EmployeeSummaryContent(
                          onTap: () {
                            _stateManager.push(
                                const NavStackItem.adminEmployeeListState());
                          },
                          stream: _bloc.totalEmployees,
                          icon: Icons.people,
                          color: AppColors.primaryGreen,
                          desc: AppLocalizations.of(context)
                              .admin_home_employee_tag,
                        ),
                        EmployeeSummaryContent(
                          onTap: null,
                          stream: _bloc.totalRequest,
                          icon: Icons.notifications_active_rounded,
                          color: AppColors.primaryDarkYellow,
                          desc: AppLocalizations.of(context)
                              .admin_home_request_tag,
                        ),
                        EmployeeSummaryContent(
                          stream: _bloc.absenceCount,
                          onTap: () {
                            _stateManager.push(
                                const NavStackItem.whoIsOutCalendarState());
                          },
                          icon: Icons.calendar_month_rounded,
                          color: AppColors.primaryPink,
                          desc: AppLocalizations.of(context)
                              .admin_home_absence_tag,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
