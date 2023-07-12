import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/hr_request/hr_request.dart';
import 'bloc/hr_requests_bloc.dart';
import 'bloc/hr_requests_events.dart';
import 'bloc/hr_requests_states.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/theme.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../../data/core/utils/date_formatter.dart';
import '../../../data/di/service_locator.dart';

class HrRequestsPage extends StatelessWidget {
  const HrRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<HrRequestsBloc>()
          ..add(HrRequestsInit()),
        child: const HrRequestsScreen());
  }
}

class HrRequestsScreen extends StatefulWidget {
  const HrRequestsScreen({super.key});

  @override
  State<HrRequestsScreen> createState() =>
      _HrServiceDeskRequestScreenState();
}

class _HrServiceDeskRequestScreenState
    extends State<HrRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HR Requests"),
      ),
      body: BlocConsumer<HrRequestsBloc, HrRequestsState>(
        listenWhen: (previous, current) =>
            current.status == Status.error && current.error != null,
        listener: (context, state) {
          if (state.status == Status.error && state.error != null) {
            showSnackBar(context: context, error: state.error);
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const AppCircularProgressIndicator();
          } else if (state.status == Status.success &&
              state.hrServiceDeskRequests.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.hrServiceDeskRequests.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) => HrServiceDeskRequestCard(
                  onTap: () {},
                  hrRequest: state.hrServiceDeskRequests[index]),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("New Request"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class HrServiceDeskRequestCard extends StatelessWidget {
  final void Function()? onTap;
  final HrRequest hrRequest;

  const HrServiceDeskRequestCard(
      {super.key, this.onTap, required this.hrRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Material(
        borderRadius: AppTheme.commonBorderRadius,
        color: AppColors.whiteColor,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(hrRequest.type.name,
                        style: AppFontStyle.titleDark),
                    Text(
                        DateFormatter(AppLocalizations.of(context))
                            .timeAgoPresentation(
                                hrRequest.requestedAt),
                        style: AppFontStyle.bodyMedium,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                const Divider(height: 32),
                Text(hrRequest.description,
                    style: AppFontStyle.labelGrey,
                    overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
