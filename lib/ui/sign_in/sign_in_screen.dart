import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/sign_in/widget/sign_in_button.dart';
import '../../data/core/utils/const/image_constant.dart';
import '../../data/di/service_locator.dart';
import '../widget/error_snack_bar.dart';
import 'bloc/sign_in_view_bloc.dart';
import 'bloc/sign_in_view_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>(),
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
    return AppPage(
      backGroundColor: context.colorScheme.surface,

      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInFailureState) {
            showSnackBar(context: context, error: state.error);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 400),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(20).copyWith(bottom: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 20),
                      Flexible(
                        child: Image.asset(ImageConst.loginPageVectorImage,
                            width: MediaQuery.of(context).size.width * 0.8),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              context.l10n.sign_in_title_text,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.style24.copyWith(
                                color: context.colorScheme.textPrimary,
                                overflow: TextOverflow.fade,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 20, bottom: 40),
                              child: Text(
                                context.l10n.sign_in_description_text,
                                style: AppTextStyle.style16.copyWith(
                                    color: context.colorScheme.textPrimary),
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SignInButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
