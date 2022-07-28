import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/core/utils/const/image_constant.dart';

import '../configs/colors.dart';

class EmptyLeaveScreen extends StatelessWidget {
  const EmptyLeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage(emptyLeaveStateImage),
            ),
            SizedBox(
              height: 20,
            ),
            Text('You haven\'t applied for any \n leaves yet!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: subTitleTextSize,
                )),
          ],
        ),
      ),
    );
  }
}
