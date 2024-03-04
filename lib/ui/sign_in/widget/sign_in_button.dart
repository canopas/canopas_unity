import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/colors.dart';
import 'package:projectunity/style/other/app_button.dart';
import '../../../data/configs/colors.dart';
import '../../../data/core/utils/const/image_constant.dart';
import '../bloc/sign_in_view_bloc.dart';
import '../bloc/sign_in_view_event.dart';
import '../bloc/sign_in_view_state.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (previous, current) =>
        previous is SignInLoadingState ||
            current is SignInLoadingState,
      builder: (context,state) {
        return AppButton(
          onTap:()=> context.read<SignInBloc>().add(SignInEvent()),
          loading: state is SignInLoadingState,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.whiteColor),
                  child: const Image(
                      image: AssetImage(ImageConst.googleLogoImage),
                      fit: BoxFit.contain,
                      width: 35,
                      height: 35)),
              Flexible(
                child: Text(
                  context.l10n
                      .login_button_text,
                  style: AppFontStyle.bodyLarge
                      .copyWith(color: surfaceColor),
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(width: 35),
            ],
          ),
        );
      }
    );
  }
}
