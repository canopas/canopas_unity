import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/space/create_space/bloc/create_workspace_state.dart';
import 'package:projectunity/ui/space/create_space/widget/tab_1.dart';
import 'package:projectunity/ui/space/create_space/widget/tab_2.dart';
import 'package:projectunity/ui/space/create_space/widget/tab_3.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/di/service_locator.dart';
import 'bloc/create_workspace_bloc.dart';
import 'bloc/create_workspace_event.dart';

class CreateWorkSpacePage extends StatelessWidget {
  const CreateWorkSpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateSpaceBLoc>(),
      child: const CreateWorkSpaceScreen(),
    );
  }
}

class CreateWorkSpaceScreen extends StatefulWidget {
  const CreateWorkSpaceScreen({Key? key}) : super(key: key);

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
    final locale = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: AppColors.lightPrimaryBlue,
        appBar: AppBar(
          backgroundColor: AppColors.lightPrimaryBlue,
          title: Text(locale.create_new_space_title),
          bottom: TabBar(
            isScrollable: true,
            labelStyle: AppFontStyle.bodyMedium,
            padding: const EdgeInsets.all(10),
            controller: _tabController,
            indicatorColor: AppColors.primaryBlue,
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.greyColor,
            dividerColor: AppColors.lightPrimaryBlue,
            tabs: [
              Tab(text: locale.create_space_tab_1_tag),
              Tab(text: locale.create_space_tab_2_tag),
              Tab(text: locale.create_space_tab_3_tag)
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TabBarView(
              controller: _tabController,
              children: const [
                SpaceBasicDetails(),
                SetUpSpaceDetails(),
                PersonalInfo(),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
                buildWhen: (previous, current) =>
                    previous.buttonState != current.buttonState ||
                    previous.page != current.page,
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: state.buttonState == ButtonState.enable
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
                      child: state.page == 2
                          ? Text(locale.create_space_tag,
                              style: AppFontStyle.labelRegular)
                          : Text(
                              locale.next_tag,
                              style: AppFontStyle.labelRegular,
                            ));
                })));
  }
}
