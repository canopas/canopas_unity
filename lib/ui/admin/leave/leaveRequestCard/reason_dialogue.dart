import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../utils/const/other_constant.dart';

class ReasonDialogue extends StatelessWidget {
  ReasonDialogue({
    Key? key,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: AppColors.whiteColor,
        ),
        height: 200,
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: ('Please enter reason'),
                    border: InputBorder.none),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            )
          ],
        ),
      ),
    );
  }
}
