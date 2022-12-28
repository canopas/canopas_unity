import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/admin/home/bloc/admin_home_bloc.dart';
import 'package:projectunity/ui/admin/home/bloc/admin_home_event.dart';
import 'package:projectunity/ui/admin/home/bloc/admin_home_state.dart';
import 'package:projectunity/ui/admin/home/widget/request_list.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import 'package:projectunity/widget/expanded_app_bar.dart';

import '../../../configs/colors.dart';
import '../../../configs/text_style.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../router/app_router.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>getIt<AdminHomeBloc>()..add(AdminHomeInitialLoadEvent()),
        child: const AdminHomeScreen());
  }
}



class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocListener<AdminHomeBloc,AdminHomeState>(
        listener: (context,state){
          state.status==AdminHomeStatus.failure ?showSnackBar(context: context,error: state.error):null;
        },
        child: Stack(
              children: [
                Column(
                  children: [
                    const HomePageAppbar(),
                    const SizedBox(height: 66,),
                    Expanded(
                      child: BlocBuilder<AdminHomeBloc,AdminHomeState>(
                          builder: (context, state) {
                            if (state.status == AdminHomeStatus.loading) {
                              return const AppCircularProgressIndicator();
                            } else if (state.status == AdminHomeStatus.success) {
                              final map = state.leaveAppMap;
                              return LeaveRequestList(map: map);
                            }return const SizedBox();
                          }
                      ),
                    ),
                  ],
                ),

                const EmployeeSummaryCard(),
              ],
           ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }

}





class HomePageAppbar extends StatelessWidget {
  const HomePageAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandedAppBar(
        content: Row(children: [
          const Spacer(),
          IconButton(
              icon: const Icon(
                Icons.add,
                color: AppColors.whiteColor,
              ),
              onPressed: () =>context.goNamed(Routes.addMember)),
          IconButton(
              icon: const Icon(
                Icons.settings,
                color: AppColors.whiteColor,
              ),
              onPressed: () =>context.goNamed(Routes.adminSettings)),
        ]));
  }
}






class EmployeeSummaryCard extends StatelessWidget {
  const EmployeeSummaryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Expanded(
                child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()=>context.pushNamed(Routes.employees),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     const Icon(
                        Icons.people,
                        size: 26,
                         color: AppColors.primaryGreen,
                      ),
                      Text( AppLocalizations.of(context)
                          .admin_home_employee_tag, style: AppTextStyle.secondaryBodyText),

                      BlocBuilder<AdminHomeBloc,AdminHomeState>(
                        builder: (context,state){
                          final String employeesCount= state.totalOfEmployees.toString();
                          return Text(employeesCount,style: AppTextStyle.headerTextBold
                          );
                        },

                      ),
                    ],
                  ),
                ),
            ),
              ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_active_rounded,
                            size: 26,
                            color: AppColors.primaryDarkYellow,
                          ),
                          Text(AppLocalizations.of(context)
                              .admin_home_request_tag, style: AppTextStyle.secondaryBodyText),

                          BlocBuilder<AdminHomeBloc,AdminHomeState>(
                            builder: (context,state) {
                              String requestsCount= state.totalOfRequests.toString();
                              return Text(requestsCount,style: AppTextStyle.headerTextBold
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: ()=>context.pushNamed(Routes.adminCalender),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              size: 26,
                              color: AppColors.primaryPink,
                            ),
                            Text( AppLocalizations.of(context).admin_home_absence_tag, style: AppTextStyle.secondaryBodyText),

                            BlocBuilder<AdminHomeBloc,AdminHomeState>(
                              builder: (context,state){
                               final String absenceCount= state.totalAbsence.toString();
                                return Text(absenceCount,style: AppTextStyle.headerTextBold
                                );
                              },

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
