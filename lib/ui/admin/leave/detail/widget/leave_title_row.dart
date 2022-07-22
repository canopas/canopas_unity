import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/leave_string_utils.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class LeaveTitleRow extends StatelessWidget {
  LeaveRequestData leave;

  LeaveTitleRow({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _leaveType = getLeaveStatus(leave.leaveType ?? 1, leaveTypeMap)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeaveTypeHeader(leaveType: _leaveType),
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
              _buildApplyDate(date: '8 july,2022')
            ],
          )
        ],
      ),
    );
  }

  Text _buildApplyDate({required String date}) {
    return Text(
      date,
      style: const TextStyle(
          color: AppColors.secondaryText, fontSize: bodyTextSize),
    );
  }

  Text _buildLeaveTypeHeader({required String leaveType}) {
    return Text(leaveType,
        style: const TextStyle(
            fontSize: headerTextSize,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText));
  }
}
