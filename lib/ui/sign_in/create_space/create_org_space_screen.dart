import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/colors.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/sign_in/create_space/bloc/create_space_event.dart';
import 'package:projectunity/ui/sign_in/create_space/bloc/create_space_state.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/employee_details_textfield.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'bloc/create_space_bloc.dart';

class CreateSpacePage extends StatelessWidget {
  const CreateSpacePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateSpaceBloc>(),
      child: const CreateOrgScreen(),
    );
  }
}

class CreateOrgScreen extends StatefulWidget {
  const CreateOrgScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrgScreen> createState() => _CreateOrgScreenState();
}

class _CreateOrgScreenState extends State<CreateOrgScreen> {
  final TextEditingController _orgNameController = TextEditingController();
  final TextEditingController _orgDescriptionController =
      TextEditingController();
  final TextEditingController _orgDomainController = TextEditingController();

  @override
  void dispose() {
    _orgNameController.dispose();
    _orgDescriptionController.dispose();
    _orgDomainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<CreateSpaceBloc, CreateSpaceStates>(
          listener: (context, state) {
            if (state is CreateSpaceFailureState) {
              showSnackBar(context: context, error: state.error);
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0).copyWith(bottom: 85, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).create_new_space_tag,
                  style: AppFontStyle.titleDark,
                ),
                const SizedBox(height: 20),
                _OrgLogoView(imageURl: null, onButtonTap: () {}),
                const SizedBox(height: 30),
                FieldEntry(
                  controller: _orgNameController,
                  hintText: AppLocalizations.of(context).company_name_tag,
                ),
                const SizedBox(height: 20),
                FieldEntry(
                  maxLine: 2,
                  controller: _orgDescriptionController,
                  hintText: AppLocalizations.of(context)
                      .create_space_short_description_label,
                ),
                const SizedBox(height: 20),
                FieldEntry(
                  controller: _orgDomainController,
                  hintText: AppLocalizations.of(context)
                      .create_space_Website_url_label,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)
                            .create_space_add_member_title,
                        style: AppFontStyle.bodyLarge,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(AppLocalizations.of(context)
                            .add_member_button_tag)),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context).create_space_screen_description,
                  style: AppFontStyle.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 2,
              fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
              padding: const EdgeInsets.only(left: 20, right: 10)),
          onPressed: () {
            context.read<CreateSpaceBloc>().add(const CreateSpaceEvent());
          },
          child: BlocBuilder<CreateSpaceBloc, CreateSpaceStates>(
              builder: (context, state) => state is CreateSpaceLoadingState
                  ? const AppCircularProgressIndicator(
                      color: AppColors.whiteColor,
                      size: 25,
                    )
                  : Text(
                      AppLocalizations.of(context).create_new_space_tag)),
        ));
  }
}

class _OrgLogoView extends StatelessWidget {
  final void Function()? onButtonTap;

  final String? imageURl;

  const _OrgLogoView({Key? key, this.onButtonTap, this.imageURl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: const Alignment(1.5, 1.5),
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.textFieldBg, width: 3),
                color: AppColors.textFieldBg,
                borderRadius: AppTheme.commonBorderRadius,
                image: imageURl == null
                    ? null
                    : DecorationImage(
                        image: NetworkImage(imageURl!),
                        fit: BoxFit.cover,
                      )),
            child: imageURl != null
                ? null
                : const Icon(Icons.business,
                    color: AppColors.secondaryText, size: 45),
          ),
          IconButton(
            style: IconButton.styleFrom(
                fixedSize: const Size(45, 45),
                side: const BorderSide(color: AppColors.textFieldBg, width: 3),
                backgroundColor: AppColors.whiteColor),
            onPressed: onButtonTap,
            icon: const Icon(
              Icons.edit,
              size: 20,
              color: AppColors.greyColor,
            ),
          )
        ],
      ),
    );
  }
}
