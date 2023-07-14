import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../widget/error_snack_bar.dart';
import 'widgets/hr_request_form_description_view.dart';
import 'widgets/hr_request_form_type_view.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../widget/circular_progress_indicator.dart';
import 'bloc/hr_request_form_bloc.dart';
import 'bloc/hr_request_form_events.dart';
import 'bloc/hr_request_form_states.dart';
import '../../../../data/configs/text_style.dart';
import '../../../../data/di/service_locator.dart';

class HrRequestFormPage extends StatelessWidget {
  const HrRequestFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<HrRequestFormBloc>(),
        child: const HrRequestFormScreen());
  }
}

class HrRequestFormScreen extends StatefulWidget {
  const HrRequestFormScreen({super.key});

  @override
  State<HrRequestFormScreen> createState() => _HrRequestFormScreenState();
}

class _HrRequestFormScreenState extends State<HrRequestFormScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.hr_request_title),
        actions: [
          BlocBuilder<HrRequestFormBloc, HrRequestFormState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.isProvidedDataValid != current.isProvidedDataValid,
              builder: (context, state) => state.status == Status.loading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: AppCircularProgressIndicator(size: 20),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                          onPressed: state.isProvidedDataValid
                              ? () {
                                  context
                                      .read<HrRequestFormBloc>()
                                      .add(ApplyHrRequest());
                                }
                              : null,
                          child: Text(
                              AppLocalizations.of(context).submit_button_tag)),
                    )),
        ],
      ),
      body: BlocListener<HrRequestFormBloc, HrRequestFormState>(
        listenWhen: (previous, current) =>
            current.error != null || current.status == Status.success,
        listener: (context, state) {
          if (state.error != null) {
            showSnackBar(context: context, error: state.error);
          } else if (state.status == Status.success) {
            context.pop(true);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(locale.type_tag,
                  textAlign: TextAlign.start, style: AppFontStyle.labelGrey),
            ),
            const HrRequestTypeView(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(locale.description_tag,
                  textAlign: TextAlign.start, style: AppFontStyle.labelGrey),
            ),
            const HrRequestDescriptionView(),
          ],
        ),
      ),
    );
  }
}
