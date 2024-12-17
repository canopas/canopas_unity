import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/app_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/other/smart_scroll_view.dart';
import 'package:projectunity/ui/sign_in/widget/apple_signin_button.dart';
import 'package:projectunity/ui/sign_in/widget/google_signin_button.dart';
import '../../data/core/utils/const/image_constant.dart';
import '../../data/di/service_locator.dart';
import '../widget/error_snack_bar.dart';
import 'bloc/sign_in_view_bloc.dart';
import 'bloc/sign_in_view_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>(),
      child: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      backGroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    context.colorScheme.surface,
                    context.colorScheme.primary.withValues(alpha: 0.5)
                  ],
                      stops: const [
                    0.5,
                    1
                  ])),
            ),
            BlocListener<SignInBloc, SignInState>(
                listenWhen: (previous, current) => current.error != null,
                listener: (context, state) {
                  if (state.error != null) {
                    if (state.firebaseAuthUser != null) {
                      context.goNamed(Routes.setupProfile,
                          extra: state.firebaseAuthUser);
                    } else {
                      showSnackBar(context: context, error: state.error);
                    }
                  }
                },
                child: SafeArea(
                  child: SmartScrollView(
                    padding: const EdgeInsets.all(16).copyWith(bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageConst.loginPageVectorImage,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                context.l10n.sign_in_title_text,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.style24.copyWith(
                                  color: context.colorScheme.textPrimary,
                                  overflow: TextOverflow.fade,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 20, bottom: 40),
                                child: Text(
                                  context.l10n.sign_in_description_text,
                                  style: AppTextStyle.style16.copyWith(
                                      color: context.colorScheme.textSecondary),
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const GoogleSignInButton(),
                        const SizedBox(
                          height: 20,
                        ),
                        if (!kIsWeb && Platform.isIOS) const AppleSignInButton()
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
