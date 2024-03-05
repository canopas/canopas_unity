import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/other/app_button.dart';
import '../../../data/core/utils/const/image_constant.dart';
import '../bloc/sign_in_view_bloc.dart';
import '../bloc/sign_in_view_event.dart';
import '../bloc/sign_in_view_state.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (previous, current) =>
            previous is SignInLoadingState || current is SignInLoadingState,
        builder: (context, state) {
          return AppButton(
            onTap: () => context.read<SignInBloc>().add(SignInEvent()),
            loading: state is SignInLoadingState,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorScheme.surface),
                    child: const Image(
                        image: AssetImage(ImageConst.googleLogoImage),
                        fit: BoxFit.contain,
                        width: 35,
                        height: 35)),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    context.l10n.login_button_text,
                    style: AppTextStyle.style18
                        .copyWith(color: context.colorScheme.surface),
                    overflow: TextOverflow.clip,
                  ),
                ),
                const SizedBox(width: 35),
              ],
            ),
          );
        });
  }
}
