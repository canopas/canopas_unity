import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import '../../../../configs/colors.dart';
import '../../../../core/utils/const/role.dart';

class ToggleButton extends StatefulWidget {
  final Function(int role) onRoleChange;

  const ToggleButton({Key? key, required this.onRoleChange}) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

Map<int, double> roleTypeSelectionAlignment = {
  kRoleTypeEmployee: -1,
  kRoleTypeAdmin: 1,
};

class _ToggleButtonState extends State<ToggleButton> {
  double selectedAt = roleTypeSelectionAlignment[kRoleTypeEmployee]!;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * (90/roleTypeSelectionAlignment.length/100);
    var localization = AppLocalizations.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 60.0,
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
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.primaryDarkYellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
            ...roleTypeSelectionAlignment.entries.map(
                  (roleTypeAlignment) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAt = roleTypeAlignment.value;
                        widget.onRoleChange(roleTypeAlignment.key);
                      });
                    },
                    child: Align(
                      alignment: Alignment(roleTypeAlignment.value, 0),
                      child: Container(
                        width: width,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          localization.user_detail_role_type(roleTypeAlignment.key),
                          textAlign: TextAlign.start,
                          style: AppTextStyle.bodyTextDark
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ).toList()
          ],
        ),
      ),
    );
  }
}
