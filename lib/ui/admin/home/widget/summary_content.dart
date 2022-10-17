import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../configs/text_style.dart';

class EmployeeSummaryContent extends StatelessWidget {
  Stream<int> stream;
  IconData icon;
  Color color;
  String desc;
  Function()? onTap;

  EmployeeSummaryContent(
      {Key? key,
      required this.stream,
      required this.icon,
      required this.desc,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: stream,
        builder: (context, snapshot) {
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 26,
                      color: color,
                    ),
                    Text(desc, style: AppTextStyle.secondaryBodyText),
                    Text(snapshot.data.toString(),
                        style: AppTextStyle.headerTextBold),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
