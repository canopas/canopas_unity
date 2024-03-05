import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_event.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_state.dart';
import 'package:projectunity/ui/admin/forms/form_list/widget/form_card.dart';
import 'package:projectunity/app_router.dart';
import 'package:projectunity/ui/widget/empty_screen.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../../data/di/service_locator.dart';
import '../../../widget/circular_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AdminFormListPage extends StatelessWidget {
  const AdminFormListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminFormListBloc>(),
      child: const AdminFormListScreen(),
    );
  }
}

class AdminFormListScreen extends StatefulWidget {
  const AdminFormListScreen({super.key});

  @override
  State<AdminFormListScreen> createState() => _AdminFormListScreenState();
}

class _AdminFormListScreenState extends State<AdminFormListScreen> {
  @override
  void initState() {
    context.read<AdminFormListBloc>().add(AdminFormListInitialLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdminFormListBloc>();
    return AppPage(
      title: context.l10n.forms_title,
      body: BlocConsumer<AdminFormListBloc, AdminFormListState>(
        listenWhen: (previous, current) => current.status != previous.status,
        listener: (context, state) {
          if (state.error != null && state.status == Status.error) {
            showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const AppCircularProgressIndicator();
          } else if (state.status == Status.success && state.forms.isNotEmpty) {
            return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) =>
                    AdminListFormCard(formInfo: state.forms[index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: state.forms.length);
          }
          return EmptyScreen(
              message:
                  AppLocalizations.of(context).form_list_empty_screen_title,
              title:
                  AppLocalizations.of(context).form_list_empty_screen_message);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context).create_tag),
        onPressed: () async {
          final String? formId = await context.pushNamed(Routes.newForm);
          if (formId != null) {
            bloc.add(UpdateFormEvent(formId));
          }
        },
      ),
    );
  }
}
