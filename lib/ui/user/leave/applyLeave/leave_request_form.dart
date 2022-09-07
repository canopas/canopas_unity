import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/bottom_button_bar.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/datetimecard/end_leave_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/datetimecard/leave_request_form_subtitle.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/datetimecard/start_leave_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/leave_type_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/reason_card.dart';
import 'package:provider/provider.dart';
import '../../../../configs/colors.dart';
import '../../../../core/utils/const/other_constant.dart';
import '../../../../di/service_locator.dart';
import '../../../../navigation/navigation_stack_manager.dart';
import '../../../../stateManager/user/leave_request_data_manager.dart';

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
    var _localization = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (_) => LeaveRequestDataManager(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_localization.leave_request_tag,),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
                horizontal: primaryHorizontalSpacing, vertical: 15),
            children: [
              const LeaveTypeCard(),
              LeaveRequestSubTitle(subtitle: _localization.user_apply_leave_from_tag),
              const StartLeaveCard(),
              LeaveRequestSubTitle(subtitle: _localization.user_apply_leave_to_tag),
              const EndLeaveCard(),
              ReasonCard(),
              //  const SupervisorCard(),
              Container(height: 50)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BottomButtonBar(),
      ),
    );
  }
}


