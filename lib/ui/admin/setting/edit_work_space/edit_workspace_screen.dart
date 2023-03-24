import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_bloc.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_event.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/theme.dart';
import '../../../../data/di/service_locator.dart';
import '../../../widget/employee_details_textfield.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/edit_workspace_state.dart';

class EditWorkspacePage extends StatelessWidget {
  const EditWorkspacePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<EditWorkSpaceBloc>()..add(EditWorkSpaceInitialEvent()),
      child: const EditWorkSpaceScreen(),
    );
  }
}

class EditWorkSpaceScreen extends StatefulWidget {
  const EditWorkSpaceScreen({Key? key}) : super(key: key);

  @override
  State<EditWorkSpaceScreen> createState() => _EditWorkSpaceScreenState();
}

class _EditWorkSpaceScreenState extends State<EditWorkSpaceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _paidTimeOffLeaveController =
      TextEditingController();

  @override
  void initState() {
    ///TODO: add initial data for edit workspace
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
        title: Text(AppLocalizations.of(context).workspace_tag),
        actions: [
          BlocBuilder<EditWorkSpaceBloc, EditWorkspaceState>(
              builder: (context, state) => TextButton(
                  onPressed: state.isValid ? () {} : null,
                  child: Text(AppLocalizations.of(context).save_tag))),
          const SizedBox(width: 10)
        ],
      ),
      body: BlocListener<EditWorkSpaceBloc, EditWorkspaceState>(
        listener: (context, state) {
          if (state.status == EditWorkspaceStatus.failure) {
            showSnackBar(context: context, error: state.error);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0).copyWith(
            bottom: 85,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OrgLogoView(imageURl: null, onButtonTap: () {}),
              const SizedBox(height: 30),
              FieldEntry(
                onChanged: (name) => context
                    .read<EditWorkSpaceBloc>()
                    .add(CompanyNameChangeEvent(companyName: name)),
                controller: _nameController,
                hintText: AppLocalizations.of(context).company_name_tag,
              ),
              const SizedBox(height: 20),
              FieldEntry(
                controller: _domainController,
                hintText: AppLocalizations.of(context)
                    .create_workspace_Website_url_label,
              ),
              const SizedBox(height: 20),
              FieldEntry(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (timeOff) => context
                    .read<EditWorkSpaceBloc>()
                    .add(YearlyPaidTimeOffChangeEvent(timeOff: timeOff)),
                controller: _paidTimeOffLeaveController,
                hintText: AppLocalizations.of(context).yearly_paid_time_off_tag,
              ),
            ],
          ),
        ),
      ),
    );
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
