import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:provider/provider.dart';

import '../../../../../stateManager/apply_leave_state_provider.dart';

class ReasonCard extends StatelessWidget {
  const ReasonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: const TextStyle(
              color: AppColors.darkText, fontSize: bodyTextSize),
          cursorColor: AppColors.secondaryText,
          maxLines: 5,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Reason',
            hintStyle:
                TextStyle(color: Colors.grey, fontSize: subTitleTextSize),
          ),
          validator: (String? value) {
            if (value == null || value == '') {
              return 'Please enter valid reason';
            }
            return null;
          },
          autofocus: true,
          controller: Provider.of<ApplyLeaveStateProvider>(context)
              .leaveReasonController,
          keyboardType: TextInputType.text,
        ),
      )),
    );
  }
}

