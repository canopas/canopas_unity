import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../../../../widget/error_snack_bar.dart';
import '../../../../widget/leave_card.dart';
import '../bloc/leaves/user_leave_bloc.dart';
import '../bloc/leaves/user_leave_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LeaveList extends StatelessWidget {
  final bool isHR;
  const LeaveList({Key? key, required this.isHR}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLeaveBloc, UserLeaveState>(
      buildWhen: (previous, current) =>
      previous.status != current.status ||
          previous.leaves != current.leaves,
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: AppCircularProgressIndicator(),
          );
        } else if (state.status == Status.success &&
            state.leaves.isNotEmpty) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemBuilder: (context, index) => LeaveCard(
                  onTap: () {
                    context.goNamed(
                        isHR
                            ? Routes.hrLeaveDetails
                            : Routes.userLeaveDetail,
                        params: {
                          RoutesParamsConst.leaveId:
                          state.leaves[index].leaveId
                        });
                  },
                  leave: state.leaves[index]),
              separatorBuilder: (context, index) =>
              const SizedBox(height: 16),
              itemCount: state.leaves.length);
        }
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.lightPrimaryBlue,
                borderRadius: AppTheme.commonBorderRadius),
            child: Text(
              AppLocalizations.of(context).user_leave_no_leaves_msg,
              style: const TextStyle(fontSize: 15),
            ));
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
