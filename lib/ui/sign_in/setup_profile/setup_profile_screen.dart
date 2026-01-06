import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:projectunity/ui/sign_in/setup_profile/bloc/setup_profile_state.dart';

import '../../../app_router.dart';
import '../../../data/di/service_locator.dart';
import '../../../style/other/app_button.dart';
import '../../widget/employee_details_textfield.dart';
import '../../widget/error_snack_bar.dart';
import 'bloc/setup_profile_bloc.dart';
import 'bloc/setup_profile_event.dart';

class SetUpProfilePage extends StatelessWidget {
  final firebase_auth.User user;
  const SetUpProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SetupProfileBloc>(),
      child: SetupProfileScreen(user: user),
    );
  }
}

class SetupProfileScreen extends StatefulWidget {
  final firebase_auth.User user;
  const SetupProfileScreen({super.key, required this.user});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.displayName);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      title: context.l10n.setup_profile_title,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        color: context.colorScheme.textPrimary,
        onPressed: () {
          context.goNamed(Routes.login);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: primaryHorizontalSpacing,
          ),
          child: BlocListener<SetupProfileBloc, SetupProfileState>(
            listener: (BuildContext context, SetupProfileState state) {
              if (state.error != null) {
                showSnackBar(context: context, error: state.error);
                context.goNamed(Routes.login);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldTitle(title: context.l10n.employee_name_tag),
                BlocBuilder<SetupProfileBloc, SetupProfileState>(
                  builder: (context, state) {
                    return FieldEntry(
                      textInputAction: TextInputAction.next,
                      controller: nameController,
                      hintText: context.l10n.employee_name_tag,
                      onChanged: (value) => context
                          .read<SetupProfileBloc>()
                          .add(NameChangedEvent(name: value)),
                      errorText: state.nameError
                          ? context.l10n.admin_home_add_member_error_name
                          : null,
                    );
                  },
                ),
                FieldTitle(title: context.l10n.employee_email_tag),
                BlocBuilder<SetupProfileBloc, SetupProfileState>(
                  builder: (context, state) {
                    return FieldEntry(
                      textInputAction: TextInputAction.done,
                      controller: emailController,
                      hintText: context.l10n.employee_email_tag,
                      onChanged: (value) => context
                          .read<SetupProfileBloc>()
                          .add(EmailChangedEvent(email: value)),
                      errorText: state.emailError
                          ? context.l10n.admin_home_add_member_error_email
                          : null,
                    );
                  },
                ),
                const Spacer(),
                BlocBuilder<SetupProfileBloc, SetupProfileState>(
                  builder: (context, state) {
                    return AppButton(
                      backgroundColor: state.buttonEnabled
                          ? context.colorScheme.primary
                          : context.colorScheme.primary.withValues(alpha: 0.5),
                      loading: state.isSubmitting,
                      tag: context.l10n.submit_button_tag,
                      onTap: () => context.read<SetupProfileBloc>().add(
                        SubmitProfileEvent(uid: widget.user.uid),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
