import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../ui/user/leave/applyLeave/widget/picker_card.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../widget/date_time_picker.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_bloc.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_events.dart';
import '../bloc/leave_request_form_bloc/leave_request_view_states.dart';

class LeaveRequestDateSelection extends StatelessWidget {
  const LeaveRequestDateSelection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LeaveRequestBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHalfSpacing),
      child: Row(
        children: [
          BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
            buildWhen: (previous, current) => previous.startDate != current.startDate,
            builder: (context, state) => DatePickerCard(
              title: AppLocalizations.of(context).user_apply_leave_from_tag,
              onPress: () async {
                DateTime? date = await pickDate(context: context, initialDate: state.startDate,onlyFutureDateSelection: true);
                bloc.add(LeaveRequestStartDateChangeEvents(startDate: date));
              },
              date: state.startDate,
            ),
          ),
          BlocBuilder<LeaveRequestBloc, LeaveRequestViewState>(
            buildWhen: (previous, current) => previous.endDate != current.endDate,
            builder: (context, state) => DatePickerCard(
              title: AppLocalizations.of(context).user_apply_leave_to_tag,
              onPress: () async {
                DateTime? date = await pickDate(context: context, initialDate: state.endDate, onlyFutureDateSelection: true);
                bloc.add(LeaveRequestEndDateChangeEvent(endDate: date));
              },
              date: state.endDate,
            ),
          ),
        ],
      ),
    );
  }
}