import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/login/widget/sign_in_button.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';
import 'bloc/login_view_bloc.dart';
import '../../core/utils/const/image_constant.dart';
import 'bloc/login_view_event.dart';
import 'bloc/login_view_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<LoginBloc>(),
      child: const LoginView(),
    );
  }
}


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<LoginBloc,LoginState>(
        listener: (context, state) {
          if(state is LoginFailureState){
            showSnackBar(context: context,error: state.error);
          }
        },
        child: Container(
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
                          BlocBuilder<LoginBloc,LoginState>(
                              builder: (context, state) =>
                                state is LoginLoadingState?const kCircularProgressIndicator()
                                :SignInButton(onPressed: (){
                                  context.read<LoginBloc>().add(SignInEvent());
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
