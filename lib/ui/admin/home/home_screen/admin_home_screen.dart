import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/admin/home/home_screen/widget/admin_home_appbar.dart';
import 'package:projectunity/ui/admin/home/home_screen/widget/request_list.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/space_constant.dart';
import '../../../../di/service_locator.dart';
import '../../../../router/app_router.dart';
import '../../../../widget/WhoIsOutCard/who_is_out_card.dart';
import '../../../../widget/empty_screen.dart';
import 'bloc/admin_home_bloc.dart';
import 'bloc/admin_home_event.dart';
import 'bloc/admin_home_state.dart';

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
      appBar: AdminHomeAppBar(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: primaryHorizontalSpacing,
                  vertical: primaryHalfSpacing),
              child: WhoIsOutCard(
                onSeeAllButtonTap: () => context.goNamed(Routes.adminCalender),
              ),
            ),
            BlocConsumer<AdminHomeBloc, AdminHomeState>(
                listener: (context, state) {
              if (state.status == AdminHomeStatus.failure) {
                showSnackBar(context: context, error: state.error);
              }
            }, builder: (context, state) {
              if (state.status == AdminHomeStatus.loading) {
                return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.22),
                    child: const AppCircularProgressIndicator());
              } else if (state.leaveAppMap.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.09),
                  child: EmptyScreen(
                    message: AppLocalizations.of(context)
                        .admin_home_empty_leave_request_message,
                    title: AppLocalizations.of(context)
                        .admin_home_no_request_title,
                  ),
                );
              }
              return LeaveRequestList(map: state.leaveAppMap);
            }),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
