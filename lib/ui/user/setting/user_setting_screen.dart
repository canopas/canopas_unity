import 'package:flutter/material.dart';
import 'package:projectunity/bloc/admin/leave_count/all_leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import '../../../bloc/user/setting_view_bloc.dart';
import '../../../di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class EmployeeSettingScreen extends StatefulWidget {
  const EmployeeSettingScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeSettingScreen> createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {

  final _userManager = getIt<UserManager>();
  final _adminLeaveCount = getIt<AdminLeaveCount>();
  final TextEditingController _allLeaveCount = TextEditingController();


  @override
  void initState() {
    _allLeaveCount.text = _adminLeaveCount.totalLeaveCount.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
          ),
    ));
  }
  
}

