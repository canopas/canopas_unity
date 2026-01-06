import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/widget_extension.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/bottom_sheet_top_divider.dart';
import 'package:projectunity/ui/widget/employee_card.dart';
import 'package:projectunity/ui/widget/employee_details_textfield.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/di/service_locator.dart';
import '../../../../widget/widget_validation.dart';
import '../bloc /admin_leave_event.dart';
import '../bloc /admin_leaves_bloc.dart';
import '../bloc /admin_leaves_state.dart';

class AdminLeavesFilter extends StatefulWidget {
  const AdminLeavesFilter({super.key});

  @override
  State<AdminLeavesFilter> createState() => _AdminLeavesFilterState();
}

class _AdminLeavesFilterState extends State<AdminLeavesFilter> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        borderRadius: AppTheme.commonBorderRadius,
        onTap: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: context.colorScheme.surface,
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<AdminLeavesBloc>(),
              child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const BottomSheetTopSlider(),
                    FieldEntry(
                      controller: _searchController,
                      hintText: context.l10n.search_employee_tag,
                      onChanged: (searchInput) => context
                          .read<AdminLeavesBloc>()
                          .add(SearchEmployeeEvent(search: searchInput)),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 0),
                    const SizedBox(height: 20),
                    Expanded(
                      child: BlocBuilder<AdminLeavesBloc, AdminLeavesState>(
                        buildWhen: (previous, current) =>
                            previous.members != current.members,
                        builder: (context, state) {
                          return ListView(
                            children: [
                              ValidateWidget(
                                isValid: state.selectedMember != null,
                                child: SearchEmployeeShowAllMemberLeaveButton(
                                  employeeIsSelected:
                                      state.selectedMember != null,
                                ),
                              ),
                              ...state.members.map(
                                (member) => EmployeeCard(
                                  employee: member,
                                  onTap: () {
                                    context.read<AdminLeavesBloc>().add(
                                      FetchLeavesInitialEvent(member: member),
                                    );
                                    context.pop();
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: BlocBuilder<AdminLeavesBloc, AdminLeavesState>(
          buildWhen: (previous, current) =>
              previous.selectedMember != current.selectedMember,
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                state.selectedMember == null
                    ? SpaceLogoView(
                        spaceLogoUrl:
                            getIt<UserStateNotifier>().currentSpace?.logo,
                        size: 30,
                      )
                    : ImageProfile(
                        radius: 15,
                        imageUrl: state.selectedMember!.imageUrl,
                      ),
                const SizedBox(width: 10),
                Text(
                  state.selectedMember?.name ?? context.l10n.all_tag,
                  style: AppTextStyle.style18.copyWith(
                    color: context.colorScheme.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Icon(
                  Icons.filter_list_rounded,
                  color: context.colorScheme.textPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchEmployeeShowAllMemberLeaveButton extends StatelessWidget {
  final bool employeeIsSelected;

  const SearchEmployeeShowAllMemberLeaveButton({
    super.key,
    required this.employeeIsSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SpaceLogoView(
            spaceLogoUrl: getIt<UserStateNotifier>().currentSpace?.logo,
          ),
          const SizedBox(width: 20),
          Text(
            context.l10n.all_tag,
            style: AppTextStyle.style16.copyWith(
              color: context.colorScheme.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).onTapGesture(() {
      if (employeeIsSelected) {
        context.read<AdminLeavesBloc>().add(FetchLeavesInitialEvent());
      }
      context.pop();
    });
  }
}
