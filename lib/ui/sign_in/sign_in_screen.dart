import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/sign_in/widget/sign_in_button.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/space_constant.dart';
import '../../data/configs/text_style.dart';
import '../../data/core/utils/const/image_constant.dart';
import '../../data/di/service_locator.dart';
import '../widget/circular_progress_indicator.dart';
import '../widget/error_snack_bar.dart';
import 'bloc/sign_in_view_bloc.dart';
import 'bloc/sign_in_view_event.dart';
import 'bloc/sign_in_view_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInScreenBloc>(),
      child: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<SignInScreenBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInScreenFailureState) {
            showSnackBar(context: context, error: state.error);
          }
          if (state is CreateSpaceSignInSuccessState) {}
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
                          BlocBuilder<SignInScreenBloc, SignInState>(
                            builder: (context, state) => state
                                    is SignInLoadingState
                                ? const AppCircularProgressIndicator()
                                : Column(
                                    children: [
                                      SignInButton(onPressed: () {
                                        context
                                            .read<SignInScreenBloc>()
                                            .add(SignInEvent());
                                      }),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<SignInScreenBloc>()
                                                .add(CreateSpaceSignInEvent());
                                          },
                                          child: const Text("Create Space"))
                                    ],
                                  ),
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
        height: MediaQuery.of(context).size.height / 2.1,
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
