import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';
import 'package:projectunity/ui/space/join_space/widget/workspace_card.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../data/configs/colors.dart';
import '../../navigation/app_router.dart';

class JoinSpacePage extends StatelessWidget {
  const JoinSpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: const JoinSpaceScreen(),
        create: (context) =>
            getIt<JoinSpaceBloc>()..add(JoinSpaceInitialFetchEvent()));
  }
}

class JoinSpaceScreen extends StatefulWidget {
  const JoinSpaceScreen({Key? key}) : super(key: key);

  @override
  State<JoinSpaceScreen> createState() => _JoinSpaceScreenState();
}

class _JoinSpaceScreenState extends State<JoinSpaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<JoinSpaceBloc, JoinSpaceState>(
        listenWhen: (previous, current) =>
            current.fetchSpaceStatus == Status.failure || current.selectSpaceStatus == Status.failure,
        listener: (context, state) {
          if (state.error != null) {
            showSnackBar(context: context, error: state.error);
          }
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(primaryHorizontalSpacing)
                .copyWith(top: 32),
            children: [
              Text(
                AppLocalizations.of(context).welcome_to_unity_text,
                style: AppFontStyle.titleDark,
              ),
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context).create_own_space_title,
                  style: AppFontStyle.bodyLarge),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: AppColors.lightPrimaryBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.commonBorderRadius),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 45)),
                onPressed: () => context.goNamed(Routes.createSpace),
                child:
                    Text(AppLocalizations.of(context).create_new_space_title),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  const Divider(),
                  Container(
                      color: AppColors.whiteColor,
                      margin: const EdgeInsets.symmetric(vertical: primarySpacing),
                      padding: const EdgeInsets.symmetric(horizontal: primarySpacing),
                      child: Text(
                        AppLocalizations.of(context).or_tag,
                        style: AppFontStyle.bodyLarge
                            .copyWith(color: AppColors.secondaryText),
                      ))
                ],
              ),
              Text(
                  AppLocalizations.of(context).spaces_list_title(
                      context.read<JoinSpaceBloc>().userEmail),
                  style: AppFontStyle.bodyLarge),
              const SizedBox(height: 10),
              BlocBuilder<JoinSpaceBloc, JoinSpaceState>(
                builder: (context, state) =>
                    state.fetchSpaceStatus == Status.loading
                        ? const AppCircularProgressIndicator()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: state.spaces
                                .map((space) => WorkSpaceCard(
                                      title: space.name,
                                      members: 24,
                                      imageURL: space.logo,
                                      onPressed: () => context.read<JoinSpaceBloc>().add(SelectSpaceEvent(space: space)),
                                    ))
                                .toList(),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
