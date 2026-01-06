import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/other/app_button.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/sign_in_view_bloc.dart';
import '../bloc/sign_in_view_event.dart';
import '../bloc/sign_in_view_state.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.googleSignInLoading != current.googleSignInLoading,
      builder: (context, state) {
        return AppButton(
          backgroundColor: Colors.white,
          onTap: () => context.read<SignInBloc>().add(GoogleSignInEvent()),
          loading: state.googleSignInLoading,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.images.googleLogo),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  context.l10n.google_login_button_text,
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
