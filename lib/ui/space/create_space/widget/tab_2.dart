import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../widget/employee_details_textfield.dart';
import '../bloc/create_workspace_bloc.dart';
import '../bloc/create_workspace_event.dart';
import '../bloc/create_workspace_state.dart';

class SetUpSpaceDetails extends StatefulWidget {
  final void Function()? onNextButtonPressed;

  const SetUpSpaceDetails({super.key, this.onNextButtonPressed});

  @override
  State<SetUpSpaceDetails> createState() => _SetUpSpaceDetailsState();
}

class _SetUpSpaceDetailsState extends State<SetUpSpaceDetails>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bloc = BlocProvider.of<CreateSpaceBLoc>(context);
    final locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.create_space_set_up_your_space_text,
          style: AppTextStyle.style20
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(
          height: 30,
        ),
        BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
            buildWhen: (previous, current) =>
                previous.paidTimeOff != current.paidTimeOff,
            builder: (context, state) {
              return FieldEntry(
                hintText: AppLocalizations.of(context).yearly_paid_time_off_tag,
                keyboardType: TextInputType.number,
                maxLength: 2,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (String? value) {
                  bloc.add(PaidTimeOffChangeEvent(paidTimeOff: value));
                },
                errorText: state.paidTimeOffError
                    ? locale.create_space_invalid_time_off_error
                    : null,
              );
            }),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
