import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../configs/colors.dart';
import '../../../../core/utils/const/role.dart';

class ToggleButton extends StatefulWidget {
  final Function(int role) onRoleChange;

  const ToggleButton({Key? key, required this.onRoleChange}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double height = 60.0;
const double employee = -1;
const double hr = 1;

class _ToggleButtonState extends State<ToggleButton> {
  double selectedAt = -1;

  @override
  void initState() {
    super.initState();
    selectedAt = employee;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    var _localization = AppLocalizations.of(context);

    return Center(
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          color: AppColors.textFieldBg,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(selectedAt, 0),
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: width * 0.5,
                height: height,
                decoration: const BoxDecoration(
                  color: AppColors.primaryDarkYellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedAt = employee;
                  widget.onRoleChange(kRoleTypeEmployee);
                });
              },
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    _localization.admin_home_employee_tag,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: bodyTextSize,
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedAt = hr;
                  widget.onRoleChange(kRoleTypeHR);
                });
              },
              child: Align(
                alignment: const Alignment(hr, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    _localization.admin_addMember_hr_roleTag,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: bodyTextSize,
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
