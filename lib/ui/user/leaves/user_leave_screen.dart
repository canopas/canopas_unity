import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_cout_event.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_state.dart';
import 'package:projectunity/ui/user/leaves/widget/past_leave_card.dart';
import 'package:projectunity/ui/user/leaves/widget/upcoming_leave_Card.dart';

import 'widget/leave_count_card.dart';

class UserLeavePage extends StatelessWidget {
  const UserLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              getIt<UserLeaveCountBloc>()..add(UserLeaveCountEvent())),
      BlocProvider(create: (_)=>getIt<UserLeaveBloc>()..add(UserLeaveEvent()))
    ], child: const UserLeaveScreen());
  }
}

class UserLeaveScreen extends StatefulWidget {
  const UserLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UserLeaveScreen> createState() => _UserLeaveScreenState();
}

class _UserLeaveScreenState extends State<UserLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(
            localization.user_leave_tag,
            style: AppFontStyle.appbarHeaderStyle,
          ),
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(localization.user_apply_tag,
                    style: AppFontStyle.buttonTextStyle))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: const [
              LeaveCountCard(),
              Divider(),
              UpcomingLeaveCard(),
              PastLeaveCard()
            ],
          ),
        ));
  }
}
