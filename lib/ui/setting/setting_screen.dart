import 'package:flutter/material.dart';
import '../../bloc/user/setting_view_bloc.dart';
import '../../di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: ()async {
                   getIt<SettingViewBLoc>().singOut();
                },
                child:  Text(AppLocalizations.of(context).logout_button_text),
              ),
            ],
          ),
    ));
  }
}
