import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/login/widget/sign_in_button.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../bloc/authentication/login_bloc.dart';
import '../../core/utils/const/image_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = getIt<LoginBloc>();
  bool _showProgress = false;

  @override
  void initState() {
    _bloc.loginResponse.listen((value) {
      value.when(
          idle: () => {},
          loading: () => {
                setState(() {
                  _showProgress = true;
                })
              },
          completed: (b) => {
                setState(() {
                  _showProgress = false;
                })
              },
          error: (e) => {
                showSnackBar(context: context, error: e),
                _bloc.reset(),
                setState(() {
                  _showProgress = false;
                })
              });
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(loginPageBackgroundImage),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(primaryHorizontalSpacing),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(primaryHorizontalSpacing),
                        child: Column(
                          children: [
                            buildTitle(),
                            buildSubTitle(),
                          ],
                        ),
                      ),
                      buildImage(context),
                      Column(children: [
                        Center(
                          child: Text(
                              AppLocalizations.of(context)
                                  .login_guide_description,
                              style: AppTextStyle.secondaryBodyText),
                        ),
                        const SizedBox(
                          height: primaryHorizontalSpacing,
                        ),
                        _showProgress
                            ? const Center(child: CircularProgressIndicator())
                            : SignInButton(onPressed: _bloc.signIn),
                      ]),
                    ]),
              ),
            ),
          )),
    );
  }

  Container buildImage(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              loginPageVectorImage,
            ),
          ),
        ));
  }

  Text buildSubTitle() {
    return Text(
      AppLocalizations.of(context).login_toUnity_text,
      style: AppTextStyle.appTitleText.copyWith(height: 1, letterSpacing: 1),
    );
  }

  Text buildTitle() {
    return Text(
      AppLocalizations.of(context).login_welcome_text,
      style: AppTextStyle.appTitleText
          .copyWith(height: 2, fontStyle: FontStyle.italic),
    );
  }
}
