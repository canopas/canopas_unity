import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/error_snack_bar.dart';
import '../../../../widget/leave_card.dart';
import '../bloc/leaves/user_leave_bloc.dart';
import '../bloc/leaves/user_leave_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LeaveList extends StatelessWidget {
  const LeaveList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLeaveBloc, UserLeaveState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.leaves != current.leaves,
      builder: (context, state) {
        if (state.status == Status.success && state.leaves.isNotEmpty) {
          return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => LeaveCard(
                  onTap: () {
                    context.goNamed(Routes.userLeaveDetail, params: {
                      RoutesParamsConst.leaveId: state.leaves[index].leaveId
                    });
                  },
                  leave: state.leaves[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: state.leaves.length);
        }
        return ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 300,
            ),
            child: SizedBox(
                height: MediaQuery.of(context).size.height - 500,
                child: state.status == Status.loading
                    ? const AppCircularProgressIndicator()
                    : EmptyScreen(
                        title: AppLocalizations.of(context).no_leaves_tag,
                        message: AppLocalizations.of(context).user_leave_empty_screen_message)));
      },
      listenWhen: (previous, current) => current.status == Status.error,
      listener: (context, state) {
        if (state.status == Status.error) {
          showSnackBar(context: context, error: state.error);
        }
      },
    );
  }
}
