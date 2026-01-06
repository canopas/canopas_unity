import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import '../../../gen/assets.gen.dart';
import '../../../style/app_text_style.dart';
import '../../../style/other/app_button.dart';
import '../bloc/sign_in_view_bloc.dart';
import '../bloc/sign_in_view_event.dart';
import '../bloc/sign_in_view_state.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.appleSignInLoading != current.appleSignInLoading,
      builder: (context, state) {
        return AppButton(
          backgroundColor: Colors.white,
          onTap: () => context.read<SignInBloc>().add(AppleSignInEvent()),
          loading: state.appleSignInLoading,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.images.appleLogo,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  context.l10n.apple_login_button_text,
                  style: AppTextStyle.style18.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(width: 35),
            ],
          ),
        );
      },
    );
  }
}
