import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/widget/picker_card.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../widget/date_time_picker.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_event.dart';
import '../bloc/apply_leave_state.dart';

class LeaveRequestDateSelection extends StatelessWidget {
  const LeaveRequestDateSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ApplyLeaveBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHalfSpacing),
      child: Row(
        children: [
          BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
            buildWhen: (previous, current) =>
                previous.startDate != current.startDate,
            builder: (context, state) => DatePickerCard(
              title: AppLocalizations.of(context)
                  .user_leaves_apply_leave_start_tag,
              onPress: () async {
                DateTime? date = await pickDate(
                    context: context,
                    initialDate: state.startDate,
                    onlyFutureDateSelection: true);
                bloc.add(ApplyLeaveStartDateChangeEvents(startDate: date));
              },
              date: state.startDate,
            ),
          ),
          BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
            buildWhen: (previous, current) =>
                previous.endDate != current.endDate,
            builder: (context, state) => DatePickerCard(
              title:
                  AppLocalizations.of(context).user_leaves_apply_leave_end_tag,
              onPress: () async {
                DateTime? date = await pickDate(
                    context: context,
                    initialDate: state.endDate,
                    onlyFutureDateSelection: true);
                bloc.add(ApplyLeaveEndDateChangeEvent(endDate: date));
              },
              date: state.endDate,
            ),
          ),
        ],
      ),
    );
  }
}
