import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:provider/provider.dart';

import '../../../../../model/leave/leave_request_data.dart';
import '../../../../../stateManager/apply_leave_state_provider.dart';

class LeaveTypeCard extends StatelessWidget {
  const LeaveTypeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplyLeaveStateProvider _leaveService =
        Provider.of<ApplyLeaveStateProvider>(context);
    int? leaveType = _leaveService.leaveType;
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Leave Type',
                  style:
                      TextStyle(color: Colors.grey, fontSize: subTitleTextSize),
                ),
              ),
            ),
            Expanded(
              child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                      errorStyle: TextStyle(height: 0, fontSize: 0),
                      border: InputBorder.none,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  hint: const Text(
                    'Select',
                    style: TextStyle(
                        color: Colors.grey, fontSize: subTitleTextSize),
                  ),
                  items: leaveTypeMap
                      .map((key, value) {
                        return MapEntry(
                            key,
                            DropdownMenuItem<int>(
                              value: key,
                              child: Text(value),
                            ));
                      })
                      .values
                      .toList(),
                  value: leaveType,
                  validator: (int? value) {
                    return value == null ? '' : null;
                  },
                  onChanged: (int? value) {
                    leaveType = value;
                    _leaveService.setLeaveType(leaveType);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
