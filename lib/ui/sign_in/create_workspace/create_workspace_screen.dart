import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/ui/sign_in/create_workspace/bloc/create_workspace_bloc.dart';
import 'package:projectunity/ui/sign_in/create_workspace/bloc/create_workspace_event.dart';
import 'package:projectunity/ui/sign_in/create_workspace/bloc/create_workspace_state.dart';
import 'package:projectunity/ui/sign_in/create_workspace/widget/step_1_screen.dart';
import 'package:projectunity/ui/sign_in/create_workspace/widget/step_2_screen.dart';

import '../../../data/di/service_locator.dart';

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

class _CreateWorkSpaceScreenState extends State<CreateWorkSpaceScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigatePreviousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _navigateToNextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).create_new_workspace_title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
            buildWhen: (previous, current) => previous.page != current.page,
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.page == 0
                    ? const SizedBox(height: 48)
                    : IconButton(
                        onPressed: _navigatePreviousPage,
                        icon: const Icon(Icons.arrow_back)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                      AppLocalizations.of(context).create_workspace_step_text(
                          (state.page + 1).toString()),
                      style: AppFontStyle.titleDark),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                      AppLocalizations.of(context)
                          .create_workspace_step_description(state.page),
                      style: AppFontStyle.labelGrey),
                ),
                //const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (page) => context
                  .read<CreateSpaceBLoc>()
                  .add(PageChangeEvent(page: page)),
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                WorkSpaceBasicDetails(onNextButtonPressed: _navigateToNextPage),
                WorkspacePaidLeaves(onNextButtonPressed: _navigateToNextPage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
