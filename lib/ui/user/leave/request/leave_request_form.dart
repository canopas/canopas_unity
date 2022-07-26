import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/ui/user/leave/request/widget/bottom_button_bar.dart';
import 'package:projectunity/ui/user/leave/request/widget/leave_type_card.dart';
import 'package:provider/provider.dart';

import '../../../../configs/colors.dart';
import '../../../../core/utils/const/other_constant.dart';
import '../../../../di/service_locator.dart';
import '../../../../navigation/navigation_stack_manager.dart';
import '../../../../stateManager/user/leave_request_data_manager.dart';
import '../../../user/leave/request/widget/datetimecard/end_leave_card.dart';
import '../../../user/leave/request/widget/datetimecard/start_leave_card.dart';
import '../../../user/leave/request/widget/reason_card.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _stateManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveRequestDataManager(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              _stateManager.pop();
              _stateManager.setBottomBar(true);
            },
          ),
          centerTitle: true,
          title: const Text('Leave Request'),
          titleTextStyle: const TextStyle(
              fontSize: headerTextSize, fontWeight: FontWeight.w600),
          backgroundColor: AppColors.primaryBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: primaryHorizontalSpacing, vertical: 15),
          child: Stack(children: [
            SizedBox(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LeaveTypeCard(),
                      const StartLeaveCard(),
                      const EndLeaveCard(),
                      ReasonCard(),
                      //  const SupervisorCard(),
                      Container(height: 50)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: BottomButtonBar())),
          ]),
        ),
      ),
    );
  }
}
