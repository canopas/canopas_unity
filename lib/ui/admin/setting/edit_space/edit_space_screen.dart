import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/theme.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/di/service_locator.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/employee_details_textfield.dart';
import '../../../widget/error_snack_bar.dart';
import '../../../widget/pick_image_bottom_sheet.dart';
import 'bloc/edit_space_bloc.dart';
import 'bloc/edit_space_event.dart';
import 'bloc/edit_space_state.dart';
import 'dart:io';

class EditSpacePage extends StatelessWidget {
  const EditSpacePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditSpaceBloc>()..add(EditSpaceInitialEvent()),
      child: const EditSpaceScreen(),
    );
  }
}

class EditSpaceScreen extends StatefulWidget {
  const EditSpaceScreen({Key? key}) : super(key: key);

  @override
  State<EditSpaceScreen> createState() => _EditSpaceScreenState();
}

class _EditSpaceScreenState extends State<EditSpaceScreen> {
  final UserManager _userManager = getIt<UserManager>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _paidTimeOffLeaveController =
      TextEditingController();

  @override
  void initState() {
    _nameController.text = _userManager.currentSpace?.name ?? "";
    _domainController.text = _userManager.currentSpace?.domain ?? "";
    _paidTimeOffLeaveController.text =
        _userManager.currentSpace?.paidTimeOff.toString() ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _domainController.dispose();
    _paidTimeOffLeaveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).space_tag),
        actions: [
          BlocBuilder<EditSpaceBloc, EditSpaceState>(
              buildWhen: (previous, current) =>
                  previous.updateSpaceStatus != current.updateSpaceStatus ||
                  previous.isDataValid != current.isDataValid,
              builder: (context, state) => state.updateSpaceStatus ==
                      Status.loading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: AppCircularProgressIndicator(size: 20),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                          onPressed: state.isDataValid
                              ? () {
                                  context.read<EditSpaceBloc>().add(
                                      SaveSpaceDetails(
                                          paidTimeOff:
                                              _paidTimeOffLeaveController.text,
                                          spaceName: _nameController.text,
                                          spaceDomain: _domainController.text));
                                }
                              : null,
                          child: Text(AppLocalizations.of(context).save_tag)),
                    )),
        ],
      ),
      body: BlocListener<EditSpaceBloc, EditSpaceState>(
        listenWhen: (previous, current) =>
            previous.updateSpaceStatus != current.updateSpaceStatus ||
            current.isFailure,
        listener: (context, state) {
          if (state.isFailure) {
            showSnackBar(context: context, error: state.error);
          } else if (state.updateSpaceStatus == Status.success) {
            context.pop();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<EditSpaceBloc, EditSpaceState>(
                listenWhen: (previous, current) => current.isLogoPickedDone,
                listener: (context, state) {
                  if (state.isLogoPickedDone) {
                    context.pop();
                  }
                },
                buildWhen: (previous, current) => previous.logo != current.logo,
                builder: (context, state) => _OrgLogoView(
                    imageURL: _userManager.currentSpace?.logo,
                    pickedLogo: state.logo,
                    onButtonTap: () => showBottomSheet(
                        context: context,
                        builder: (_) => PickImageBottomSheet(
                            onButtonTap: (ImageSource source) => context
                                .read<EditSpaceBloc>()
                                .add(PickImageEvent(imageSource: source))))),
              ),
              const SizedBox(height: 30),
              FieldEntry(
                onChanged: (name) => context
                    .read<EditSpaceBloc>()
                    .add(CompanyNameChangeEvent(companyName: name)),
                controller: _nameController,
                hintText: AppLocalizations.of(context).company_name_tag,
              ),
              const SizedBox(height: 20),
              FieldEntry(
                controller: _domainController,
                hintText:
                    AppLocalizations.of(context).create_space_Website_url_label,
              ),
              const SizedBox(height: 20),
              FieldEntry(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (timeOff) => context
                    .read<EditSpaceBloc>()
                    .add(YearlyPaidTimeOffChangeEvent(timeOff: timeOff)),
                controller: _paidTimeOffLeaveController,
                hintText: AppLocalizations.of(context).yearly_paid_time_off_tag,
              ),
              const DeleteSpaceButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteSpaceButton extends StatelessWidget {
  const DeleteSpaceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 600,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      child: BlocBuilder<EditSpaceBloc, EditSpaceState>(
        buildWhen: (previous, current) =>
            previous.deleteWorkSpaceStatus != current.deleteWorkSpaceStatus,
        builder: (context, state) =>
            state.deleteWorkSpaceStatus == Status.loading
                ? const AppCircularProgressIndicator()
                : TextButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.redColor,
                    ),
                    child: Text(AppLocalizations.of(context).delete_space_text),
                    onPressed: () => showAlertDialog(
                      title: AppLocalizations.of(context).delete_space_text,
                      context: context,
                      actionButtonTitle:
                          AppLocalizations.of(context).delete_space_text,
                      description: AppLocalizations.of(context)
                          .delete_dialog_description_text,
                      onActionButtonPressed: () {
                        context.read<EditSpaceBloc>().add(DeleteSpaceEvent());
                      },
                    ),
                  ),
      ),
    );
  }
}

class _OrgLogoView extends StatelessWidget {
  final void Function()? onButtonTap;
  final String? pickedLogo;
  final String? imageURL;

  const _OrgLogoView(
      {Key? key, this.onButtonTap, this.pickedLogo, required this.imageURL})
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
              image: pickedLogo.isNotNullOrEmpty || imageURL.isNotNullOrEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: pickedLogo.isNotNullOrEmpty
                          ? FileImage(File(pickedLogo!))
                          : CachedNetworkImageProvider(imageURL!)
                              as ImageProvider)
                  : null,
            ),
            child: ValidateWidget(
              isValid:
                  !pickedLogo.isNotNullOrEmpty && !imageURL.isNotNullOrEmpty,
              child: const Icon(Icons.business,
                  color: AppColors.secondaryText, size: 45),
            ),
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
