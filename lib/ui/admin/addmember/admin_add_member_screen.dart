import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/admin/addmember/widget/add_member_form.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import '../../../configs/colors.dart';
import 'bloc/add_member_bloc.dart';
import 'bloc/add_member_event.dart';
import 'bloc/add_member_state.dart';

class AdminAddMemberPage extends StatelessWidget {
  const AdminAddMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<AddMemberBloc>(),
        child: const AdminAddMemberScreen());
  }
}

class AdminAddMemberScreen extends StatefulWidget {
  const AdminAddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddMemberScreen> createState() => _AdminAddMemberScreenState();
}

class _AdminAddMemberScreenState extends State<AdminAddMemberScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).admin_addMember_addMember_tag),
      ),
      body: AddMemberForm(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const AddMemberButton(),
    );
  }
}

class AddMemberButton extends StatelessWidget {
  const AddMemberButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0? Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: BlocConsumer<AddMemberBloc, AddMemberFormState>(
              builder: (context, state) {
                if (state.status == SubmitFormStatus.loading) {
                  return const AppCircularProgressIndicator();
                }
                  return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor:
                              context.watch<AddMemberBloc>().validForm
                                  ? AppColors.primaryBlue
                                  : AppColors.greyColor,
                        ),
                        onPressed: () {
                          context
                              .read<AddMemberBloc>()
                              .add(const SubmitEmployeeFormEvent());
                          final bool formSubmitted =
                              context.read<AddMemberBloc>().state.status ==
                                  SubmitFormStatus.done;
                          formSubmitted ? context.pop : null;
                        },
                        child: Text(
                            AppLocalizations.of(context)
                                .admin_addMember_button_submit,
                            style: AppTextStyle.subtitleText)));
              },
              listener: (context, state) {
                if (state.status == SubmitFormStatus.done) {
                  showSnackBar(
                      context: context,
                      msg: AppLocalizations.of(context)
                          .admin_add_member_successfully_added);
                  context.pop();
                }
                if (state.status == SubmitFormStatus.error) {
                  showSnackBar(context: context, error: state.msg);
                }
              },
            )):const SizedBox();
  }
}
