import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/provider/user_data.dart';
import '../../../bloc/admin/leave_count/all_leave_count.dart';
import '../../../bloc/user/setting_view_bloc.dart';
import '../../../di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import '../../../navigation/navigation_stack_manager.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({Key? key}) : super(key: key);

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _adminLeaveCount = getIt<AdminLeaveCount>();
  final _userManager = getIt<UserManager>();

  @override
  void initState() {
    _adminLeaveCount.fetchTotalLeaveCounts();
    super.initState();
  }

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
         settingSubTitle(subtitle: _localizations.settings_setting_text),
          SettingOption(
            icon: Icons.edit_note,
            title: _localizations.admin_total_leave_count_text,
            onTap: () {
              _stateManager.push(
                  const AdminNavigationStackItem.updateLeaveCountsState());
            },
          ),
          SettingOption(
            icon: Icons.logout_rounded,
            title: _localizations.logout_button_text,
            onTap: () async {
              getIt<SettingViewBLoc>().singOut();
            },
            iconColor: AppColors.redColor,
            titleColor: AppColors.redColor,
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

class SettingOption extends StatelessWidget {
  SettingOption({required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.blackColor,
    this.titleColor = AppColors.blackColor,
    Key? key})
      : super(key: key);
  Color titleColor;
  Color iconColor;
  IconData icon;
  String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: Icon(
        icon,
        size: 32,
        color: iconColor,
      ),
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: titleColor),
      ),
    );
  }
}
