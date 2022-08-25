import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/model/leave/leave.dart';
import '../../../../../configs/colors.dart';

class LeaveTitleRow extends StatelessWidget {
  Leave leave;

  LeaveTitleRow({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeaveTypeHeader(
              leaveType: _localization
                  .leave_type_placeholder_leave_status(leave.leaveStatus)),
          Row(
            children: [
              (const Icon(
                Icons.access_time,
                color: AppColors.secondaryText,
                size: 20,
              )),
              const SizedBox(
                width: 5,
              ),

              //TODO: Pass actual application date of leave request from leave data instead of Datetime.now()
              _buildApplyDate(
                  date: AppLocalizations.of(context)
                      .date_format_yMMMd(DateTime.now()))
            ],
          )
        ],
      ),
    );
  }

  Text _buildApplyDate({required String date}) {
    return Text(
      date,
      style: AppTextStyle.secondaryBodyText,
    );
  }

  Text _buildLeaveTypeHeader({required String leaveType}) {
    return Text(leaveType,
        style: AppTextStyle.headerTextNormal);
  }
}
