import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/colors.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_event.dart';
import '../bloc/apply_leave_state.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 16),
        child: BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
          builder: (context, state) => state.leaveRequestStatus ==
                  Status.loading
              ? const FittedBox(child: AppCircularProgressIndicator())
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryLightColor,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      elevation: 2),
                  onPressed: () {
                    context
                        .read<ApplyLeaveBloc>()
                        .add(ApplyLeaveSubmitFormEvent());
                  },
                  child: Text(
                     context.l10n.
                          user_leaves_apply_leave_button_tag,
                      style: AppTextStyle.style14
                          .copyWith(color: AppColors.whiteColor))),
        ));
  }
}
