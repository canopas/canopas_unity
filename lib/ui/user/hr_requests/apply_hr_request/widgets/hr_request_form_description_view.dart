import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../bloc/hr_request_form_bloc.dart';
import '../bloc/hr_request_form_events.dart';
import '../bloc/hr_request_form_states.dart';

class HrRequestDescriptionView extends StatelessWidget {
  const HrRequestDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      padding: const EdgeInsets.all(primaryHorizontalSpacing)
          .copyWith(top: 0, bottom: primaryVerticalSpacing),
      child: BlocBuilder<HrRequestFormBloc, HrRequestFormState>(
          buildWhen: (previous, current) =>
              current.description != previous.description,
          builder: (context, state) => TextField(
                style: AppFontStyle.bodySmallRegular,
                cursorColor: AppColors.secondaryText,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter description",
                  hintStyle: AppFontStyle.labelGrey,
                ),
                onChanged: (description) {
                  context
                      .read<HrRequestFormBloc>()
                      .add(ChangeDescription(description));
                },
              )),
    );
  }
}
