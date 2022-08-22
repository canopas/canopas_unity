import 'package:flutter/material.dart';
import 'package:projectunity/provider/user_data.dart';
import '../../../bloc/user/setting_view_bloc.dart';
import '../../../configs/colors.dart';
import '../../../di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class EmployeeSettingScreen extends StatefulWidget {
  const EmployeeSettingScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeSettingScreen> createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {

  final _userManager = getIt<UserManager>();

  @override
  Widget build(BuildContext context) {
    final _localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor, elevation: 0, foregroundColor: AppColors.blackColor,
      ),
      backgroundColor: AppColors.whiteColor,
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(30),
        children: [
          Text(_localizations.settings_setting_text, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: AppColors.blackColor),),
          settingSubTitle(subtitle: _localizations.settings_account_text),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  (_userManager.userImage == null)
                      ? CircleAvatar(
                    backgroundColor: AppColors.primaryGray,
                    radius: MediaQuery
                        .of(context)
                        .size
                        .width * 0.09,
                    child: const Icon(Icons.person, size: 40, color: AppColors.blackColor),
                  )
                      : CircleAvatar(
                    backgroundImage: NetworkImage(_userManager.userImage!),
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_userManager.userName, style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Text(_userManager.employeeDesignation, style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),),

                    ],
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90,right: 90, top: 380),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: AppColors.redColor,
                  fixedSize:  Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
              onPressed: (){
                getIt<SettingViewBLoc>().singOut();
              },
              child: Text(_localizations.logout_button_text),
            ),
          ),
        ],
      ),
    );
  }

}


settingSubTitle({required String subtitle}){
  return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child:  Text(subtitle, style: const TextStyle(fontSize: 22, color: AppColors.greyColor, fontWeight:FontWeight.w600,))
  );
}
