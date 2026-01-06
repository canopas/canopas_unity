import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../gen/assets.gen.dart';
import '../bloc/apply_leave_bloc.dart';
import '../bloc/apply_leave_event.dart';
import '../bloc/apply_leave_state.dart';

class LeaveRequestReasonCard extends StatelessWidget {
  const LeaveRequestReasonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.images.pencilSquare),
              const SizedBox(width: 10),
              Text(
                context.l10n.reason_tag,
                style: AppTextStyle.style18.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colorScheme.containerHigh),
            ),
            padding: const EdgeInsets.all(
              primaryHorizontalSpacing,
            ).copyWith(top: 0, bottom: primaryVerticalSpacing),
            child: BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
              buildWhen: (previous, current) =>
                  current.reason != previous.reason ||
                  current.showTextFieldError != previous.showTextFieldError,
              builder: (context, state) => TextField(
                style: AppTextStyle.style14.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
                cursorColor: context.colorScheme.textSecondary,
                maxLines: 5,
                decoration: InputDecoration(
                  errorText: state.showTextFieldError
                      ? context.l10n.user_leaves_apply_leave_error_valid_reason
                      : null,
                  border: InputBorder.none,
                ),
                onChanged: (reason) {
                  context.read<ApplyLeaveBloc>().add(
                    ApplyLeaveReasonChangeEvent(reason: reason),
                  );
                },
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
