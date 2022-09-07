import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import '../../../../../configs/text_style.dart';
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
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 11,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                _localization.leave_type_tag,
                style: AppTextStyle.leaveRequestFormSubtitle
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: DropdownButtonFormField<int>(
              icon: const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.arrow_drop_down,
                ),
              ),
              borderRadius: BorderRadius.circular(4),
                decoration: InputDecoration(
                    errorStyle: AppTextStyle.removeTextStyle,
                    border: InputBorder.none,
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red))),
                hint: Text(
                   AppLocalizations.of(context).user_apply_leave_select_tag,
                  style: AppTextStyle.leaveRequestFormSubtitle, overflow: TextOverflow.ellipsis),
                items: leaveTypeMap
                    .map((key, value) {
                      return MapEntry(
                          key,
                          DropdownMenuItem<int>(
                            value: key,
                            child: Text(" " + _localization
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
    );
  }
}
