import 'package:flutter/material.dart';
import 'package:projectunity/ui/admin/leave/leaveRequestCard/reason_dialogue.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/font_size.dart';

class ButtonContent extends StatelessWidget {
  const ButtonContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ReasonDialogue();
                  });
            },
            child: const Text(
              'REJECT',
              style: TextStyle(
                  color: AppColors.darkText, fontSize: subTitleTextSize),
            )),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(primary: AppColors.primaryBlue),
            child: const Text(
              'APPROVE',
              style: TextStyle(fontSize: subTitleTextSize),
            ))
      ],
    );
  }
}
