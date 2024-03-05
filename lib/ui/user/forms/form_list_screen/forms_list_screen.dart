import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/ui/user/forms/form_list_screen/widget/form_card.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/empty_screen.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/user_forms_list_screen_bloc.dart';
import 'bloc/user_forms_list_screen_event.dart';
import 'bloc/user_forms_list_screen_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class UserFormListPage extends StatelessWidget {
  const UserFormListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserFormListBloc>(),
      child: const UserFormListScreen(),
    );
  }
}

class UserFormListScreen extends StatefulWidget {
  const UserFormListScreen({super.key});

  @override
  State<UserFormListScreen> createState() => _UserFormListScreenState();
}

class _UserFormListScreenState extends State<UserFormListScreen> {
  @override
  void initState() {
    context.read<UserFormListBloc>().add(UserFormListInitialLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backGroundColor: context.colorScheme.surface,

      title: context.l10n.forms_title,
      body: BlocConsumer<UserFormListBloc, UserFormListState>(
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
                    UserListFormCard(formInfo: state.forms[index]),
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
    );
  }
}
