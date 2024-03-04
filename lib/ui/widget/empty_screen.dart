import 'package:flutter/material.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../data/core/utils/const/image_constant.dart';

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
            Text(title,
                style: AppTextStyle.style20.copyWith(
                    color: context.colorScheme.textPrimary,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: AppTextStyle.style16
                    .copyWith(color: context.colorScheme.textDisabled)),
          ],
        ),
      ),
    );
  }
}
