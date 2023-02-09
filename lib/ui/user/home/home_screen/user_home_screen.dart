import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/user/home/home_screen/widget/employee_home_appbar.dart';

import '../../../../configs/colors.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../di/service_locator.dart';
import '../../../../router/app_router.dart';
import '../../../../widget/WhoIsOutCard/who_is_out_card.dart';
import 'bloc/user_home_bloc.dart';

class UserHomeScreenPage extends StatelessWidget {
  const UserHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserHomeBloc>(),
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
        ],
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
