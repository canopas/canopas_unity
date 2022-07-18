import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class LeaveTitleRow extends StatelessWidget {
  const LeaveTitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeaveTypeHeader(leaveType: 'Sick Leave'),
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
