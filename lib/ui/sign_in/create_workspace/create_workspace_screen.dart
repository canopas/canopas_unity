import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/sign_in/create_workspace/bloc/create_workspace_bloc.dart';
import 'package:projectunity/ui/sign_in/create_workspace/bloc/create_workspace_event.dart';
import 'package:projectunity/ui/sign_in/create_workspace/bloc/create_workspace_state.dart';
import 'package:projectunity/ui/sign_in/create_workspace/widget/org_logo_view.dart';
import '../../../data/di/service_locator.dart';
import '../../widget/employee_details_textfield.dart';

class CreateWorkSpacePage extends StatelessWidget {
  const CreateWorkSpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateWorkSpaceBLoc>(),
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
          BlocBuilder<CreateWorkSpaceBLoc, CreateWorkSpaceState>(
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
                  .read<CreateWorkSpaceBLoc>()
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

class WorkspacePaidLeaves extends StatelessWidget {
  final void Function()? onNextButtonPressed;

  const WorkspacePaidLeaves({Key? key, this.onNextButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FieldEntry(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              hintText: AppLocalizations.of(context).yearly_paid_time_off_tag,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 45)),
                onPressed: onNextButtonPressed,
                child: Text(AppLocalizations.of(context)
                    .create_workspace_create_workspace_button_text)),
          ],
        ));
  }
}

class WorkSpaceBasicDetails extends StatelessWidget {
  final void Function()? onNextButtonPressed;

  const WorkSpaceBasicDetails({
    Key? key,
    this.onNextButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrgLogoView(imageURl: null, onButtonTap: () {}),
            const SizedBox(height: 32),
            FieldEntry(
              hintText: AppLocalizations.of(context).company_name_tag,
            ),
            const SizedBox(height: 20),
            FieldEntry(
              hintText: AppLocalizations.of(context)
                  .create_workspace_Website_url_label,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 45)),
                onPressed: onNextButtonPressed,
                child: Text(AppLocalizations.of(context).next_tag)),
          ],
        ));
  }
}
