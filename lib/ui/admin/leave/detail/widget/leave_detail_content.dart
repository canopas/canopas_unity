import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';

class LeaveDetailContent extends StatelessWidget {
  const LeaveDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldColumn(title: 'Total Days', value: '2 days'),
            _buildDivider(),
            _buildFieldColumn(
                title: 'Duration', value: 'Nov 19 - Nov 22, 2022'),
            _buildDivider(),
            _buildFieldColumn(
              title: 'Reason',
              value:
                  'Hey! need urgent vacation due to medical emergency in family so kindly consider it',
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
