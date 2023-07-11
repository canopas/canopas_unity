import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/widget/bottom_sheet_top_divider.dart';
import 'package:projectunity/ui/widget/employee_card.dart';
import 'package:projectunity/ui/widget/employee_details_textfield.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/di/service_locator.dart';
import '../bloc /admin_leave_event.dart';
import '../bloc /admin_leaves_bloc.dart';
import '../bloc /admin_leaves_state.dart';

class AdminLeavesFilter extends StatelessWidget {
  const AdminLeavesFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userManager = getIt<UserStateNotifier>();
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SearchEmployeeBottomSheet(),
          const SizedBox(width: 8),
          BlocBuilder<AdminLeavesBloc, AdminLeavesState>(
            buildWhen: (previous, current) =>
                previous.selectedYear != current.selectedYear ||
                previous.selectedEmployee != current.selectedEmployee,
            builder: (context, state) {
              final startLeaveYear =
                  state.selectedEmployee?.dateOfJoining.year ??
                      userManager.currentSpace!.createdAt.year;
              return Container(
                height: 45,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.dividerColor),
                ),
                child: Material(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      style: AppFontStyle.bodySmallRegular,
                      isExpanded: true,
                      iconSize: 0.0,
                      icon: const SizedBox(),
                      borderRadius: BorderRadius.circular(12),
                      alignment: Alignment.center,
                      items: List.generate(
                          DateTime.now().year - (startLeaveYear - 1),
                          (change) => startLeaveYear + change).map((year) {
                        return DropdownMenuItem<int>(
                          alignment: Alignment.center,
                          value: year,
                          child: Text(year.toString(),
                              style: AppFontStyle.bodySmallHeavy,
                              overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      value: state.selectedYear,
                      onChanged: (int? year) {
                        context.read<AdminLeavesBloc>().add(
                            ChangeEmployeeLeavesYearEvent(
                                year: year ?? state.selectedYear));
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SearchEmployeeBottomSheet extends StatefulWidget {
  const SearchEmployeeBottomSheet({Key? key}) : super(key: key);

  @override
  State<SearchEmployeeBottomSheet> createState() =>
      _SearchEmployeeBottomSheetState();
}

class _SearchEmployeeBottomSheetState extends State<SearchEmployeeBottomSheet> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: AppColors.whiteColor,
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<AdminLeavesBloc>(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    const BottomSheetTopSlider(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FieldEntry(
                        controller: searchController,
                        hintText:
                            AppLocalizations.of(context).search_employee_tag,
                        onChanged: (searchInput) => context
                            .read<AdminLeavesBloc>()
                            .add(SearchEmployeeEvent(search: searchInput)),
                      ),
                    ),
                    const Divider(height: 0),
                    Expanded(
                      child: BlocBuilder<AdminLeavesBloc, AdminLeavesState>(
                        buildWhen: (previous, current) =>
                            previous.members != current.members,
                        builder: (context, state) {
                          return ListView(
                            padding: const EdgeInsets.all(8),
                            children: [
                              const SearchEmployeeShowAllMemberLeaveButton(),
                              ...state.members.map((member) => EmployeeCard(
                                  employee: member,
                                  onTap: () {
                                    context.read<AdminLeavesBloc>().add(
                                        ChangeMemberEvent(member: member));
                                    context.pop();
                                  })),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: BlocBuilder<AdminLeavesBloc, AdminLeavesState>(
          buildWhen: (previous, current) =>
              previous.selectedEmployee != current.selectedEmployee,
          builder: (context, state) => Container(
            alignment: Alignment.center,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Text(
                state.selectedEmployee?.name ??
                    AppLocalizations.of(context).all_tag,
                style: AppFontStyle.bodySmallHeavy,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}

class SearchEmployeeShowAllMemberLeaveButton extends StatelessWidget {
  const SearchEmployeeShowAllMemberLeaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<AdminLeavesBloc>()
            .add(ChangeMemberEvent(member: null));
        context.pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SpaceLogoView(
                spaceLogoUrl: getIt<UserStateNotifier>().currentSpace?.logo),
            const SizedBox(width: 20),
            Text(AppLocalizations.of(context).all_tag,
                style: AppFontStyle.bodyMedium,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
