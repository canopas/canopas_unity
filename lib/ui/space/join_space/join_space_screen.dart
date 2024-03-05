import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';
import 'package:projectunity/ui/space/join_space/widget/app_section.dart';
import 'package:projectunity/ui/space/join_space/widget/spaces.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../widget/app_dialog.dart';

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
    return AppPage(
      backGroundColor: context.colorScheme.surface,

      body: SafeArea(
        child: BlocListener<JoinSpaceBloc, JoinSpaceState>(
          listenWhen: (previous, current) =>
              current.fetchSpaceStatus == Status.error ||
              current.selectSpaceStatus == Status.error,
          listener: (context, state) {
            if (state.error != null) {
              showSnackBar(context: context, error: state.error);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(primaryHorizontalSpacing)
                .copyWith(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppSection(),
                const SizedBox(
                  height: 20,
                ),
                _divider(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                    context.l10n.spaces_list_title(
                        context.read<JoinSpaceBloc>().userEmail),
                    style: AppTextStyle.style18.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.textPrimary)),
                const SizedBox(height: 30),
                const Spaces(),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    showAppAlertDialog(
                        context: context,
                        title: context.l10n.sign_out_tag,
                        actionButtonTitle: context.l10n.sign_out_tag,
                        description: context.l10n.sign_out_alert,
                        onActionButtonPressed: () {
                          context.read<JoinSpaceBloc>().add(SignOutEvent());
                        });
                  },
                  style: TextButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                  child: Text(
                    context.l10n.sign_out_tag,
                    style: AppTextStyle.style16
                        .copyWith(color: context.colorScheme.rejectColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        color: context.colorScheme.outlineColor,
        indent: 15,
        endIndent: 15,
      )),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(context.l10n.or_tag,
              style: AppTextStyle.style14
                  .copyWith(color: context.colorScheme.outlineColor))),
      Expanded(
          child: Divider(
        color: context.colorScheme.outlineColor,
        indent: 15,
        endIndent: 15,
      )),
    ]);
  }
}
