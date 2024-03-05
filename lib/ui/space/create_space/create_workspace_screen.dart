import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/other/app_button.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_state.dart';
import 'package:projectunity/ui/space/create_space/widget/tab_1.dart';
import 'package:projectunity/ui/space/create_space/widget/tab_2.dart';
import 'package:projectunity/ui/space/create_space/widget/tab_3.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../../data/di/service_locator.dart';
import 'bloc/create_workspace_bloc.dart';
import 'bloc/create_workspace_event.dart';

class CreateWorkSpacePage extends StatelessWidget {
  const CreateWorkSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateSpaceBLoc>(),
      child: const CreateWorkSpaceScreen(),
    );
  }
}

class CreateWorkSpaceScreen extends StatefulWidget {
  const CreateWorkSpaceScreen({super.key});

  @override
  State<CreateWorkSpaceScreen> createState() => _CreateWorkSpaceScreenState();
}

class _CreateWorkSpaceScreenState extends State<CreateWorkSpaceScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      BlocProvider.of<CreateSpaceBLoc>(context)
          .add(PageChangeEvent(page: _tabController.index));
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CreateSpaceBLoc>(context);
    final locale = context.l10n;
    return AppPage(
        backGroundColor: context.colorScheme.surface,
        title: locale.create_new_space_title,
        body: Material(
          color: context.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  labelStyle: AppTextStyle.style16
                      .copyWith(color: context.colorScheme.textPrimary),
                  controller: _tabController,
                  indicatorColor: context.colorScheme.primary,
                  labelColor: context.colorScheme.primary,
                  tabs: [
                    Tab(text: locale.create_space_tab_1_tag),
                    Tab(text: locale.create_space_tab_2_tag),
                    Tab(text: locale.create_space_tab_3_tag)
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      SpaceBasicDetails(),
                      SetUpSpaceDetails(),
                      PersonalInfo(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
              buildWhen: (previous, current) =>
                  previous.buttonState != current.buttonState ||
                  previous.page != current.page ||
                  previous.createSpaceStatus != current.createSpaceStatus,
              builder: (context, state) {
                return AppButton(
                  loading: state.createSpaceStatus == Status.loading,
                  tag: state.page == 2
                      ? locale.create_space_tag
                      : locale.next_tag,
                  onTap: state.buttonState == ButtonState.enable
                      ? () {
                          if (state.page < 2) {
                            _tabController.animateTo(state.page + 1);
                            bloc.add(PageChangeEvent(page: state.page + 1));
                          }
                          if (state.page == 2) {
                            bloc.add(CreateSpaceButtonTapEvent());
                          }
                        }
                      : null,
                );
              }),
        ));
  }
}
