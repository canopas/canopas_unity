import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/widget_extension.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/admin/members/list/inivitation_card.dart';
import 'package:projectunity/ui/widget/employee_card.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/member_list_bloc.dart';
import 'bloc/member_list_event.dart';
import 'bloc/member_list_state.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminMembersBloc>(
        create: (_) =>
            getIt<AdminMembersBloc>()..add(AdminMembersInitialLoadEvent()),
        child: const MemberListScreen());
  }
}

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      title: AppLocalizations.of(context).members_tag,
      actions: [
        TextButton(
            onPressed: () => context.pushNamed(Routes.inviteMember),
            child: Text(
              context.l10n.invite_tag,
              style: AppTextStyle.style16
                  .copyWith(color: context.colorScheme.primary),
            ))
      ],
      body: BlocConsumer<AdminMembersBloc, AdminMembersState>(
        builder: (BuildContext context, AdminMembersState state) {
          return state.memberFetchStatus == Status.loading
              ? const AppCircularProgressIndicator()
              : CustomScrollView(
                  slivers: [
                    MembersTile(
                      index: 1,
                      isExpanded: state.expanded.contains(1),
                      employees: state.activeMembers,
                      title: context.l10n.members_tag,
                      invited: false,
                    ),
                    MembersTile(
                      index: 2,
                      isExpanded: state.expanded.contains(2),
                      employees: state.invitation,
                      title: context.l10n.invited_members_title,
                      invited: true,
                    ),
                    MembersTile(
                      index: 3,
                      isExpanded: state.expanded.contains(3),
                      employees: state.inactiveMembers,
                      title: context.l10n.inactive_members_title,
                      invited: false,
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

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  HeaderDelegate({Key? key, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}

class MembersTile extends StatelessWidget {
  final int index;
  final List<dynamic> employees;
  final String title;
  final bool isExpanded;
  final bool invited;

  const MembersTile(
      {super.key,
      required this.index,
      required this.employees,
      required this.title,
      required this.invited,
      required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      SliverPersistentHeader(
          pinned: true,
          delegate: HeaderDelegate(
              child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.style20.copyWith(
                      color: isExpanded
                          ? context.colorScheme.primary
                          : context.colorScheme.textPrimary),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: isExpanded
                      ? context.colorScheme.primary
                      : context.colorScheme.textPrimary,
                )
              ],
            ),
          ).onTapGesture(() {
            context.read<AdminMembersBloc>().add(ExpansionChangeEvent(index));
          }))),
      if (isExpanded)
        SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: employees.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                        child:
                            Text("No any $title", style: AppTextStyle.style16)))
                : SliverList.separated(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      final employee = employees[index];
                      return invited
                          ? InvitedMemberCard(
                              invitation: employee as Invitation)
                          : EmployeeCard(
                              employee: employee,
                              onTap: () => context.goNamed(
                                  Routes.adminMemberDetails,
                                  extra: employee.uid),
                            );
                    },
                    separatorBuilder: (context, index) => const Divider()))
    ]);
  }
}
