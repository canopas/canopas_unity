import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/login/widget/sign_in_button.dart';
import '../../data/configs/colors.dart';
import '../../data/core/utils/const/image_constant.dart';
import '../widget/circular_progress_indicator.dart';
import '../widget/error_snack_bar.dart';
import 'bloc/login_view_bloc.dart';
import 'bloc/login_view_event.dart';
import 'bloc/login_view_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailureState) {
            showSnackBar(context: context, error: state.error);
          }
        },
        child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConst.loginPageBackgroundImage),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(primaryHorizontalSpacing),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(primaryHorizontalSpacing),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context).login_welcome_text,
                                style: AppFontStyle.appTitleText.copyWith(
                                    height: 2, fontStyle: FontStyle.italic),
                              ),
                              Text(
                                AppLocalizations.of(context).login_toUnity_text,
                                style: AppFontStyle.appTitleText
                                    .copyWith(height: 1, letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                        const _BuildImage(),
                        Column(children: [
                          Center(
                            child: Text(
                                AppLocalizations.of(context)
                                    .login_guide_description,
                                style: AppFontStyle.bodySmallRegular),
                          ),
                          const SizedBox(height: primaryHorizontalSpacing),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) =>
                                state is LoginLoadingState
                                    ? const AppCircularProgressIndicator()
                                    : SignInButton(onPressed: () {
                                        context
                                            .read<LoginBloc>()
                                            .add(SignInEvent());
                                      }),
                          ),
                        ]),
                      ]),
                ),
              ),
            )),
      ),
    );
  }
}

class _BuildImage extends StatelessWidget {
  const _BuildImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConst.loginPageVectorImage,
            ),
          ),
        ));
  }
}
