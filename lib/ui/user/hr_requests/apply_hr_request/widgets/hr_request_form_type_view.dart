import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/model/hr_request/hr_request.dart';
import '../bloc/hr_request_form_bloc.dart';
import '../bloc/hr_request_form_events.dart';
import '../bloc/hr_request_form_states.dart';

class HrRequestTypeView extends StatelessWidget {
  const HrRequestTypeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Material(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        child: BlocBuilder<HrRequestFormBloc, HrRequestFormState>(
          buildWhen: (previous, current) => previous.type != current.type,
          builder: (context, state) => DropdownButtonHideUnderline(
            child: DropdownButton<HrRequestType?>(
              isExpanded: true,
              style: AppFontStyle.bodyLarge,
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_drop_down),
              ),
              borderRadius: BorderRadius.circular(12),
              hint: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(localization.user_settings_edit_select_tag),
              ),
              items: HrRequestType.values.map((type) {
                return DropdownMenuItem<HrRequestType?>(
                  value: type,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                        localization.hr_request_types(type.value.toString())),
                  ),
                );
              }).toList(),
              value: state.type,
              onChanged: (HrRequestType? type) {
                context.read<HrRequestFormBloc>().add(ChangeType(type));
              },
            ),
          ),
        ),
      ),
    );
  }
}
