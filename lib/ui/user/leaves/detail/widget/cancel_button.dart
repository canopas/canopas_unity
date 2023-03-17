import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart';
import '../bloc/user_leave_detail_event.dart';

class CancelButton extends StatelessWidget {
  final String leaveId;
  const CancelButton({Key? key, required this.leaveId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: primaryHorizontalSpacing),
      child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<UserLeaveDetailBloc>(context)
                .add(CancelLeaveApplicationEvent(leaveId: leaveId));
          },
          child: Text(AppLocalizations.of(context)
              .user_leaves_detail_cancel_button_tag)),
    );
  }
}
