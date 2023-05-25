import 'package:flutter/material.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/core/exception/exception_msg.dart';
import '../../data/core/utils/const/image_constant.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error.errorMessage(context)),
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  final String title;
  final String message;

  const EmptyScreen({
    Key? key,
    required this.message,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(ImageConst.emptyLeaveStateImage),
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(title, style: AppFontStyle.titleDark),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(message,
                textAlign: TextAlign.center, style: AppFontStyle.labelGrey),
          ],
        ),
      ),
    );
  }
}
