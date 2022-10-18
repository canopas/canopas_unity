import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/leave_map.dart';

class LeaveTypeCard extends StatelessWidget {
  Stream<int> stream;
  void Function(int?, int) onChange;

  LeaveTypeCard({Key? key, required this.stream, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 11,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(localization.leave_type_tag,
                  style: AppTextStyle.leaveRequestFormSubtitle),
            ),
          ),
          Expanded(
            flex: 12,
            child: StreamBuilder<int>(
                stream: stream,
                builder: (context, snapshot) {
                  int leaveType = snapshot.data ?? 0;
                  return DropdownButton<int>(
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    underline: Container(),
                    items: leaveTypeMap
                        .map((key, value) {
                          return MapEntry(
                              key,
                              DropdownMenuItem<int>(
                                value: key,
                                child: Text(localization
                                    .leave_type_placeholder_leave_status(key)),
                              ));
                        })
                        .values
                        .toList(),
                    value: leaveType,
                    onChanged: (int? value) {
                      onChange(value, leaveType);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
