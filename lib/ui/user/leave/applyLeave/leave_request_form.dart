import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/exception/exception_msg.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/bottom_button.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/datetimecard/leave_request_form_subtitle.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/datetimecard/picker_card.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/datetimecard/show_picker.dart';
import 'package:projectunity/ui/user/leave/applyLeave/widget/leave_type_card.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../bloc/employee/leave/apply_leave_bloc.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/font_size.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/other_constant.dart';

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({Key? key}) : super(key: key);

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final TextEditingController _textEditingController = TextEditingController();

  final _applyLeaveBloc = getIt<ApplyLeaveBloc>();

  @override
  void initState() {
    _applyLeaveBloc.validLeave.listen((event) {
      event.whenOrNull(error: (error) {
        showSnackBar(context: context, error: error);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _applyLeaveBloc.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _localization.leave_request_tag,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        children: [
          LeaveTypeCard(
            stream: _applyLeaveBloc.leaveType,
            onChange: (int? value, int leaveType) {
              leaveType = value ?? 0;
              _applyLeaveBloc.updateLeaveTpe(leaveType);
            },
          ),
          LeaveRequestSubTitle(
              subtitle: _localization.user_apply_leave_from_tag),
          _buildStartLeaveCard(),
          LeaveRequestSubTitle(subtitle: _localization.user_apply_leave_to_tag),
          _buildEndLeaveCard(),
          _buildReasonCard(),
          Container(height: 50)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildButtonBar(),
    );
  }

  Widget _buildStartLeaveCard() {
    return Row(
      children: [
        DatePickerCard(
          stream: _applyLeaveBloc.startDate,
          onPress: () async {
            DateTime datetime = await _applyLeaveBloc.startDate.first;
            DateTime? date =
                await pickDate(context: context, initialDate: datetime);
            _applyLeaveBloc.updateStartLeaveDate(date);
          },
        ),
        TimePickerCard(
          onPress: () async {
            TimeOfDay timeOfDay = await _applyLeaveBloc.startLeaveTime.first;
            TimeOfDay? time =
                await pickTime(context: context, initialTime: timeOfDay);
            _applyLeaveBloc.updateStartTime(time);
          },
          stream: _applyLeaveBloc.startLeaveTime,
        )
      ],
    );
  }

  Widget _buildEndLeaveCard() {
    return Row(
      children: [
        DatePickerCard(
          stream: _applyLeaveBloc.endDate,
          onPress: () async {
            DateTime dateTime = await _applyLeaveBloc.endDate.first;
            DateTime? date =
                await pickDate(context: context, initialDate: dateTime);
            _applyLeaveBloc.updateEndLeaveDate(date);
          },
        ),
        TimePickerCard(
          stream: _applyLeaveBloc.endLeaveTime,
          onPress: () async {
            TimeOfDay timeOfDay = await _applyLeaveBloc.endLeaveTime.first;
            TimeOfDay? time =
                await pickTime(context: context, initialTime: timeOfDay);
            _applyLeaveBloc.updateEndTime(time);
          },
        ),
      ],
    );
  }

  Widget _buildReasonCard() {
    return Card(
        margin: const EdgeInsets.only(top: primaryHorizontalSpacing),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: StreamBuilder<String>(
              stream: _applyLeaveBloc.reason,
              builder: (context, snapshot) {
                return TextField(
                  controller: _textEditingController,
                  style: const TextStyle(
                      color: AppColors.darkText, fontSize: bodyTextSize),
                  cursorColor: AppColors.secondaryText,
                  maxLines: 5,
                  decoration: InputDecoration(
                    errorText: snapshot.hasError
                        ? snapshot.error.toString().errorMessage(context)
                        : null,
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context).leave_reason_tag,
                    hintStyle: AppTextStyle.leaveRequestFormSubtitle,
                  ),
                  onChanged: (String text) {
                    _applyLeaveBloc.sinkReason.add(text);
                  },
                  keyboardType: TextInputType.text,
                );
              }),
        ));
  }

  Widget _buildButtonBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColors.boxShadowColor,
          blurRadius: 5,
          spreadRadius: 3,
        ),
      ]),
      child: Row(
        children: [
          ResetButton(
            onPress: () async {
              _textEditingController.clear();
              _applyLeaveBloc.reset();
            },
          ),
          const SizedBox(
            width: 5,
          ),
          ApplyButton(
              stream: _applyLeaveBloc.validLeave,
              onPress: () => _applyLeaveBloc.validation())
        ],
      ),
    );
  }
}


