import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/ui/admin/home/home_screen/widget/request_list.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_event.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/di/service_locator.dart';
import '../../../shared/appbar_drawer/appbar/dashboard_appbar.dart';
import '../../../shared/who_is_out_card/bloc/who_is_out_card_bloc.dart';
import '../../../shared/who_is_out_card/who_is_out_card.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/empty_screen.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/admin_home_bloc.dart';
import 'bloc/admin_home_event.dart';
import 'bloc/admin_home_state.dart';

class AdminHomeScreenPage extends StatelessWidget {
  const AdminHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt.get<AdminHomeBloc>()..add(AdminHomeInitialLoadEvent()),
        ),
        BlocProvider(
            create: (context) =>
                getIt<WhoIsOutCardBloc>()..add(FetchWhoIsOutCardLeaves())),
      ],
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
    final locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: DashBoardAppBar(onTap: () => Scaffold.of(context).openDrawer(),
      ),
      body: ListView(
        children: [
          const WhoIsOutCard(),
          BlocConsumer<AdminHomeBloc, AdminHomeState>(
              listenWhen: (previous, current) => current.status == Status.error,
              listener: (context, state) {
                if (state.status == Status.error) {
                  showSnackBar(context: context, error: state.error);
                }
              },
              buildWhen: (previous, current) => current.status != Status.error,
              builder: (context, state) {
                if (state.status == Status.success &&
                    state.leaveAppMap.isNotEmpty) {
                  return LeaveRequestList(map: state.leaveAppMap);
                }
                return ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 300),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 500,
                    child: state.status == Status.loading
                        ? const AppCircularProgressIndicator()
                        : EmptyScreen(
                            message: locale.empty_request_message,
                            title: locale.empty_request_title,
                          ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
