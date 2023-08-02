import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/widget/bottom_sheet_top_divider.dart';
import 'package:projectunity/ui/widget/employee_card.dart';
import 'package:projectunity/ui/widget/employee_details_textfield.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/di/service_locator.dart';
import '../../../../widget/widget_validation.dart';
import '../bloc /admin_leave_event.dart';
import '../bloc /admin_leaves_bloc.dart';
import '../bloc /admin_leaves_state.dart';

class AdminLeavesFilter extends StatefulWidget {
  const AdminLeavesFilter({Key? key}) : super(key: key);

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
                        controller: _searchController,
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
                              ValidateWidget(
                                isValid: state.selectedMember != null,
                                child: SearchEmployeeShowAllMemberLeaveButton(
                                  employeeIsSelected:
                                      state.selectedMember != null,
                                ),
                              ),
                              ...state.members.map((member) => EmployeeCard(
                                  employee: member,
                                  onTap: () {
                                    context.read<AdminLeavesBloc>().add(
                                        FetchLeavesInitialEvent(
                                            member: member));
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
              previous.selectedMember != current.selectedMember,
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                state.selectedMember == null
                    ? SpaceLogoView(
                        spaceLogoUrl:
                            getIt<UserStateNotifier>().currentSpace?.logo,
                        size: 30)
                    : ImageProfile(
                        radius: 15, imageUrl: state.selectedMember!.imageUrl),
                const SizedBox(width: 10),
                Text(
                    state.selectedMember?.name ??
                        AppLocalizations.of(context).all_tag,
                    style: AppFontStyle.bodySmallHeavy,
                    overflow: TextOverflow.ellipsis),
                const Spacer(),
                const Icon(Icons.filter_list_rounded)
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

  const SearchEmployeeShowAllMemberLeaveButton(
      {Key? key, required this.employeeIsSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (employeeIsSelected) {
          context.read<AdminLeavesBloc>().add(FetchLeavesInitialEvent());
        }
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
