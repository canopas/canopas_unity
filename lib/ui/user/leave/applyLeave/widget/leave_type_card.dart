import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/colors.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../stateManager/user/leave_request_data_manager.dart';

class LeaveTypeCard extends StatelessWidget {
  const LeaveTypeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LeaveRequestDataManager _leaveService =
        Provider.of<LeaveRequestDataManager>(context);
    int? leaveType = _leaveService.leaveType;
    var _localization = AppLocalizations.of(context);
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  _localization.leave_type_tag,
                  style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: subTitleTextSize),
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
                  hint: Text(
                    AppLocalizations.of(context).user_apply_leave_select_tag,
                    style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: subTitleTextSize),
                  ),
                  items: leaveTypeMap
                      .map((key, value) {
                        return MapEntry(
                            key,
                            DropdownMenuItem<int>(
                              value: key,
                              child: Text(_localization
                                  .leave_type_placeholder_leave_status(key)),
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
                    _leaveService.setLeaveType(leaveType ?? -1);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
