import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/shared/drawer/bloc/app_drawer_bloc.dart';
import 'package:projectunity/ui/shared/drawer/bloc/app_drawer_event.dart';
import 'package:projectunity/ui/shared/drawer/bloc/app_drawer_state.dart';
import 'package:projectunity/ui/shared/drawer/widget/drawer_option.dart';
import 'package:projectunity/ui/shared/drawer/widget/drawer_space_card.dart';
import 'package:projectunity/ui/shared/drawer/widget/drawer_user_profile_card.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../../data/di/service_locator.dart';
import '../../../data/provider/user_data.dart';
import '../../widget/app_dialog.dart';
import '../../widget/circular_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final UserManager userManager = getIt<UserManager>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrawerBloc>(
      create: (context) => getIt<DrawerBloc>()..add(FetchSpacesEvent()),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
          color: AppColors.whiteColor,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.8,
        child: SafeArea(
          child: Material(
            color: AppColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileCard(
                  currentEmployee: userManager.employee,
                  currentSpace: userManager.currentSpace!,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text("Spaces for pratik.k@canopas.com",
                      style: AppFontStyle.subTitleGrey.copyWith(fontSize: 16)),
                ),
                const Divider(height: 0),
                const SpaceList(),
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DrawerOption(
                          icon: Icons.edit_note_rounded,
                          title: "Edit Space",
                          onTap: () {}),
                      DrawerOption(
                          icon: Icons.person_outline_rounded,
                          title: "View Profile",
                          onTap: () {}),
                      BlocBuilder<DrawerBloc,DrawerState>(
                        builder: (context, state) => DrawerOption(
                            icon: Icons.logout_rounded,
                            title: AppLocalizations.of(context).sign_out_tag,
                            onTap: () {
                              showAlertDialog(
                                context: context,
                                actionButtonTitle:
                                    AppLocalizations.of(context).sign_out_tag,
                                onActionButtonPressed: () {
                                  context.read<DrawerBloc>().add(SignOutEvent());
                                },
                                title: AppLocalizations.of(context).sign_out_tag,
                                description:
                                    AppLocalizations.of(context).sign_out_alert,
                              );
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpaceList extends StatelessWidget {
  const SpaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
        if (state.fetchSpacesStatus == Status.loading) {
          return const ThreeBounceLoading(
            color: AppColors.primaryBlue,
            size: 20,
          );
        } else if (state.fetchSpacesStatus == Status.success) {
          if (state.spaces.isEmpty) {
            return const SizedBox();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
            shrinkWrap: true,
            itemCount: state.spaces.length,
            itemBuilder: (context, index) => DrawerSpaceCard(
              logo: state.spaces[index].logo,
              name: state.spaces[index].name,
              onTap: () => context
                  .read<DrawerBloc>()
                  .add(ChangeSpaceEvent(state.spaces[index])),
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
