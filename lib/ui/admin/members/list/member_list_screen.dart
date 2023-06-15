import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/employee_card.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/text_style.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/member_list_bloc.dart';
import 'bloc/member_list_event.dart';
import 'bloc/member_list_state.dart';
import 'invitation_card.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminMembersBloc>(
        create: (_) => getIt<AdminMembersBloc>()..add(FetchInvitationEvent()),
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
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).members_tag,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
                onPressed: () => context.pushNamed(Routes.inviteMember),
                child: Text(localizations.invite_tag)),
          )
        ],
      ),
      body: BlocConsumer<AdminMembersBloc, AdminMembersState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<AdminMembersBloc>().add(FetchInvitationEvent());
            },
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(
                          endIndent: primaryVerticalSpacing,
                          indent: primaryVerticalSpacing,
                        ),
                    padding: const EdgeInsets.all(primaryVerticalSpacing),
                    itemCount: state.members.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EmployeeCard(
                        employee: state.members[index],
                        onTap: () => context
                            .goNamed(Routes.adminMemberDetails, params: {
                          RoutesParamsConst.employeeId: state.members[index].uid
                        }),
                      );
                    }),
                ValidateWidget(
                  isValid: state.invitation.isNotEmpty,
                  child: state.fetchInvitationStatus == Status.loading
                      ? const AppCircularProgressIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                localizations.invited_members_title,
                                style: AppFontStyle.headerDark,
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
                                padding: const EdgeInsets.all(
                                    primaryHorizontalSpacing),
                                itemCount: state.invitation.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    InvitedMemberCard(
                                        invitation: state.invitation[index])),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.error != null &&
              (state.fetchMemberStatus == Status.error ||
                  state.fetchInvitationStatus == Status.error)) {
            showSnackBar(context: context, error: state.error);
          }
        },
      ),
    );
  }
}
