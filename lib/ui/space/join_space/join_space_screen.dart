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
import 'package:projectunity/ui/widget/space_card.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../data/configs/colors.dart';
import '../../../data/core/utils/bloc_status.dart';
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
    final locale = AppLocalizations.of(context);
    return Scaffold(
      body: BlocListener<JoinSpaceBloc, JoinSpaceState>(
        listenWhen: (previous, current) =>
            current.fetchSpaceStatus == Status.error ||
            current.selectSpaceStatus == Status.error,
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
                locale.welcome_to_unity_text,
                style: AppFontStyle.titleDark,
              ),
              const SizedBox(height: 20),
              Text(locale.create_own_space_title,
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
                child: Text(locale.create_new_space_title),
              ),
              Row(children: <Widget>[
                const Expanded(
                    child: Divider(
                  indent: 15,
                  endIndent: 15,
                )),
                Text(locale.or_tag, style: AppFontStyle.subTitleGrey),
                const Expanded(
                    child: Divider(
                  indent: 15,
                  endIndent: 15,
                )),
              ]),
              Text(
                  locale.spaces_list_title(
                      context.read<JoinSpaceBloc>().userEmail),
                  style: AppFontStyle.bodyLarge),
              const SizedBox(height: 10),
              BlocBuilder<JoinSpaceBloc, JoinSpaceState>(
                  builder: (context, state) {
                if (state.fetchSpaceStatus == Status.loading) {
                  return const AppCircularProgressIndicator();
                } else {
                  if (state.spaces.isEmpty) {
                    return Text(
                      locale.empty_space_list_msg,
                      style: AppFontStyle.subTitleGrey,
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: state.spaces
                        .map((space) => SpaceCard(
                              title: space.name,
                              domain: space.domain,
                              imageURL: space.logo,
                              onPressed: () => context
                                  .read<JoinSpaceBloc>()
                                  .add(SelectSpaceEvent(space: space)),
                            ))
                        .toList(),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
