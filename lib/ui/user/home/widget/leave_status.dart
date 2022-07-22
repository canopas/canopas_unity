import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../configs/colors.dart';

class LeaveStatus extends StatelessWidget {
  const LeaveStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Card(
          color: AppColors.primaryDarkYellow,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LeaveInfo(
                    title: 'Available',
                    value: '7',
                  ),
                  Container(
                    width: 1,
                    color: Colors.grey,
                  ),
                  const LeaveInfo(title: 'All', value: '26'),
                  Container(
                    width: 1,
                    color: AppColors.secondaryText,
                  ),
                  const LeaveInfo(title: 'Used', value: '19'),
                ],
              ),
            ),
          )),
    );
  }
}

class LeaveInfo extends StatelessWidget {
  final String title;
  final String value;

  const LeaveInfo({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.blueGrey, fontSize: bodyTextSize),
        ),
        const SizedBox(
          height: 7,
        ),
        Text('$value Days ',
            style: const TextStyle(
                color: AppColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
