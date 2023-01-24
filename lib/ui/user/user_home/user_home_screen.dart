import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/utils/const/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/user/user_home/widget/leave_navigation_card.dart';
import '../../../router/app_router.dart';
import '../../../widget/WhoIsOutCard/who_is_out_card.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          children:  [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor,
                    boxShadow: AppTheme.commonBoxShadow,
                    image:  const DecorationImage(
                      image: NetworkImage(ImageConst.companyLogo)
                    ),
                  ),
                ),
                const SizedBox(width: primaryHorizontalSpacing,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(AppLocalizations.of(context).company_name,style: AppTextStyle.titleDark,overflow: TextOverflow.ellipsis),
                    Text(AppLocalizations.of(context).company_subtitle,style: AppTextStyle.bodyDarkGrey,)
                  ],
                ),
                const Spacer(),
                ///TODO remove this navigation on bottom bar navigation implementation.".
                IconButton(
                    onPressed: () => context.pushNamed(Routes.userLeaveCalender),
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.blackColor,
                    )),
                IconButton(
                    onPressed: () => context.pushNamed(Routes.userSettings),
                    icon: const Icon(
                      Icons.settings,
                      color: AppColors.blackColor,
                    )),
              ],
            ),
            const SizedBox(height: primaryHorizontalSpacing,),
            const WhoIsOutCard(),
            ///TODO remove this navigation on bottom bar navigation implementation.".
            const _EmployeeHomeNavigationCard(),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}


class _EmployeeHomeNavigationCard extends StatelessWidget {
  const _EmployeeHomeNavigationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: primaryHorizontalSpacing,),
      LeaveNavigationCard(
          color: AppColors.primaryPink,
          leaveText: AppLocalizations.of(context).user_home_all_leaves_tag,
          onPress: () => context.pushNamed(Routes.allLeaves)),
      LeaveNavigationCard(
          color: AppColors.primaryBlue,
          leaveText:
          AppLocalizations.of(context).user_home_requested_leaves_tag,
          onPress: () => context.pushNamed(Routes.requested)),
      LeaveNavigationCard(
          color: AppColors.primaryGreen,
          leaveText: AppLocalizations.of(context).user_home_upcoming_leaves_tag,
          onPress: () => context.pushNamed(Routes.upcoming)),
      LeaveNavigationCard(
          color: AppColors.primaryDarkYellow,
          leaveText: AppLocalizations.of(context).user_home_apply_leave_tag,
          onPress: () => context.pushNamed(Routes.applyLeave)),

    ]);
  }
}