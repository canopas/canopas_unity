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
import '../../../configs/colors.dart';
import '../../../configs/text_style.dart';
import '../../../configs/theme.dart';
import '../../../core/utils/const/image_constant.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../router/app_router.dart';
import '../../../widget/WhoIsOutCard/who_is_out_card.dart';

class AdminHomeScreenPage extends StatelessWidget {
  const AdminHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AdminHomeBloc>()..add(AdminHomeInitialLoadEvent()),
      child: const AdminHomeScreen(),
    );
  }
}

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(color: AppColors.whiteColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor,
                      boxShadow: AppTheme.commonBoxShadow,
                      image: const DecorationImage(
                          image: NetworkImage(ImageConst.companyLogo)),
                    ),
                  ),
                  const SizedBox(
                    width: primaryHorizontalSpacing,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).company_name,
                          style: AppTextStyle.titleDark,
                          overflow: TextOverflow.ellipsis),
                      Text(
                        AppLocalizations.of(context).company_subtitle,
                        style: AppTextStyle.bodyDarkGrey,
                      )
                    ],
                  ),
                  const Spacer(),

                  ///TODO remove this navigation on bottom bar navigation implementation.".
                  CircleAvatar(
                    backgroundColor: const Color(0xfff5f5f5),
                    child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.darkGrey,
                        ),
                        onPressed: () => context.goNamed(Routes.addMember)),
                  ),
                  const SizedBox(
                    width: primaryVerticalSpacing,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xfff5f5f5),
                    child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: AppColors.darkGrey,
                        ),
                        onPressed: () => context.goNamed(Routes.adminSettings)),
                  ),
                ],
              ),
              const SizedBox(
                height: primaryHalfSpacing,
              ),
              const Divider(
                color: AppColors.dividerColor,
                height: 1,
                thickness: 1,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: primaryHorizontalSpacing,
                  vertical: primaryHalfSpacing),
              child: WhoIsOutCard(
                onSeeAllButtonTap: () => context.goNamed(Routes.allUserCalender),
              ),
            ),
            BlocConsumer<AdminHomeBloc, AdminHomeState>(
                listener: (context, state) {
              if (state.status == AdminHomeStatus.failure) {
                showSnackBar(context: context, error: state.error);
              }
            }, builder: (context, state) {
              if (state.status == AdminHomeStatus.loading) {
                return const AppCircularProgressIndicator();
              } else if (state.status == AdminHomeStatus.success) {
                final map = state.leaveAppMap;
                return LeaveRequestList(map: map);
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
