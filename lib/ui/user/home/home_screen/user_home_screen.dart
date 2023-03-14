import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';
import 'package:projectunity/ui/user/home/home_screen/widget/employee_home_appbar.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import '../../../../configs/colors.dart';
import '../../../../di/service_locator.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/leave_card.dart';
import '../../../shared/WhoIsOutCard/who_is_out_card.dart';
import 'bloc/user_home_bloc.dart';

class UserHomeScreenPage extends StatelessWidget {
  const UserHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<UserHomeBloc>()..add(UserHomeFetchLeaveRequest()),
      child: const UserHomeScreen(),
    );
  }
}

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmployeeHomeAppBar(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
      ),
      body: ListView(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        children: [
          WhoIsOutCard(
            onSeeAllButtonTap: () {
              context.pushNamed(Routes.userCalender);
            },
          ),
          BlocConsumer<UserHomeBloc, UserHomeState>(
              builder: (context, state) {
                if (state is UserHomeSuccessState) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: Text(
                              AppLocalizations.of(context)
                                  .user_home_requests_tag,
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, leave) => LeaveCard(onTap: (){}, leave: state.requests[leave]),
                            separatorBuilder:  (context, index) => const SizedBox(height: 16,),
                            itemCount: state.requests.length),
                      ]);
                }
                return const SizedBox();
              },
              listenWhen: (previous, current) => current is UserHomeErrorState,
              listener: (context, state) {
                if (state is UserHomeErrorState) {
                  showSnackBar(context: context, error: state.error);
                }
              })
        ],
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
