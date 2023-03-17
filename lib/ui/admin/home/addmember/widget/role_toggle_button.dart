import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import '../../../../../configs/colors.dart';
import '../../../../../data/core/utils/const/role.dart';

class ToggleButton extends StatelessWidget {
  final int role;
  final Function(int role) onRoleChange;

  const ToggleButton({Key? key, required this.onRoleChange, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width *
        (90 / roleTypeSelectionToggleButtonAlignment.length / 100);
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
              alignment: Alignment(
                  roleTypeSelectionToggleButtonAlignment[role] ?? -1, 0),
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
            ...roleTypeSelectionToggleButtonAlignment.entries
                .map(
                  (roleTypeAlignment) => GestureDetector(
                    onTap: () {
                      onRoleChange(roleTypeAlignment.key);
                    },
                    child: Align(
                      alignment: Alignment(roleTypeAlignment.value, 0),
                      child: Container(
                        width: width,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                            localization.user_detail_role_type(
                                roleTypeAlignment.key.toString()),
                            textAlign: TextAlign.start,
                            style: AppFontStyle.bodySmallHeavy),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}

Map<int, double> roleTypeSelectionToggleButtonAlignment = {
  kRoleTypeEmployee: -1,
  kRoleTypeHR: 0,
  kRoleTypeAdmin: 1,
};
