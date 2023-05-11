import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../../data/configs/colors.dart';
import '../../../widget/employee_details_textfield.dart';
import 'bloc/invite_member_bloc.dart';
import 'bloc/invite_member_event.dart';
import 'bloc/invite_member_state.dart';

class InviteMemberPage extends StatelessWidget {
  const InviteMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InviteMemberBloc>(
      create: (_) => getIt.get<InviteMemberBloc>(),
      child: const SearchMemberScreen(),
    );
  }
}

class SearchMemberScreen extends StatefulWidget {
  const SearchMemberScreen({Key? key}) : super(key: key);

  @override
  State<SearchMemberScreen> createState() => _SearchMemberScreenState();
}

class _SearchMemberScreenState extends State<SearchMemberScreen> {

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.admin_home_invite_member_appbar_tag),
      ),
      body: BlocConsumer<InviteMemberBloc, InviteMemberState>(
        listenWhen: (previous, current) =>
            current.status == Status.error || current.status == Status.success,
        listener: (context, state) {
          if (state.status == Status.error) {
            showSnackBar(context: context, error: state.error);
          } else if (state.status == Status.success) {
            context.pop();
          }
        },
        buildWhen: (previous, current) =>
            (previous.email != current.email) ||
            current.status == Status.loading,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const AppCircularProgressIndicator();
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(bottom: 0),
                child: BlocBuilder<InviteMemberBloc, InviteMemberState>(
                    builder: (context, state) {
                  return FieldEntry(
                    hintText: locale.admin_home_invite_member_hint_text,
                    errorText: state.emailError
                        ? locale.admin_home_invite_member_error_email
                        : '',
                    onChanged: (String? query) => context
                        .read<InviteMemberBloc>()
                        .add(AddEmailEvent(query)),
                  );
                }),
              ),
              FloatingActionButton.extended(
                extendedPadding: const EdgeInsets.symmetric(horizontal: 60),
                elevation: 0,
                onPressed: () =>
                    context.read<InviteMemberBloc>().add(InviteMemberEvent()),
                label: Text(
                  locale.admin_home_invite_Button_tag,
                  style: AppFontStyle.buttonTextStyle
                      .copyWith(color: AppColors.whiteColor),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
