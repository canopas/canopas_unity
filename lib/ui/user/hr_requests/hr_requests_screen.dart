import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../navigation/app_router.dart';
import '../../widget/hr_request_card.dart';
import 'bloc/hr_requests_bloc.dart';
import 'bloc/hr_requests_events.dart';
import 'bloc/hr_requests_states.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../../data/di/service_locator.dart';

class HrRequestsPage extends StatelessWidget {
  const HrRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<HrRequestsBloc>()..add(HrRequestsInit()),
        child: const HrRequestsScreen());
  }
}

class HrRequestsScreen extends StatefulWidget {
  const HrRequestsScreen({super.key});

  @override
  State<HrRequestsScreen> createState() => _HrServiceDeskRequestScreenState();
}

class _HrServiceDeskRequestScreenState extends State<HrRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.hr_requests_title),
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
                  onTap: () {
                    ///TODO: Open hr request details screen
                  },
                  hrRequest: state.hrServiceDeskRequests[index]),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bloc = context.read<HrRequestsBloc>();
          bool? value = await context.pushNamed(Routes.applyHrRequests);
          if (value == true) {
            bloc.add(HrRequestsInit());
          }
        },
        label: Text(locale.new_request_tag),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
