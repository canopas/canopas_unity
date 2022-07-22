import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/leave_string_utils.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../model/leave/leave_request_data.dart';

class LeaveDetailContent extends StatelessWidget {
  LeaveRequestData leave;

  LeaveDetailContent({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String totalDays = totalLeaves(leave.totalLeaves);
    String duration = dateInSingleLine(
        startTimeStamp: leave.startDate, endTimeStamp: leave.endDate);
    String reason = leave.reason;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldColumn(title: 'Total Days', value: totalDays),
            _buildDivider(),
            _buildFieldColumn(title: 'Duration', value: duration),
            _buildDivider(),
            _buildFieldColumn(
              title: 'Reason',
              value: reason,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldColumn({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title: title),
        const SizedBox(
          height: 5,
        ),
        _buildValue(value: value),
      ],
    );
  }

  Text _buildValue({required String value}) {
    return Text(
      value,
      style: const TextStyle(
        color: AppColors.darkText,
        fontSize: subTitleTextSize,
      ),
    );
  }

  Text _buildTitle({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.secondaryText,
        fontSize: bodyTextSize,
      ),
    );
  }

  Widget _buildDivider() {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        Divider(
          color: AppColors.lightGreyColor,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
