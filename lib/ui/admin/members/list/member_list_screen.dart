import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/employee_card.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/member_list_bloc.dart';
import 'bloc/member_list_event.dart';
import 'bloc/member_list_state.dart';
import 'inivitation_card.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminMembersBloc>(
        create: (_) =>
            getIt<AdminMembersBloc>()..add(AdminMembersInitialLoadEvent()),
        child: const MemberListScreen());
  }
}

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({Key? key}) : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: AppLocalizations.of(context).members_tag,
      actions: [
        TextButton(
            onPressed: () => context.pushNamed(Routes.inviteMember),
            child: Text(context.l10n.invite_tag))
      ],
      body: BlocConsumer<AdminMembersBloc, AdminMembersState>(
        builder: (BuildContext context, AdminMembersState state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              state.memberFetchStatus == Status.loading
                  ? const AppCircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const Divider(
                                  endIndent: primaryVerticalSpacing,
                                  indent: primaryVerticalSpacing,
                                ),
                            itemCount: state.activeMembers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return EmployeeCard(
                                employee: state.activeMembers[index],
                                onTap: () => context.goNamed(
                                    Routes.adminMemberDetails,
                                    extra: state.activeMembers[index].uid),
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        ValidateWidget(
                          isValid: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .inactive_members_title,
                                  style: AppTextStyle.style20.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.colorScheme.textPrimary),
                                ),
                              ),
                              const Divider(height: 0),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                        endIndent: primaryVerticalSpacing,
                                        indent: primaryVerticalSpacing,
                                      ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  itemCount: state.inactiveMembers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return EmployeeCard(
                                      employee: state.inactiveMembers[index],
                                      onTap: () => context.goNamed(
                                          Routes.adminMemberDetails,
                                          extra:
                                              state.inactiveMembers[index].uid),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              state.invitationFetchStatus == Status.loading
                  ? const AppCircularProgressIndicator()
                  : ValidateWidget(
                      isValid: state.invitation.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              context.l10n.invited_members_title,
                              style: AppTextStyle.style20.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.textPrimary),
                            ),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              itemCount: state.invitation.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  InvitedMemberCard(
                                      invitation: state.invitation[index])),
                        ],
                      ),
                    ),
            ],
          );
        },
        listener: (BuildContext context, AdminMembersState state) {
          if (state.error != null) {
            showSnackBar(context: context, error: state.error);
          }
        },
      ),
    );
  }
}
